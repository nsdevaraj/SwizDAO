package com.adams.cambook.utils
{
	import mx.utils.UIDUtil;
	
	public class FileNameSplitter
	{
		public function FileNameSplitter()
		{
		} 
		//@TODO
		public static function splitFileName(str:String):Object{
			var obj:Object = new Object();
			var strlength:int = str.length;
			var splitter:int=0;
			for (var i:int=strlength;i>=0;i--){			
				if(str.charAt(i)=="."){
					splitter = i;
					break;
				}
			}
			
			var filename:String = str.substr(0,splitter);
			var extension:String = str.substr(splitter+1,str.length-1);
			obj.filename = filename;
			obj.extension = extension;
			return obj;
		}
		
		public static function getUId():String{
			return UIDUtil.createUID();
		}
		
	}
}