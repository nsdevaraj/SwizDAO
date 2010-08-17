package com.adams.cambook.models.vo
{
	[Bindable]
	[RemoteClass(alias='com.adams.scrum.pojo.Events')]
	public class Notes extends AbstractVO
	{
		private var _eventDate:Date;
		private var _eventId:int;
		private var _eventLabel:String;
		private var _eventStatusFk:int;
		private var _personFk:int;
		private var _productFk:int;
		private var _sprintFk:int;
		private var _storyFk:int;
		private var _taskFk:int;
		private var _ticketFk:int;
		
		private var _statusObject:Status;
		
		public function Notes()
		{
			super();
		}
		
		public function get ticketFk():int
		{
			return _ticketFk;
		}
		
		public function set ticketFk(value:int):void
		{
			_ticketFk = value;
		}
		
		public function get taskFk():int
		{
			return _taskFk;
		}
		
		public function set taskFk(value:int):void
		{
			_taskFk = value;
		}
		
		public function get storyFk():int
		{
			return _storyFk;
		}
		
		public function set storyFk(value:int):void
		{
			_storyFk = value;
		}
		
		public function get sprintFk():int
		{
			return _sprintFk;
		}
		
		public function set sprintFk(value:int):void
		{
			_sprintFk = value;
		}
		
		public function get productFk():int
		{
			return _productFk;
		}
		
		public function set productFk(value:int):void
		{
			_productFk = value;
		}
		
		public function get personFk():int
		{
			return _personFk;
		}
		
		public function set personFk(value:int):void
		{
			_personFk = value;
		}
		
		public function get eventStatusFk():int
		{
			return _eventStatusFk;
		}
		
		public function set eventStatusFk(value:int):void
		{
			_eventStatusFk = value;
		}
		
		public function get eventLabel():String
		{
			return _eventLabel;
		}
		
		public function set eventLabel(value:String):void
		{
			_eventLabel = value;
		}
		
		public function get eventId():int
		{
			return _eventId;
		}
		
		public function set eventId(value:int):void
		{
			_eventId = value;
		} 
		
		public function get eventDate():Date
		{
			return _eventDate;
		}
		
		public function set eventDate(value:Date):void
		{
			_eventDate = value;
		}
		public function get statusObject():Status
		{
			return _statusObject;
		}
		
		public function set statusObject(value:Status):void
		{
			_statusObject = value;
		}
	}
}