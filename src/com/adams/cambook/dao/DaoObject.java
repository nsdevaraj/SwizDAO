package com.adams.cambook.dao;

import java.util.Map;



public class DaoObject {
	Map<String,CambookInterface> map;
	DaoObject(Map<String,CambookInterface> map){
		 this.map=map;
	}

	public CambookInterface getObject(String objectName){
		 return map.get(objectName);
	 }
}
