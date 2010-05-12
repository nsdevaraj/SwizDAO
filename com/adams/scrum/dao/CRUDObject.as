package com.adams.scrum.dao 
{
	import com.adams.scrum.models.collections.AbstractCollection;
	import com.adams.scrum.models.collections.ICollection;
	import com.adams.scrum.models.processor.AbstractProcessor;
	import com.adams.scrum.models.processor.IVOProcessor;
	import com.adams.scrum.models.vo.IValueObject;
	import com.adams.scrum.response.AbstractResult;
	import com.adams.scrum.utils.Action;
	
	import mx.collections.IList;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class CRUDObject  
	{

		public function get processor():IVOProcessor
		{
			return _processor;
		}

		public function set processor(value:IVOProcessor):void
		{
			_processor = value;
		}

		public function CRUDObject():void { 
			
		}
		[Inject]
		public var delegate:AbstractResult;
		
		protected var _remoteService:RemoteObject;  
		public function get remoteService():RemoteObject  {
			return _remoteService;
		}
		
		public function set remoteService( ro:RemoteObject ):void {
			_remoteService = ro; 
		}
		
		protected var _destination:String;  
		public function get destination():String {
			return _destination;
		}
		
		public function set destination( str:String ):void {
			_destination = str;
		}
		
		public function invoke(action:String):void{
			remoteService.destination = destination;
		}
		
		private var _processor:IVOProcessor;
		
		protected var _collection:ICollection = new AbstractCollection();
		
		public function get collection():ICollection {
			return _collection;
		}
		
		public function set collection(v:ICollection):void {
			_collection=v;
		}
		
		public function create( vo:IValueObject ):AsyncToken {
			invoke(Action.CREATE);
			delegate.token = remoteService.create(vo);
			return delegate.token;
		}
		
		public function update( vo:IValueObject ):AsyncToken {
			invoke(Action.UPDATE);
			delegate.token = remoteService.update(vo);
			return delegate.token;
		}
		
		public function read( id:int ):AsyncToken {
			invoke(Action.READ);
			delegate.token = remoteService.findByTaskId( id );
			return delegate.token;
		}
		
		public function findById( id:int ):AsyncToken {
			invoke(Action.FIND_ID);
			delegate.token = remoteService.findById( id );
			return delegate.token;
		}
		
		public function findId( id:int ):AsyncToken {
			invoke(Action.FINDPUSH_ID);
			delegate.token = remoteService.findId( id );
			return delegate.token;
		}
		
		public function deleteById( vo:IValueObject ):AsyncToken {
			invoke(Action.DELETE);
			delegate.token = remoteService.deleteById( vo );
			return delegate.token;
		}
		
		public function count():AsyncToken {
			invoke(Action.GET_COUNT);
			delegate.token = remoteService.count();
			return delegate.token;
		}
		
		public function getList():AsyncToken {
			invoke(Action.GET_LIST);
			delegate.token = remoteService.getList();
			return delegate.token;
		}
		
		public function bulkUpdate( list:IList ):AsyncToken {
			invoke(Action.BULK_UPDATE);
			delegate.token = remoteService.bulkUpdate(list);
			return delegate.token;
		}
		
		public function deleteAll():AsyncToken {
			invoke(Action.DELETE_ALL);
			delegate.token = remoteService.deleteAll();
			return delegate.token;
		}
	}
}