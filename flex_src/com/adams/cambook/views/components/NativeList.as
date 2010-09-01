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
package com.adams.cambook.views.components
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import org.osflash.signals.Signal;
	
	import spark.components.List;
	
	public class NativeList extends List
	{
		public static const REPLIEDUPDATE:String = 'replyUpdate';
		public static const OPENCHAT:String = 'openChat';
		public static const FOLLOWPERSON:String = 'followPerson';  
		public var renderSignal:Signal = new Signal();
		public var collection:IList;
		public var removeRendererProperty:Boolean;
		public var editRendererProperty:Boolean;
		public var addRemoveRendererProperty:Boolean;
		public var selectDeselectRendererProperty:Boolean;
		public function NativeList()
		{
			super();
		}
	}
}