package com.adams.cambook.models.processor
{
	import com.adams.cambook.dao.AbstractDAO; 
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.models.vo.Persons;
	import com.adams.cambook.models.vo.SignalVO;
	import com.adams.cambook.utils.GetVOUtil;

	public class PersonProcessor extends AbstractProcessor
	{  		
		public function PersonProcessor()
		{
			super();
		} 	
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var person:Persons = vo as Persons;
				super.processVO(vo);
			}
		}
	}
}