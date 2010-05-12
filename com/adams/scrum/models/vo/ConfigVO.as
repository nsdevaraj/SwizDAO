package com.adams.scrum.models.vo
{ 
	[Bindable]
	public class ConfigVO extends AbstractVO
	{
		public function ConfigVO()
		{ 
		}
		private var _dbserver:String
		private var _serverLocation:String
		private var _FileServer:String
		private var _pdfServerDir:String
		private var _CF:int
		private var _prjCount:int = 257
		private var _evalMins:String
		private var _Copyright:String
		private var _SmtpHost:String
		private var _SmtpPort:String
		private var _SmtpUsername:String
		private var _SmtpPassword:String
		private var _SmtpfrmLbl:String
		private var _SmtpTeamEmail:String
		private var _allReports:Boolean
		
		public function get dbserver():String
		{
			return _dbserver;
		}
		
		public function set dbserver(value:String):void
		{
			_dbserver = value;
		}
		
 		public function get serverLocation():String
		{
			return _serverLocation;
		}
		
		public function set serverLocation(value:String):void
		{
			_serverLocation = value;
		}
		
		public function get FileServer():String
		{
			return _FileServer;
		}
		
		public function set FileServer(value:String):void
		{
			_FileServer = value;
		}
		
		public function get pdfServerDir():String
		{
			return _pdfServerDir;
		}
		
		public function set pdfServerDir(value:String):void
		{
			_pdfServerDir = value;
		}
		
		public function get CF():int
		{
			return _CF;
		}
		
		public function set CF(value:int):void
		{
			_CF = value;
		}
		
		public function get prjCount():int
		{
			return _prjCount;
		}
		
		public function set prjCount(value:int):void
		{
			_prjCount = value;
		}
		
		public function get evalMins():String
		{
			return _evalMins;
		}
		
		public function set evalMins(value:String):void
		{
			_evalMins = value;
		}
		
		public function get Copyright():String
		{
			return _Copyright;
		}
		
		public function set Copyright(value:String):void
		{
			_Copyright = value;
		}
		
		public function get SmtpHost():String
		{
			return _SmtpHost;
		}
		
		public function set SmtpHost(value:String):void
		{
			_SmtpHost = value;
		}
		
		public function get SmtpPort():String
		{
			return _SmtpPort;
		}
		
		public function set SmtpPort(value:String):void
		{
			_SmtpPort = value;
		}
		
		public function get SmtpUsername():String
		{
			return _SmtpUsername;
		}
		
		public function set SmtpUsername(value:String):void
		{
			_SmtpUsername = value;
		}
		
		public function get SmtpPassword():String
		{
			return _SmtpPassword;
		}
		
		public function set SmtpPassword(value:String):void
		{
			_SmtpPassword = value;
		}
		
		public function get SmtpfrmLbl():String
		{
			return _SmtpfrmLbl;
		}
		
		public function set SmtpfrmLbl(value:String):void
		{
			_SmtpfrmLbl = value;
		}
		
		public function get SmtpTeamEmail():String
		{
			return _SmtpTeamEmail;
		}
		
		public function set SmtpTeamEmail(value:String):void
		{
			_SmtpTeamEmail = value;
		}
		
		public function get allReports():Boolean
		{
			return _allReports;
		}
		
		public function set allReports(value:Boolean):void
		{
			_allReports = value;
		}
		
		public function set authenticated (value:int):void
		{
			_authenticated = value;
		}
		
		private var _authenticated:int = 0;
		public function get authenticated ():int
		{
			return _authenticated;
		}
		private var _login:String;
		public function set login (value:String):void
		{
			_login = value;
		}
		
		public function get login ():String
		{
			return _login;
		}
		
		
		
		private var _password:String;
		public function set password (value:String):void
		{
			_password = value;
		}
		
		public function get password ():String
		{
			return _password;
		} 	
	}
}