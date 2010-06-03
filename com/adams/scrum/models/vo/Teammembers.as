package com.adams.scrum.models.vo
{
	[Bindable]
	[RemoteClass(alias='com.adams.scrum.pojo.Teammembers')]
	public class Teammembers extends AbstractVO
	{
		private var _personFk:int;
		private var _profileFk:int;
		private var _teamFk:int;
		private var _teammemberId:int;
		
		public function Teammembers()
		{
			super();
		} 
		
		public function get personFk():int
		{
			return _personFk;
		}
		
		public function set personFk(value:int):void
		{
			_personFk = value;
		}
		
		public function get profileFk():int
		{
			return _profileFk;
		}
		
		public function set profileFk(value:int):void
		{
			_profileFk = value;
		}
		
		public function get teamFk():int
		{
			return _teamFk;
		}
		
		public function set teamFk(value:int):void
		{
			_teamFk = value;
		}
		
		public function get teammemberId():int
		{
			return _teammemberId;
		}
		
		public function set teammemberId(value:int):void
		{
			_teammemberId = value;
		}
		
	}
}