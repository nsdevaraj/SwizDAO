package com.adams.cambook.dao;

import java.util.Date;
import java.util.List;

public interface CambookInterface extends IGenericDAO<Object, Integer>{
	List<?> findByName(String name)throws BaseAppException;
	List<?> findByNames(String name1,String name2)throws BaseAppException;
	List<?> findByCode(String name)throws BaseAppException;
	List<?> findByNameId(String name,int id); 
	List<?> findByIdName(int id,String name); 
	List<?> findById(int subnum);
	List<?> findByNums(int subnum1,int subnum2);
	List<?> findByList()throws BaseAppException;
	List<?> findAll()throws BaseAppException;
	List<?> findByDate(Date date, int id);
	List<?> findByDateBetween(Date startDate, Date endDate)throws BaseAppException;
	List<?> findByDateEnd(Date date, int id);
	List<?> findByDateBetweenEnd(Date startDate, Date endDate)throws BaseAppException;
	List<?> findList();
}
