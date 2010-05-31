/*
 * Copyright 2010 Swiz Framework Contributors
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

package org.swizframework.utils.services
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[ExcludeClass]
	
	/**
	 *
	 * DynamicUrlRequest can be used to wrap URLLoader calles.
	 * The faultHandler function will be used for IOErrors and SecurityErrors
	 * so you should type the argument Event and check/cast the specific type
	 * in the method body.
	 *
	 * When used implicitly from Swiz.executeUrlRequest or AbstractController.executeUrlRequest
	 * the generic fault handler will be applied if available. Otherwise in an error case
	 * the Swiz internal generic fault shows up.
	 *
	 */
	public class SwizURLRequest
	{
		/**
		 *
		 * @param request
		 * @param resultHandler The resultHandler function must expect the an event. event.currentTarget.data should contain the result. Signature can be extended with additional eventArgs
		 * @param faultHandler The faultHandler function will be called for IOErrors and SecurityErrors with the specific error event.
		 * @param progressHandler
		 * @param httpStatusHandler
		 * @param eventArgs The eventArgs will be applied to the signature of the resultHandler function.
		 *
		 */
		public function SwizURLRequest( request:URLRequest, resultHandler:Function, 
			faultHandler:Function = null, progressHandler:Function = null, 
			httpStatusHandler:Function = null, eventArgs:Array = null )
		{
			
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener( Event.COMPLETE, function( e:Event ):void
				{
					// we could apply the result directly but from the current knowledge applying the event itself
					// seems more flexible. This may change in the future if we don't see any necessarity for this.
					
					if ( eventArgs == null ) {
						resultHandler( e );
					} else {
						eventArgs.unshift( e );
						resultHandler.apply( null, eventArgs );
					}
				} );
			
			loader.addEventListener( IOErrorEvent.IO_ERROR, function( e:IOErrorEvent ):void
				{
					if ( faultHandler != null )
						faultHandler( e );
					else {
						// todo: what if there is no fault handler applied to dynamic url request
					}
				} );
			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, function( e:SecurityErrorEvent ):void
				{
					if ( faultHandler != null )
						faultHandler( e );
					else {
						// todo: what if there is no fault handler applied to dynamic url request
					}
				} );
			
			if( progressHandler != null )
			{
				loader.addEventListener( ProgressEvent.PROGRESS, function( e:ProgressEvent ):void
					{
						progressHandler( e );
					} );
			}
			
			if( httpStatusHandler != null )
			{
				loader.addEventListener( HTTPStatusEvent.HTTP_STATUS, function( e:HTTPStatusEvent ):void
					{
						httpStatusHandler( e );
					} );
			}
			
			loader.load( request );
		}
	}
}