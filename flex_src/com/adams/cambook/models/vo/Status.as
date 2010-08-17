package com.adams.cambook.models.vo
{
	[Bindable]
	[RemoteClass(alias='com.adams.scrum.pojo.Status')]
	public class Status extends AbstractVO
	{
		private var _statusId:int;
		private var _statusLabel:String;
		private var _type:String;
		
		public function Status()
		{
			super();
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
		public function get statusLabel():String
		{
			return _statusLabel;
		}
		
		public function set statusLabel(value:String):void
		{
			_statusLabel = value;
		}
		
		public function get statusId():int
		{
			return _statusId;
		}
		
		public function set statusId(value:int):void
		{
			_statusId = value;
		}
		 
	}
}