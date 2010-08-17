package com.adams.cambook.models.vo
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias='com.adams.cambook.dao.entities.Persons')]
	public class Persons extends AbstractVO
	{
		 
		 
		public var  personRelations:int;
		public var  tweetId:String;
		public var  personAvailability:int;
		public var  personPhotoFK:Files;
		public var  personQuestion:int;
		public var  personAnswer:String;
		
		[ArrayElementType( "com.adams.cambook.models.vo.Persons" )]
		public var  connectionSet:ArrayCollection;
		
		private var _activated:int;
		private var _personCity:String;
		private var _personCountry:String;
		private var _personEmail:String;
		private var _personFirstname:String;
		private var _PersonId:int;
		private var _personLastname:String;
		private var _personMobile:String;
		private var _personPassword:String;
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
		 
		public function get personLastname():String
		{
			return _personLastname;
		}
		
		public function set personLastname(value:String):void
		{
			_personLastname = value;
		}
		
		public function get PersonId():int
		{
			return _PersonId;
		}
		
		public function set PersonId(value:int):void
		{
			_PersonId = value;
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