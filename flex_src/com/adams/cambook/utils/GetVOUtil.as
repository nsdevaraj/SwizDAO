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
	 
	import com.adams.cambook.models.collections.ICollection;
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.models.vo.Persons; 
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	public class GetVOUtil
	{  
		private static var sort:Sort
		private static var dp:ArrayCollection;
		private static var cursor:IViewCursor;
		private static var found:Boolean; 
		//@TODO
		public static function getPersonObject( username:String, password:String,arrc:ArrayCollection):Persons{
			var item:IValueObject = new Persons();
			Persons(item).personEmail= username;
			Persons(item).personPassword = password;
			arrc.sort = null;
			var returnPerson:Persons = getValueObject(item,'personEmail',arrc) as Persons;
			arrc.sort = null;
			return returnPerson; 
		}   
		public static function getVOObject( pkId:int, coll:IList, primaryKey:String, clz:Class):IValueObject{
			var item:IValueObject = new clz();
			clz(item)[primaryKey] = pkId;
			var returnClz :IValueObject;
			if(coll)
				returnClz = getValueObject(item,primaryKey, coll as ArrayCollection) as IValueObject;
			return returnClz;
		} 
		public static function getValueObject( item:IValueObject,sortField:String,arrc:ArrayCollection ):IValueObject{
			sort = new Sort(); 
			sort.fields = [ new SortField( sortField ) ];
			dp = arrc;
			if( dp.sort == null ) {
				dp.sort = sort;
				dp.refresh(); 
			}
			cursor =  dp.createCursor(); 
			try{
				found = cursor.findAny( item );
			}
			catch(err:Error){
				
			}finally{
				if ( found )  {
					item = IValueObject( cursor.current ); 
				}
				return item;
			} 
		} 
		public static function getStatusObject( coll:IList, filedKey:String, primaryKey:String, clz:Class):ArrayCollection{
			var returnArrayCollection:ArrayCollection = new ArrayCollection();
			if(coll){
				var tempArrayCollection:ArrayCollection = coll as ArrayCollection;
				var item:IValueObject = new clz();
				for each(item in tempArrayCollection){
					if(clz(item)[filedKey] == primaryKey){
						returnArrayCollection.addItem(item);
					}
				}
			}
			return returnArrayCollection;
		}
		
		public static function sortArrayCollection( sortField:String,arrc:IList ):IList{
			if(arrc){
				sort = new Sort(); 
				sort.fields = [ new SortField( sortField ) ];
				if( ArrayCollection(arrc).sort == null ) {
					ArrayCollection(arrc).sort = sort;
					ArrayCollection(arrc).refresh(); 
				}
			}
			return arrc;
		}  
		
	}
}