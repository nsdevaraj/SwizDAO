package com.adams.cambook.models.processor
{
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.models.vo.Notes;
	import com.adams.cambook.models.vo.Persons;
	import com.adams.cambook.utils.GetVOUtil;

	public class NoteProcessor extends AbstractProcessor
	{  
		[Inject("noteDAO")]
		public var noteDAO:AbstractDAO;

		public function NoteProcessor()
		{
			super();
		}
		//@TODO
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var notevo:Notes = vo as Notes;
				if(!noteDAO.collection.containsItem(notevo)){
					noteDAO.collection.addItem(notevo);
				}
				for each(var repliedNote:Notes in notevo.notesSet){
					/*processVO(repliedNote);
					if(!noteDAO.collection.containsItem(repliedNote)){
						noteDAO.collection.addItem(repliedNote);
					}*/
				}
				super.processVO(vo);
			}
		}
	}
}