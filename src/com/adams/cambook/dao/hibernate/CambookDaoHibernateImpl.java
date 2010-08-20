package com.adams.cambook.dao.hibernate;

import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.type.Type;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.adams.cambook.dao.IGenericDAO;
import com.adams.cambook.dao.entities.Persons;
import com.adams.cambook.dao.hibernate.finder.FinderArgumentTypeFactory;
import com.adams.cambook.dao.hibernate.finder.FinderExecutor;
import com.adams.cambook.dao.hibernate.finder.FinderNamingStrategy;
import com.adams.cambook.dao.hibernate.finder.impl.SimpleFinderArgumentTypeFactory;
import com.adams.cambook.dao.hibernate.finder.impl.SimpleFinderNamingStrategy;


public class CambookDaoHibernateImpl<T, PK extends Serializable> extends HibernateDaoSupport implements
		IGenericDAO<T, PK>, FinderExecutor  {
	private SessionFactory sessionFactory;
	private FinderNamingStrategy namingStrategy = new SimpleFinderNamingStrategy(); // Default. Can override in config
	private FinderArgumentTypeFactory argumentTypeFactory = new SimpleFinderArgumentTypeFactory(); // Default. Can override in config
	HibernateTemplate hibernateTemplate;
	private Class<T> type;
	private String cacheKeyValue;
	

	public String getCacheKeyValue() {
		return cacheKeyValue;
	}

	public CambookDaoHibernateImpl(Class<T> type) {
		this.type = type;
		this.cacheKeyValue=type.getName();
	}

	public T create(T o)  {
 		 try {
 			 getSession().save(o);
		} catch (HibernateException e) {
			e.printStackTrace();
			System.out.print("");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print("");
		} finally {
			return (T) o;
 		}
	}

	public T read(PK id) {
  		return (T) getSession().get(type, id);
	}

	public T readWithRefresh(PK id,T o){
		getSession().refresh(o);
		return (T) getSession().get(type, id);
	}
	
	public List<?> bulkUpdate(List<?> objList){		
		getHibernateTemplate().saveOrUpdateAll(objList);
		return objList;
	}
	
	public List<?> getList() {
		List list = null;
		try {
			list = (getHibernateTemplate().find("from " + type.getName() + " x"));
		} catch (HibernateException sqle) {
			sqle.printStackTrace();			
		}
		return list;
    }
	
	public void deleteAll() {
        getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException {
                String hqlDelete = "delete " + type.getName();
                int deletedEntities = session.createQuery(hqlDelete).executeUpdate();
                return null;
            }
        });
    }
	
	public Long count() {
        List list = getHibernateTemplate().find(
                "select count(*) from " + type.getName() + " x");
        Long count = (Long) list.get(0);
        return count;
    }
	
	public T update(T o) {	
		try {
			getSession().merge(o);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("");
		}
		return (T) o;
	}
 
	
	public T directUpdate(T o) {	
		try { 
			getSession().update(o);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("");
		}
		return (T) o;
	}


	public void deleteById(T o) {
		getSession().delete(o);
	}

	public List<T> executeFinder(Method method, final Object[] queryArgs) {
		final Query namedQuery = prepareQuery(method, queryArgs);
		//System.out.print(((Persons) namedQuery.list().get(0)).getPersonAvailability() + "sdfa");
		return (List<T>) namedQuery.list();
	}

	public Iterator<T> iterateFinder(Method method, final Object[] queryArgs) {
		final Query namedQuery = prepareQuery(method, queryArgs);
		return (Iterator<T>) namedQuery.iterate();
	} 

	private Query prepareQuery(Method method, Object[] queryArgs) {
		final String queryName = getNamingStrategy().queryNameFromMethod(type,
				method);
		final Query namedQuery = getSession().getNamedQuery(queryName);
		String[] namedParameters = namedQuery.getNamedParameters();
		if (namedParameters.length == 0) {
			setPositionalParams(queryArgs, namedQuery);
		} else {
			setNamedParams(namedParameters, queryArgs, namedQuery);
		}
		return namedQuery;
	}

	private void setPositionalParams(Object[] queryArgs, Query namedQuery) {
		// Set parameter. Use custom Hibernate Type if necessary
		if (queryArgs != null) {
			for (int i = 0; i < queryArgs.length; i++) {
				Object arg = queryArgs[i];
				Type argType = getArgumentTypeFactory().getArgumentType(arg);
				if (argType != null) {
					namedQuery.setParameter(i, arg, argType);
				} else {
					namedQuery.setParameter(i, arg);
				}
			}
		}
	}

	
	private void setNamedParams(String[] namedParameters, Object[] queryArgs,
			Query namedQuery) {
		// Set parameter. Use custom Hibernate Type if necessary
		if (queryArgs != null) {
			for (int i = 0; i < queryArgs.length; i++) {
				Object arg = queryArgs[i];
				Type argType = getArgumentTypeFactory().getArgumentType(arg);
				if (argType != null) {
					namedQuery.setParameter(namedParameters[i], arg, argType);
				} else {
					if (arg instanceof Collection) {
						namedQuery.setParameterList(namedParameters[i],
								(Collection) arg);
					} else {
						namedQuery.setParameter(namedParameters[i], arg);
					}
				}
			}
		}
	}
 

	public FinderNamingStrategy getNamingStrategy() {
		return namingStrategy;
	}

	public void setNamingStrategy(FinderNamingStrategy namingStrategy) {
		this.namingStrategy = namingStrategy;
	}

	public FinderArgumentTypeFactory getArgumentTypeFactory() {
		return argumentTypeFactory;
	}

	public void setArgumentTypeFactory(
			FinderArgumentTypeFactory argumentTypeFactory) {
		this.argumentTypeFactory = argumentTypeFactory;
	}
}
