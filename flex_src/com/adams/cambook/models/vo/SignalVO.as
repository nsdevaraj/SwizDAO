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
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.dao.IAbstractDAO;
	import com.adams.cambook.models.collections.ICollection;
	import com.adams.cambook.models.processor.IVOProcessor;
	
	import mx.collections.IList;
	
	[Bindable]
	public class SignalVO extends AbstractVO
	{
		
		private var _receivers:Array;
		private var _destination:String;
		private var _name:String;
		private var _emailId:String;
		private var _emailBody:String;
		private var _action:String;
		private var _id:int;
		private var _valueObject:IValueObject;
		private var _processor:IVOProcessor;
		private var _collection:ICollection;
		private var _list:IList;
		private var _description:Object;
		private var _objectId:String;
		private var _daoName:String;
		private var _performed:Boolean;
		private var _startIndex:int;
		private var _endIndex:int;
		/**
		 * Constructor, valueObject used to dispatch signals in a encapsulated object
		 */
		public function SignalVO( obj:Object=null, dao:IAbstractDAO = null, actionStr:String ='', pushmsg:PushMessage = null ) {
			
			if( obj ) {
				objectId = obj.name;	
			}
			
			if( dao ) {
				destination = dao.destination;
				daoName = dao.daoName;
				collection = dao.collection;
				processor = dao.processor;
				action = actionStr;
			}
			
			if( pushmsg ) {
				receivers = pushmsg.receivers;
				name = pushmsg.name;
				description = pushmsg.description;
			}
		
		}
		
		public function get emailBody():String
		{
			return _emailBody;
		}

		public function set emailBody(value:String):void
		{
			_emailBody = value;
		}

		public function get emailId():String
		{
			return _emailId;
		}

		public function set emailId(value:String):void
		{
			_emailId = value;
		}

		public function get startIndex():int
		{
			return _startIndex;
		}

		public function set startIndex(value:int):void
		{
			_startIndex = value;
		}

		public function get endIndex():int
		{
			return _endIndex;
		}

		public function set endIndex(value:int):void
		{
			_endIndex = value;
		}

		public function get performed():Boolean
		{
			return _performed;
		}

		public function set performed(value:Boolean):void
		{
			_performed = value;
		}

		public function get daoName():String
		{
			return _daoName;
		}

		public function set daoName(value:String):void
		{
			_daoName = value;
		}

		public function get objectId():String {
			return _objectId;
		}
		public function set objectId( value:String ):void {
			_objectId = value;
		}

		public function get destination():String {
			return _destination;
		}
		public function set destination( value:String ):void {
			_destination = value;
		}
		 
		public function get processor():IVOProcessor {
			return _processor;
		}
		public function set processor( value:IVOProcessor ):void 	{
			_processor = value;
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
		
		public function get action():String {
			return _action;
		}
		public function set action( value:String ):void {
			_action = value;
		}
		
		public function get id():int {
			return _id;
		}
		public function set id( value:int ):void {
			_id = value;
		}
		
		public function get valueObject():IValueObject {
			return _valueObject;
		}
		public function set valueObject ( value:IValueObject ):void {
			_valueObject = value;
		}
		
		public function get collection():ICollection {
			return _collection;
		}
		public function set collection( value:ICollection ):void {
			_collection = value;
		}
		
		public function get list():IList {
			return _list;
		}
		public function set list( value:IList ):void 	{
			_list = value;
		}
		
		public function get description():Object {
			return _description;
		}
		public function set description( value:Object ):void {
			_description = value;
		}
	}
}