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
		function processAddPushMessage(signal:SignalVO,dao:AbstractDAO):void
		function processUpdatePushMessage(signal:SignalVO,dao:AbstractDAO):void
	}
}