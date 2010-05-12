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

package org.swizframework.utils
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.ILoggingTarget;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	
	public class SwizLogger extends EventDispatcher implements ILogger
	{
		protected static var loggers:Dictionary;
		protected static var loggingTargets:Array;
		
		public static function getLogger( target:Object ):ILogger
		{
			loggers ||= new Dictionary();
			
			var className:String = getQualifiedClassName( target );
			var logger:SwizLogger = loggers[ className ];
			
			// if the logger doesn't already exist, create and store it
			if( logger == null )
			{
				logger = new SwizLogger( className );
				loggers[ className ] = logger;
			}
			
			// check for existing targets interested in this logger
			if( loggingTargets != null )
			{
				for each( var logTarget:ILoggingTarget in loggingTargets )
				{
					if( categoryMatchInFilterList( logger.category, logTarget.filters ) )
						logTarget.addLogger( logger );
				}
			}
			
			return logger;
		}
		
		/**
		 *  This method checks that the specified category matches any of the filter
		 *  expressions provided in the <code>filters</code> Array.
		 *
		 *  @param category The category to match against
		 *  @param filters A list of Strings to check category against.
		 *  @return <code>true</code> if the specified category matches any of the
		 *            filter expressions found in the filters list, <code>false</code>
		 *            otherwise.
		 */
		public static function categoryMatchInFilterList( category:String, filters:Array ):Boolean
		{
			var result:Boolean = false;
			var filter:String;
			var index:int = -1;
			for( var i:uint = 0; i < filters.length; i++ )
			{
				filter = filters[ i ];
				// first check to see if we need to do a partial match
				// do we have an asterisk?
				index = filter.indexOf( "*" );
				
				if( index == 0 )
					return true;
				
				index = index < 0 ? index = category.length : index - 1;
				
				if( category.substring( 0, index ) == filter.substring( 0, index ) )
					return true;
			}
			return false;
		}
		
		public static function addLoggingTarget( loggingTarget:ILoggingTarget ):void
		{
			loggingTargets ||= [];
			if( loggingTargets.indexOf( loggingTarget ) < 0 )
				loggingTargets.push( loggingTarget );
			
			if( loggers != null )
			{
				for each( var logger:ILogger in loggers )
				{
					if( categoryMatchInFilterList( logger.category, loggingTarget.filters ) )
						loggingTarget.addLogger( logger );
				}
			}
		}
		
		// ========================================
		// static stuff above
		// ========================================
		// ========================================
		// instance stuff below
		// ========================================
		
		protected var _category:String;
		
		public function SwizLogger( className:String )
		{
			super();
			
			_category = className;
		}
		
		/**
		 *  The category this logger send messages for.
		 */
		public function get category():String
		{
			return _category;
		}
		
		protected function constructMessage( msg:String, params:Array ):String
		{
			// replace all of the parameters in the msg string
			for( var i:int = 0; i < params.length; i++ )
			{
				msg = msg.replace( new RegExp( "\\{" + i + "\\}", "g" ), params[ i ] );
			}
			return msg;
		}
		
		// ========================================
		// public methods
		// ========================================
		
		/**
		 *  @inheritDoc
		 */
		public function log( level:int, msg:String, ... rest ):void
		{
			if( hasEventListener( LogEvent.LOG ) )
			{
				dispatchEvent( new LogEvent( constructMessage( msg, rest ), level ) );
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function debug( msg:String, ... rest ):void
		{
			if( hasEventListener( LogEvent.LOG ) )
			{
				dispatchEvent( new LogEvent( constructMessage( msg, rest ), LogEventLevel.DEBUG ) );
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function info( msg:String, ... rest ):void
		{
			if( hasEventListener( LogEvent.LOG ) )
			{
				dispatchEvent( new LogEvent( constructMessage( msg, rest ), LogEventLevel.INFO ) );
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function warn( msg:String, ... rest ):void
		{
			if( hasEventListener( LogEvent.LOG ) )
			{
				dispatchEvent( new LogEvent( constructMessage( msg, rest ), LogEventLevel.WARN ) );
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function error( msg:String, ... rest ):void
		{
			if( hasEventListener( LogEvent.LOG ) )
			{
				dispatchEvent( new LogEvent( constructMessage( msg, rest ), LogEventLevel.ERROR ) );
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function fatal( msg:String, ... rest ):void
		{
			if( hasEventListener( LogEvent.LOG ) )
			{
				dispatchEvent( new LogEvent( constructMessage( msg, rest ), LogEventLevel.FATAL ) );
			}
		}
	}
}
