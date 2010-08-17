/*
Copyright 2010 Samuel Ahn

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package com.foomonger.swizframework.processors {

	import flash.utils.getDefinitionByName;
	
	import org.osflash.signals.IDeluxeSignal;
	import org.osflash.signals.ISignal;
	import org.swizframework.core.Bean;
	import org.swizframework.processors.BaseMetadataProcessor;
	import org.swizframework.reflection.BaseMetadataTag;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.reflection.MetadataArg;
	import org.swizframework.reflection.MetadataHostMethod;
	import org.swizframework.reflection.MethodParameter;
	import org.swizframework.utils.logging.SwizLogger;

	/**
	 * MediateSignalProcessor is the Signal version of MediateProcessor. After defining 
	 * Signal or DeluxeSignal Beans, decorate Signal listener methods with the [MediateSignal]
	 * metadata tag and set a bean name ("bean" property) or type ("type" property) which 
	 * is useful when subclassing Signals. "bean" is the default property. You may also use 
	 * the "priority" property for DeluxeSignals. 
	 */ 
	public class MediateSignalProcessor extends BaseMetadataProcessor {

		protected static const MEDIATE_SIGNAL:String = "MediateSignal";
		
		protected static const WILDCARD_PACKAGE:RegExp = /\A(.*)(\.\**)\Z/;
		
		internal var logger:SwizLogger = SwizLogger.getLogger(this);
		
		protected var _signalPackages:Array = [];

		public var strictArgumentTypes:Boolean = false;
	
		public function get signalPackages():Array {
			return _signalPackages;
		}
				
		public function set signalPackages(value:*):void {
			_signalPackages = parsePackageValue(value);
		}
 
		public function MediateSignalProcessor() {
			super([MEDIATE_SIGNAL]);
		}
 
		override public function setUpMetadataTag(metadataTag:IMetadataTag, bean:Bean):void {
			var signalBean:Bean = getSignalBean(metadataTag);
			
			if (signalBean == null) {
				logger.error("[MediateSignalProcessor] Bean not found for tag {0}", (metadataTag as BaseMetadataTag).asTag);
				return;
			}
			if (!(signalBean.source is ISignal) && !(signalBean.source is IDeluxeSignal)) {
				logger.error("[MediateSignalProcessor] Bean source is not a Signal for tag {0}", (metadataTag as BaseMetadataTag).asTag);
				return;
			}
			var hostParameters:Array = (metadataTag.host as MetadataHostMethod).parameters;
			var signalValueClasses:Array = (signalBean.source["valueClasses"] as Array)
											? signalBean.source["valueClasses"] as Array
											: [];
			
			if (!isValidHostArguments(hostParameters, signalValueClasses)) {
				logger.error("[MediateSignalProcessor] Invalid Signal listener arguments. {0}.{1}()", String(bean.source), metadataTag.host.name);
				return;
			}
			
			var listener:Function = bean.source[metadataTag.host.name];
			
			if (signalBean.source is ISignal) {
				var signal:ISignal = signalBean.source as ISignal;
				signal.add(listener);
			} else if (signalBean.source is IDeluxeSignal) {
				var deluxeSignal:IDeluxeSignal = signalBean.source as IDeluxeSignal;
				var priorityArg:MetadataArg = metadataTag.getArg("priority");
				var priority:int = priorityArg ? int(priorityArg.value) : 0; 
				deluxeSignal.addWithPriority(listener, priority);
			}
		}
						
		override public function tearDownMetadataTag(metadataTag:IMetadataTag, bean:Bean):void {
			var signalBean:Bean = getSignalBean(metadataTag);
			
			if (signalBean) {
				var listener:Function = bean.source[metadataTag.host.name];
				
				if (signalBean.source is ISignal) {
					var signal:ISignal = signalBean.source as ISignal;
					signal.remove(listener);
				} else if (signalBean.source is IDeluxeSignal) {
					var deluxeSignal:IDeluxeSignal = signalBean.source as IDeluxeSignal; 
					deluxeSignal.remove(listener);
				}
			}
		}
 
		private function getSignalBean(metadataTag:IMetadataTag):Bean {
			var signalBean:Bean;
			
			// First find Bean by name
			var beanName:String;
			var defaultArg:MetadataArg = metadataTag.getArg("");
			if (defaultArg) {
				beanName = defaultArg.value;
			} else {
				var beanArg:MetadataArg = metadataTag.getArg("bean");
				if (beanArg) {
					beanName = beanArg.value;
				}
			}
			if (beanName) {
				signalBean = beanFactory.getBeanByName(beanName)
			}
			
			// If not found by Name, then find by Type
			if (signalBean == null) {
				var typeArg:MetadataArg = metadataTag.getArg("type");
				if (typeArg) {
					var type:Class;
					if (signalPackages.length > 0) {
						type = findClassDefinition(typeArg.value, signalPackages);
					} else {
						type = getClassDefinitionByName(typeArg.value) as Class;
					}
					if (type) {
						signalBean = beanFactory.getBeanByType(type);
					}
				}
			}

			return signalBean;
		}
		
		private function isValidHostArguments(hostParameters:Array, signalValueClasses:Array):Boolean {
			// Compare lengths
			if (hostParameters.length != signalValueClasses.length) {
				return false;
			}
			// If strict mode, then check types
			if (strictArgumentTypes) {
				hostParameters.sortOn("index", Array.NUMERIC);
				var ilen:int = signalValueClasses.length;
				var hostParameter:MethodParameter;
				var signalValueClass:Class;
				for (var i:int = 0; i < ilen; i++) {
					signalValueClass = signalValueClasses[i] as Class;
					hostParameter = hostParameters[i] as MethodParameter;
					// It would be nice if this accounted for interface implementations
					if (signalValueClass != hostParameter.type) {
						return false;
					}
				}
			}
			
			return true;
		}
		
		/*
		Parser method copied from SwizConfig so that logic is consitent with eventPackages.
		*/
		
		private static function parsePackageValue(value:*):Array {
			if (value == null) {
				return [];
			} else if (value is Array) {
				return parsePackageNames(value as Array);
			} else if (value is String) {
				return parsePackageNames(value.replace( /\ /g, "" ).split( "," ));
			} else {
				throw new Error("Package specified using unknown type. Supported types are Array or String.");
			}
		}

		private static function parsePackageNames( packageNames:Array):Array {
			var parsedPackageNames:Array = [];
			
			for each(var packageName:String in packageNames) {
				parsedPackageNames.push(parsePackageName(packageName));
			}
			
			return parsedPackageNames;
		}
		
		private static function parsePackageName(packageName:String):String {
			var match:Object = WILDCARD_PACKAGE.exec(packageName);
			if (match) {
				return match[1];
			}
			return packageName;
		}
		
		/*
		Lookup logic copied from ClassConstant.
		*/
		private static function findClassDefinition(className:String, packageNames:Array):Class {
			var definition:Class;
			for each(var packageName:String in packageNames) {
				definition = getClassDefinitionByName(packageName + "." + className) as Class;
				if (definition != null) {
					break;
				}
			}
			return definition;
		}
		
		private static function getClassDefinitionByName(className:String):Class {
			var definition:Class;
			try {
				definition = getDefinitionByName(className) as Class;
			} catch (e:Error) {
				// Nothing
			}
			return definition;
		}
	}
}