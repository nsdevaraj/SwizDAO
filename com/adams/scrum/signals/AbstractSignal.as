package com.adams.scrum.signals
{
	import com.adams.scrum.models.collections.ICollection;
	import com.adams.scrum.models.processor.IVOProcessor;
	import com.adams.scrum.models.vo.SignalVO;
	
	import org.osflash.signals.Signal;

	public class AbstractSignal extends Signal
	{  
		public var currentSignal:SignalVO;
		public var currentCollection:ICollection;
		public var currentProcessor:IVOProcessor;
		public function AbstractSignal()
		{
			super(SignalVO);
		}
	}
}