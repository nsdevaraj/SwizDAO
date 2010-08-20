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
	import com.adams.cambook.utils.ObjectUtils;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	[Bindable]
	public class AbstractCollection implements ICollection
	{
		
		/**
		 * Returns the array of Property Names of First element in the items collection
		 * Since the items collection is going to have all the items of Same type
		 * it returns the first element
		 * 
		 */ 
		protected var _propertyNames:Array;
		private var _findByPushIdArr:Array =[];
		
		private var _findByIdArr:Array =[];
		private var _findAll:Boolean;
		private var _sortString:String;

		public function get findByPushIdArr():Array
		{
			return _findByPushIdArr;
		}

		public function set findByPushIdArr(value:Array):void
		{
			_findByPushIdArr = value;
		}

		public function get findByIdArr():Array
		{
			return _findByIdArr;
		}

		public function set findByIdArr(value:Array):void
		{
			_findByIdArr = value;
		}

		public function get findAll():Boolean
		{
			return _findAll;
		}

		public function set findAll(value:Boolean):void
		{
			_findAll = value;
		}

		public function get sortString():String
		{
			return _sortString;
		}

		public function set sortString(value:String):void
		{
			_sortString = value;
		}
		
		/**
		 * Returns array with list of properties available in an Object
		 * 
		 */
		public function get propertyNames():Array {
			if( items.length > 0 ) {
				_propertyNames = ObjectUtils.getPropNames( items.getItemAt( 0 ) );
			}
			else {
				_propertyNames = [];
			}
			return _propertyNames;
		}
		
		/**
		 * Getter and Setter function of the main List
		 * 
		 */ 
		protected var _items:IList;
		public function get items():IList {
			return _items;
		}
		public function set items( value:IList ):void {
			_items = value;
		}
		
		/**
		 * Returns the length of items collection if items exists otherwise it reurns 0.
		 * 
		 */ 
		private var _length:int;
		public function get length():int {
			return items.length;
		}
		 
		/**
		 * Returns the index of the given element in the items collection
		 */ 
		private var _getItemIndex:int;
		public function getItemIndex( obj:Object ):int {
			if( items ) {
				var itemIndex:int = items.getItemIndex( obj );
				if(itemIndex == -1){
					itemIndex = findEqualItemIndex(obj[ sortString ] as int);
				}
				return itemIndex;
			}
			return -1;
		}
		
		private function findEqualItemIndex( itemId:int ):int {
			for each( var existingItem:Object in items ) {
				if( existingItem[ sortString ] == itemId ) {
					return items.getItemIndex( existingItem );
				}    
			}
			return -1;
		}
		/**
		 * Checks Wheather the given item exists in the collection if so it just replaces the existing item
		 * otherewise it just adds the given item into the collection
		 * 
		 */ 
		public function addItem( obj:Object ):void {
			if( !items ) {
				items = new ArrayCollection();
			}
			addItemAt( obj, length );	
		}
		
		/**
		 * Checks Wheather the given item exists in the collection if so it just replaces the existing item
		 * otherewise it just adds the given item into the collection 
		 */ 
		public function addItemAt( obj:Object, index:int ):void {
			var isExistingItem:Object = findExistingItem ( obj );
			if( isExistingItem ) {
				updateItem( isExistingItem, obj );
			}
			else {
				items.addItemAt( obj, index );
			}
		}
		
		/**
		 * Passes the index of given Object to the RemovItemAT method
		 */
		public function removeItem( obj:Object ):void {
			removeItemAt( getItemIndex( obj ) );
		}
		
		/**
		 * Removes the item at the particualr index
		 */
		public function removeItemAt( index:int ):void {
			items.removeItemAt( index );
		}
		
		/**
		 * Removes all the items in the list
		 */
		public function removeAll():void {
			items.removeAll();
		}
		
		
		/**
		 * Takes two parameters of oldObject and the new Object parses the value of properties of
		 * new object into old Object and the calls the itemUpdated method
		 */
		public function updateItem( oldValueObject:Object, newValueObject:Object ):void {
			for each( var str:String in propertyNames ) { 
				oldValueObject[ str ] = newValueObject[ str ];
			}
			items.itemUpdated( oldValueObject );
		}
		
		/**
		 * Takes newList as parameter if the existing list is empty then it updates it with the newList
		 * else replace the oldlistItem with the newlistItems;
		 */
		public function updateItems( newList:IList ):void {
			if( !items ) {
				items = newList;
			}
			else {
				for( var i:int = 0; i < newList.length; i++ ) {
					addItem( newList.getItemAt( i ) );
				}
			}
		}
		
		/**
		 * Returns index position of the item searched from the list, if not exist -1 will be the return value
		 */ 
		public function modifyItem( item:Object, arrc:ArrayCollection, sortString:String ):int {
			var returnValue:int = -1;
			if( !arrc.sort ) {
				var sort:Sort = new Sort(); 
				sort.fields = [ new SortField( sortString ) ];
				arrc.sort = sort;	
			}
			arrc.refresh(); 
			var cursor:IViewCursor = arrc.createCursor();
			var found:Boolean = cursor.findAny( item );	
			if( found ) {
				returnValue = arrc.getItemIndex( cursor.current );
			} 	
			return returnValue;
		}
		
		/**
		 * Modifies the list with new set of items, if the item doesnot exist in the list 
		 * otherwise add the item into the list
		 */ 
		public function modifyItems( newList:IList ):void {
			
			if( !items) {
				items = newList;
			}
			else {
				for ( var i:int = 0; i < newList.length; i++ ) {
					var isItem:int =  modifyItem( newList.getItemAt( i ), items as ArrayCollection, sortString );
					if( isItem != -1 ) {
						removeItemAt( isItem );
						addItemAt( newList.getItemAt( i ), isItem );
					}
					else {
						addItem( newList.getItemAt( i ) );
					}	
				}
			}
		}
		
		
		/**
		 * Returns true if the passed Object can be matched to a Object in this collection.
		 */ 
		public function containsItem( item:Object ):Boolean {
			for each( var existingItem:Object in items ) {
				if( existingItem[ sortString ] == item[ sortString ] ) {
					return true;
				}    
			}
			return false;
		}
		
		/**
		 * Returns a Object from this collection that matches the passed Object.
		 */ 
		public function findExistingItem( item:Object ):Object {
			for each( var existingItem:Object in items ) {
				if( existingItem[ sortString ] == item[ sortString ] ) {
					return existingItem;
				}    
			}
			return null;
		}
		
		public function findItem( itemId:int ):Boolean {
			for each( var existingItem:Object in items ) {
				if( existingItem[ sortString ] == itemId ) {
					return true;
				}    
			}
			return false;
		}
	}
}