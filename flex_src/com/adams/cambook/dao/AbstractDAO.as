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
package com.adams.cambook.dao
{
	import com.adams.cambook.controller.ServiceController;
	import com.adams.cambook.models.processor.IVOProcessor;
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.models.vo.SignalVO;
	import com.adams.cambook.response.SignalSequence;
	import com.adams.cambook.service.NativeMessenger;
	import com.adams.cambook.signals.PushRefreshSignal;
	import com.adams.cambook.utils.Action;
	import com.adams.cambook.utils.Description;
	import com.adams.cambook.utils.GetVOUtil;
	import com.adams.cambook.utils.Utils;
	
	import mx.collections.ArrayCollection;
	
	public class AbstractDAO extends CRUDObject implements IAbstractDAO
	{  
		[Inject]
		public var messenger:NativeMessenger; 
		
		[Inject]
		public var pushRefreshSignal:PushRefreshSignal;
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		protected var voClazz:Class;
		private var _daoName:String;
		/**
		 * Whenever an AbstractSignal is dispatched.
		 * This DAO is responsible for performing the Server Request initiation.
		 * if(obj.destination == this.destination) makes sure the DAO Object required 
		 * <p>
		 * Constructor, AbstractDAO, extended from CRUDObject.
		 * </p>
 		 */
		public function AbstractDAO( destn:String, clz:Class, process:IVOProcessor =null ,name:String='')
		{
			destination = destn;
			processor = process;
			voClazz = clz;
			daoName = name;
		} 		
		public function get daoName():String
		{
			return _daoName;
		}
		
		public function set daoName(value:String):void
		{
			_daoName = value;
		}
		
		protected var _controlService:ServiceController;  
		public function get controlService():ServiceController  {
			return _controlService;
		}
		[Inject]
		public function set controlService( ro:ServiceController ):void {
			_controlService = ro; 
			remoteService = _controlService.authRo;
		}
		
		/**
		 * Whenever an AbstractSignal is dispatched.
		 * MediateSignal initates this invokeAction to perform Generic Actions
		 * <p>
		 * The invoke functions to perform generic dao functions
		 * </p>
 		 */
		[MediateSignal(type="AbstractSignal")]
		public function invokeAction( obj:SignalVO ):void {
			if( obj.destination == this.destination ) {
				switch( obj.action ) {
					case Action.CREATE:
						create( obj.valueObject );
					break;
					case Action.UPDATE:
						update( obj.valueObject );
					break;
					case Action.READ:
						read( obj.id );
					break;
					case Action.FINDBY_NAME: 
						findByName( obj.name );
					break;
					case Action.FIND_ID:
						// call if not already called
						collection.findByIdArr.push( obj.id );
						findById( obj.id );
					break; 
					case Action.FINDBY_ID: 
						findId( obj.id );
					break; 
					case Action.DELETE:
						deleteById( obj.valueObject );
					break;
					case Action.GET_COUNT:
						count();
					break;
					case Action.GET_LIST:
						// call if not already called
						collection.findAll = true;
						getList();
					break;
					case Action.SQL_FINDALL: 
						getSQLList();
						break;
					case Action.BULK_UPDATE:
						bulkUpdate( obj.list );
					break;
					case Action.DELETE_ALL:
						deleteAll();
					break;
					case Action.PUSH_MSG:
						messenger.produceMessage( obj );
					break;
					case Action.RECEIVE_MSG:
						switch( obj.name ) {
							case Description.CREATE: 
							case Description.UPDATE: 
								obj.action = Action.FINDPUSH_ID;
								findId( obj.description as int );
							break;
							case Description.DELETE: 
								var deletedId:int =obj.description as int;
								ArrayCollection( collection.items ).refresh();
								var valueObject:IValueObject;
								if(collection.findItem(deletedId)){
									valueObject = GetVOUtil.getVOObject( deletedId,collection.items, this.destination, voClazz );
									collection.removeItem( valueObject );
								}
								obj.performed =true;
								pushRefreshSignal.dispatch( obj );
							break;
							default:
							break;
						}
					break;	
					default:
						messenger.currentInstance.serverLastAccessedAt = new Date();  
					break;	
				}
			}
		}  
	}
}