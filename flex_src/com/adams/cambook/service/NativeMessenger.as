/*
 * Copyright 2010 @nsdevaraj
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License. You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.adams.cambook.service
{
	import com.adams.cambook.controller.ServiceController;
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.models.vo.CurrentInstance;
	import com.adams.cambook.models.vo.Persons;
	import com.adams.cambook.models.vo.PushMessage;
	import com.adams.cambook.models.vo.SignalVO;
	import com.adams.cambook.response.SignalSequence;
	import com.adams.cambook.utils.Action;
	import com.adams.cambook.utils.Description;
	import com.adams.cambook.utils.GetVOUtil;
	import com.adams.cambook.utils.Utils;
	
	import flash.utils.Dictionary;
	
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AsyncMessage;
	
	import org.swizframework.core.IBeanFactory;
	import org.swizframework.core.IBeanFactoryAware;
	
	public class NativeMessenger implements IBeanFactoryAware
	{
		public var produce:NativeProducer;
		public var consume:NativeConsumer;
		public var dynamicDAO:AbstractDAO;
		
		[Inject("personDAO")]
		public var personDAO:AbstractDAO;
		
		[Inject]
		public var currentInstance:CurrentInstance;
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		protected var _controlService:ServiceController;  
		public function get controlService():ServiceController {
			return _controlService;
		}
		
		[Inject]
		public function set controlService( ro:ServiceController ):void {
			_controlService = ro; 
			produce = _controlService.producer;
			consume = _controlService.consumer;
		}
		
		private var _beanFactory:IBeanFactory;
		public function set beanFactory( beanFactory:IBeanFactory ):void {
			_beanFactory = beanFactory;
		}
			
		public function NativeMessenger()
		{
		}
		
		[PostConstruct]
		public function subscribeMessage():void { 
			consume.consumeAttempt.add( consumeHandler );
		}
		
		private var sentMsgArr:Dictionary=new Dictionary();
		public function produceMessage( signal:SignalVO ):void {
			var message:AsyncMessage = new AsyncMessage();
			message.headers = [];
			message.headers[ "destination" ] = signal.destination; 
			message.headers[ "name" ] = signal.name;
			message.headers[ "recepient" ] = signal.receivers;
		 	message.headers[ "dynamicdao" ] = signal.daoName;
			message.body = signal.description;
			produce.produceAttempt.add( onAckReceived ); 
			produce.produceMessage( message );
			//chat message
			if (Description.DESCARR.indexOf(signal.name)==-1){
				if(sentMsgArr[signal.receivers[0].toString()]){
					sentMsgArr[signal.receivers[0].toString()].push(signal.name);
					if(sentMsgArr[signal.receivers[0].toString()].length>3){
						if(personDAO.collection.findItem(signal.receivers[0])){
							var perAvailsignal:SignalVO = new SignalVO( null, personDAO, Action.UPDATE );
							var offlinePerson:Persons = GetVOUtil.getVOObject(signal.receivers[0],personDAO.collection.items,personDAO.destination,Persons) as Persons;
							offlinePerson.personAvailability = 0;
							perAvailsignal.valueObject = offlinePerson;
							signalSeq.addSignal( perAvailsignal ); 
							
							var pushOfflineMessage:PushMessage = new PushMessage( Description.UPDATE, [],  signal.receivers[0]);
							var pushOfflineSignal:SignalVO = new SignalVO( null, personDAO, Action.PUSH_MSG, pushOfflineMessage );
							signalSeq.addSignal( pushOfflineSignal );
						}
					}
				}else{
					sentMsgArr[signal.receivers[0].toString()] = [signal.name];
				}
				
			}
		} 
		
		protected function onAckReceived( event:MessageEvent = null ):void {
			signalSeq.onSignalDone();
		}
		
		private var avoidSignal:Boolean;
		protected function consumeHandler( event:MessageEvent = null ):void {
			var daoName:String =  event.message.headers[ "dynamicdao" ];
			dynamicDAO = _beanFactory.getBeanByName( daoName ).source as AbstractDAO;
			var receivedSignal:SignalVO = new SignalVO( null, dynamicDAO, Action.RECEIVE_MSG );
			receivedSignal.destination = event.message.headers[ "destination" ];
			receivedSignal.name = event.message.headers[ "name" ];
			receivedSignal.receivers = event.message.headers[ "recepient" ];
			receivedSignal.description = event.message.body;
			
			avoidSignal = false;   
			if( daoName == Utils.PERSONDAO ) {
				var message:String = receivedSignal.name as String; 
				//if id is not in the collection 
				if( currentInstance.currentPerson.personId == ( receivedSignal.description as int ) ) {
					avoidSignal = true;
				}
				//consume chat message
			 	if (Description.DESCARR.indexOf(message)==-1 || Description.ACKNOWLEDGE == message){
					avoidSignal = true;
					// find message intended to me
					if( currentInstance.currentPerson.personId == ( receivedSignal.receivers[0] as int ) ) {
						var personSentId:int = receivedSignal.description as int;
						
						// on receivng chat message
						if(message != Description.ACKNOWLEDGE){
							// create acknowledge message
							var pushChatMessage:PushMessage = new PushMessage( Description.ACKNOWLEDGE, [personSentId],  currentInstance.currentPerson.personId );
							var pushChatSignal:SignalVO = new SignalVO( null, personDAO, Action.PUSH_MSG, pushChatMessage );
							signalSeq.addSignal( pushChatSignal );
							
							// create chat window
							var sentPerson:Persons = new Persons();
							sentPerson.personId = personSentId;
							sentPerson =	Utils.findObject(sentPerson,currentInstance.currentPersonsList,personDAO.destination) as Persons;
							//Alert.show(message,sentPerson.personFirstname);
							
						}else if( currentInstance.currentPerson.personId != ( receivedSignal.description as int ) ) {
							//check previous push
							sentMsgArr[personSentId.toString()] = [];
						}
					} 
				} 				
			}
			if( (( receivedSignal.receivers.indexOf( currentInstance.currentPerson.personId ) != -1 ) || ( receivedSignal.receivers.length == 0 )) && ( !avoidSignal ) ) {
					signalSeq.addSignal( receivedSignal );
			}			
		}
	}
}