package com.adams.scrum.models.collections
{
	import com.adams.scrum.utils.ObjectUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
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
		public function get propertyNames():Array {
			if( items.length > 0 ) {
				_propertyNames = ObjectUtil.getPropNames( items.getItemAt( 0 ) );
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
			return _length;
		}
		
		public function set length(v:int):void {
			_length =v;
		}
		
		/**
		 * Returns the index of the given element in the items collection
		 */ 
		private var _getItemIndex:int;
		public function getItemIndex( obj:Object ):int {
			if( items ) {
				return items.getItemIndex( obj );
			}
			return -1;
		}
		
		/**
		 * Checks Wheather the given item exists in the collection if so it just replaces the existing item
		 * otherewise it just adds the given item into the collection
		 * 
		 */ 
		public function addItem( obj:Object ):void {
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
			if( length == 0 ) {
				items = newList;
			}
			else {
				for( var i:int = 0; i < length; i++ ) {
					updateItem( items.getItemAt( i ), newList.getItemAt( i ) );
				}
			}
		}
		
		/**
		 * Returns true if the passed Object can be matched to a Object in this collection.
		 */ 
		public function containsItem( item:Object ):Boolean {
			if( propertyNames.indexOf( ObjectUtil.getPropNames( item )[ 0 ] ) == -1 ) {
				return false;
			}
			else {
				var compareProperty:String = propertyNames[ 0 ];
				for each( var existingItem:Object in items ) {
					if( existingItem[ compareProperty ] == item[ compareProperty ] ) {
						return true;
					}    
				}
			}
			return false;
		}
		
		/**
		 * Returns a Object from this collection that matches the passed Object.
		 */ 
		public function findExistingItem( item:Object ):Object {
			if( propertyNames.indexOf( ObjectUtil.getPropNames( item )[ 0 ] ) == -1 ) {
				return null;
			}
			else {
				var compareProperty:String = propertyNames[ 0 ];
				for each( var existingItem:Object in items ) {
					if( existingItem[ compareProperty ] == item[ compareProperty ] ) {
						return existingItem;
					}    
				}
			}
			return null;
		}
	}
}