package com.adams.cambook.models.processor
{
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.models.vo.Notes;
	import com.adams.cambook.models.vo.Persons;
	import com.adams.cambook.utils.GetVOUtil;

	public class NoteProcessor extends AbstractProcessor
	{  
		
		[Inject("personDAO")]
		public var personDAO:AbstractDAO;
		
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
				notevo.PersonObj = GetVOUtil.getVOObject(notevo.createdPersonFK,personDAO.collection.items,personDAO.destination,Persons) as Persons;
				
				for each(var repliedNote:Notes in notevo.notesSet){
					processVO(repliedNote);
					if(!noteDAO.collection.containsItem(repliedNote)){
						noteDAO.collection.addItem(repliedNote);
					}
				}
				super.processVO(vo);
			}
		}
	}
}