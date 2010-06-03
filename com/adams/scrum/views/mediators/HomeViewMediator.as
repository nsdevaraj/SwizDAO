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
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;

	public class HomeViewMediator extends AbstractViewMediator
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
 			//load all persons
			var persignal:SignalVO = new SignalVO(this,personDAO,Action.GET_LIST);
			signalSeq.addSignal(persignal); 
			// enable teammember DAO collection
			teammemberDAO.collection.items = new ArrayCollection();
			//load all tasks
			var tasksignal:SignalVO = new SignalVO(this,taskDAO,Action.GET_LIST);
			signalSeq.addSignal(tasksignal);
		}
		 
		
		[MediateSignal(type="ResultSignal")]
		public function resultHandler(obj:Object,signal:SignalVO):void {
			if(signal.destination == personDAO.destination && signal.objectId == this.name){
				 	currentInstance.currentPerson = GetVOUtil.getPersonObject(currentInstance.currentPerson.personLogin,currentInstance.currentPerson.personPassword,personDAO.collection.items as ArrayCollection);
				}
				if(signal.destination == taskDAO.destination && signal.objectId == this.name){
					if(currentInstance.currentPerson.personLogin != 'deva'){
						selectedPersonId = currentInstance.currentPerson.personId;
						var taskCollection:ArrayCollection = taskDAO.collection.items as ArrayCollection;
						taskCollection.filterFunction = selectPersonTask;
						taskCollection.refresh();
						
						view.taskList.dataProvider =  taskCollection;
						view.taskEdit.enabled = false;
						view.taskDelete.enabled =false;
 					}else{
						currentInstance.mainViewStackIndex = 2;
					}
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
			var selectedTask:Tasks = view.taskList.selectedItem as Tasks;
			view.taskcommentTxt.text = selectedTask.taskComment.toString();
			view.taskStatusFkTxt.text = selectedTask.taskStatusFk.toString();
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
			var tasksSignal:SignalVO = new SignalVO(this,taskDAO,Action.CREATE); 
			var tasksvo:Tasks = new Tasks();		
			var by:ByteArray = new ByteArray();
			var str:String = view.taskcommentTxt.text;
			by.writeUTFBytes(str);
			tasksvo.taskComment = by;
			tasksvo.taskStatusFk = int(view.taskStatusFkTxt.text); 
			tasksvo.TDateCreation = new Date(); 
			tasksvo.personFk = selectedPersonId; 
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
			var tasksSignal:SignalVO = new SignalVO(this,taskDAO,Action.UPDATE); 
			var tasksvo:Tasks = view.taskList.selectedItem as Tasks;
			var by:ByteArray = new ByteArray();
			var str:String = view.taskcommentTxt.text;
			by.writeUTFBytes(str);
			tasksvo.taskComment = by;
			tasksvo.taskStatusFk = int(view.taskStatusFkTxt.text); 
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
			var tasksSignal:SignalVO = new SignalVO(this,taskDAO,Action.DELETE); 
			var selectedTask:Tasks = view.taskList.selectedItem as Tasks;
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