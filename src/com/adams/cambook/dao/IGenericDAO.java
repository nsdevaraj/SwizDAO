package com.adams.cambook.dao;

import java.io.Serializable;
import java.util.List;

public interface IGenericDAO<T, PK extends Serializable>{
    T create(T newInstance)throws BaseAppException;
    T read(PK id);
    T update(T transientObject);
    T directUpdate(T transientObject);
    List<?> bulkUpdate(List<?> objList);
    List<?> getList();
    Long count();
    void deleteAll();
    void deleteById(T persistentObject) throws BaseAppException;
}
