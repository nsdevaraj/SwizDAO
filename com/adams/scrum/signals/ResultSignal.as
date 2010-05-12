package com.adams.scrum.signals
{ 
	import com.adams.scrum.models.vo.SignalVO;
	
	import org.osflash.signals.Signal;
	
	public class ResultSignal extends Signal
	{ 
		public function ResultSignal()
		{
			super(Object,SignalVO);
		}
	}
}