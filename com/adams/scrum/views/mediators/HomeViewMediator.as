package com.adams.scrum.views.mediators
{
	import com.adams.scrum.dao.AbstractDAO;
	import com.adams.scrum.models.vo.CurrentInstance;
	import com.adams.scrum.models.vo.Persons;
	import com.adams.scrum.models.vo.PushMessage;
	import com.adams.scrum.models.vo.SignalVO;
	import com.adams.scrum.response.SignalSequence;
	import com.adams.scrum.utils.Action;
	import com.adams.scrum.utils.Description;
	import com.adams.scrum.utils.GetVOUtil;
	import com.adams.scrum.views.HomeSkinView;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class HomeViewMediator extends AbstractViewMediator
	{
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject("personDAO")]
		public var personDAO:AbstractDAO;
		 
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		
		/**
		 * Constructor.
		 */
		public function HomeViewMediator(viewType:Class=null)
		{
			super(HomeSkinView); 
		}
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():HomeSkinView
		{
			return this._view as HomeSkinView;
		}
		
		/**
		 * The <code>init()</code> method is fired off automatically by the 
		 * AbstractViewMediator when the creation complete event fires for the
		 * corresponding ViewMediator's view. This allows us to listen for events
		 * and set data bindings on the view with the confidence that our view
		 * and all of it's child views have been created and live on the stage.
		 */
		override protected function init():void
		{
			super.init(); 
			view.domainList.editable = true;
			//load all persons
			var persignal:SignalVO = new SignalVO(personDAO,Action.GET_LIST);
			persignal.objectId = this.name;
			signalSeq.addSignal(persignal); 
			
			// to push a message
			var pushMsg:PushMessage = new PushMessage(Description.CREATE,[1,2],currentInstance.currentPerson.personId);
			var pushsignal:SignalVO = new SignalVO(personDAO,Action.PUSH_MSG,pushMsg); 
			signalSeq.addSignal(pushsignal);
		}
		
		[MediateSignal(type="ResultSignal")]
		public function resultHandler(obj:Object,signal:SignalVO):void {
			if(signal.destination == personDAO.destination && signal.objectId == this.name){
				currentInstance.currentPerson = GetVOUtil.getPersonObject(currentInstance.currentPerson.personLogin,currentInstance.currentPerson.personPassword,personDAO.collection.items as ArrayCollection);
			} 
		}  
		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void
		{
			super.setViewListeners();
			
		}
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void
		{
			super.cleanup(event); 
			
		}
		
	}
}