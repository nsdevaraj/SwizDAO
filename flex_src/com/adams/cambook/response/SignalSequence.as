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
package com.adams.cambook.response
{
	import com.adams.cambook.models.vo.SignalVO;
	import com.adams.cambook.signals.AbstractSignal;
	import com.adams.cambook.utils.ArrayUtil;			
	public class SignalSequence 
	{       
		private var events:Array = [];  
		
		[Inject]
		public var serviceSignal:AbstractSignal;
		
		private var serviceInProcess:Boolean;
		
		private var signal:SignalVO;

		//@TODO
		public function SignalSequence():void {
		}
		
		public function addSignal( signal:SignalVO ):void { 
			events.push( signal );
			if( !serviceInProcess ) {
				onSignalDone();
			} 
		}

		private function dispatchNextSignal():void {
			signal  = events[ 0 ] as SignalVO;
			serviceSignal.currentSignal = signal;
			serviceSignal.currentCollection = signal.collection;
			serviceSignal.currentProcessor = signal.processor;
			serviceSignal.dispatch( signal );
			ArrayUtil.removeElementAt( 0, events );
		}  
		
		public function onSignalDone():void { 
			if( events.length > 0 ) {
				dispatchNextSignal();
				if(!signal.performed){
					serviceInProcess = true;
				}else{
					serviceInProcess = false;
				}
				return;      			
			}
			else {
				serviceInProcess = false;
			}
		} 
	}
}