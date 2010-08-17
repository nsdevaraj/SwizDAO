package com.adams.cambook.models.vo
{
	[Bindable]
	[RemoteClass(alias='com.adams.cambook.dao.entities.FileDetails')]
	public class Files extends AbstractVO
	{
		 
		private var _personFK:int;
		private var _fileID:int;
		private var _filedate:Date;
		private var _filename:String;
		private var _filepath:String;  
		
		public function Files()
		{
			super();
		}  
		 
		
		public function get personFK():int
		{
			return _personFK;
		}

		public function set personFK(value:int):void
		{
			_personFK = value;
		}

		public function get filepath():String
		{
			return _filepath;
		}
		
		public function set filepath(value:String):void
		{
			_filepath = value;
		}
		
		public function get filename():String
		{
			return _filename;
		}
		
		public function set filename(value:String):void
		{
			_filename = value;
		}
		
		public function get filedate():Date
		{
			return _filedate;
		}
		
		public function set filedate(value:Date):void
		{
			_filedate = value;
		}
		
		public function get fileID():int
		{
			return _fileID;
		}
		
		public function set fileID(value:int):void
		{
			_fileID = value;
		} 
		
	}
}