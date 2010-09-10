package com.adams.cambook.views.components
{
	import org.osflash.signals.Signal;
	
	import spark.components.DataGroup;
	
	public class NativeDataGroup extends DataGroup
	{
		
		public static const REPLIEDUPDATE:String = 'replyUpdate';
		public static const FOLLOWPERSON:String = 'followPerson';  
		public var currentPersonId:int;  
		public var renderSignal:Signal = new Signal();
		public function NativeDataGroup()
		{
			super();
		}
	}
}