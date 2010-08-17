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
	public class ArrayUtil
	{
		public function ArrayUtil()
		{
		}
		
		public static function addElement(element:*, source:Array):*
		{
			source.push(element);
			return element;
		} 
		
		public static function addElementAt(element:*, index:int, source:Array):*
		{
			if (index < 0) {
				index += source.length;
			}
			
			if (index < 0 || source.length < index) {
				throw new RangeError('index');
			}
			
			source.splice(index, 0, element);
			
			return element;
		}
		
		public static function getElementAt(index:int, source:Array):*
		{
			if (index < 0) {
				index += source.length;
			}
			
			if (index < 0 || source.length <= index) {
				throw new RangeError('index');
			}
			
			return source[index];
		}
		
		public static function getElementIndex(element:*, source:Array):int
		{
			return source.indexOf(element);
		}
		
		public static function removeElement(element:*, source:Array):*
		{
			var index:int = source.indexOf(element);
			if (index < 0) {
				throw new ArgumentError('element');
			}
			
			source.splice(index, 1);
			
			return element;
		}
		
		public static function removeElementAt(index:int, source:Array):*
		{
			if (index < 0) {
				index += source.length;
			}
			
			if (index < 0 || source.length <= index) {
				throw new RangeError('index');
			}
			
			return source.splice(index, 1)[0];
		}
		public static function arraysAreEqual(arr1:Array, arr2:Array):Boolean
		{
			if(arr1.length != arr2.length)
			{
				return false;
			}
			
			var len:Number = arr1.length;
			
			for(var i:Number = 0; i < len; i++)
			{
				if(arr1[i] !== arr2[i])
				{
					return false;
				}
			}
			
			return true;
		}
		public static function setElementIndex(element:*, index:int, source:Array):void
		{
			if (index < 0) {
				index += source.length;
			}
			
			if (index < 0 || source.length <= index) {
				throw new RangeError('index');
			}
			
			var oldIndex:int = source.indexOf(element);
			if (oldIndex < 0) {
				throw new ArgumentError('element');
			}
			
			source.splice(oldIndex, 1);
			source.splice(index, 0, element);
		}
		
		public static function swapElements(element1:*, element2:*, source:Array):void
		{
			var index1:int = source.indexOf(element1);
			if (index1 < 0) {
				throw new ArgumentError('element1');
			}
			
			var index2:int = source.indexOf(element2);
			if (index2 < 0) {
				throw new ArgumentError('element2');
			}
			
			source[index1] = element2;
			source[index2] = element1;
		}
		
		public static function swapElementsAt(index1:int, index2:int, source:Array):void
		{
			if (index1 < 0) {
				index1 += source.length;
			}
			if (index1 < 0 || source.length <= index1) {
				throw new RangeError('index1');
			}
			
			if (index2 < 0) {
				index2 += source.length;
			}
			if (index2 < 0 || source.length <= index2) {
				throw new RangeError('index2');
			}
			
			var temp:* = source[index1];
			source[index1] = source[index2];
			source[index2] = temp;
		}
		
		public static function identicalArray( param:* , len:uint ):Array
		{
			var a:Array = [];
			for(var i:uint=0;i<len;i++) a.push(param);
			return a;
		}
		
		public static function numericArray(len:int, firstValue:Number=0, step:Number=1.0 ):Array
		{
			var a:Array = new Array(len);
			return a.map(function(v:Number, i:int, a:Array):Number { return firstValue+i*step; });
		}  
		
		public static function instanceOfEquals( array:Array, theClass:Class=null ):Boolean
		{
			var n:uint = array.length;
			
			if (n == 0) throw new ArgumentError("????????????????????");
			
			theClass = theClass || array[0].constructor;
			
			for (var i:int = 0; i < n; i++ )
				if ( !(array[i] is theClass) ) return false;
			return true;
		} 
		
		public static function addNumber( numericArray:Array, value:Number ):Array
		{
			return numericArray.map(function(v:Number, i:int, a:Array):Number { return v + value; } );
		} 
		
		public static function subtractNumber( numericArray:Array, value:Number ):Array
		{
			return numericArray.map(function(v:Number, i:int, a:Array):Number { return v - value; } );
		}
		
		public static function multipleNumber( numericArray:Array, value:Number ):Array
		{
			return numericArray.map(function(v:Number, i:int, a:Array):Number { return v * value; } );
		}
		
		public static function divideNumber( numericArray:Array, value:Number ):Array
		{
			return numericArray.map(function(v:Number, i:int, a:Array):Number { return v / value; } );
		}
		
		public static function shuffle( array:Array ):Array
		{
			var c:Array = array.concat();
			var n:int, i:int = c.length - 1, t:*;
			for( ; i; --i ){
				n = Math.random() * i >> 0;
				t = c[i];
				c[i] = c[n];
				c[n] = t;
			}
			return c;
		} 
		
		public static function matches(array:Array, compareTarget:Array):Array
		{
			var len1:uint = array.length;
			var len2:uint = compareTarget.length;
			var res:Array = [];
			for (var i:int = 0; i < len1; i++ ) {
				for (var j:int = 0; j < len2; j++ ) {
					if( array[i] == compareTarget[j] ) {
						res.push( array[i] );
						break;
					}
				}
			}
			return res;
		}
		
	}
}