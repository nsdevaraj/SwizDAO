/*
 * Copyright 2010 @nsdevaraj
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License. You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.adams.cambook.views.mediators
{ 
	
	import com.adams.cambook.models.vo.SignalVO;
	import com.adams.cambook.response.SignalSequence;
	import com.nsdevaraj.swiz.processors.FormProcessor;
	
	import flash.events.Event;
	import flash.system.System;
	
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
		[Inject]
		public var signalSeq:SignalSequence;
		/** 
		 * A flag indicating if the correpsonding view's creation complete has fired.
		 */
		public var isViewCreationComplete:Boolean = false;
		
		/**
		 * The view class we're injecting into the view mediator.
		 */
		protected var viewType:Class;
		protected var viewIndex:int;
		protected var viewState:String;
		/**
		 * The view that corresponds to this view mediator.
		 */
		protected var _view:UIComponent; 
		/**
		 * Constructor.		 
		 * the PassiveView view pattern with Spark Components is achieved using this class
		 * "http://blogs.adobe.com/paulw/archives/2007/11/presentation_pa_6.html".
		 * the class extens Skinnable Component to work with spark skinning architecture
		 */
		public function AbstractViewMediator( viewType:Class )
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
		public function setView( value:Object ):void { 
			if( ( value is viewType ) && !( _view ) ) { 
				
				this._view = value as UIComponent;
				
				// determine if the view has been initialized...
				// NO...listen for it;s creation complete event
				if( this._view.initialized == false ) 	{
					this._view.addEventListener( FlexEvent.CREATION_COMPLETE, onCreationComplete );
				}
				// YES...call the init() method to kick off the instation of the view mediator
				else {
					this.isViewCreationComplete = true;
					this.init();
					this.setRenderers();
				}
				
				// don't get in GC's way if the view is removed
				this._view.addEventListener( Event.REMOVED_FROM_STAGE, gcCleanup );
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
		 * The FormReady Event is dispatched, thus the form object is initiated for the FormProcessor
		 *
		 * <p>
		 * Does not have to be overriden. Simple here for convenience and as a marker method
		 * </p>
		 */
		protected function init():void {
			this.setViewListeners();
			this.setViewDataBindings();
			dispatchEvent( new Event( FormProcessor.FORM_READY ) );
		}
		
		protected function setRenderers():void {
			// OVERRIDDEN
		}
		
		/**
		 * Set the listeners for the UI components on the stage for the ViewMediator's corresponding View.
		 * 
		 * <p>
		 * Does not have to be overriden. Simple here for convenience and as a marker method
		 * </p>
		 */
		protected function setViewListeners():void {
			// OVERRIDDEN
		}
		
		/**
		 * Set the data bindings for the UI components on the stage for the ViewMediator's corresponding View.
		 * 
		 * <p>
		 * Does not have to be overriden. Simple here for convenience and as a marker method
		 * </p>
		 */
		protected function setViewDataBindings():void 	{
			// OVERRIDDEN
		}		
		
		/**
		 * Listen for the creation complete of the View for this ViewMediator.
		 */
		protected function onCreationComplete( event:FlexEvent ):void {
			this.isViewCreationComplete = true;
			this._view.removeEventListener( FlexEvent.CREATION_COMPLETE, onCreationComplete );
			this.init();
			this.setRenderers();
		}
		
		/**
		 * Mediate result signal if the service signal is dispatched from current view
		 */
		[MediateSignal(type="ResultSignal")]
		public function resultMapping( obj:Object, signal:SignalVO ):void {
			if( signal.objectId == name ) {
				serviceResultHandler( obj, signal );
			}
		}
		
		[MediateSignal(type="PushRefreshSignal")]
		public function pushHandler( signal:SignalVO = null ): void {
			pushResultHandler( signal );
		}
		
		protected function pushResultHandler( signal:SignalVO ):void {
			// overridden
		}
		
		protected function serviceResultHandler( obj:Object, signal:SignalVO ):void {
			// overridden
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
		protected function cleanup( event:Event ):void {
			this._view.removeEventListener( Event.REMOVED_FROM_STAGE, cleanup );
			System.gc();
			System.gc();
		}
		
		/**
		 * <p>
		 * Developers should override this method to invoke cleanup only if not 
		 * current view is swapped, in case of minimize, resize
		 * created in the concrete ViewMediator. 
		 * </p>
		 */
		protected function gcCleanup( event:Event ):void {
			// overridden
		}
	}
}