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
package com.adams.cambook.utils
{
	public class Description
	{
		public static const CREATE:String = 'Create$☼';
		public static const UPDATE:String = 'Update$☼';
		public static const ACKNOWLEDGE:String = 'Acknowledge$☼';
		public static const DELETE:String = 'Delete$☼'; 
		public static const EVENTSTATUS:String = 'eventStatus$☼';
		public static const WAITING:String = 'Waiting$☼';
		public static const INPROGRESS:String = 'InProgress$☼';
		public static const STANDBY:String = 'StandBy$☼';
		public static const FINISHED:String = 'Finished$☼';
		public static const DESCARR:Array = [CREATE,UPDATE,ACKNOWLEDGE,DELETE,EVENTSTATUS,WAITING,INPROGRESS,STANDBY,FINISHED];
		public function Description()
		{
		}
	}
}