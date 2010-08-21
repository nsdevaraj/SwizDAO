package com.adams.cambook.views.mediators
{ 
	
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.dao.PagingDAO;
	import com.adams.cambook.models.vo.*;
	import com.adams.cambook.utils.Action;
	import com.adams.cambook.utils.ObjectUtils;
	import com.adams.cambook.utils.Utils;
	import com.adams.cambook.views.LoginSkinView;
	
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
	public class LoginViewMediator extends AbstractViewMediator
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
		public function LoginViewMediator(viewType:Class=null)
		{
			super(LoginSkinView); 
		}
		
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():LoginSkinView
		{
			return _view as LoginSkinView;
		}
		
		[MediateView( "LoginSkinView" )]
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
			createFormValidators();
			
			// set the focus to the username field
			view.userNameTextInput.setFocus();
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
			view.personEmail.addEventListener(Event.CHANGE, inputChgHandler);
			view.personFirstname.addEventListener(Event.CHANGE, inputChgHandler);
			
			view.userNameTextInput.addEventListener(Event.CHANGE, inputChgHandler);
			view.passwordTextInput.addEventListener(Event.CHANGE, inputChgHandler);
			view.newUserBtn.clicked.add(changeToRegisterView);
			view.cancelBtn.clicked.add(changeToRegisterView);
			view.registerBtn.clicked.add(createNewUser);
			// handle the click of the submit button
			view.submitBtn.clicked.add( submitBtnClickHandler);
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
			sendPasswordMail(newPerson.personPassword);
		} 
		protected function sendPasswordMail(pswd:String):void
		{
			var loginMailSignal:SignalVO = new SignalVO( this, pagingDAO, Action.SENDMAIL );
			loginMailSignal.emailId = view.personEmail.text;
			loginMailSignal.name = 'Welcome to '+Utils.ALERTHEADER+', New User :'+view.personFirstname.text;
			loginMailSignal.emailBody = "Your System Generated Password :"+pswd+'\n You can now login with your password and Email \n'+currentInstance.config.serverLocation+'cambook';
			 
			signalSeq.addSignal( loginMailSignal );			
		}
		override protected function serviceResultHandler( obj:Object,signal:SignalVO ):void {  
			if( signal.destination == pagingDAO.destination ) {
				if(signal.action == Action.CREATEPERSON){
					Alert.show("Your Password have been mailed to your email\n" +view.personEmail.text,Utils.ALERTHEADER);
					changeToRegisterView();
				}
			}
		}
		protected function changeToRegisterView(evt:MouseEvent = null):void
		{
			registerState = !registerState;
			changeState(registerState);
		}
		protected function changeState(register:Boolean):void
		{
			view.registerBtn.includeInLayout = register;
			view.cancelBtn.includeInLayout = register;
			view.registerForm.includeInLayout = register
			view.registerBtn.visible = register;
			view.cancelBtn.visible = register;
			view.registerForm.visible = register;
			
			view.loginForm.includeInLayout = !register;
			view.loginForm.visible = !register;
			view.submitBtn.visible = !register;
			view.submitBtn.includeInLayout = !register;
			view.newUserBtn.includeInLayout = !register;
			view.newUserBtn.visible = !register;
		}
		/**
		 * Handles the click event from the submit button.
		 * Grabs the username and password from the respeective text
		 * input fields and populates a LoginDTO, then dispatches the
		 * LoginEvent to the Cairngorm framework.
		 */
		protected function submitBtnClickHandler(evt:MouseEvent):void
		{
			var userName:String;
			var password:String;
			
			userName = view.userNameTextInput.text;
			password = view.passwordTextInput.text;
			
			login(userName, password);
			view.submitBtn.clicked.removeAll();
		}
		
		/**
		 * The functional login method that dispatches the login event with the
		 * username and password.
		 * 
		 * @param userName
		 * @param password
		 */
		protected function login(userName:String, password:String):void
		{
			personDAO.controlService.authCS.loginAttempt.add(checkLogin);
			personDAO.controlService.authCS.login(userName,password);
			cursorManager.setBusyCursor();
			currentInstance.currentPerson.personEmail= userName;
			currentInstance.currentPerson.personPassword = password;
		}
		/**
		 * The handler to check the userlogin credentials
		 */
		protected function checkLogin(ev:Object =null) : void
		{
			if(personDAO.controlService.authCS.authenticated)
			{ 
				cleanup(null);
				currentInstance.mainViewStackIndex = Utils.HOME_INDEX;
				cursorManager.removeBusyCursor();
			}else{
				setTimeout(wrongCredentialsAlert,1500); 
			}
		}
		
		/**
		 * The function to display wrong credential Alert
		 */
		protected function wrongCredentialsAlert():void{
			cursorManager.removeBusyCursor();
			view.submitBtn.clicked.add( submitBtnClickHandler);
			view.wrongCredentials.text ='wrong username / password' 
		}
		
		/**
		 * Create the form field validators for the login fields.
		 */
		protected function createFormValidators():void
		{ 
			
			// create the user name validator
			userNameValidator = new StringValidator();
			userNameValidator.requiredFieldError = "Please enter minimum 5 Characters";
			userNameValidator.minLength = 5;
			userNameValidator.property = "text";
			
			// create the password validator
			emailValidator = new EmailValidator();
			emailValidator.required = true;
			emailValidator.requiredFieldError = "Please enter a valid Email";
		}
		
		/**
		 * Handles text input changes to the username and password and validate them.
		 * Only enable the submit button if both the username and password fields 
		 * are valid.
		 * 
		 * @param evt    Change event from the targeted input field.
		 */
		protected function inputChgHandler(evt:Event):void
		{
			view.registerBtn.enabled = isTextInputFieldValid(view.personFirstname,userNameValidator) && isTextInputFieldValid(view.personEmail,emailValidator);
			view.submitBtn.enabled = isTextInputFieldValid(view.userNameTextInput,emailValidator) && isTextInputFieldValid(view.passwordTextInput,userNameValidator);
		}
		
		/**
		 * Determines if the username text input is valid.
		 * @return Boolean
		 */
		protected function isTextInputFieldValid(textInput:spark.components.TextInput, validator:Validator):Boolean
		{
			textInput.errorString = "";
			
			var resultEvent:ValidationResultEvent = validator.validate(textInput.text);
			if (resultEvent.type != ValidationResultEvent.VALID)
			{
				textInput.errorString = resultEvent.message;
			}
			return (resultEvent.type == ValidationResultEvent.VALID);
		}
		
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void
		{
			super.cleanup(event); 
			
			view.personEmail.removeEventListener(Event.CHANGE, inputChgHandler);
			view.personFirstname.removeEventListener(Event.CHANGE, inputChgHandler);
			view.userNameTextInput.removeEventListener(Event.CHANGE, inputChgHandler);
			view.passwordTextInput.removeEventListener(Event.CHANGE, inputChgHandler);
			view.submitBtn.clicked.removeAll();
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