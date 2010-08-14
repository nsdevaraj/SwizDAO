package com.adams.scrum.models.processor
{
	import com.adams.scrum.dao.AbstractDAO;
	import com.adams.scrum.models.collections.ICollection;
	import com.adams.scrum.models.vo.IValueObject;
	import com.adams.scrum.models.vo.SignalVO;
	
	import mx.collections.IList;

	public interface IVOProcessor
	{ 
		function processCollection(collection:IList):void
		function processVO(vo:IValueObject):void 
	}
}