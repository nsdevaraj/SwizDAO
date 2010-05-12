package com.adams.scrum.models.vo
{
	public class AbstractVO implements IValueObject
	{
		public function AbstractVO()
		{
		}
		private var _processed:Boolean

		public function get processed():Boolean
		{
			return _processed;
		}

		public function set processed(value:Boolean):void
		{
			_processed = value;
		}

	}
}