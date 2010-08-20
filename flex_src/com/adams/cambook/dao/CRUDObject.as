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
package com.adams.cambook.dao 
{
	import com.adams.cambook.models.collections.AbstractCollection;
	import com.adams.cambook.models.collections.ICollection;
	import com.adams.cambook.models.processor.AbstractProcessor;
	import com.adams.cambook.models.processor.IVOProcessor;
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.response.AbstractResult;
	import com.adams.cambook.utils.Action;
	
	import mx.collections.IList;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class CRUDObject  
	{

		public function get processor():IVOProcessor
		{
			return _processor;
		}

		public function set processor(value:IVOProcessor):void
		{
			_processor = value;
		}
		
		/**
		 * The CRUDObject is responsible for assigning VOProcessor, Collection, ServerObject 
		 * and also manages assigning the AbstractResult as delegate to manage the server responses.
		 * <p>
		 * Constructor, parent of AbstractDAO
		 * </p>
 		 */
		public function CRUDObject():void { 
			
		}
		[Inject]
		public var delegate:AbstractResult;
		
		protected var _remoteService:RemoteObject;  
		public function get remoteService():RemoteObject  {
			return _remoteService;
		}
		
		public function set remoteService( ro:RemoteObject ):void {
			_remoteService = ro; 
		}
		
		protected var _destination:String;  
		public function get destination():String {
			return _destination;
		}
		
		public function set destination( str:String ):void {
			_destination = str;
		}
		/**
 		 * <p>
		 * The destination of remote service is set accordingly
		 * </p>
 		 */		
		public function invoke():void{
			remoteService.destination = destination;
		}
		
		private var _processor:IVOProcessor;
		
		protected var _collection:ICollection = new AbstractCollection();
		/**
		 * <p>
		 * The sortString of collection is set as destination for generic find functions
		 * using IViewCursor as Sort is necessary for finding
		 * </p>
 		 */
		public function get collection():ICollection {
			_collection.sortString = destination;
			return _collection;
		}
		
		public function set collection(v:ICollection):void {
			_collection=v;
		}
		/**
		 * Whenever an create action is called by AbstractDAO.
		 * invokeAction initates to perform Generic Create Action
		 * <p>
		 * The new VO create function for Generic DAO
		 * </p>
 		 */
		public function create( vo:IValueObject ):AsyncToken {
			invoke();
			delegate.token = remoteService.create(vo);
			return delegate.token;
		}
		/**
		 * Whenever an update action is called by AbstractDAO.
		 * invokeAction initates to perform Generic update Action
		 * <p>
		 * The VO update function for Generic DAO
		 * </p>
 		 */		
		public function update( vo:IValueObject ):AsyncToken {
			invoke();
			delegate.token = remoteService.update(vo);
			return delegate.token;
		}
		/**
		 * Whenever an read action is called by AbstractDAO.
		 * invokeAction initates to perform Generic read Action
		 * <p>
		 * The VO read function for Generic DAO
		 * </p>
 		 */		
		public function read( id:int ):AsyncToken {
			invoke();
			delegate.token = remoteService.findByTaskId( id );
			return delegate.token;
		}
		/**
		 * Whenever an create action is called by AbstractDAO.
		 * invokeAction initates to perform Generic Create Action
		 * <p>
		 * The new VO create function for Generic DAO
		 * </p>
 		 */		
		public function findById( id:int ):AsyncToken {
			invoke();
			delegate.token = remoteService.findById( id );
			return delegate.token;
		}
		public function findByName( str:String ):AsyncToken {
			invoke();
			delegate.token = remoteService.findByName( str );
			return delegate.token;
		}
		/**
		 * Whenever an read for pushed object action is called by AbstractDAO.
		 * invokeAction initates to perform Generic read for pushed Action
		 * <p>
		 * The read for pushed VO function for Generic DAO
		 * </p>
 		 */		
		public function findId( id:int ):AsyncToken {
			invoke();
			delegate.token = remoteService.findId( id );
			return delegate.token;
		}
		/**
		 * Whenever an delete action is called by AbstractDAO.
		 * invokeAction initates to perform Generic delete Action
		 * <p>
		 * The VO delete function for Generic DAO
		 * </p>
 		 */		
		public function deleteById( vo:IValueObject ):AsyncToken {
			invoke();
			delegate.token = remoteService.deleteById( vo );
			return delegate.token;
		}
		/**
		 * Whenever an count action is called by AbstractDAO.
		 * invokeAction initates to perform Generic count Action
		 * <p>
		 * The VO count function for Generic DAO
		 * </p>
 		 */		
		public function count():AsyncToken {
			invoke();
			delegate.token = remoteService.count();
			return delegate.token;
		}
		/**
		 * Whenever an get All action is called by AbstractDAO.
		 * invokeAction initates to perform Generic get All Action
		 * <p>
		 * The get All VOs function for Generic DAO
		 * </p>
 		 */		
		public function getList():AsyncToken {
			invoke();
			delegate.token = remoteService.getList(); 
			return delegate.token;
		}
		public function getSQLList():AsyncToken {
			invoke();
			delegate.token = remoteService.findAll(); 
			return delegate.token;
		}
		/**
		 * Whenever an bulk update action is called by AbstractDAO.
		 * invokeAction initates to perform Generic bulk update Action
		 * <p>
		 * The VO list bulk updatefunction for Generic DAO
		 * </p>
 		 */		
		public function bulkUpdate( list:IList ):AsyncToken {
			invoke();
			delegate.token = remoteService.bulkUpdate(list);
			return delegate.token;
		}
		/**
		 * Whenever an delete all action is called by AbstractDAO.
		 * invokeAction initates to perform Generic delete all Action
		 * <p>
		 * The delete all VOs function for Generic DAO
		 * </p>
 		 */		
		public function deleteAll():AsyncToken {
			invoke();
			delegate.token = remoteService.deleteAll();
			return delegate.token;
		}
	}
}