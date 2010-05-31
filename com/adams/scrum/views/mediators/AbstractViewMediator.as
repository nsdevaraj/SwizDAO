package com.adams.scrum.views.mediators
{ 
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.components.supportClasses.SkinnableComponent;
	
	/**
	 * The base class for all view mediators. It's most useful function is to
	 * provide the metadata and setter method to inject the corresponding view into 
	 * the mediator.
	 * 
	 * <p>
	 * In addition, it allows concrete View Mediators to add view event handlers 
	 * and data bindings to children of the corresponding View with confidence by 
	 * by determining if the view is "alive" (aka has been instantiated and added to 
	 * the stage -- creationComplete event fired) or if it needs to listen for it's
	 * creation complete event before performing actions on it. See the 
	 * <code>public function setView( value:* ):void</code> method for more 
	 * details on this.
	 * </p>
	 */
	public class AbstractViewMediator extends SkinnableComponent
	{
		/** 
		 * A flag indicating if the correpsonding view's creation complete has fired.
		 */
		public var isViewCreationComplete:Boolean = false;
		
		/**
		 * The view class we're injecting into the view mediator.
		 */
		protected var viewType:Class;
		
		/**
		 * The view that corresponds to this view mediator.
		 */
		protected var _view:UIComponent; 
		/**
		 * Constructor.
		 */
		public function AbstractViewMediator(viewType:Class)
		{
			super(); 
			
			this.viewType = viewType;
		}
		
		/**
		 * Listen for views added to the stage and determine if it's the corresponding 
		 * View for this View Mediator. This check is done by looking at the view added 
		 * to the stage and do a simple compare on the <code>viewType:Class</code> class
		 * member that we set in concrete View Medators via their constructors.
		 * 
		 * <p>
		 * Also determine if the View has fired its creation complete event so developers
		 * can perform actions on the view from the View Mediator without hitting null pointers
		 * for uninstantiated objects in the View. If the creation complete has not fired, then 
		 * listen for it.
		 * </p>
		 */
		[Mediate( event="flash.events.Event.ADDED_TO_STAGE" , properties="target",useCapture="true" )]
		public function setView(value:Object):void
		{ 
			if(value is viewType)
			{ 
				this._view = value as UIComponent;
				
				// determine if the view has been initialized...
				// NO...listen for it;s creation complete event
				if(this._view.initialized == false)
				{
					this._view.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
				}
					// YES...call the init() method to kick off the instation of the view mediator
				else
				{
					this.isViewCreationComplete = true;
					this.init();
				}
				
				// don't get in GC's way if the view is removed
				this._view.addEventListener(Event.REMOVED_FROM_STAGE, cleanup);
			} 
		}
		
		/**
		 * The <code>init()</code> method is only called when the ViewMediator's corresponding 
		 * View's creationComplete has been fired; this allows developers to add event listens,
		 * data bindings, and any other view functions in confidence (without worry about accessing
		 * children of the view that are null and cause runtime errors.)
		 * 
		 * <p>
		 * Developers can override this to perform additional initializaitons in their ViewMediator,
		 * but must call <code>super.init()</code> in order for the aforementioned to function
		 * correctly.
		 * </p>
		 * 
		 * <p>
		 * Does not have to be overriden. Simple here for convenience and as a marker method
		 * </p>
		 */
		protected function init():void
		{
			this.setViewListeners();
			this.setViewDataBindings();
		}
		
		/**
		 * Set the listeners for the UI components on the stage for the ViewMediator's corresponding View.
		 * 
		 * <p>
		 * Does not have to be overriden. Simple here for convenience and as a marker method
		 * </p>
		 */
		protected function setViewListeners():void
		{
			// OVERRIDDEN
		}
		
		/**
		 * Set the data bindings for the UI components on the stage for the ViewMediator's corresponding View.
		 * 
		 * <p>
		 * Does not have to be overriden. Simple here for convenience and as a marker method
		 * </p>
		 */
		protected function setViewDataBindings():void
		{
			// OVERRIDDEN
		}		
		
		/**
		 * Listen for the creation complete of the View for this ViewMediator.
		 */
		protected function onCreationComplete( event:FlexEvent ):void
		{
			this.isViewCreationComplete = true;
			this._view.removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			this.init();
		}
		
		/**
		 * Remove any listeners we've created.
		 * 
		 * <p>
		 * Developers should override this method to remove any custom listners
		 * created in the concrete ViewMediator. Developers must call 
		 * <code>super.cleanup()</code> in order for this to function correctly.
		 * </p>
		 */
		protected function cleanup( event:Event ):void
		{
			this._view.removeEventListener(Event.REMOVED_FROM_STAGE, cleanup);
		}
	}
}