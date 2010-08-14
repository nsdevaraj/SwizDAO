package com.adams.scrum.dao.hibernate;
 
import java.util.Date;
import java.util.List;
 
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class DTPageDAO extends HibernateDaoSupport {

	public List<?> getQueryResult(String query) throws Exception {
		Query q = getSession().createSQLQuery(query);
		if (q == null)
			throw new Exception("Order id is null.");

		return q.list();
	} 	
	
	public Object save(Object o)  {
		 try {
			getHibernateTemplate().save(o);
		} catch (HibernateException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return o;
	}
	
	public List<?> bulkUpdate(List<?> objList){		
		getHibernateTemplate().saveOrUpdateAll(objList);
		return objList;
	}
	
	public List<?> paginationListView(String strQuery, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}
	public List<?> queryListView(String strQuery) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery); 
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}
	public List<?> paginationListViewId(String strQuery, Integer prgId, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
 			System.out.println(strQuery);
			query = getSession().getNamedQuery(strQuery);
		
			query.setInteger(0, prgId);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		
			return query.list();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("SQL server db exception.");
		}
	}
	
	public List<?> paginationListViewIdId(String strQuery, Integer prgId1, Integer prgId2, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery);
			query.setInteger(0, prgId1);
			query.setInteger(1, prgId2);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}

	public List<?> paginationListViewIdIdId(String strQuery, Integer prgId1, Integer prgId2, Integer prgId3, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery);
			query.setInteger(0, prgId1);
			query.setInteger(1, prgId2);
			query.setInteger(2, prgId3);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}

	public List<?> paginationListViewIdStr(String strQuery, Integer prgId, String tempFieldValue, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery);
			query.setInteger(0, prgId);
			query.setString(1, tempFieldValue);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}
	
	public List<?> paginationListViewIdDtDt(String strQuery, Integer prgId, Date startDate, Date endDate, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery);
			query.setInteger(0, prgId);
			query.setDate(1, startDate);
			query.setDate(2, endDate);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}
		
	public List<?> paginationListViewStr(String strQuery, String userName, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery);
			query.setString(0, userName);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}
	
	public List<?> paginationListViewStrStr(String strQuery, String userName1, String userName2, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery);
			query.setString(0, userName1);
			query.setString(1, userName2);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}
	
	public List paginationListViewStrStrDtDt(String strQuery, String instiName, String status, Date startDate, Date endDate, Integer startPoint, Integer endPoint) throws Exception {
		Query query = null;
		try {
			query = getSession().getNamedQuery(strQuery);
			query.setString(0, instiName);
			query.setString(1, status);
			query.setDate(2, startDate);
			query.setDate(3, endDate);
			query.setFirstResult(startPoint);
			query.setMaxResults(endPoint);
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}
	 	
	public void deleteByForeignKey(String strQuery) throws Exception {
		
		try {
			Query query =	getSession().createSQLQuery(strQuery);
			query.executeUpdate();
			
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
	}
	
	public List<?> queryPagination(String strQuery, Integer startPoint, Integer endPoint) throws Exception {
		Query query =null;
		try {
			 query =getSession().createQuery(strQuery);
			 query.setFirstResult(startPoint);
			 query.setMaxResults(endPoint);
			
		} catch (Exception e) {
			throw new Exception("SQL server db exception.");
		}
		return query.list();
	}
}