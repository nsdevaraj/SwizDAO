package com.adams.scrum.controller
{
	import com.adams.scrum.models.vo.CurrentInstance;
	import com.adams.scrum.service.NativeChannelSet;
	import com.adams.scrum.service.NativeConsumer;
	import com.adams.scrum.service.NativeProducer;
	import com.adams.scrum.service.NativeRemoteObject;
	
	import mx.messaging.channels.AMFChannel;
	
	import org.swizframework.controller.AbstractController;
	
	public class ServiceController extends AbstractController 
	{	
		
		public function ServiceController()
		{
			super();
		}
		
		public var unAuthRo:NativeRemoteObject;
		public var authRo:NativeRemoteObject; 
		public var producer:NativeProducer = new NativeProducer(); 
		public var consumer:NativeConsumer = new NativeConsumer();
		public var pushCS:NativeChannelSet;
		public var authCS:NativeChannelSet;
		
		[PostConstruct]
		public function initialize():void
		{
			createChannelSets();
			createRemoteObjects();
			createProducers();
		}
		private function createRemoteObjects():void
		{
			authRo = new NativeRemoteObject();
			unAuthRo = new NativeRemoteObject();
			authRo.channelSet = authCS;
			unAuthRo.channelSet = pushCS;
		}
		
		private function createChannelSets():void
		{
			authCS = new NativeChannelSet();
			pushCS = new NativeChannelSet();
		}
		public var serverLocation:String;
		public function assignChannelSets():void
		{ 
			var baseChannel:AMFChannel = new AMFChannel("my-amf",serverLocation+"spring/messagebroker/amf");
			//"my-polling-amf", "spring/messagebroker/amfpolling"
			//"my-longpolling-amf", "spring/messagebroker/amflongpolling"
			//"my-streaming-amf",'spring/messagebroker/streamingamf'
			var pushChannel:AMFChannel = new AMFChannel("my-streaming-amf",serverLocation+"spring/messagebroker/streamingamf");
			pushChannel.pollingEnabled= true;
			pushChannel.pollingInterval= 5000;
			pushChannel.piggybackingEnabled=true;
			
			authCS.channels = [baseChannel];
			pushCS.channels = [pushChannel];
		}
		
		private function createProducers():void{
			producer.channelSet = pushCS;
			consumer.channelSet = pushCS;
			producer.destination = consumer.destination = 'chatonline';
		}
	}
}