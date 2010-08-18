package com.adams.cambook.views.mediators
{
	import com.adams.cambook.dao.AbstractDAO;
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
		
		[Inject("statusDAO")]
		public var statusDAO:AbstractDAO;
		
		 
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
		//	if( !personDAO.collection.findAll ) {
				var persignal:SignalVO = new SignalVO( this, personDAO, Action.GET_LIST );
				signalSeq.addSignal( persignal ); 
			/*}
			else {
				currentInstance.currentPerson = GetVOUtil.getPersonObject( currentInstance.currentPerson.personEmail, currentInstance.currentPerson.personPassword, personDAO.collection.items as ArrayCollection );
			}*/
			
			//load all status
			if( !statusDAO.collection.findAll ) {
				var statusSignal:SignalVO = new SignalVO( this, statusDAO, Action.GET_LIST ); 
			//	signalSeq.addSignal( statusSignal );
			}
			
		} 
		override protected function setRenderers():void {
			super.setRenderers(); 
		} 
		override protected function serviceResultHandler( obj:Object,signal:SignalVO ):void { 
		 	 	if( signal.destination == personDAO.destination ) {
					if( signal.action == Action.GET_LIST ){
						currentInstance.currentPerson = GetVOUtil.getPersonObject( currentInstance.currentPerson.personEmail, currentInstance.currentPerson.personPassword, personDAO.collection.items as ArrayCollection );
					}
				}
		}

		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void {
			super.setViewListeners(); 
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