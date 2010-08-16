package com.adams.cambook.dao.hibernate.finder.impl;

import org.hibernate.type.Type;

import com.adams.cambook.dao.hibernate.finder.FinderArgumentTypeFactory;

/**
 * Maps Enums to a custom Hibernate user type
 */
public class SimpleFinderArgumentTypeFactory implements FinderArgumentTypeFactory
{
    public Type getArgumentType(Object arg)
    { 
            return null;
    } 
}
