package com.adams.cambook.models.processor
{
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.models.vo.Notes;
	import com.adams.cambook.models.vo.Persons;
	import com.adams.cambook.models.vo.SignalVO;
	import com.adams.cambook.utils.GetVOUtil;

	public class PersonProcessor extends AbstractProcessor
	{  		
		
		[Inject]
		public var noteProcessor:NoteProcessor;
		
		[Inject("personDAO")]
		public var personDAO:AbstractDAO;
		
		public function PersonProcessor()
		{
			super();
		} 	
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var person:Persons = vo as Persons;
				for each(var connectedPerson:Persons in person.connectionSet){
					processVO(connectedPerson);
					person.connectionArr.push(connectedPerson.personId);
					
					if(!personDAO.collection.containsItem(connectedPerson)){
						personDAO.collection.addItem(connectedPerson);
					}
				}
				for each(var note:Notes in person.notesSet){
					noteProcessor.processVO(note);
				}
				
				super.processVO(vo);
			}
		}
	}
}