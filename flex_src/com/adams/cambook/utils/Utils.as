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
package com.adams.cambook.utils
{  
	import com.adams.cambook.dao.AbstractDAO; 
	import com.adams.cambook.models.vo.*;
	import com.adams.cambook.views.components.RatingComponent; 
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.core.ClassFactory;
	
	public class Utils
	{  	 
		public static const LOGIN_INDEX:int=0; 
		public static const HOME_INDEX:int=1;  
		 
		public static const SQL_TYPE:String="type";  
		public static const ALERTHEADER:String='CamBook';
		public static const DELETEITEMALERT:String="Are you sure you want to delete this item?";
		 
		public static const PERSONKEY 	:String="personId"; 
		public static const NOTEKEY 	:String="noteId";  
		public static const FILEKEY 	:String="fileId";  
		public static const STATUSKEY 	:String="statusId";  
		
		public static const PERSONDAO 	:String="personDAO"; 
		public static const NOTEDAO 	:String="noteDAO";  
		public static const FILEDAO 	:String="fileDAO";  
		public static const STATUSDAO 	:String="statusDAO";  
		 
		public static function getCustomRenderer( type:String):ClassFactory{
			/*switch(type){
				case PRODUCTRENDER:					
				 	return new ClassFactory(com.adams.cambook.views.renderers.ProductRenderer);
					break; 
			}	*/		
			return null; 
		}   		
		//@TODO
		public static function StrToByteArray(str:String):ByteArray{
			var by:ByteArray = new ByteArray();
			by.writeUTFBytes(str);
			return by;
		}
		public static function removeArrcItem(item:Object,arrc:ArrayCollection, sortString:String):void{
			var returnValue:int = -1;
			var sort:Sort = new Sort(); 
			sort.fields = [ new SortField( sortString ) ];
			if(arrc.sort==null) arrc.sort = sort;
			arrc.refresh(); 
			var cursor:IViewCursor = arrc.createCursor();
			var found:Boolean = cursor.findAny( item );	
			if( found ) {
				returnValue = arrc.getItemIndex( cursor.current );
			} 	
			if( returnValue != -1 ) {
				arrc.removeItemAt(returnValue);
			}
		} 
		public static function findObject( item:Object, arrc:ArrayCollection, sortString:String ):Object{
			var returnValue:int = -1;
			var returnObject:Object = new Object();
			var sort:Sort = new Sort(); 
			sort.fields = [ new SortField( sortString ) ];
			if(arrc.sort==null) arrc.sort = sort;
			arrc.refresh(); 
			var cursor:IViewCursor = arrc.createCursor();
			var found:Boolean = cursor.findAny( item );	
			if( found ) {
				returnValue = arrc.getItemIndex( cursor.current );
			} 	
			if( returnValue != -1 ) { 
				returnObject = arrc.getItemAt(returnValue);
			}
			return returnObject;
		}
		public static function addArrcStrictItem( item:Object, arrc:ArrayCollection, sortString:String, modified:Boolean =false ):void{
			var returnValue:int = -1;
			var sort:Sort = new Sort(); 
			sort.fields = [ new SortField( sortString ) ];
			if(arrc.sort==null) arrc.sort = sort;
			arrc.refresh(); 
			var cursor:IViewCursor = arrc.createCursor();
			var found:Boolean = cursor.findAny( item );	
			if( found ) {
				returnValue = arrc.getItemIndex( cursor.current );
			} 	
			if( returnValue == -1 ) {
				arrc.addItem(item);
			}else{
				if(modified){
					arrc.removeItemAt(returnValue);
					arrc.addItemAt(item, returnValue);
				}
			}
		} 
		/**
		 * @item //The New Item to be added
		 * @source //The  Array in which the new item is to be added
		 * @sortString //The property of the item by which the comparison takes place
		 * Checks wheather the item to be added already exists in the array, if so replaces it
		 * otherwise just pushes the new object and returns the source array
		 */
		public static function pushNewItem( item:Object, source:Array, sortString:String ):Array {
			var findIndex:int = -1;
			
			for( var i:int = 0; i < source.length; i++ ) {
				if( source[ i ][ sortString ] == item[ sortString ] ) {
					findIndex = i;
					break;
				}
			}
			
			if( findIndex != -1 ) {
				source[ findIndex ] = item;
			}
			else {
				source.push( item );
			}
			
			return source;
		} 
	}
}