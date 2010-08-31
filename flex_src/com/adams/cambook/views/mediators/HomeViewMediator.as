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
	import com.adams.cambook.utils.ObjectUtils;
	import com.adams.cambook.utils.Utils;
	import com.adams.cambook.views.HomeSkinView;
	import com.adams.cambook.views.components.NativeList;
	import com.adams.cambook.views.renderers.BuddyCard;
	import com.adams.cambook.views.renderers.UpdateCard;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	import mx.events.ListEvent;
	import mx.events.ValidationResultEvent;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import spark.components.TextInput;
	import spark.events.IndexChangeEvent;
	import spark.skins.spark.DefaultItemRenderer;
	

	public class HomeViewMediator extends AbstractViewMediator
	{ 		 
		[Bindable]
		[Inject]
		public var currentInstance:CurrentInstance; 
		 
		[Bindable]
		[Inject("personDAO")]
		public var personDAO:AbstractDAO;
		
		[Bindable]
		[Inject("noteDAO")]
		public var noteDAO:AbstractDAO;
		
		[Inject]
		public var pagingDAO:PagingDAO;
		
		[Inject("fileDAO")]
		public var fileDAO:AbstractDAO;
		
		[Form(form="view.passwordForm")]
		public var personObj:Object;
		 
		protected var passWordNameValidator:StringValidator;
		private var _mainViewStackIndex:int
		public function get mainViewStackIndex():int {
			return _mainViewStackIndex;
		}
		public function set mainViewStackIndex( value:int ):void {
			_mainViewStackIndex = value;
		} 
		
		
		/**
		 * Create the form field validators for the login fields.
		 */
		protected function createFormValidators():void
		{ 
			
			// create the user name validator
			passWordNameValidator = new StringValidator();
			passWordNameValidator.requiredFieldError = "Please enter minimum 5 Characters";
			passWordNameValidator.minLength = 5;
			passWordNameValidator.property = "text";
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
		 * Handles text input changes to the username and password and validate them.
		 * Only enable the submit button if both the username and password fields 
		 * are valid.
		 * 
		 * @param evt    Change event from the targeted input field.
		 */
		protected function inputChgHandler(evt:Event):void
		{
			view.submitBtn.enabled = isTextInputFieldValid(view.personPassword1,passWordNameValidator) && isTextInputFieldValid(view.personPassword2,passWordNameValidator);
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
		 * The <code>init()</code> method is fired off automatically by the 
		 * AbstractViewMediator when the creation complete event fires for the
		 * corresponding ViewMediator's view. This allows us to listen for events
		 * and set data bindings on the view with the confidence that our view
		 * and all of it's child views have been created and live on the stage.
		 */
		override protected function init():void {
			super.init();  
			viewIndex = Utils.HOME_INDEX;
			
			view.personQuestion.dataProvider = new ArrayList(["My Favorite Movie?","My Mother's Maiden Name?","My First Vehicle?","My Favorite Color?"]);
			view.personQuestion.selectedIndex = 0;
			
			createFormValidators();
			//load all persons
		 	if(!int( currentInstance.currentPerson.personId) ) {
				var persignal:SignalVO = new SignalVO( this, personDAO, Action.FINDBY_NAME );
				persignal.name = currentInstance.currentPerson.personEmail;
				signalSeq.addSignal( persignal ); 
				
				var perAllsignal:SignalVO = new SignalVO( this, personDAO, Action.SQL_FINDALL );
				signalSeq.addSignal( perAllsignal ); 
			 }
		}
		protected function setDataProviders():void {	
			view.wallDG.dataProvider = noteDAO.collection.items;
			view.myUpdateDG.dataProvider = currentInstance.currentPerson.notesSet;
			view.messageDG.dataProvider = noteDAO.collection.items;
			view.friendsListDG.dataProvider = currentInstance.currentPerson.connectionSet;
			view.suggestFriendsListDG.dataProvider = personDAO.collection.items;
		} 
		override protected function setRenderers():void {
			super.setRenderers(); 
			BuddyCard.personsArr = currentInstance.currentPerson.connectionArr;
			UpdateCard.currentPersonId = currentInstance.currentPerson.personId;
			view.wallDG.itemRenderer = Utils.getCustomRenderer(Utils.NOTEDAO);
			view.myUpdateDG.itemRenderer = Utils.getCustomRenderer(Utils.NOTEDAO);
			view.messageDG.itemRenderer = Utils.getCustomRenderer(Utils.NOTEDAO);
			view.friendsListDG.itemRenderer = Utils.getCustomRenderer(Utils.PERSONDAO);
			view.suggestFriendsListDG.itemRenderer = Utils.getCustomRenderer(Utils.PERSONDAO);
		} 
		private var passwordState:Boolean;
		
		protected function changeToPasswordView(evt:MouseEvent = null):void
		{
			passwordState = !passwordState;
			changeState(passwordState);
		}
		protected function changeState(register:Boolean):void
		{
			view.passwordForm.includeInLayout = register;
			view.passwordForm.visible = register;
			view.passwordBtn.includeInLayout =!register;
			view.passwordBtn.visible = !register;
		}
		override protected function serviceResultHandler( obj:Object,signal:SignalVO ):void {  
		 	 	if( signal.destination == personDAO.destination ) {
					if( signal.action == Action.FINDBY_NAME ){
 						currentInstance.currentPerson =GetVOUtil.getPersonObject( currentInstance.currentPerson.personEmail, currentInstance.currentPerson.personPassword, personDAO.collection.items as ArrayCollection );
						currentInstance.currentPerson.personAvailability = 1;
						view.personName.text = currentInstance.currentPerson.personFirstname;
						ObjectUtils.setUpForm(currentInstance.currentPerson,view.personForm); 
						ObjectUtils.setUpForm(currentInstance.currentPerson,view.passwordForm); 
						
						view.friendsCount.text ='Friends Count : '+ currentInstance.currentPerson.connectionArr.length;
						if(currentInstance.currentPerson.personRelations == 0){
							changeToPasswordView();
							currentInstance.currentPerson.personRelations = 1;
						}
						var perAvailSignal:SignalVO = new SignalVO( this, personDAO, Action.UPDATE );
						perAvailSignal.valueObject = currentInstance.currentPerson;
						signalSeq.addSignal( perAvailSignal ); 
						
						var pushOnlineMessage:PushMessage = new PushMessage( Description.UPDATE, [],  currentInstance.currentPerson.personId );
						var pushOnlineSignal:SignalVO = new SignalVO( this, personDAO, Action.PUSH_MSG, pushOnlineMessage );
						signalSeq.addSignal( pushOnlineSignal );
						setDataProviders();
					}
					if( signal.action == Action.SQL_FINDALL ){
					currentInstance.currentPersonsList = obj as ArrayCollection;
					}
				}
				if( signal.destination == noteDAO.destination ) {
					if( signal.action == Action.CREATE ){
						var newNote:Notes = GetVOUtil.getVOObject((obj as Notes).noteId,noteDAO.collection.items,noteDAO.destination,Notes) as Notes;
						currentInstance.currentPerson.notesSet.addItem(newNote);
					//	view.myUpdateDG.dataProvider =	currentInstance.currentPerson.notesSet;
						view.updateTxt.text = '';
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
		protected function newTweetHandler(ev:Object):void{ 
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
			//view.tweet.clicked.add(chatPush);
			view.submitBtn.clicked.add(modifyPasswordHandler);
			view.personPassword1.addEventListener(Event.CHANGE, inputChgHandler);
			view.personPassword2.addEventListener(Event.CHANGE, inputChgHandler);
			view.passwordBtn.clicked.add(changeToPasswordView);
			view.cancelBtn.clicked.add(changeToPasswordView);
			
			view.profilePanel.panelSignal.add(profilePanelHandler);
			view.searchPanel.panelSignal.add(searchPanelHandler);
			view.profileTxt.addEventListener(MouseEvent.CLICK,profilePanelHandler);
			view.goBtn.clicked.add(searchPanelHandler);
			view.update.clicked.add(newUpdateHandler);
			
			view.wallDG.renderSignal.add(wallHandler);
			view.myUpdateDG.renderSignal.add(myUpdateDGHandler);
			view.messageDG.renderSignal.add(messageDGHandler);
			view.friendsListDG.renderSignal.add(friendsListDGHandler);
			view.suggestFriendsListDG.renderSignal.add(suggestFriendsListDGHandler);
		}
		private function wallHandler(str:String, note:Notes):void{ 
			var updateNoteSignal:SignalVO = new SignalVO( this, noteDAO, Action.CREATE );
			updateNoteSignal.valueObject = note;
			signalSeq.addSignal( updateNoteSignal );
		}
		private function myUpdateDGHandler(str:String, note:Notes):void{
			var updateNoteSignal:SignalVO = new SignalVO( this, noteDAO, Action.CREATE );
			updateNoteSignal.valueObject = note;
			signalSeq.addSignal( updateNoteSignal );
		}
		private function messageDGHandler(str:String, note:Notes):void{
			var updateNoteSignal:SignalVO = new SignalVO( this, noteDAO, Action.CREATE );
			updateNoteSignal.valueObject = note;
			signalSeq.addSignal( updateNoteSignal );
		}
		private function friendsListDGHandler(str:String, person:Persons):void{
			
		}
		private function suggestFriendsListDGHandler(str:String, person:Persons):void{
			
		} 
		
		private function newUpdateHandler(event:MouseEvent=null):void{
			var newNote:Notes = new Notes();
			newNote.description =  view.updateTxt.text;
			newNote.createdPersonFK = currentInstance.currentPerson.personId;
			newNote.creationDate = new Date();
			if(view.tweet.selected){
				var tweetSignal:SignalVO = new SignalVO( this, pagingDAO, Action.UPDATETWEET );
				tweetSignal.id = newNote.createdPersonFK; 
				tweetSignal.name =newNote.description 
				signalSeq.addSignal( tweetSignal );
			}
			var updateNoteSignal:SignalVO = new SignalVO( this, noteDAO, Action.CREATE );
			updateNoteSignal.valueObject = newNote;
			signalSeq.addSignal( updateNoteSignal );
		}
		private function searchPanelHandler(event:MouseEvent=null):void{
			view.searchPanel.includeInLayout = !view.searchPanel.includeInLayout;
			view.searchPanel.visible = !view.searchPanel.visible ;
		}
		private function profilePanelHandler(event:MouseEvent=null):void{
			view.profilePanel.includeInLayout = !view.profilePanel.includeInLayout ;
			view.profilePanel.visible = !view.profilePanel.visible;
		}
 
		protected function modifyPasswordHandler( event:MouseEvent): void {
			var perPasswdSignal:SignalVO = new SignalVO( this, personDAO, Action.UPDATE );
			var personVo:Persons= currentInstance.currentPerson;
			personVo = ObjectUtils.getCastObject(personObj,personVo) as Persons;
			personVo.personPassword = view.personPassword1.text;
			perPasswdSignal.valueObject = personVo;
			
			if(view.personPassword1.text == view.personPassword2.text && view.oldPersonPassword.text == currentInstance.currentPerson.personPassword){
				signalSeq.addSignal(perPasswdSignal);
				changeToPasswordView();
			}else{
				Alert.show('Passwords should match',Utils.ALERTHEADER);
			}
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