package com.adams.cambook.util;

import java.io.Serializable;
import java.util.List;

public class Abstract<T, PK extends Serializable>{
	public List<?> newList;
	public Long count;
	public List<?> findByName(String name){return newList;}
	public List<?> findByNames(String name1,String name2){return newList;}
	public List<?> findByCode(String name){return newList;}
	public List<?> findByNameId(String name,int id){return newList;}
	public List<?> findByIdName(int id,String name){return newList;}
	public List<?> findById(int subnum){return newList;}
	public List<?> findByNums(int subnum1,int subnum2){return newList;}
	public List<?> findByList(){return newList;}
	public List<?> findList(){return newList;}
	public List<?> findAll(){return newList;}
	public List<?> create(T newInstance){return newList;}
	public List<?> read(PK id){return newList;}
	public List<?> update(T transientObject){return newList;}
	public List<?> directUpdate(T transientObject){return newList;}
	public List<?> bulkUpdate(List<?> objList){return newList;}
	public List<?> getList(){return newList;}
	public void deleteAll(){}
	public Long count(){return count;}
}