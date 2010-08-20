package com.adams.cambook.servlets;

import java.util.ResourceBundle;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.adams.cambook.dao.hibernate.CambookPageDAO;
import com.adams.cambook.util.BuildConfig;

public class SetDefaults extends HttpServlet{
	public void init() {
		System.out.println("Servlet init called...........");
		ResourceBundle rb = ResourceBundle.getBundle("serverconfig");	    
		BuildConfig.serverAddress = rb.getString("server.address");
		BuildConfig.serverPort = rb.getString("server.port");
		BuildConfig.db = rb.getString("server.db");
		
		BuildConfig.smtpMailFromUser = rb.getString("SenderEmail.username"); 
		BuildConfig.smtpMailFromPass = rb.getString("SenderEmail.password"); 
		BuildConfig.smtpMailHostName = rb.getString("SenderEmail.host"); 
		BuildConfig.smtpMailHostPort = rb.getString("SenderEmail.port"); 
		BuildConfig.smtpMailStarttlsEnable = rb.getString("SenderEmail.starttlsenable").equalsIgnoreCase("true")?true:false;
		BuildConfig.smtpMailIsSSL = rb.getString("SenderEmail.isSSL").equalsIgnoreCase("true")?true:false;
		BuildConfig.smtpMailAuth = rb.getString("SenderEmail.auth").equalsIgnoreCase("true")?true:false;
		BuildConfig.smtpMailDebugging = rb.getString("SenderEmail.debugging").equalsIgnoreCase("true")?true:false;
		BuildConfig.smtpMailMailLabel = rb.getString("SenderEmail.mailLabel"); 
		
		getDTPageDAO();
		getApplicationContext();
	}	
	
	private void getDTPageDAO() {
		ServletContext context = getServletContext();
		WebApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(context);
		CambookPageDAO dao = (CambookPageDAO) applicationContext.getBean("pagingDAO");
		
		BuildConfig.cambookPageDAO = dao;
	}
	
	private void getApplicationContext() {
		ServletContext context = getServletContext();
		BuildConfig.applicationContext = context.getInitParameter("webAppRootKey");
	}
}
