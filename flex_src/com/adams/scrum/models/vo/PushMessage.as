package com.adams.scrum.models.vo
{
	public class PushMessage extends AbstractVO
	{
		public function PushMessage(nameStr:String,sentTo:Array,desc:Object)
		{
			 name = nameStr;
			 receivers = sentTo;
			 description = desc;
		}
		private var _receivers:Array;
		private var _name:String;
		private var _description:Object;

		public function get description():Object
		{
			return _description;
		}

		public function set description(value:Object):void
		{
			_description = value;
		}

		public function get receivers():Array
		{
			return _receivers;
		}

		public function set receivers(value:Array):void
		{
			_receivers = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		 
	}
}