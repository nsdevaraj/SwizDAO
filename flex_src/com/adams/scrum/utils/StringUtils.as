package com.adams.scrum.utils
{
	public class StringUtils{
		private static var accents:Array= ['é','é','è','ç','à','ê','ë','ô','ö','î','ï','û','ü','â','ä','ù','Œ','œ','€','æ', 'Æ','-','+','%','~','&','!',"#"];
		private static var alphbets:Array=['e','e','e','c','a','e','e','o','o','i','i','u','u','a','a','u','OE','oe','e','ae','AE','_','_','_','_','_','_','_'];
		private static const STrimExp:RegExp = /[^a-zA-Z0-9.-_+]/;
		private static const nTrimExp:RegExp = /[`.@$|?<>:"\\\^\*\/+]/g;
		public static function trimSpace(v:String):String{
			return v.replace(/\s+/g, '');
		} 
		public static function specialtrim(v:String):String{ 
			return v.replace(STrimExp, "_");
		}
		public static function trimAll(v:String):String{
			return specialtrim(trimSpace(v));
		} 
		public static function compatibleTrim(v:String):String{
			for (var i:int =0; i<accents.length; i++){
				if(v.indexOf(accents[i])!= -1) 
					v = v.replace( new RegExp(accents[i], "i"),alphbets[i]);
			} 
			v = v.replace( nTrimExp,'_');
			return (trimSpace(v)); 
		}
	}
}