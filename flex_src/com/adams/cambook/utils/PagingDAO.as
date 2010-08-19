package com.adams.cambook.utils
{
	import com.adams.cambook.controller.ServiceController;
	import com.adams.cambook.models.vo.SignalVO;
	import com.adams.cambook.response.AbstractResult;
	import com.adams.cambook.response.SignalSequence;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class PagingDAO
	{
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		[Inject]
		public var delegate:AbstractResult;
		
		public function PagingDAO()
		{
			
		}
		
		protected var _destination:String =Utils.PAGINGDAO;  
		public function get destination():String {
			return _destination;
		}
		
		public function set destination( str:String ):void {
			_destination = str;
		}
		/**
		 * <p>
		 * The destination of remote service is set accordingly
		 * </p>
		 */		
		public function invoke():void{
			remoteService.destination = destination;
		}
		
		[MediateSignal(type="AbstractSignal")]
		public function invokeAction( obj:SignalVO ):AsyncToken {
			if( obj.destination == this.destination ) {
				switch( obj.action ) {
					case Action.GETQUERYRESULT:
						delegate.token = remoteService.getQueryResult(obj.name) ;
						return delegate.token;
						break;
					case Action.PAGINATIONLISTVIEW:
						delegate.token = remoteService.paginationListView(obj.name,obj.startIndex,obj.endIndex) ;
						return delegate.token;
						break;
					case Action.QUERYLISTVIEW:
						delegate.token = remoteService.queryListView(obj.name) ;
						return delegate.token;
						break;
					case Action.PAGINATIONLISTVIEWID:
						delegate.token = remoteService.paginationListViewId(obj.name, obj.id, obj.startIndex,obj.endIndex) ;
						return delegate.token;
						break;
					case Action.QUERYPAGINATION:	
						delegate.token = remoteService.queryPagination(obj.name,obj.startIndex, obj.endIndex);
						return delegate.token;
						break;
					case Action.REFRESHTWEETS:
						delegate.token = remoteService.refreshTweets(obj.id) ;//void
						return delegate.token;
						break;
					case Action.UPDATETWEET:
						delegate.token = remoteService.updateTweet(obj.name, obj.id) ;//string 
						return delegate.token;
						break;
				}
			}
			return null;
		}	
		 
		protected var _remoteService:RemoteObject;  
		public function get remoteService():RemoteObject  {
			return _remoteService;
		}
		
		public function set remoteService( ro:RemoteObject ):void {
			_remoteService = ro; 
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
	}
}