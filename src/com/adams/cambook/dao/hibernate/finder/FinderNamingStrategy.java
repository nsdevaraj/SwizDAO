package com.adams.cambook.dao.hibernate.finder;

import java.lang.reflect.Method;

/**
 * Used to locate a named query based on the called finder method
 */
public interface FinderNamingStrategy
{
    public String queryNameFromMethod(Class findTargetType, Method finderMethod);
}
