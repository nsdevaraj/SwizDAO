package com.adams.scrum.views.mediators
{ 
	
	import com.adams.scrum.dao.AbstractDAO;
	import com.adams.scrum.models.vo.*;
	import com.adams.scrum.views.LoginSkinView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import mx.controls.TextInput;
	import mx.events.ValidationResultEvent;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import spark.components.Button;
	
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
		
		/**
		 * Field validator for the user name form field.
		 */
		protected var userNameValidator:StringValidator;
		
		/**
		 * Field validator for the password form field.
		 */
		protected var passwordValidator:StringValidator;
		public var title:String ='here'
		
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
			return this._view as LoginSkinView;
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
			
			// create the form validators for the login panel
			this.createFormValidators();
			
			// disable the submit btn to start
			this.view.submitBtn.enabled = false;
			
			
			// set the focus to the username field
			this.view.userNameTextInput.setFocus();
		}
		
		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void
		{
			super.setViewListeners();
			
			// handle user input on the form fields for instant form validation feedback
			this.view.userNameTextInput.addEventListener(Event.CHANGE, inputChgHandler);
			this.view.passwordTextInput.addEventListener(Event.CHANGE, inputChgHandler);
			
			// handle the click of the submit button
			this.view.submitBtn.addEventListener(MouseEvent.CLICK, submitBtnClickHandler);
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
			
			userName = this.view.userNameTextInput.text;
			password = this.view.passwordTextInput.text;
			
			this.login(userName, password);
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
			currentInstance.currentPerson.personLogin = userName;
			currentInstance.currentPerson.personPassword = password;
		}
		protected function checkLogin(ev:Object =null) : void
		{
			if(personDAO.controlService.authCS.authenticated)
			{
				cleanup(null);
				currentInstance.mainViewStackIndex = 1;
			}else{
				setTimeout(wrongCredentialsAlert,1000);
			}
		}
		protected function wrongCredentialsAlert():void{
			this.view.wrongCredentials.text ='wrong username / password' 
		}
		
		/**
		 * Create the form field validators for the login fields.
		 */
		protected function createFormValidators():void
		{ 
			
			// create the user name validator
			this.userNameValidator = new StringValidator();
			this.userNameValidator.requiredFieldError = "Please enter a valid login";
			this.userNameValidator.minLength = 4;
			this.userNameValidator.property = "text";
			
			// create the password validator
			this.passwordValidator = new StringValidator();
			this.passwordValidator.required = true;
			this.passwordValidator.requiredFieldError = "Please enter a password.";
			this.passwordValidator.minLength = 3;
			this.passwordValidator.property = "text";
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
			this.view.submitBtn.enabled = true;
		}
		
		/**
		 * Determines if the username text input is valid.
		 * @return Boolean
		 */
		protected function isTextInputFieldValid(textInput:TextInput, validator:Validator):Boolean
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
			
			this.view.userNameTextInput.removeEventListener(Event.CHANGE, inputChgHandler);
			this.view.passwordTextInput.removeEventListener(Event.CHANGE, inputChgHandler);
			this.view.submitBtn.removeEventListener(MouseEvent.CLICK, submitBtnClickHandler);
		}
	}
}