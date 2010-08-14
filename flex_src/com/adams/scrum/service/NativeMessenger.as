package com.adams.scrum.service
{
	import com.adams.scrum.controller.ServiceController;
	import com.adams.scrum.models.vo.CurrentInstance;
	import com.adams.scrum.models.vo.SignalVO;
	import com.adams.scrum.response.SignalSequence;
	import com.adams.scrum.utils.Action;
	
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AsyncMessage;
	
	public class NativeMessenger
	{
		public var produce:NativeProducer;
		
		public var consume:NativeConsumer;
		
		protected var _controlService:ServiceController;  
		public function get controlService():ServiceController  {
			return _controlService;
		}
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject]
		public function set controlService( ro:ServiceController ):void {
			_controlService = ro; 
			produce = _controlService.producer;
			consume = _controlService.consumer;
		}
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		
		public function NativeMessenger()
		{
		}
		[PostConstruct]
		public function subscribeMessage():void{
			consume.consumeAttempt.add(consumeHandler);			
		}
		
		public function produceMessage(signal:SignalVO) : void
		{
			var message:AsyncMessage = new AsyncMessage();
			message.headers = [];
			message.headers["destination"] = signal.destination; 
			message.headers["name"] = signal.name;
			message.headers["recepient"] = signal.receivers;
			message.body = signal.description;
			produce.produceAttempt.add(onAckReceived); 
			produce.produceMessage(message);
		} 
		protected function onAckReceived(event:MessageEvent =null) : void
		{
			signalSeq.onSignalDone();
		}
		protected function consumeHandler(event:MessageEvent =null) : void
		{
			var receivedSignal:SignalVO = new SignalVO();
			receivedSignal.action = Action.RECEIVE_MSG;
			receivedSignal.destination = event.message.headers["destination"];
			receivedSignal.name = event.message.headers["name"];
			receivedSignal.receivers = event.message.headers["recepient"];
			receivedSignal.description = event.message.body;
			
			trace(receivedSignal.description +' push Msg Received ' );
			if(receivedSignal.receivers.indexOf(currentInstance.currentPerson.personId)!=-1){
				signalSeq.addSignal(receivedSignal);
			}			
		}
	}
}