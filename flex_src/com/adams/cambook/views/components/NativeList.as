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
		public static const PRODUCTEDITED:String = 'productedit';
		public static const PRODUCTOPENED:String = 'productopen'; 
		public static const PRODUCTDELETED:String = 'productdelete';
		public static const SPRINTEDITED:String = 'sprintedit';
		public static const SPRINTOPENED:String = 'sprintopen'; 
		public static const SPRINTDELETED:String = 'sprintdelete'; 
		public static const VERSIONDELETED:String = 'versiondelete'; 
		public static const THEMEDELETED:String = 'themedelete';
		public static const STORYSELECTED:String = 'storyselect';
		public static const STORYDESELECTED:String = 'storyUnselect';
		
		public static const STORYSPRINTSELECTED:String = 'storySprintselect';
		public static const TASKSELECTED:String = 'taskselect';
		public static const TASKCREATED:String = 'taskcreate';
		public static const TICKETCREATED:String = 'ticketcreate';
		public static const TICKETDETAIL:String = 'ticketdetail';
		public static const TICKETMODIFY:String = 'ticketmodify';
		public static const TEAMMEMBERREMOVED:String = 'teammemberdelete';
		public static const TASKSTATUSUPDATE:String = 'taskstatusupdate';
		public static const TASKVISIBLEUPDATE:String = 'taskvisibleupdate';
		public static const STORYMODIFY:String = 'storyedit';
		public static const STORYDELETE:String = 'storydelete';
		public static const TASKLABELUPDATE:String='tasklabelupdate'	
		public static const STORYEXPAND:String = 'StoryExpand';
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