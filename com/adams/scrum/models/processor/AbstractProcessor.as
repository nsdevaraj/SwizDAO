package com.adams.scrum.models.processor
{
	import com.adams.scrum.dao.AbstractDAO;
	import com.adams.scrum.models.collections.ICollection;
	import com.adams.scrum.models.vo.IValueObject;
	import com.adams.scrum.models.vo.SignalVO;
	import com.adams.scrum.response.SignalSequence;
	import com.adams.scrum.utils.Action;
	
	import mx.collections.IList;

	public class AbstractProcessor implements IVOProcessor
	{
		[Inject]
		public var signalSeq:SignalSequence;
		
		public function AbstractProcessor()
		{
		} 
		
		public function processCollection(arrayCollection:IList):void
		{
			for each(var vo:Object in arrayCollection){
				processVO(vo as IValueObject);
				vo.processed = true;
			}
		}
		public function processVO(vo:IValueObject):void
		{
			//overridden
		}
		public function processAddPushMessage(signal:SignalVO,dao:AbstractDAO):void{
			signal.action = Action.FINDPUSH_ID;
			signal.destination = dao.destination;
			signal.collection = dao.collection;
			signal.processor = dao.processor;
			signal.id = signal.description as int;
			signalSeq.addSignal(signal);			
		}
		public function processUpdatePushMessage(signal:SignalVO,dao:AbstractDAO):void{
			signal.action = Action.FINDPUSH_ID;
			signal.destination = dao.destination;
			signal.collection = dao.collection;
			signal.processor = dao.processor;
			signal.id = signal.description as int;
			signalSeq.addSignal(signal);				
		}
	}
}