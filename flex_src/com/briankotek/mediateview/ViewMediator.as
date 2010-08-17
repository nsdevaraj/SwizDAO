package com.briankotek.mediateview
{
	public class ViewMediator
	{
		private var _viewMetadataTag : MediateViewMetadataTag;
		
		public function get method() : Function
		{
			return _method;
		}
		
		private var _method : Function;
		
		public function get viewMetadataTag() : MediateViewMetadataTag
		{
			return _viewMetadataTag;
		}
		
		public function ViewMediator( viewMetadataTag : MediateViewMetadataTag, method : Function )
		{
			_viewMetadataTag = viewMetadataTag;
			_method = method;
		}
	}
}