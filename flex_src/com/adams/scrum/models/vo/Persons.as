package com.adams.scrum.models.vo
{
	import flash.utils.ByteArray;
	
	[Bindable]
	[RemoteClass(alias='com.adams.scrum.pojo.Persons')]
	public class Persons extends AbstractVO
	{
		private var _activated:int; 
		private var _personEmail:String;
		private var _personFirstname:String;
		private var _personId:int;
		private var _personLastname:String;
		private var _personLogin:String; 
		private var _personPassword:String;
		
		public function Persons()
		{
			super();
		} 
		public function get personPassword():String
		{
			return _personPassword;
		}
		
		public function set personPassword(value:String):void
		{
			_personPassword = value;
		}
		 
		
		public function get personLogin():String
		{
			return _personLogin;
		}
		
		public function set personLogin(value:String):void
		{
			_personLogin = value;
		}
		
		public function get personLastname():String
		{
			return _personLastname;
		}
		
		public function set personLastname(value:String):void
		{
			_personLastname = value;
		}
		
		public function get personId():int
		{
			return _personId;
		}
		
		public function set personId(value:int):void
		{
			_personId = value;
		}
		
		public function get personFirstname():String
		{
			return _personFirstname;
		}
		
		public function set personFirstname(value:String):void
		{
			_personFirstname = value;
		}
		
		public function get personEmail():String
		{
			return _personEmail;
		}
		
		public function set personEmail(value:String):void
		{
			_personEmail = value;
		}
		 
		
		public function get activated():int
		{
			return _activated;
		}
		
		public function set activated(value:int):void
		{
			_activated = value;
		}
		
	}
}