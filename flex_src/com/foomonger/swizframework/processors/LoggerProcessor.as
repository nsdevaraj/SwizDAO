/*
Copyright 2010 Samuel Ahn

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package com.foomonger.swizframework.processors {

	import org.swizframework.core.Bean;
	import org.swizframework.processors.BaseMetadataProcessor;
	import org.swizframework.processors.ProcessorPriority;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.utils.logging.SwizLogger;

	/**
	 * LoggerProcessor injects an ILogger instance to the decorated property
	 * using the Bean source as the ILogger target.
	 */ 
	public class LoggerProcessor extends BaseMetadataProcessor {

		protected static const LOGGER:String = "Logger";
		
		override public function get priority():int {
			return ProcessorPriority.INJECT - 1;
		}
		
		public function LoggerProcessor() {
			super([LOGGER]);
		}
 
		override public function setUpMetadataTag(metadataTag:IMetadataTag, bean:Bean):void {
			var logger:SwizLogger = SwizLogger.getLogger(bean.source);
			bean.source[metadataTag.host.name] = logger;
		}
		
		override public function tearDownMetadataTag(metadataTag:IMetadataTag, bean:Bean):void {
			bean.source[metadataTag.host.name] = null;
		}
		
	}
}