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
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CurrentInstance extends AbstractVO
	{
		/**
		 * Constructor, to store the values to be shared across views.
		 * 
		 */ 
		public function CurrentInstance()
		{ 
		}  
		
		public function get currentPersonsList():ArrayCollection
		{
			return _currentPersonsList;
		}

		public function set currentPersonsList(value:ArrayCollection):void
		{
			_currentPersonsList = value;
		}

		public function get serverLastAccessedAt():Date
		{
			return _serverLastAccessedAt;
		}

		public function set serverLastAccessedAt(value:Date):void
		{
			_serverLastAccessedAt = value;
		}

		public function get idle():Boolean
		{
			var timeStamp:Date = new Date();
			var diffmillisecs:int =  -(serverLastAccessedAt.time - timeStamp.time);
			var diffmins:int = diffmillisecs/60000;
			(diffmins>1)? _idle=true: _idle=false;  
			return _idle;
		}
 
		public function get currentPerson():Persons
		{
			return _currentPerson;
		}

		public function set currentPerson(value:Persons):void
		{
			_currentPerson = value;
		}

		public function get mainViewStackIndex():int
		{
			return _mainViewStackIndex;
		}

		public function set mainViewStackIndex(value:int):void
		{
			_mainViewStackIndex = value;
		}
		 
		private var _config:ConfigVO = new ConfigVO();
		public function set config (value:ConfigVO):void
		{
			_config = value;
		}
		
		public function get config ():ConfigVO
		{
			return _config;
		}  
		private var _mainViewStackIndex:int;
		private var _currentPerson:Persons = new Persons();
		
		[ArrayElementType( "com.adams.cambook.models.vo.Persons" )]
		private var _currentPersonsList:ArrayCollection = new ArrayCollection();
		
		private var _serverLastAccessedAt:Date = new Date();
		private var _idle:Boolean; 
	}
}