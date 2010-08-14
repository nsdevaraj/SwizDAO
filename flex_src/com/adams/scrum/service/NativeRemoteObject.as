package com.adams.scrum.service
{
	import mx.messaging.ChannelSet;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public dynamic class NativeRemoteObject extends RemoteObject
	{
		public function NativeRemoteObject(destination:String=null)
		{
			super(destination);
		} 
	}
}