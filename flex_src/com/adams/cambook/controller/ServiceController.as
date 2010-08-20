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
package com.adams.cambook.controller
{
	import com.adams.cambook.models.vo.CurrentInstance;
	import com.adams.cambook.service.NativeChannelSet;
	import com.adams.cambook.service.NativeConsumer;
	import com.adams.cambook.service.NativeProducer;
	import com.adams.cambook.service.NativeRemoteObject;
	
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
		/** <p>
		 * Channel set of remote objects were assigned with server context locations and channel info
		 * </p>
 		 */
		public function assignChannelSets():void
		{ 
			var baseChannel:AMFChannel = new AMFChannel("my-amf",serverLocation+"spring/messagebroker/amf");
			//"my-polling-amf", "spring/messagebroker/amfpolling"
			//"my-longpolling-amf", "spring/messagebroker/amflongpolling"
			//"my-streaming-amf",serverLocation+"spring/messagebroker/streamingamf"
			var pushChannel:AMFChannel = new AMFChannel("my-longpolling-amf",serverLocation+ "spring/messagebroker/amflongpolling");
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