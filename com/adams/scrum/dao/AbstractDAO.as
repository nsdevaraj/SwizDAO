package com.adams.scrum.dao
{
	import com.adams.scrum.controller.ServiceController;
	import com.adams.scrum.models.processor.IVOProcessor;
	import com.adams.scrum.models.vo.IValueObject;
	import com.adams.scrum.models.vo.SignalVO;
	import com.adams.scrum.service.NativeMessenger;
	import com.adams.scrum.utils.Action;
	import com.adams.scrum.utils.Description;
	
	public class AbstractDAO extends CRUDObject
	{  
		[Inject]
		public var messenger:NativeMessenger;
		
		public function AbstractDAO(destn:String,process:IVOProcessor =null)
		{
			destination = destn;
			processor = process;
		} 		
		
		protected var _controlService:ServiceController;  
		public function get controlService():ServiceController  {
			return _controlService;
		}
		
		[Inject]
		public function set controlService( ro:ServiceController ):void {
			_controlService = ro; 
			remoteService = _controlService.authRo;
		}
		
		[MediateSignal(type="AbstractSignal")]
		public function invokeAction(obj:SignalVO):void {
			if(obj.destination == this.destination){
				switch(obj.action){
					case Action.CREATE:
						create(obj.valueObject);
						break;
					case Action.UPDATE:
						update(obj.valueObject);
						break;
					case Action.READ:
						read(obj.id);
						break;
					case Action.FIND_ID:
						findById(obj.id);
						break; 
					case Action.DELETE:
						deleteById(obj.valueObject);
						break;
					case Action.GET_COUNT:
						count();
						break;
					case Action.GET_LIST:
						getList();
						break;
					case Action.BULK_UPDATE:
						bulkUpdate(obj.list);
						break;
					case Action.DELETE_ALL:
						deleteAll();
						break;
					case Action.PUSH_MSG:
						messenger.produceMessage(obj);
						break;
					case Action.RECEIVE_MSG:
						obj.action = Action.FINDPUSH_ID;
						switch(obj.name ){
							case Description.CREATE:
							case Description.UPDATE: 
								findId(obj.description as int); 
								break;
						}
				}
			}
		}  
		
	}
}