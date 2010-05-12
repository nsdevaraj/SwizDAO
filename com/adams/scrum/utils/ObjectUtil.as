package com.adams.scrum.utils
{
	public class ObjectUtil
	{
		public function ObjectUtil()
		{
		}
		
		public static function hasOwnProperties( target:Object, ...propNames/* of String */ ):Boolean
		{
			var len:uint = propNames.length;
			for ( var i:uint = 0; i < len;i++ ) {
				if ( !target.hasOwnProperty(propNames[i]) ) return false;
			}
			return true;
		}
		
		public static function propLength( target:Object ):uint
		{
			var n:uint = 0;
			for (var val:String in target) n++;
			return n;
		}
		
		public static function toArray(target:Object, propNames:Array=null /* of String */ ):Array
		{
			var a:Array = [];
			if ( propNames ) {
				var len:uint = propNames.length;
				for (var i:uint = 0; i < len; i++ ) {
					a.push( target[propNames[i]] );
				}
				return a;
			} else {
				for (var val:String in target) {
					a.push(target[val]);
				}
				return a;
			}
		}
		
		public static function getPropNames(target:Object):Array
		{
			var a:Array = [];
			for (var val:String in target) a.push(val);
			return a;
		}
		
		public static function getPropValues(target:Object):Array
		{
			var a:Array = [];
			for each(var val:* in target) a.push(val);
			return a;
		}
		
		/* public static function compareObjects(currentObj:Object, oldObj:Object):Array
		{
		var propArr:Array = getPropNames(currentObj);
		var curObjVal:Array = getPropValues(currentObj);
		var oldObjVal:Array = getPropValues(oldObj);
		var diffArr:Array = ArrayUtil.matches(curObjVal,oldObjVal);
		for each(var obj:Object in diffArr){
		trace(obj);
		}
		} */
	}
}