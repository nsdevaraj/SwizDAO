package com.adams.cambook.models.vo
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias='com.adams.cambook.dao.entities.Persons')]
	public class Persons extends AbstractVO
	{
		 
		 
		private var  _personRelations:int;
		private var  _tweetId:String;
		private var  _personAvailability:int;
		private var  _personPhotoFK:Files;
		private var  _personQuestion:int;
		private var  _personAnswer:String;
		private var  _tweetPassword:String;
		private var  _personRole:String;
		 
		[ArrayElementType( "com.adams.cambook.models.vo.Persons" )]
		public var  connectionSet:ArrayCollection = new ArrayCollection();
		
		[ArrayElementType( "com.adams.cambook.models.vo.Notes" )]
		public var  notesSet:ArrayCollection = new ArrayCollection();
		
		private var _activated:int;
		private var _personCity:String;
		private var _personCountry:String;
		private var _personEmail:String;
		private var _personFirstname:String;
		private var _personId:int;
		private var _personLastname:String;
		private var _personMobile:String;
		private var _personPassword:String;
		private var _personPostalCode:String; 
		
		public var connectionArr:Array=[]; 
		public function Persons()
		{
			super();
		} 
		 

		public function get personRelations():int
		{
			return _personRelations;
		}

		public function set personRelations(value:int):void
		{
			_personRelations = value;
		}

		public function get tweetId():String
		{
			return _tweetId;
		}

		public function set tweetId(value:String):void
		{
			_tweetId = value;
		}

		public function get personPhotoFK():Files
		{
			return _personPhotoFK;
		}

		public function set personPhotoFK(value:Files):void
		{
			_personPhotoFK = value;
		}

		public function get personAvailability():int
		{
			return _personAvailability;
		}

		public function set personAvailability(value:int):void
		{
			_personAvailability = value;
		}

		public function get personQuestion():int
		{
			return _personQuestion;
		}

		public function set personQuestion(value:int):void
		{
			_personQuestion = value;
		}

		public function get personAnswer():String
		{
			return _personAnswer;
		}

		public function set personAnswer(value:String):void
		{
			_personAnswer = value;
		}

		public function get tweetPassword():String
		{
			return _tweetPassword;
		}

		public function set tweetPassword(value:String):void
		{
			_tweetPassword = value;
		}

		public function get personRole():String
		{
			return _personRole;
		}

		public function set personRole(value:String):void
		{
			_personRole = value;
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