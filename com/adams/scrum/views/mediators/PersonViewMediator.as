package com.adams.scrum.views.mediators
{
	import com.adams.scrum.dao.AbstractDAO;
	import com.adams.scrum.models.vo.CurrentInstance;
	import com.adams.scrum.models.vo.Persons;
	import com.adams.scrum.models.vo.PushMessage;
	import com.adams.scrum.models.vo.SignalVO;
	import com.adams.scrum.models.vo.Tasks;
	import com.adams.scrum.models.vo.Teammembers;
	import com.adams.scrum.response.SignalSequence;
	import com.adams.scrum.utils.Action;
	import com.adams.scrum.utils.Description;
	import com.adams.scrum.utils.GetVOUtil;
	import com.adams.scrum.views.HomeSkinView;
	import com.adams.scrum.views.PersonSkinView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;

	public class PersonViewMediator extends AbstractViewMediator
	{
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject("personDAO")]
		public var personDAO:AbstractDAO;
		
		[Inject("teammemberDAO")]
		public var teammemberDAO:AbstractDAO;
		
		[Inject("taskDAO")]
		public var taskDAO:AbstractDAO;
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		
		/**
		 * Constructor.
		 */
		public function PersonViewMediator(viewType:Class=null)
		{
			super(PersonSkinView); 
		}
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():PersonSkinView
		{
			return this._view as PersonSkinView;
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
 			
			view.taskList.dataProvider = personDAO.collection.items as ArrayCollection;
		}
		 
		
		[MediateSignal(type="ResultSignal")]
		public function resultHandler(obj:Object,signal:SignalVO):void {
			if(signal.destination == personDAO.destination && signal.objectId == this.name){
				 
			}
		}
		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void
		{
			super.setViewListeners();
			
			view.taskList.addEventListener(ListEvent.ITEM_CLICK,dataGridTaskList);
			
			view.taskAdd.addEventListener(MouseEvent.CLICK, createBtnClickHandler);
			view.taskEdit.addEventListener(MouseEvent.CLICK, editBtnClickHandler);
			view.taskDelete.addEventListener(MouseEvent.CLICK, deleteBtnClickHandler);
						
		}
		
		private var selectedPersonId:int;
		private function dataGridTaskList(evt:ListEvent):void
		{    
			var selectedTask:Persons = view.taskList.selectedItem as Persons;
			view.firstname.text = selectedTask.personFirstname;
			view.lastname.text = selectedTask.personLastname;
			view.email.text = selectedTask.personEmail;
			view.username.text = selectedTask.personLogin;
			view.password.text = selectedTask.personPassword;
			view.taskEdit.enabled = true;
			view.taskDelete.enabled =true;
		}
		 
		/**
		* Filter function to filter the tasks of selected
		* persons in the Arraycollection
		*/
		private function selectPersonTask(item:Tasks):Boolean{
			if(item.personFk == selectedPersonId){
				return true;
			}
			return false;
		}
		
		/**
		 * Handles the click event from the create button.
		 * Grabs the new tasks details from the respeective text
		 * input fields and populates a taskDTO, then dispatches the
		 * taskEvent to the Cairngorm framework.
		 */
		protected function createBtnClickHandler(evt:MouseEvent):void
		{ 
			var btnName:String = evt.target.id.toString();
			var tasksSignal:SignalVO = new SignalVO(this,personDAO,Action.CREATE); 
			var tasksvo:Persons = new Persons();		
			tasksvo.personFirstname = view.firstname.text;
			tasksvo.personLastname = view.lastname.text;
			tasksvo.personEmail = view.email.text ;
			tasksvo.personLogin = view.username.text ;
			tasksvo.personPassword = view.password.text ;
			tasksvo.activated = 1; 
			tasksSignal.valueObject = tasksvo;
			signalSeq.addSignal(tasksSignal);
		}
		
		/**
		 * Handles the click event from the create button.
		 * Grabs the new tasks details from the respeective text
		 * input fields and populates a taskDTO, then dispatches the
		 * taskEvent to the Cairngorm framework.
		 */
		protected function editBtnClickHandler(evt:MouseEvent):void
		{
			var btnName:String = evt.target.id.toString();
			var tasksSignal:SignalVO = new SignalVO(this,personDAO,Action.UPDATE); 
			var tasksvo:Persons = view.taskList.selectedItem as Persons;
			tasksvo.personFirstname = view.firstname.text;
			tasksvo.personLastname = view.lastname.text;
			tasksvo.personEmail = view.email.text ;
			tasksvo.personLogin = view.username.text ;
			tasksvo.personPassword = view.password.text ;
			tasksvo.activated = 1; 
			tasksSignal.valueObject = tasksvo;
			tasksSignal.valueObject = tasksvo;
			signalSeq.addSignal(tasksSignal);
		}
		/**
		 * Handles the click event from the create button.
		 * Grabs the new tasks details from the respeective text
		 * input fields and populates a taskDTO, then dispatches the
		 * taskEvent to the Cairngorm framework.
		 */
		protected function deleteBtnClickHandler(evt:MouseEvent):void
		{
			var btnName:String = evt.target.id.toString();
			var tasksSignal:SignalVO = new SignalVO(this,personDAO,Action.DELETE); 
			var selectedTask:Persons = view.taskList.selectedItem as Persons;
			tasksSignal.valueObject = selectedTask;
			signalSeq.addSignal(tasksSignal);
		}
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void
		{
			super.cleanup(event); 
			view.taskList.removeEventListener(ListEvent.ITEM_CLICK,dataGridTaskList);
			
			view.taskAdd.removeEventListener(MouseEvent.CLICK, createBtnClickHandler);
			view.taskEdit.removeEventListener(MouseEvent.CLICK, editBtnClickHandler);
			view.taskDelete.removeEventListener(MouseEvent.CLICK, deleteBtnClickHandler);
			 
		}
		
	}
}