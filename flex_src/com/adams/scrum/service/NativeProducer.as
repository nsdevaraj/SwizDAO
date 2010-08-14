package com.adams.scrum.service
{
	import mx.messaging.Producer;
	import mx.messaging.events.MessageAckEvent;
	import mx.messaging.messages.IMessage;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class NativeProducer extends Producer
	{
		public var produceAttempt:NativeSignal;
		public function NativeProducer()
		{
			super();
			produceAttempt = new NativeSignal(this,'acknowledge',MessageAckEvent);
		}
		public function produceMessage(message:IMessage) : void
		{
			this.send(message);
		}	
	}
}