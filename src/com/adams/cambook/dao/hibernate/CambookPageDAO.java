package com.adams.cambook.dao.hibernate;
 
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.adams.cambook.dao.entities.Notes;
import com.adams.cambook.dao.entities.Persons;
import com.adams.cambook.util.MailUtil;
import com.adams.cambook.util.TwitterSupport;

public class CambookPageDAO extends HibernateDaoSupport {

	public List<?> getQueryResult(String query) throws Exception {
		Query q = getSession().createSQLQuery(query);
		if (q == null)
			throw new Exception("Order id is null.");

		return q.list();
	}
	
	public List<?> getList(Class type) {
		List list = null;
		try {
			list = (getHibernateTemplate().find("from " + type.getName() + " x"));
		} catch (HibernateException sqle) {
			sqle.printStackTrace();			
		}
		return list;
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
	
	private List<?> bulkUpdate(List<?> objList){		
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
	
	public List<?> paginationListViewStrStrDtDt(String strQuery, String instiName, String status, Date startDate, Date endDate, Integer startPoint, Integer endPoint) throws Exception {
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
	
	public void refreshTweets(int userId) {
		Query query = null;
		TwitterSupport tw;
		List<Notes> notesSet; 
		try {
			
			query = getSession().createQuery("select u.personId, u.tweetId, u.tweetPassword from Persons u where u.personId=?");
			query.setParameter(0, userId);
			List value = query.list();
			
			if(null!=value) {
				Object[] vals = (Object[])value.get(0);
				int personId = (Integer)vals[0];
				tw = new TwitterSupport((String)vals[1],(String)vals[2], personId);
				notesSet = tw.getTwitterUpdates();
				
				query = getSession().createQuery("delete from Notes u where u.noteType=3 and createdPersonFK=?");
				query.setParameter(0, personId);
				query.executeUpdate();
				bulkUpdate(notesSet);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void SmtpSSLMail(String msgTo, String msgSubject, String msgBody) throws Exception {
		try {
			MailUtil mailutil = new MailUtil();
			mailutil.setCambookPageDAO( this ); 
			mailutil.SmtpSSLMail(msgTo, msgSubject, msgBody);
			
		} catch (Exception e) {
			throw new Exception("SMTP exception.");
		}		
	}
	
	public String updateTweet(String message, int userId) {
		String returnMsg = null;
		TwitterSupport tw;
		Query query = null;
		System.out.print(message);
		try {
			query = getSession().createQuery("select u.personId, u.tweetId, u.tweetPassword from Persons u where u.personId=?");
			query.setParameter(0, userId);
			List value = query.list();
			
			if(null!=value) {
				Object[] vals = (Object[])value.get(0);
				int personId = (Integer)vals[0];
				tw = new TwitterSupport((String)vals[1],(String)vals[2], personId);
				returnMsg = tw.updateNewTweet(message);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMsg;
	}
}