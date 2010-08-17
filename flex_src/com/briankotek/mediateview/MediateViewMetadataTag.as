package com.briankotek.mediateview
{
	import org.swizframework.reflection.BaseMetadataTag;
	import org.swizframework.reflection.IMetadataTag;
	
	public class MediateViewMetadataTag extends BaseMetadataTag
	{
		
		/**
		 * Backing variable for read-only <code>viewId</code> property.
		 */
		protected var _viewId : String;
		
		/**
		 * Backing variable for read-only <code>view</code> property.
		 */
		protected var _view : String;
		
		public function MediateViewMetadataTag()
		{
			defaultArgName = "view";
		}
		
		public function get viewId() : String
		{
			return _viewId;
		}
		
		public function get view() : String
		{
			return _view;
		}
		
		/**
		 * Initialize properties based on values provided in [MediateView] tag.
		 */
		override public function copyFrom( metadataTag : IMetadataTag ) : void
		{
			// super will set name, args and host for us
			super.copyFrom( metadataTag );
			
			// view is the default attribute
			// [MediateView( "MyView" )] == [MediateView( view="MyView" )]
			if ( hasArg( "view" ) )
				_view = getArg( "view" ).value;
			
			if ( hasArg( "viewId" ) )
				_viewId = getArg( "viewId" ).value;
		}
		
	}
}