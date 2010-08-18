package com.adams.cambook.servlets;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.adams.cambook.dao.entities.Notes;
import com.adams.cambook.dao.entities.Persons;
import com.adams.cambook.util.BuildConfig;
import com.adams.cambook.util.EncryptUtil;
import com.sun.syndication.feed.synd.SyndContent;
import com.sun.syndication.feed.synd.SyndContentImpl;
import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndEntryImpl;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.feed.synd.SyndFeedImpl;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.SyndFeedOutput;

/**
 * Servlet implementation class RssFeeds
 */
public class RssFeeds extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SyndFeed feed = null;
	private String feedType = "rss_2.0";
	
	private List  entries = null;
	private static final String CONTENT_TYPE = "application/rss+xml";
	private EncryptUtil encryptUtil = null;
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException { 
		System.out.println("RSSFeeder called.");
		System.out.println("***************************");
		encryptUtil = new EncryptUtil();
		
		String enUsername = request.getParameter("eun")!=null?request.getParameter("eun"):"";
		String enPassword = request.getParameter("eps")!=null?request.getParameter("eps"):"";
		
		System.out.println("enUsername:"+enUsername);
		System.out.println("enUsername:"+enPassword);
		int userId = 0;
		try {
			//userId = getUserId(encryptUtil.getDecryptedString(enUsername), encryptUtil.getDecryptedString(enPassword));
			userId = getUserId(enUsername, enPassword);
			System.out.println("User Id:"+userId);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		feed = new SyndFeedImpl();
		entries = new ArrayList();
		createUpdatesFeed(userId);
		feed.setEntries(entries);
		
		SyndFeedOutput output = new SyndFeedOutput();
		try {
		    response.setContentType(CONTENT_TYPE);
		    PrintWriter out = response.getWriter();
			output.output(feed,out);
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (FeedException e) {
			e.printStackTrace();
		} 
	}

	
	private int getUserId(String username, String password) {
		int userId = 0;
		List<?> userList;
		try {
			userList = BuildConfig.cambookPageDAO.paginationListViewStr("Persons.findByLogin", username, 0, 1);
			if(userList.size()>0) {
				Persons person = (Persons)userList.get(0);
				if(person.getPersonPassword().equals(password)) {
					userId = person.getPersonId();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	private void createUpdatesFeed(int userId) {
		feed.setFeedType(feedType);
		feed.setTitle("Cambook - My Updates");
		feed.setLink("http://"+BuildConfig.serverAddress+":"+BuildConfig.serverPort+"/DTFlex");
		feed.setDescription("Cambook - Updates");
		try {
			if(userId>0)
				getEntries(BuildConfig.cambookPageDAO.paginationListViewId("Notes.findMyUpdates", userId, 0, 100) );
			else 
				assignInvalidUserEntry();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void assignInvalidUserEntry() {
		String descriptionStr;
		SyndEntry entry;
		SyndContent description;
		try {
			entry = new SyndEntryImpl();
			description = new SyndContentImpl();
			descriptionStr = "The URL is not Authenticated. Please verify your URL or contact DTFlex";
			entry.setTitle("Invalid User!");
			entry.setLink("http://"+BuildConfig.serverAddress+":"+BuildConfig.serverPort+"/DTFlex");
			entry.setPublishedDate(Calendar.getInstance().getTime());
			description.setType("text/html");
			description.setValue(descriptionStr);
			entry.setDescription(description);
			entries.add(entry);
		} finally {
			
		}
	}
	
	private void getEntries(List<?> updateslist) {
		System.out.println("Updates List:"+updateslist.size());
		for(Object obj: updateslist) {
			Notes note = (Notes)obj;
			assignUpdatesEntry(note);
		}		
	}

	private void assignUpdatesEntry(Notes note) {
		String descriptionStr;
		SyndEntry entry;
		SyndContent description;
		try {
			entry = new SyndEntryImpl();
			description = new SyndContentImpl();
			descriptionStr = "";
			descriptionStr = note.getDescription();
			
			descriptionStr = descriptionStr.replace("\n", "<br>");
			entry.setTitle("");
			entry.setLink("http://"+BuildConfig.serverAddress+":"+BuildConfig.serverPort+"/cambook");
			entry.setPublishedDate(note.getCreationDate());
			description.setType("text/html");
			if(descriptionStr.trim().equals("")) {
				descriptionStr = "-";
			}
			descriptionStr = "<div style='background-color:#efefef; padding:10px; border:solid 1px #aeaeae;'>"+descriptionStr+"</div>";
			description.setValue(descriptionStr);
			entry.setDescription(description);
			entries.add(entry);
		} finally {
			
		}
	}
	
	private byte[] toByteArray(Blob fromBlob) {
		 ByteArrayOutputStream baos = new ByteArrayOutputStream();
		 try {
			 return toByteArrayImpl(fromBlob, baos);
		 } catch (SQLException e) {
			 throw new RuntimeException(e);
		 } catch (IOException e) {
			 throw new RuntimeException(e);
		 } finally {
			 if (baos != null) {
				 try {
					 baos.close();
				 } catch (IOException ex) {
				 }
		 	}
		 }
	}
	
	private byte[] toByteArrayImpl(Blob fromBlob, ByteArrayOutputStream baos) throws SQLException, IOException {
		  byte[] buf = new byte[4000];
		  InputStream is = fromBlob.getBinaryStream();
		  try {
			  for (;;) {
				  int dataSize = is.read(buf);

				  if (dataSize == -1)
					  break;
				  baos.write(buf, 0, dataSize);
			  }
		  	} finally {
		  		if (is != null) {
		  			try {
		  				is.close();
		  			} catch (IOException ex) {
		  			}
		  		}
		  	}
		  	return baos.toByteArray();
		}
}
