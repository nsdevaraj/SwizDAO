package com.adams.scrum.dao;
import java.util.Date;
import java.util.List;   
public interface DTInterface extends IGenericDAO<Object, Integer>{ 
	List<?> findById(int subnum); 
	List<?> findAll();  
	List<?> findByTaskId(int id); 
	List<?> findByName(String str); 
	List<?> findId(int proId);
}
