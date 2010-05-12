package com.adams.scrum.service
{
	import mx.events.PropertyChangeEvent;
	import mx.messaging.ChannelSet;
	
	import org.osflash.signals.natives.NativeSignal;
	
	public class NativeChannelSet extends ChannelSet
	{
		public var loginAttempt:NativeSignal;
		public function NativeChannelSet(channelIds:Array=null, clusteredWithURLLoadBalancing:Boolean=false)
		{
			super(channelIds, clusteredWithURLLoadBalancing);
			loginAttempt = new NativeSignal(this,'propertyChange',PropertyChangeEvent);
		}
		
	}
}