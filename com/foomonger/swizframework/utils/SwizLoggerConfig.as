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

package com.foomonger.swizframework.utils {

	import mx.logging.ILoggingTarget;
	
	import org.swizframework.utils.SwizLogger;
	
	[DefaultProperty("targets")]
	
	/**
	 * SwizLoggerConfig is a helper class that makes it easy to declare 
	 * logging targets in MXML. If you're creating a non-Flex application
	 * then yoou should use SwizLogger directly. 
	 */ 
	public class SwizLoggerConfig {
		
		private var _targets:Array;
		
		public function get targets():Array {
			return _targets;
		}
		
		public function set targets(value:Array):void {
			if (_targets == null) {
				_targets = value;
				updateTargets();
			}
		}
		
		public function SwizLoggerConfig() {
		}
 		
 		private function updateTargets():void {
 			for each (var target:ILoggingTarget in targets) {
	 			SwizLogger.addLoggingTarget(target);
 			}
 		}
	}
}