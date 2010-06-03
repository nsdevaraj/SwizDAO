package com.adams.scrum.response
{
	import com.adams.scrum.models.collections.ICollection;
	import com.adams.scrum.models.processor.IVOProcessor;
	import com.adams.scrum.models.vo.SignalVO;
	import com.adams.scrum.signals.AbstractSignal;
	import com.adams.scrum.signals.ResultSignal;
	import com.adams.scrum.utils.Action;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	import org.swizframework.utils.services.ServiceHelper;
	
	public class AbstractResult extends AbstractController
	{
		
		public function AbstractResult()
		{
		} 
		[Inject]
		public var service:ServiceHelper;
		private var _token:AsyncToken = new AsyncToken();
		public function get token():AsyncToken {
			return _token;
		}
		
		public function set token( value:AsyncToken ):void {
			_token = value; 
			service.executeServiceCall(_token, resultHandler, faultHandler,[serviceSignal]);
		} 
		
		private function resultHandler( rpcevt:ResultEvent, token:AbstractSignal = null ):void {
			var resultObj:Object = rpcevt.result;
			var outCollection:ICollection = updateCollection(token.currentCollection, token.currentSignal,resultObj);
			if(token.currentProcessor) processVO(token.currentProcessor,outCollection);
			resultSignal.dispatch(resultObj, token.currentSignal);
			signalSeq.onSignalDone();
		} 
		
		private function processVO(process:IVOProcessor, collection:ICollection):void{
			process.processCollection(collection.items);
		}
		private function updateCollection(collection:ICollection,currentSignal:SignalVO,resultObj:Object):ICollection{
			switch(currentSignal.action){
				case Action.CREATE:
					collection.addItem(resultObj);
					break;
				case Action.UPDATE:
					collection.updateItem(currentSignal.valueObject,resultObj);
					break;
				case Action.READ:
					collection.updateItems(resultObj as ArrayCollection);
					break;
				case Action.FIND_ID:
					collection.updateItems(resultObj as ArrayCollection);
					break;
				case Action.DELETE:
					collection.removeItem(currentSignal.valueObject);
					break;
				case Action.GET_COUNT:
					collection.length = resultObj as int;
					break;
				case Action.GET_LIST:
					collection.updateItems(resultObj as ArrayCollection);
					break;
				case Action.BULK_UPDATE:
					collection.updateItems(resultObj as ArrayCollection);
					break;
				case Action.DELETE_ALL:
					collection.removeAll();
					break;
			}
			return collection;
		}
		
		private function faultHandler( event:FaultEvent):void {
			trace(serviceSignal.currentSignal.action+ ' '+serviceSignal.currentSignal.destination+' failed'+event);
			signalSeq.onSignalDone();
		}
		
		[Inject]
		public var serviceSignal:AbstractSignal;
		
		[Inject]
		public var resultSignal:ResultSignal;
		
		[Inject]
		public var signalSeq:SignalSequence;
		
	}
}