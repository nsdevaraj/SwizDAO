package com.adams.scrum.models.collections
{
	import mx.collections.IList;
	
	[Bindable]
	public interface ICollection
	{
		function get propertyNames():Array;
		function get items():IList;
		function set items( value:IList ):void;
		function get length():int;
		function set length(v:int):void
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
	}
}