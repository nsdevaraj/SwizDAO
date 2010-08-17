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
package com.adams.cambook.models.vo
{
	public class PushMessage extends AbstractVO
	{
		
		private var _receivers:Array;
		private var _name:String;
		private var _description:Object;
		
		/**
		 * Constructor, valueObject used to pass the push message with encapsulation
		 */
		public function PushMessage( nameStr:String, sentTo:Array, desc:Object ) {
			 name = nameStr;
			 receivers = sentTo;
			 description = desc;
		}
		
		public function get description():Object {
			return _description;
		}

		public function set description( value:Object ):void {
			_description = value;
		}

		public function get receivers():Array {
			return _receivers;
		}

		public function set receivers( value:Array ):void {
			_receivers = value;
		}

		public function get name():String {
			return _name;
		}

		public function set name( value:String ):void {
			_name = value;
		}
	}
}