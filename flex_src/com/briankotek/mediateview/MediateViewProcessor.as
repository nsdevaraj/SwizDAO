/**
 * This Swiz custom metadata processor allows the addition of views to be mediated by Swiz beans.
 * Usage:
 *
 * The default metadata argument for MediateView is "view". You can specify the name of the view class that you are interested in.
 * In this example, when a TestPanel is added to the stage, the setView() method will be invoked, and the view will be passed as a method argument:
 *
 <code>
 [MediateView( "TestPanel" )]
 public function setView( panel : TestPanel ) : void
 {
 view = panel;
 view.testLabel.text = "Text set for type TestPanel from controller.";
 }
 </code>
 *
 * Another way to use MediateView is to specify a viewId. In this case, when a UIComponent with the ID "testPanel2" is added to the stage,
 * the setView2() method will be invoked, and the view will be passed as a method argument.
 *
 <code>
 [MediateView( viewId="testPanel2" )]
 public function setView2( panel : TestPanel ) : void
 {
 view2 = panel;
 view2.testLabel.text = "Text set for id 'testPanel2' from controller.";
 }
 </code>
 *
 * You may optionally set the values <code>mediateEventType</code> and <code>useCapture</code>. By default, the event type is "addedToStage", and useCapture is true.
 * 
 * When a bean is torn down, references to it are removed from this processor, to allow for proper garbage collection of torn down beans.
 *
 */
package com.briankotek.mediateview
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.*;
	
	import mx.core.UIComponent;
	
	import org.swizframework.core.Bean;
	import org.swizframework.core.SwizConfig;
	import org.swizframework.processors.BaseMetadataProcessor;
	import org.swizframework.reflection.IMetadataTag;
	
	public class MediateViewProcessor extends BaseMetadataProcessor
	{
		protected static const MEDIATE_VIEW : String = "MediateView";
		
		public var mediateEventType : String = Event.ADDED_TO_STAGE;
		public var useCapture : Boolean = true;
		
		protected var mediatorsByViewType : Dictionary = new Dictionary();
		protected var mediatorsByViewId : Dictionary = new Dictionary();
		
		private var dispatcherListenerAdded : Boolean = false;
		
		public function MediateViewProcessor()
		{
			super( [ MEDIATE_VIEW ], MediateViewMetadataTag );
		}
		
		public function mediateView( event : Event ) : void
		{
			var target : DisplayObject = DisplayObject( event.target );
			var viewMediator : ViewMediator;
			var mediators : Array;
			
			if ( target is UIComponent && mediatorsByViewId[ UIComponent( target ).id ] is Array )
			{
				mediators = mediatorsByViewId[ UIComponent( target ).id ] as Array;
			}
			else
			{
				var targetType : Class = findViewClassFromInstance( target );
				if ( mediatorsByViewType[ targetType ] is Array )
				{
					mediators = mediatorsByViewType[ targetType ] as Array;
				}
			}
			
			if ( mediators )
			{
				for each ( viewMediator in mediators )
				{
					viewMediator.method.apply( null, [ target ] );
				}
			}
			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setUpMetadataTag( metadataTag : IMetadataTag, bean : Bean ) : void
		{
			var mediateViewTag : MediateViewMetadataTag = metadataTag as MediateViewMetadataTag;
			var beanMethod : Function = bean.source[ mediateViewTag.host.name ];
			
			if ( mediateViewTag.view )
			{
				var viewClass : Class = findViewClassFromName( mediateViewTag.view );
				mediatorsByViewType[ viewClass ] ||= [];
				mediatorsByViewType[ viewClass ].push( new ViewMediator( mediateViewTag, beanMethod ) );
			}
			else if ( mediateViewTag.viewId )
			{
				mediatorsByViewId[ mediateViewTag.viewId ] ||= [];
				mediatorsByViewId[ mediateViewTag.viewId ].push( new ViewMediator( mediateViewTag, beanMethod ) );
			}
			
			// Don't set up a listener on the dispatcher until we need to.
			if ( !dispatcherListenerAdded )
			{
				var dispatcher : IEventDispatcher = swiz.config.defaultDispatcher == SwizConfig.LOCAL_DISPATCHER ? swiz.dispatcher : swiz.globalDispatcher;
				dispatcher.addEventListener( mediateEventType, mediateView, useCapture, 0, true );
				dispatcherListenerAdded = true;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function tearDownMetadataTag( metadataTag : IMetadataTag, bean : Bean ) : void
		{
			var mediateViewTag : MediateViewMetadataTag = metadataTag as MediateViewMetadataTag;
			var beanMethod : Function = bean.source[ mediateViewTag.host.name ];
			var dispatcher : IEventDispatcher = swiz.config.defaultDispatcher == SwizConfig.LOCAL_DISPATCHER ? swiz.dispatcher : swiz.globalDispatcher;
			
			// If mediating a view by type, find the matching view in the type dictionary and remove the array element using the specified method of the bean.
			if ( mediateViewTag.view )
			{
				var viewClass : Class = findViewClassFromName( mediateViewTag.view );
				if ( mediatorsByViewType[ viewClass ] is Array )
				{
					mediatorsByViewType[ viewClass ].some( function( element : *, index : int, arr : Array ) : Boolean
					{
						var result : Boolean = false;
						if ( ViewMediator( element ).method == beanMethod )
						{
							arr.splice( index, 1 );
							result = true;
						}
						return result;
					} );
				}
			}
				// If mediating a view by type, find the matching view in the ID dictionary and remove the array element using the specified method of the bean.
			else if ( mediateViewTag.viewId )
			{
				if ( mediatorsByViewId[ mediateViewTag.viewId ] is Array )
				{
					mediatorsByViewId[ mediateViewTag.viewId ].some( function( element : *, index : int, arr : Array ) : Boolean
					{
						var result : Boolean = false;
						if ( ViewMediator( element ).method == beanMethod )
						{
							arr.splice( index, 1 );
							result = true;
						}
						return result;
					} );
				}
			}
		}
		
		/**
		 * Get the Class reference for the specified object instance.
		 */
		private function findViewClassFromInstance( view : Object ) : Class
		{
			var result : Class;
			var targetClassName : String = getQualifiedClassName( view );
			result = getDefinitionByName( targetClassName ) as Class;
			
			if ( !result )
			{
				throw new Error( "MediateViewProcessor cannot locate Class for view instance " + view.toString() + "." );
			}
			return result;
		}
		
		/**
		 * Get the Class reference for the specified class name.
		 */
		private function findViewClassFromName( view : String ) : Class
		{
			var result : Class;
			
			if ( swiz.config.viewPackages.length > 0 )
			{
				result = findClassDefinition( view, swiz.config.viewPackages );
			}
			else
			{
				result = getClassDefinitionByName( view ) as Class
			}
			
			if ( !result )
			{
				throw new Error( "MediateViewProcessor cannot locate Class for view of type " + view + "." );
			}
			return result;
		}
		
		private static function findClassDefinition( className : String, packageNames : Array ) : Class
		{
			var definition : Class;
			for each ( var packageName : String in packageNames )
			{
				definition = getClassDefinitionByName( packageName + "." + className ) as Class;
				if ( definition != null )
				{
					break;
				}
			}
			return definition;
		}
		
		private static function getClassDefinitionByName( className : String ) : Class
		{
			var definition : Class;
			try
			{
				definition = getDefinitionByName( className ) as Class;
			}
			catch ( e : Error )
			{
				// Nothing
			}
			return definition;
		}
		
	}
}