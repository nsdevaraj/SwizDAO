package com.adams.scrum.models.vo
{
	import flash.utils.ByteArray;
	
	[Bindable]
	[RemoteClass(alias='com.adams.scrum.pojo.Persons')]
	public class Persons extends AbstractVO
	{
		private var _activated:int;
		private var _personAddress:String;
		private var _personCity:String;
		private var _personCountry:String;
		private var _personDateentry:Date;
		private var _personEmail:String;
		private var _personFirstname:String;
		private var _personId:int;
		private var _personLastname:String;
		private var _personLogin:String;
		private var _personMobile:String;
		private var _personPassword:String;
		private var _personPict:ByteArray;
		private var _personPosition:String;
		private var _personPostalCode:String;
		
		public function Persons()
		{
			super();
		}
		
		public function get personPostalCode():String
		{
			return _personPostalCode;
		}
		
		public function set personPostalCode(value:String):void
		{
			_personPostalCode = value;
		}
		
		public function get personPosition():String
		{
			return _personPosition;
		}
		
		public function set personPosition(value:String):void
		{
			_personPosition = value;
		}
		
		public function get personPict():ByteArray
		{
			return _personPict;
		}
		
		public function set personPict(value:ByteArray):void
		{
			_personPict = value;
		}
		
		public function get personPassword():String
		{
			return _personPassword;
		}
		
		public function set personPassword(value:String):void
		{
			_personPassword = value;
		}
		
		public function get personMobile():String
		{
			return _personMobile;
		}
		
		public function set personMobile(value:String):void
		{
			_personMobile = value;
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
		
		public function get personDateentry():Date
		{
			return _personDateentry;
		}
		
		public function set personDateentry(value:Date):void
		{
			_personDateentry = value;
		}
		
		public function get personCountry():String
		{
			return _personCountry;
		}
		
		public function set personCountry(value:String):void
		{
			_personCountry = value;
		}
		
		public function get personCity():String
		{
			return _personCity;
		}
		
		public function set personCity(value:String):void
		{
			_personCity = value;
		}
		
		public function get personAddress():String
		{
			return _personAddress;
		}
		
		public function set personAddress(value:String):void
		{
			_personAddress = value;
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