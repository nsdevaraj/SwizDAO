package com.adams.cambook.views.mediators
{
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.dao.PagingDAO;
	import com.adams.cambook.models.vo.*;
	import com.adams.cambook.response.SignalSequence;
	import com.adams.cambook.utils.Action;
	import com.adams.cambook.utils.ArrayUtil;
	import com.adams.cambook.utils.Description;
	import com.adams.cambook.utils.GetVOUtil;
	import com.adams.cambook.utils.Utils;
	import com.adams.cambook.views.HomeSkinView;
	import com.adams.cambook.views.components.NativeList;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	import mx.events.ListEvent;
	
	import spark.events.IndexChangeEvent;
	import spark.skins.spark.DefaultItemRenderer;
	

	public class HomeViewMediator extends AbstractViewMediator
	{ 		 
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		 
		[Inject("personDAO")]
		public var personDAO:AbstractDAO;
		
		[Inject]
		public var pagingDAO:PagingDAO;
		
		[Inject("fileDAO")]
		public var fileDAO:AbstractDAO;
		 
		private var _mainViewStackIndex:int
		public function get mainViewStackIndex():int {
			return _mainViewStackIndex;
		}
		public function set mainViewStackIndex( value:int ):void {
			_mainViewStackIndex = value;
		} 
		
		/**
		 * Constructor.
		 */
		public function HomeViewMediator( viewType:Class=null )
		{
			super( HomeSkinView ); 
		}

		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():HomeSkinView 	{
			return _view as HomeSkinView;
		}
		
		[MediateView( "HomeSkinView" )]
		override public function setView( value:Object ):void { 
			super.setView(value);	
		}
		
		/**
		 * The <code>init()</code> method is fired off automatically by the 
		 * AbstractViewMediator when the creation complete event fires for the
		 * corresponding ViewMediator's view. This allows us to listen for events
		 * and set data bindings on the view with the confidence that our view
		 * and all of it's child views have been created and live on the stage.
		 */
		override protected function init():void {
			super.init();  
			viewIndex = Utils.HOME_INDEX;
			
			
			//load all persons
		 	if(!int( currentInstance.currentPerson.personId) ) {
				var persignal:SignalVO = new SignalVO( this, personDAO, Action.FINDBY_NAME );
				persignal.name = currentInstance.currentPerson.personEmail;
				signalSeq.addSignal( persignal ); 
				
				var perAllsignal:SignalVO = new SignalVO( this, personDAO, Action.SQL_FINDALL );
				signalSeq.addSignal( perAllsignal ); 
			 } 
		} 
		override protected function setRenderers():void {
			super.setRenderers(); 
		} 
		override protected function serviceResultHandler( obj:Object,signal:SignalVO ):void {  
		 	 	if( signal.destination == personDAO.destination ) {
					if( signal.action == Action.FINDBY_NAME ){
 						currentInstance.currentPerson =GetVOUtil.getPersonObject( currentInstance.currentPerson.personEmail, currentInstance.currentPerson.personPassword, personDAO.collection.items as ArrayCollection );
						currentInstance.currentPerson.personAvailability = 1;
						
						var perAvailsignal:SignalVO = new SignalVO( this, personDAO, Action.UPDATE );
						perAvailsignal.valueObject = currentInstance.currentPerson;
						signalSeq.addSignal( perAvailsignal ); 
						
						var pushOnlineMessage:PushMessage = new PushMessage( Description.UPDATE, [],  currentInstance.currentPerson.personId );
						var pushOnlineSignal:SignalVO = new SignalVO( this, personDAO, Action.PUSH_MSG, pushOnlineMessage );
						signalSeq.addSignal( pushOnlineSignal );
						
					}
					if( signal.action == Action.SQL_FINDALL ){
					currentInstance.currentPersonsList = obj as ArrayCollection;
					}
				}
				if( signal.destination == pagingDAO.destination ) {
					if(obj == Utils.TWEETSUCCESS){
						view.updateTxt.text = '';
					}else{
						Alert.show(obj as String,Utils.ALERTHEADER);
					}
				}
		}
		protected function chatPush(ev:Object):void{
			var tweetSignal:SignalVO = new SignalVO( this, pagingDAO, Action.UPDATETWEET );
			tweetSignal.id = currentInstance.currentPerson.personId;
			tweetSignal.name = view.updateTxt.text;
			signalSeq.addSignal( tweetSignal );
		/*	var pushChatMessage:PushMessage = new PushMessage( 'Chat Message', [view.personid.value],  currentInstance.currentPerson.personId );
			var pushChatSignal:SignalVO = new SignalVO( this, personDAO, Action.PUSH_MSG, pushChatMessage );
			signalSeq.addSignal( pushChatSignal );*/
			
		}
		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void {
			super.setViewListeners(); 
			view.tweet.clicked.add(chatPush);
		}
 
		 
		override protected function pushResultHandler( signal:SignalVO ): void { 
		} 
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void {
			super.cleanup( event ); 		
		}
		//@TODO

		/**
		 * initiates cleanup view, of this view. manages stage resize, minimize or maximize event 
		 * as removed from stage event should not be called on these system events
		 */		
		override protected function gcCleanup( event:Event ):void {
			if( viewIndex != Utils.HOME_INDEX ) {
				cleanup( event );	
			}
		}
	}
}