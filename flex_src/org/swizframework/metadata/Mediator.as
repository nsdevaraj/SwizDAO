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

package org.swizframework.metadata
{
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	import org.swizframework.reflection.MetadataHostMethod;
	import org.swizframework.reflection.MethodParameter;
	
	/**
	 * Represents a deferred request for mediation.
	 */
	public class Mediator
	{
		// ========================================
		// protected properties
		// ========================================
		
		/**
		 * Backing variable for <code>metadata</code> property.
		 */
		protected var _metadataTag:MediateMetadataTag;
		
		/**
		 * Backing variable for <code>method</code> property.
		 */
		protected var _method:Function;
		
		// ========================================
		// public properties
		// ========================================
		
		/**
		 * The corresponding [Mediate] tag.
		 */
		public function get metadataTag():MediateMetadataTag
		{
			return _metadataTag;
		}
		
		/**
		 * The function decorated with the [Mediate] tag.
		 */
		public function get method():Function
		{
			return _method;
		}
		
		// ========================================
		// constructor
		// ========================================
		
		/**
		 * Constructor
		 */
		public function Mediator( metadataTag:MediateMetadataTag, method:Function )
		{
			_metadataTag = metadataTag;
			_method = method;
		}
		
		// ========================================
		// public methods
		// ========================================
		
		/**
		 * Mediate
		 *
		 * @param event The Event to mediate.
		 */
		public function mediate( event:Event ):void
		{
			if( metadataTag.properties != null )
			{
				if( validateEvent( event, metadataTag.properties ) )
					method.apply( null, getEventArgs( event, metadataTag.properties ) );
			}
			else if( getRequiredParameterCount() <= 1 )
			{
				if( ( getParameterCount() > 0 ) && ( event is getParameterType( 0 ) ) )
					method.apply( null, [ event ] );
				else
					method.apply();
			}
			else
			{
				throw new Error( "Unable to mediate event: " + metadataTag.host.name + "() requires " + getRequiredParameterCount() + " parameters, and no properties were specified." );
			}
			
			if( metadataTag.stopPropagation )
				event.stopPropagation();
			
			if( metadataTag.stopImmediatePropagation )
				event.stopImmediatePropagation();
		}
		
		// ========================================
		// protected methods
		// ========================================
		
		/**
		 * Validate Event
		 *
		 * Evalutes an Event to ensure it has all of the required properties specified in the [Mediate] tag, if applicable.
		 *
		 * @param event The Event to validate.
		 * @param properties The required properties specified in the [Mediate] tag.
		 * @returns A Boolean value indicating whether the event has all of the required properties specified in the [Mediate] tag.
		 */
		protected function validateEvent( event:Event, properties:Array ):Boolean
		{
			for each( var property:String in properties )
			{
				if( ! ( property in event ) )
					throw new Error(  "Unable to mediate event: " + property + " does not exist as a property of " + getQualifiedClassName( event ) + "." );
			}
			
			return true;
		}
		
		/**
		 * Get Event Arguments
		 *
		 * @param event
		 * @param properties
		 */
		protected function getEventArgs( event:Event, properties:Array ):Array
		{
			var args:Array = [];
			
			for each( var property:String in properties )
			{
				args[ args.length ] = event[ property ];
			}
			
			return args;
		}
		
		/**
		 * Get Parameter Count
		 *
		 * @returns The number of parameters for the mediated method.
		 */
		protected function getParameterCount():int
		{
			return ( metadataTag.host as MetadataHostMethod ).parameters.length;
		}
		
		/**
		 * Get Required Parameter Count
		 *
		 * @returns The number of required parameters for the mediated method.
		 */
		protected function getRequiredParameterCount():int
		{
			var requiredParameterCount:int = 0;
			
			var parameters:Array = ( metadataTag.host as MetadataHostMethod ).parameters;
			for each( var parameter:MethodParameter in parameters )
			{
				if( parameter.optional )
					break;
				
				requiredParameterCount++;
			}
			
			return requiredParameterCount;
		}
		
		/**
		 * Get Parameter Type
		 *
		 * @param parameterIndex The index of parameter of the mediated method.
		 * @returns The type for the specified parameter.
		 */
		protected function getParameterType( parameterIndex:int ):Class
		{
			var parameters:Array = ( metadataTag.host as MetadataHostMethod ).parameters;
			
			if( parameterIndex < parameters.length )
				return ( parameters[ parameterIndex ] as MethodParameter ).type;
			
			return null;
		}
	}
}