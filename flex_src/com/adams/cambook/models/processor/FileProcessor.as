package com.adams.cambook.models.processor
{
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.models.vo.Files;
	import com.adams.cambook.models.vo.IValueObject; 
	import com.adams.cambook.utils.GetVOUtil;

	public class FileProcessor extends AbstractProcessor
	{ 
		
		public function FileProcessor()
		{
			super();
		}
		//@TODO
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var file:Files = vo as Files;
				super.processVO(vo);
			}
		}
	}
}