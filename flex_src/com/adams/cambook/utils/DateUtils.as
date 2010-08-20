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
	import mx.formatters.DateFormatter;
	
	/**
	 * The DateUtils class contains utility methods for working with
	 * dates.
	 * 
	 * <script src="http://mint.codeendeavor.com/?js" type="text/javascript"></script>
	 */
	final public class DateUtils
	{
		
		/**
		 * Get someone's age from a birthdate.
		 */
		public static function getAge(bDate:Date):int
		{  
			var cDate:Date=new Date();
			var cMonth:int=cDate.getMonth();
			var cDay:int=cDate.getDate();
			var cYear:int=cDate.getFullYear(); 
			var bMonth:int=bDate.getMonth();  
			var bDay:int=bDate.getDate();
			var bYear:int=bDate.getFullYear();
			var ageYrs:int=cYear-bYear;
			if(cDay<bMonth||(cMonth==bMonth && cDay<bDay)) ageYrs--; 
			return ageYrs;  
		}
		
		private var df:DateFormatter = new DateFormatter();
		private function dateFormate(date:Date):String{
			df.formatString = "MMM,DD,YYYY";
			var str:String = df.format(date);
			return str;
		}
		/**
		 * 0 indexed array of months for use with <code>DateUtils.getMonth()</code>.
		 */
		public static function get months():Array 
		{
			return new Array("January","February","March","April","May","June","July","August","September","October","November","December");
		}
		
		/**
		 * 0 indexed array of short months for use with <code>DateUtils.getMonth()</code>.
		 */
		public static function get shortmonths():Array
		{
			return new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");	
		}
		
		/**
		 * 0 indexed array of days for use with <code>DateUtils.getDay()</code>.
		 */
		public static function get days():Array 
		{
			return new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
		}
		
		/**
		 * 0 indexed array of short days for use with <code>DateUtils.getDay()</code>.
		 */
		public static function get shortdays():Array 
		{
			return new Array("Sun","Mon","Tue","Wed","Thur","Fri","Sat");
		}
		
		/**
		 * Get the month name by month number.
		 * 
		 * @param n The 0 based month index.
		 */
		public static function getMonth(n:int):String 
		{
			return months[n];	
		}
		
		/**
		 * Get the short month name by month number.
		 * 
		 * @param n The 0 based month index.
		 */
		public static function getShortMonth(n:int):String 
		{
			return shortmonths[n];
		}
		
		/**
		 * Get the day name by day number.
		 * 
		 * @param n The 0 based day index.
		 */	
		public static function getDay(n:int):String 
		{
			return days[n];	
		}
		
		/**
		 * Get the short day name by day number.
		 * 
		 * @param n The 0 based day index.
		 */	
		public static function getShortDay(n:int):String 
		{
			return shortdays[n];
		}
		
		/**
		 * Pads hours, minutes or seconds with a leading 0 - so 12:01 doesn't end up 12:1.
		 * 
		 * @param n The number to pad.
		 */
		public static function padTime(n:int):String 
		{
			return (String(n).length < 2) ? String("0" + n) : n as String;
		}
		
		/**
		 * Convert a DB formatted date string into a Flash Date Object.
		 * 
		 * @param dbDate A date formatted like YYYY-MM-DD HH:MM:SS.
		 */
		public static function dateFromDB(dbdate:String):Date 
		{
			var tmp:Array=dbdate.split(" ");
			var dates:Array=tmp[0].split("-");
			var hours:Array=tmp[1].split(":");
			var d:Date=new Date(dates[0],dates[1]-1,dates[2],hours[0],hours[1],hours[2]);
			return d;
		}
		
		/**
		 * Takes 24hr hours and converts to 12 hour with am/pm.
		 * 
		 * @param hour24 The hour in 24 hour format.
		 * @return An object with "hours" and "ampm" properties.
		 */
		public static function getHoursAmPm(hour24:int):Object 
		{
			var returnObj:Object=new Object();
			returnObj.ampm=(hour24 < 12)?"am":"pm";
			var hour12:Number=hour24%12;
			if(hour12 == 0) hour12=12;
			returnObj.hours=hour12;
			return returnObj;
		}
		
		/**
		 * Get the differences between two dates in milliseconds - if
		 * the second date is not provided, a new Date() is used.
		 * 
		 * @param d1 The first date.
		 * @param d2 The second date.
		 */
		public static function dateDiff(d1:Date,d2:Date=null):Number 
		{
			if(!d2) d2=new Date();
			if(!d1) d1=new Date();
			return d2.getTime() - d1.getTime();
		}
		
		public static function dateAdd(d1:Date,duration:int):Date
		{
			var d2:Date = new Date(d1.getTime() + days2ms(duration));
			return d2;
		}
		
		/**
		 * Return the number of days in a specific month.
		 * 
		 * @param year The year.
		 * @param month The 0 based month.
		 */
		public static function getTotalDaysInMonth(year:int, month:int):int 
		{
			return ms2days(dateDiff(new Date(year,month,1),new Date(year,month + 1,1)));
		}
		
		/**
		 * Returns the number of days in a specific year.
		 * 
		 * @param year The year.
		 */
		public static function getTotalDaysInYear(year:int):int 
		{
			return ms2days(dateDiff(new Date(year,0,1),new Date(year + 1,0,1)));
		}
		
		/**
		 * Determines whether or not the provided year is a leap year.
		 * 
		 * @param year The year to check.
		 */
		public static function isLeapYear(year:int):Boolean
		{
			return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
		}
		
		/**
		 * Convert number of weeks to milliseconds.
		 * 
		 * @param n The number of weeks.
		 */
		public static function weeks2ms(n:Number):Number 
		{
			return n * days2ms(7);
		}
		
		/**
		 * Convert number of days to milliseconds.
		 * 
		 * @param n The number of days.
		 */
		public static function days2ms(n:Number):Number 
		{
			return n * hours2ms(24);
		}
		
		/**
		 * Convert number of hours to milliseconds.
		 * 
		 * @param n The number of hours.
		 */
		public static function hours2ms(n:Number):Number 
		{
			return n * minutes2ms(60);
		}
		
		/**
		 * Convert minutes to milliseconds.
		 * 
		 * @param n The number of minutes.
		 */
		public static function minutes2ms(n:Number):Number 
		{
			return n * seconds2ms(60);
		}
		
		/**
		 * Convert seconds to milliseconds.
		 * 
		 * @param n The number of seconds.
		 */
		public static function seconds2ms(n:Number):Number 
		{
			return n * ms(1000);
		}
		
		/**
		 * @private
		 */
		public static function ms(n:Number):Number 
		{
			return n;
		}
		
		/**
		 * Convert milliseconds to weeks.
		 * 
		 * @param n The milliseconds.
		 */
		public static function ms2weeks(n:Number):Number 
		{
			return n / days2ms(7);
		}
		
		/**
		 * Convert milliseconds to days.
		 * 
		 * @param n The milliseconds.
		 */
		public static function ms2days(n:Number):Number 
		{
			return n / hours2ms(24);
		}
		
		/**
		 * Convert milliseconds to hours.
		 * 
		 * @param n The milliseconds.
		 */
		public static function ms2hours(n:Number):Number
		{
			return n / minutes2ms(60);
		}
		
		/**
		 * Convert milliseconds to hours.
		 * 
		 * @param n The milliseconds.
		 */
		public static function ms2minutes(n:Number):Number 
		{
			return n / seconds2ms(60);
		}
		
		/**
		 * Convert milliseconds to seconds.
		 * 
		 * @param n The milliseconds.
		 */
		public static function ms2seconds(n:Number):Number 
		{
			return n / ms(1000);
		}
		public var presetTime : Date;  
		public var debug:Boolean;
		private var _currentTime : Date = new Date();
		public function set currentTime (value : Date) : void{
			_currentTime = value;
		}		
		public function get currentTime() : Date{  
			debug ? _currentTime = presetTime : _currentTime = new Date();
			return _currentTime;
		}
		public static function getCalculatedDate(date:Date,minutes:int):Date{
			date.seconds=+(minutes*60);
			return date;
		}
		public static const milliseconds:int = 1000 * 60; 
		public static var monthDisplay:Array =  ['Jan','Fev','Mars','Avr','Mai','Juin','Juil','Aout','Sept','Oct','Nov','Dec'];
		public static function getDiffrenceBtDate(startDate:Date,endDate:Date):int{			
			return Math.ceil(( endDate.getTime() - startDate.getTime())/milliseconds);
		}
		public static function dateFormat(date:Date):String{
			var str:String = date.date+" "+monthDisplay[date.month]+" "+date.fullYear;
			return str;
		}
	}
}