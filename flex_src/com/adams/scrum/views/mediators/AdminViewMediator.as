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
	import com.adams.scrum.views.AdminSkinView;
	import com.adams.scrum.views.HomeSkinView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;

	public class AdminViewMediator extends AbstractViewMediator
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
		public function AdminViewMediator(viewType:Class=null)
		{
			super(AdminSkinView); 
		}
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():AdminSkinView
		{
			return this._view as AdminSkinView;
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
			view.personList.editable = false;  
			viewPropertySetter();
		}
		private function viewPropertySetter():void{
			view.taskForm.visible = false;
			view.taskList.visible = false; 
			view.personEdit.enabled = false;
			view.personDelete.enabled = false;
			view.taskBtns.visible = false; 
			BindingUtils.bindProperty(view.personList,'dataProvider', personDAO.collection,'items')
		}
		
		[MediateSignal(type="ResultSignal")]
		public function resultHandler(obj:Object,signal:SignalVO):void {
			if(signal.destination == personDAO.destination && signal.objectId == this.name){
				if(signal.action ==Action.CREATE ){
					var teammemberSignal:SignalVO = new SignalVO(this,teammemberDAO,Action.CREATE);
					var teammembervo:Teammembers = new Teammembers();
					teammembervo.personFk = (obj as Persons).personId;
					teammembervo.profileFk = 1;
					teammembervo.teamFk = 1;
					teammemberSignal.valueObject = teammembervo;
					signalSeq.addSignal(teammemberSignal);
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
			
			view.personList.addEventListener(ListEvent.ITEM_CLICK,dataGridPersonList);
			view.taskList.addEventListener(ListEvent.ITEM_CLICK,dataGridTaskList);
			
			view.taskAdd.addEventListener(MouseEvent.CLICK, createBtnClickHandler);
			view.taskEdit.addEventListener(MouseEvent.CLICK, editBtnClickHandler);
			view.taskDelete.addEventListener(MouseEvent.CLICK, deleteBtnClickHandler);
			
			view.personAdd.addEventListener(MouseEvent.CLICK, createBtnClickHandler);
			view.personEdit.addEventListener(MouseEvent.CLICK, editBtnClickHandler);
			view.personDelete.addEventListener(MouseEvent.CLICK, deleteBtnClickHandler);

			
		}
		
		private var selectedPersonId:int;
		private function dataGridTaskList(evt:ListEvent):void
		{    
			var selectedTask:Tasks = view.taskList.selectedItem as Tasks;
			view.taskcommentTxt.text = selectedTask.taskComment.toString();
			view.taskStatusFkTxt.text = selectedTask.taskStatusFk.toString(); 
		}
		
		private function dataGridPersonList(evt:ListEvent):void
		{		
			var personvo:Persons = view.personList.selectedItem as Persons;
			selectedPersonId = personvo.personId;
			var taskCollection:ArrayCollection = taskDAO.collection.items as ArrayCollection;
			taskCollection.filterFunction = selectPersonTask;
			taskCollection.refresh(); 
			 
			view.personEdit.enabled = true;
			view.personDelete.enabled = true;
			
			view.taskList.dataProvider =  taskCollection;
			if(taskCollection.length>0){
				view.taskForm.visible = true;
				view.taskList.visible = true;
				view.taskBtns.visible = true;
			}
			
			view.firstname.text = personvo.personFirstname;
			view.lastname.text = personvo.personLastname;
			view.username.text = personvo.personLogin;
			view.password.text =personvo.personPassword ;
			view.email.text =personvo.personEmail;
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
			if(btnName.substr(0,4)=='task'){
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
			}else{
				var personSignal:SignalVO = new SignalVO(this,personDAO,Action.CREATE); 
				var personvo:Persons = new Persons();
				personvo.personFirstname = view.firstname.text;
				personvo.personLastname = view.lastname.text;
				personvo.personLogin = view.username.text;
				personvo.personPassword = view.password.text;
				personvo.personEmail = view.email.text;
				personvo.activated = 1;
				personSignal.valueObject = personvo;
				signalSeq.addSignal(personSignal);
			}
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
			if(btnName.substr(0,4)=='task'){
				var tasksSignal:SignalVO = new SignalVO(this,taskDAO,Action.UPDATE); 
				var tasksvo:Tasks = view.taskList.selectedItem as Tasks;
				var by:ByteArray = new ByteArray();
				var str:String = view.taskcommentTxt.text;
				by.writeUTFBytes(str);
				tasksvo.taskComment = by;
				tasksvo.taskStatusFk = int(view.taskStatusFkTxt.text); 
				tasksSignal.valueObject = tasksvo;
				signalSeq.addSignal(tasksSignal);
			}else{
				var personSignal:SignalVO = new SignalVO(this,personDAO,Action.UPDATE); 
				var personvo:Persons = view.personList.selectedItem as Persons;
				personvo.personFirstname = view.firstname.text;
				personvo.personLastname = view.lastname.text;
				personvo.personLogin = view.username.text;
				personvo.personPassword = view.password.text;
				personvo.personEmail = view.email.text;
				personSignal.valueObject = personvo;
				signalSeq.addSignal(personSignal);
			}
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
			if(btnName.substr(0,4)=='task'){
				var tasksSignal:SignalVO = new SignalVO(this,taskDAO,Action.DELETE); 
				var selectedTask:Tasks = view.taskList.selectedItem as Tasks;
				tasksSignal.valueObject = selectedTask;
				signalSeq.addSignal(tasksSignal);
			}else{
				var personSignal:SignalVO = new SignalVO(this,personDAO,Action.DELETE); 
				var personvo:Persons = view.personList.selectedItem as Persons; 
				personSignal.valueObject = personvo;
				signalSeq.addSignal(personSignal);
			}
		}
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void
		{
			super.cleanup(event); 
			view.personList.removeEventListener(ListEvent.ITEM_CLICK,dataGridPersonList);
			view.taskList.removeEventListener(ListEvent.ITEM_CLICK,dataGridTaskList);
			
			view.taskAdd.removeEventListener(MouseEvent.CLICK, createBtnClickHandler);
			view.taskEdit.removeEventListener(MouseEvent.CLICK, editBtnClickHandler);
			view.taskDelete.removeEventListener(MouseEvent.CLICK, deleteBtnClickHandler);
			
			view.personAdd.removeEventListener(MouseEvent.CLICK, createBtnClickHandler);
			view.personEdit.removeEventListener(MouseEvent.CLICK, editBtnClickHandler);
			view.personDelete.removeEventListener(MouseEvent.CLICK, deleteBtnClickHandler);
			
		}
		
	}
}