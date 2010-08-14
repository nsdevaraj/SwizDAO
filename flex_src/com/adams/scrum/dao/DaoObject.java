package com.adams.scrum.dao;

import java.util.Map;



public class DaoObject {
	Map<String,DTInterface> map;
	DaoObject(Map<String,DTInterface> map){
		 this.map=map;
	}

	public DTInterface getObject(String objectName){
		 return map.get(objectName);
	 }
}
