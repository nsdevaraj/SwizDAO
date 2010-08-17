package com.nsdevaraj.swiz.processors
{
	import org.swizframework.core.Bean;
	import org.swizframework.processors.BaseMetadataProcessor;
	import org.swizframework.reflection.BaseMetadataTag;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.reflection.MetadataArg;
	import org.swizframework.reflection.MetadataHostMethod;
	import org.swizframework.reflection.MethodParameter;

	public class RandomProcessor extends BaseMetadataProcessor
	{
		protected static const RANDOM:String = "Random";
		public function RandomProcessor()
		{
			super( [RANDOM] );
		}
		
		// ========================================
		// public methods
		// ========================================
		
		/**
		 * This method is called when the bean/tag is processed.
		 * Assigns a random number to the decorated property.
		 */
		override public function setUpMetadataTag(metadataTag:IMetadataTag, bean:Bean):void 
		{
			// bean is a reference to the instance that contains the tag, wrapped in Swiz's Bean class
			// bean.source is the actual model/controller/view/whatever instance
			// metadata is the actual [Random] metadata tag
			// metadata.host is the property, method or class decorated with [Random]
			// metadata.host.name is therefore the property, method or class name
			
			// finally, we use the above references to assign a random number to the
			// specified property on the given instance
			bean.source[ metadataTag.host.name ] = Math.round( Math.random() * 1000 );
		}
		
		/**
		 * Called when the bean is unwired.
		 * Could remove listeners or do other cleanup as necessary here.
		 */
		override public function tearDownMetadataTag(metadataTag:IMetadataTag, bean:Bean):void 
		{
			bean.source[ metadataTag.host.name ] = 0;
		}
	}
}