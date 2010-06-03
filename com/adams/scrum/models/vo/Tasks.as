package com.adams.scrum.models.vo
{
	import com.adams.scrum.dao.AbstractDAO;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias='com.adams.scrum.pojo.Tasks')]
	public class Tasks extends AbstractVO
	{ 

		/*public function get personObject():Persons
		{
			return _personObject;
		}

		public function set personObject(value:Persons):void
		{
			_personObject = value;
		}*/
 
		public function get taskStatusFk():int
		{
			return _taskStatusFk;
		}
		
		public function set taskStatusFk(value:int):void
		{
			_taskStatusFk = value;
		}
		
		public function get taskId():int
		{
			return _taskId;
		}
		
		public function set taskId(value:int):void
		{
			_taskId = value;
		}
		
		public function get taskComment():ByteArray
		{
			return _taskComment;
		}
		
		public function set taskComment(value:ByteArray):void
		{
			_taskComment = value;
		}
		 
		
		public function get personFk():int
		{
			return _personFk;
		}
		
		public function set personFk(value:int):void
		{
			_personFk = value;
		}
		 
		public function get TDateCreation():Date
		{
			return _TDateCreation;
		}
		
		public function set TDateCreation(value:Date):void
		{
			_TDateCreation = value;
		}
		 
		private var _TDateCreation:Date;
		private var _TDateDone:Date;
		private var _TDateInprogress:Date;
		private var _TDateValidation:Date;
		private var _doneTime:int;
		private var _estimatedTime:int;
		private var _onairTime:int;
		private var _personFk:int;
		private var _storyFk:int;
		private var _taskComment:ByteArray;
		private var _taskId:int;
		private var _taskStatusFk:int;
		private var _taskType:int;
		private var _visible:Boolean;
		//private var _personObject:Persons; 
		[ArrayElementType("com.adams.scrum.models.vo.Tickets")]
		private var _ticketCollection:ArrayCollection = new ArrayCollection();

		[ArrayElementType("com.adams.scrum.models.vo.Files")]
		private var _fileCollection:ArrayCollection = new ArrayCollection();
		
		public function Tasks()
		{
			super();
		}
	}
}