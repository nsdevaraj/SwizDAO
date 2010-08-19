package com.adams.cambook.models.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias='com.adams.cambook.dao.entities.Notes')]
	public class Notes extends AbstractVO
	{
		private var _noteId:int;
		private var _description:String;
		private var _creationDate:Date;
		private var _createdPersonFK:int;
		private var _FileObj:Files;
		private var  _noteType:int;
		private var  _PersonObj:Persons;
		
		[ArrayElementType( "com.adams.cambook.models.vo.Notes" )]
		public var  notesSet:ArrayCollection;
		public var  personFK:int;
 
		public function Notes()
		{
			super();
		}

		public function get PersonObj():Persons
		{
			return _PersonObj;
		}

		public function set PersonObj(value:Persons):void
		{
			_PersonObj = value;
		}

		public function get noteType():int
		{
			return _noteType;
		}

		public function set noteType(value:int):void
		{
			_noteType = value;
		}

		public function get FileObj():Files
		{
			return _FileObj;
		}

		public function set FileObj(value:Files):void
		{
			_FileObj = value;
		}

		public function get creationDate():Date
		{
			return _creationDate;
		}

		public function set creationDate(value:Date):void
		{
			_creationDate = value;
		}

		public function get createdPersonFK():int
		{
			return _createdPersonFK;
		}

		public function set createdPersonFK(value:int):void
		{
			_createdPersonFK = value;
		}

		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}

		public function get noteId():int
		{
			return _noteId;
		}

		public function set noteId(value:int):void
		{
			_noteId = value;
		}

	}
}