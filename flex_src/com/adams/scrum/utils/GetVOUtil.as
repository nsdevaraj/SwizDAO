package com.adams.scrum.utils
{  
	 
	import com.adams.scrum.models.collections.ICollection;
	import com.adams.scrum.models.vo.IValueObject;
	import com.adams.scrum.models.vo.Persons;
	
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
		
		public static function getPersonObject( username:String, password:String,arrc:ArrayCollection):Persons{
			var item:IValueObject = new Persons();
			Persons(item).personLogin = username;
			Persons(item).personPassword = password;
			var returnPerson:Persons = getValueObject(item,'personLogin',arrc) as Persons;
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
	}
}