package com.adams.scrum.models.processor
{
	import com.adams.scrum.dao.AbstractDAO;
	import com.adams.scrum.models.vo.IValueObject;
	import com.adams.scrum.models.vo.Persons;
	import com.adams.scrum.models.vo.Tasks;
	import com.adams.scrum.utils.GetVOUtil;
	
	import mx.collections.ArrayCollection;

	public class TaskProcessor extends AbstractProcessor
	{ 
		
		[Inject("personDAO")]
		public var personDAO:AbstractDAO; 
		
		public function TaskProcessor()
		{
			super();
		}
		override public function processVO(vo:IValueObject):void
		{
			var task:Tasks = vo as Tasks; 
			
			//task.personObject = GetVOUtil.getVOObject(task.personFk,personDAO.collection.items,'personId',Persons) as Persons;
		}
	}
}