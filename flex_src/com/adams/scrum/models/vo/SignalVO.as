package com.adams.scrum.models.vo
{
	import com.adams.scrum.dao.AbstractDAO;
	import com.adams.scrum.models.collections.ICollection;
	import com.adams.scrum.models.processor.IVOProcessor;
	
	import mx.collections.IList;
	
	[Bindable]
	public class SignalVO extends AbstractVO
	{
		public function SignalVO(obj:Object=null, dao:AbstractDAO = null, actionStr:String ='', pushmsg:PushMessage = null)
		{
			if(obj)objectId = obj.name;
			if(dao){
				destination = dao.destination;
				collection = dao.collection;
				processor = dao.processor;
				action = actionStr;
			}
			if(pushmsg){
				receivers = pushmsg.receivers;
				name = pushmsg.name;
				description = pushmsg.description;
			}
		}
		private var _receivers:Array;
		
		public function get objectId():String
		{
			return _objectId;
		}

		public function set objectId(value:String):void
		{
			_objectId = value;
		}

		public function get destination():String
		{
			return _destination;
		}
		
		public function set destination(value:String):void
		{
			_destination = value;
		}
		private var _destination:String 
		
		public function get processor():IVOProcessor
		{
			return _processor;
		}

		public function set processor(value:IVOProcessor):void
		{
			_processor = value;
		}

		public function set receivers (value:Array):void
		{
			_receivers = value;
		}
		
		public function get receivers ():Array
		{
			return _receivers;
		} 
		
		private var _name:String;
		public function set name (value:String):void
		{
			_name = value;
		}
		
		public function get name ():String
		{
			return _name;
		}
		
		private var _action:String;
		public function set action (value:String):void
		{
			_action = value;
		}
		
		public function get action ():String
		{
			return _action;
		}
		private var _id:int;
		public function set id (value:int):void
		{
			_id = value;
		}
		
		public function get id ():int
		{
			return _id;
		}
		
		private var _valueObject:IValueObject;
		public function set valueObject (value:IValueObject):void
		{
			_valueObject = value;
		}
		
		public function get valueObject ():IValueObject
		{
			return _valueObject;
		}
		private var _processor:IVOProcessor;
		
		private var _collection:ICollection;
		public function set collection (value:ICollection):void
		{
			_collection = value;
		}
		
		public function get collection ():ICollection
		{
			return _collection;
		}
		
		private var _list:IList;
		public function set list (value:IList):void
		{
			_list = value;
		}
		
		public function get list ():IList
		{
			return _list;
		}
		
		private var _description:Object;
		public function set description (value:Object):void
		{
			_description = value;
		}
		
		public function get description ():Object
		{
			return _description;
		}
		private var _objectId:String
	}
}