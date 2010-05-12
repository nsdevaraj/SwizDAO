package com.adams.scrum.response
{
	import com.adams.scrum.models.vo.SignalVO;
	import com.adams.scrum.signals.AbstractSignal;
	import com.adams.scrum.utils.ArrayUtil;			
	public class SignalSequence 
	{       
		private var events:Array = [];  
		
		[Inject]
		public var serviceSignal:AbstractSignal;
		
		private var serviceInProcess:Boolean;
		
		public function SignalSequence():void {
		}
		
		public function addSignal(signal:SignalVO):void { 
			events.push(signal);
			if(!serviceInProcess){
				onSignalDone();
			} 
		}
		
		private function dispatchNextSignal():void {
			var signal:SignalVO = events[0] as SignalVO;
			serviceSignal.currentSignal = signal;
			serviceSignal.currentCollection = signal.collection;
			serviceSignal.currentProcessor = signal.processor;
			serviceSignal.dispatch(signal);
			ArrayUtil.removeElementAt(0,events);
		}  
		
		public function onSignalDone():void { 
			if (events.length>0) {
				dispatchNextSignal();
				serviceInProcess = true;
				return;      			
			}else{
				serviceInProcess = false;
			}
		} 
	}
}