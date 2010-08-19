package com.adams.cambook.models.processor
{
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.models.vo.Notes;
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.utils.GetVOUtil;

	public class NoteProcessor extends AbstractProcessor
	{  
		
		public function NoteProcessor()
		{
			super();
		}
		//@TODO
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var notevo:Notes = vo as Notes;
				super.processVO(vo);
			}
		}
	}
}