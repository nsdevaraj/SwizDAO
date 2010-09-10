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
		private var _fileObj:Files;
		private var  _noteType:int;
		private var  _PersonObj:Persons;
		private var _noteStatusFK:int;
		[ArrayElementType( "com.adams.cambook.models.vo.Notes" )]
		private var  _notesSet:ArrayCollection = new ArrayCollection();
		public var  personFK:int;
 		public var noteFK:int;
		public function Notes()
		{
			super();
		}
 

		public function get notesSet():ArrayCollection
		{
			return _notesSet;
		}

		public function set notesSet(value:ArrayCollection):void
		{
			_notesSet = value;
		}

		public function get noteStatusFK():int
		{
			return _noteStatusFK;
		}

		public function set noteStatusFK(value:int):void
		{
			_noteStatusFK = value;
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

		public function get fileObj():Files
		{
			return _fileObj;
		}

		public function set fileObj(value:Files):void
		{
			_fileObj = value;
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