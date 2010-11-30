/*
* Copyright 2010 Swiz Framework Contributors
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

package org.swizframework.utils.async
{
	import flash.events.Event;
	import org.swizframework.utils.chain.IAsyncChainStep;

	public class AsynchronousEvent extends Event implements IAsynchronousEvent
	{
		// ========================================
		// protected properties
		// ========================================
		
		/**
		 * Backing variable for <code>step</code> property.
		 */
		protected var _step:IAsyncChainStep;
		
		// ========================================
		// public properties
		// ========================================
		
		/**
		 * @inheritDoc
		 */
		public function get step():IAsyncChainStep
		{
			return _step;
		}
		
		public function set step( value:IAsyncChainStep ):void
		{
			_step = value;
		}
		
		// ========================================
		// constructor
		// ========================================
		
		/**
		 * Constructor.
		 */
		public function AsynchronousEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		// ========================================
		// public methods
		// ========================================
		
		/**
		 * @inheritDoc
		 */
		override public function clone():Event
		{
			var clone:AsynchronousEvent = new AsynchronousEvent( type, bubbles, cancelable );
			
			clone.step = step;
			
			return clone;
		}
	}
}