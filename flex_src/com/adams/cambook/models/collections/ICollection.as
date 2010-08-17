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
package com.adams.cambook.models.collections
{
	import mx.collections.IList;
	
	[Bindable]
	public interface ICollection
	{ 
		function get sortString():String
		function set sortString( v:String ):void
		function get findByIdArr():Array
		function set findByIdArr(v:Array):void
		function get findByPushIdArr():Array
		function set findByPushIdArr( v:Array ):void
		function get findAll():Boolean
		function set findAll( v:Boolean ):void
		function get propertyNames():Array;
		function get items():IList; 
		function findItem( itemId:int ):Boolean;
		function set items( v:IList ):void;
		function get length():int; 
		function getItemIndex( obj:Object ):int;
		function addItem( obj:Object ):void;
		function addItemAt( obj:Object, index:int ):void;
		function removeItem( obj:Object ):void;
		function removeItemAt( index:int ):void;
		function removeAll():void;
		function updateItem( oldValueObject:Object, newValueObject:Object ):void;
		function updateItems( newList:IList ):void; 
		function containsItem( item:Object ):Boolean;
		function findExistingItem( item:Object ):Object;
		function modifyItems( newList:IList ):void;
	}
}