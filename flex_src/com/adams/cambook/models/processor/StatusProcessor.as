package com.adams.cambook.models.processor
{
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.models.vo.Status;
	import com.adams.cambook.utils.Description;
	import com.adams.cambook.utils.Utils;

	public class StatusProcessor extends AbstractProcessor
	{
		public function StatusProcessor()
		{
			super();
		}
		//@TODO
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var status:Status = vo as Status;
				/*switch(status.statusLabel){ 
					case Description.WAITING:
						statusLabelCase(status);
						break;
				}*/
				super.processVO(vo);
			}
		}
		private function eventLabelCase(status:Status):void{
			switch(status.statusLabel){ 
				default:
				//	Utils[status.type+status.statusLabel]= status.statusId;
					break;						
			}
		}
		private function statusLabelCase(status:Status):void{
			switch(status.type){ 
				/*case Description.PRODUCTSTATUS:
					Utils[status.type+status.statusLabel]= status.statusId;
					break; */
			}
		}
	}
}