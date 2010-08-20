/*
 * Copyright 2010 @nsdevaraj
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License. You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.adams.cambook.models.processor
{
	import com.adams.cambook.dao.AbstractDAO;
	import com.adams.cambook.models.collections.ICollection;
	import com.adams.cambook.models.vo.IValueObject;
	import com.adams.cambook.models.vo.SignalVO; 
	import com.adams.cambook.utils.Action;
	
	import mx.collections.IList;

	public class AbstractProcessor implements IVOProcessor
	{ 
		
		public function AbstractProcessor()
		{
		} 
		//@TODO
		public function processCollection(arrayCollection:IList):void
		{ 
			for each(var vo:IValueObject in arrayCollection){
				processVO(vo);
			}
		}
		public function processResultCollection(arrayCollection:IList):void
		{
			for each(var vo:Object in arrayCollection){
				vo.processed =false;
				processVO(vo as IValueObject);
			}
		}
		public function processVO(vo:IValueObject):void
		{
			vo.processed = true; 
		} 
	}
}