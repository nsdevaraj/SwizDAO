package com.adams.cambook.dao.hibernate.finder.impl;

import java.lang.reflect.Method;

import com.adams.cambook.dao.hibernate.finder.FinderNamingStrategy;



public class ExtendedFinderNamingStrategy implements FinderNamingStrategy
{
    // Always look for queries that start with findBy (even if method is iterateBy.. or scrollBy...)
    public String queryNameFromMethod(Class findTargetType, Method finderMethod)
    {
        String methodName = finderMethod.getName();
        String methodPart = methodName;
        if(methodName.startsWith("findBy")) {
            // No-op
        }
        else if(methodName.startsWith("listBy")) {
            methodPart = "findBy" + methodName.substring("listBy".length());
        }
        else if(methodName.startsWith("iterateBy")) {
            methodPart = "findBy" + methodName.substring("iterateBy".length());
        }
        else if(methodName.startsWith("scrollBy")) {
            methodPart = "findBy" + methodName.substring("scrollBy".length());
        }
        return findTargetType.getSimpleName() + "." + methodPart;
    }
}
