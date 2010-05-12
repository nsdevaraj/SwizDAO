package com.adams.scrum.signals
{ 
	import mx.core.UIComponent;
	
	import org.osflash.signals.Signal;
	
	public class ViewSignal extends Signal
	{ 
		public function ViewSignal()
		{
			super(UIComponent);
		}
	}
}