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
package com.nsdevaraj.swiz.processors {

	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.controls.DateField;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.events.FlexEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import org.swizframework.core.Bean;
	import org.swizframework.processors.BaseMetadataProcessor;
	import org.swizframework.processors.ProcessorPriority;
	import org.swizframework.reflection.BaseMetadataTag;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.reflection.MetadataArg;
	import org.swizframework.utils.logging.SwizLogger;
	
	import spark.components.TextArea;
	import spark.components.TextInput;

	/**
	 * ResourceProcessor binds a resource to the decorated property. Define a key
	 * and bundle just like the @Resource directive.
	 */ 
	public class FormProcessor extends BaseMetadataProcessor {

		protected static const FORM:String = "Form";
		public static const FORM_READY:String ='FormReady'
		internal var logger:SwizLogger = SwizLogger.getLogger(this);
		 
		internal var sources:Dictionary;
		
		public function FormProcessor() {
			super([FORM]);
			sources = new Dictionary(true);
		}
		override public function get priority():int {
			return ProcessorPriority.POST_CONSTRUCT + 2;
		}
		private var beanObj:Object;
		private var host:String; 
		private var formKey:String; 
		private var key:String; 
		
		override public function setUpMetadataTag(metadataTag:IMetadataTag, bean:Bean):void {
			// Get properties
			beanObj = bean;
			var formArg : MetadataArg= metadataTag.getArg("form");
			var objArg:MetadataArg = metadataTag.getArg("obj");
			key = objArg ? objArg.value : "";
 			formKey = formArg ? formArg.value : "";
			
			if (formKey.length == 0){
				logger.error("[FormProcessor] form properties required for tag {0}", (metadataTag as BaseMetadataTag).asTag);
				return;
			} 
			host = metadataTag.host.name; 
			beanObj.source.addEventListener(FORM_READY,initForm,false,0,true);	
		}
		private function initForm(ev:Event):void{
			var viewObj:Object = beanObj.source[ formKey.split('.')[0]];
			var taskForm:Form = viewObj[formKey.split('.')[1]];
			
			//assign old object (optional)	
			var obj:Object;
			var oldObj:Object;
			oldObj ? obj = oldObj :obj = new Object();
			if(key!="") oldObj= beanObj.source[key];
			
			beanObj.source[host]=obj; 
			setUpForm(obj,taskForm,oldObj);
		}
		private function setUpForm(obj:Object,taskForm:Form,oldObj:Object = null ):void {
 			for (var i: int =0; i<taskForm.numElements; i++){
				if(taskForm.getChildAt(i) is FormItem){
					var uiComp:Object = FormItem(taskForm.getChildAt(i)).getChildAt(0) as Object;
					if(uiComp is spark.components.TextInput || uiComp is spark.components.TextArea ||uiComp is DateField  || uiComp is mx.controls.TextArea || uiComp is mx.controls.TextInput ){
						var watcher:ChangeWatcher = BindingUtils.bindProperty(obj, uiComp.name, uiComp, "text");
						// Bind property
 						if (watcher) {
							// Save the watcher for unbinding
							addWatcher(obj, uiComp.name, watcher);
						} else {
							logger.error("[FormProcessor] Unable to create binding for tag {0}");
						}
					}
				}
			}   
			beanObj.source.removeEventListener(FORM_READY,initForm);
		}
						
		override public function tearDownMetadataTag(metadataTag:IMetadataTag, bean:Bean):void {
			var watcher:ChangeWatcher = getWatcher(bean.source, metadataTag.host.name);
			if (watcher) {
				watcher.unwatch();
				removeWatcher(bean.source, metadataTag.host.name);
			}
		}
		
		protected function addWatcher(source:*, hostName:String, watcher:ChangeWatcher):void {
			if (sources[source] == null) {
				sources[source] = {};
			}
			var hosts:Object = sources[source] as Object;
			hosts[hostName] = watcher;
		}
		
		protected function getWatcher(source:*, hostName:String):ChangeWatcher {
			var watcher:ChangeWatcher;
			var hosts:Object = sources[source] as Object;
			if (hosts) {
				watcher = hosts[hostName] as ChangeWatcher;
			}
			return watcher;
		}
		//@TODO
		protected function removeWatcher(source:*, hostName:String):void {
			var hosts:Object = sources[source] as Object;
			if (hosts == null) {
				return;
			}
			// Delete host name record
			hosts[hostName] = null;
			delete hosts[hostName];
			// Check if no more hosts for this source
			var count:int = 0;
			for (var o:Object in hosts) {
				if (count++ > 0) {
					break;
				}
			}
			// If no more then delete source record
			if (count == 0) {
				sources[source] = null;
				delete sources[source];
			}
		}
	}
}