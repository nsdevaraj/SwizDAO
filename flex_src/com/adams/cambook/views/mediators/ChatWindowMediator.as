package com.adams.cambook.views.mediators
{ 
	
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.dao.PagingDAO;
	import com.adams.cambook.models.vo.*;
	import com.adams.cambook.utils.Action;
	import com.adams.cambook.utils.ObjectUtils;
	import com.adams.cambook.utils.Utils;
	import com.adams.cambook.views.ChatWindowSkinView;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.controls.TextInput;
	import mx.events.ValidationResultEvent;
	import mx.validators.EmailValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import spark.components.Button;
	import spark.components.TextInput;
	
	/**
	 * Handles all events, data manipulation, data bindings, and whatever else it's 
	 * corresponding View can dish out.
	 */
	public class ChatWindowMediator extends AbstractViewMediator
	{
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject("personDAO")]
		public var personDAO:AbstractDAO;
		
		[Inject]
		public var pagingDAO:PagingDAO;
		
		[Form(form="view.registerForm")]
		public var personObj:Object;
		
		[Random]
		public var randPassWord:String;
		
		/**
		 * Field validator for the user name form field.
		 */
		protected var userNameValidator:StringValidator;
		
		/**
		 * Field validator for the password form field.
		 */
		protected var emailValidator:EmailValidator;
		private var _mainViewStackIndex:int
		public function get mainViewStackIndex():int
		{
			return _mainViewStackIndex;
		}
		
		public function set mainViewStackIndex(value:int):void
		{
			_mainViewStackIndex = value;
		}
		/**
		 * Constructor.
		 */
		public function ChatWindowMediator(viewType:Class=null)
		{
			super(ChatWindowSkinView); 
		}
		
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():ChatWindowSkinView
		{
			return _view as ChatWindowSkinView;
		}
		
		[MediateView( "ChatWindowSkinView" )]
		override public function setView(value:Object):void
		{ 
			super.setView(value);	
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
			viewIndex = Utils.LOGIN_INDEX;
			// create the form validators for the login panel
		}
		private var registerState:Boolean;
		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void
		{
			super.setViewListeners();
			
			// handle user input on the form fields for instant form validation feedback
		/*	view.registerBtn.clicked.add(createNewUser);
			view.submitBtn.clicked.add( submitBtnClickHandler);*/
		}
		private function createNewUser(evt:MouseEvent):void
		{
			var personSignal:SignalVO = new SignalVO(this,pagingDAO,Action.CREATEPERSON);
			var newPerson:Persons = new Persons();
			newPerson = ObjectUtils.getCastObject(personObj,newPerson) as Persons;
			newPerson.activated = 1;
			newPerson.personPassword = randPassWord;
			newPerson.personRole = 'ROLE_USER';
			
			personSignal.valueObject = newPerson;
			signalSeq.addSignal(personSignal);
			
		} 
		
		override protected function serviceResultHandler( obj:Object,signal:SignalVO ):void {  
			if( signal.destination == pagingDAO.destination ) {
				if(signal.action == Action.CREATEPERSON){
					//Alert.show("Your Password have been mailed to your email\n" +view.personEmail.text,Utils.ALERTHEADER);
					changeToRegisterView();
				}
			}
		}
		protected function changeToRegisterView(evt:MouseEvent = null):void
		{
			registerState = !registerState;
			//changeState(registerState);
		}
		
		
		
		/**
		 * The functional login method that dispatches the login event with the
		 * username and password.
		 * 
		 * @param userName
		 * @param password
		 */
		
		  
		
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void
		{
			super.cleanup(event); 
			
			/*view.personEmail.removeEventListener(Event.CHANGE, inputChgHandler);
			view.personFirstname.removeEventListener(Event.CHANGE, inputChgHandler);
			view.userNameTextInput.removeEventListener(Event.CHANGE, inputChgHandler);
			view.passwordTextInput.removeEventListener(Event.CHANGE, inputChgHandler);
			view.submitBtn.clicked.removeAll();*/
		}
		
		/**
		 * initiates cleanup view, of this view. manages stage resize, minimize or maximize event 
		 * as removed from stage event should not be called on these system events
		 */
		override protected function gcCleanup( event:Event ):void
		{
			if(viewIndex!= Utils.LOGIN_INDEX)cleanup(event);
		}
	}
}