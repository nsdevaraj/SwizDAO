package com.adams.cambook.models.vo
{
	[Bindable]
	[RemoteClass(alias='com.adams.scrum.pojo.Files')]
	public class Files extends AbstractVO
	{
		private var _fileId:int;
		private var _filedate:Date;
		private var _filename:String;
		private var _filepath:String; 
		private var _storedfilename:String; 
		
		public function Files()
		{
			super();
		}  
		
		public function get storedfilename():String
		{
			return _storedfilename;
		}
		
		public function set storedfilename(value:String):void
		{
			_storedfilename = value;
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
		
		public function get fileId():int
		{
			return _fileId;
		}
		
		public function set fileId(value:int):void
		{
			_fileId = value;
		} 
		
	}
}