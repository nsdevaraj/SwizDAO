package com.adams.cambook.dao.hibernate.finder;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Iterator;
 
public interface FinderExecutor<T>
{
    /**
     * Execute a finder method with the appropriate arguments
     */
    List<T> executeFinder(Method method, Object[] queryArgs);

    Iterator<T> iterateFinder(Method method, Object[] queryArgs);

}
