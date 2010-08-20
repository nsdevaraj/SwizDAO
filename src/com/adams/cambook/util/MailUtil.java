package com.adams.cambook.util;  

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

import com.adams.cambook.dao.hibernate.CambookPageDAO;
import com.adams.cambook.util.BuildConfig;
import com.sun.mail.smtp.SMTPSendFailedException;

import javax.mail.SendFailedException;


public class MailUtil {  

	private String smtpMailStarttlsEnable = "false";
	private String smtpMailAuth = "false";
	private String smtpMailDebugging = "false";
	
	private String errorDetails = "";
	public MailUtil() {		
		
	}
	private CambookPageDAO cambookPageDAO = null;	
	public CambookPageDAO getCambookPageDAO() {
		return cambookPageDAO;
	}
	public void setCambookPageDAO(CambookPageDAO cambookPageDAO) {
		this.cambookPageDAO = cambookPageDAO;
	}
	
	public void SmtpSSLMail(String msgTo, String msgSubject, String msgBody) {
		
		Properties serverprops = new Properties();
		if(BuildConfig.smtpMailStarttlsEnable)
			smtpMailStarttlsEnable = "true";
		
		if(BuildConfig.smtpMailAuth)
			smtpMailAuth = "true";
		
		if(BuildConfig.smtpMailDebugging)
			smtpMailDebugging = "true";
		
		serverprops.put("mail.smtp.user", BuildConfig.smtpMailFromUser);
		serverprops.put("mail.smtp.host", BuildConfig.smtpMailHostName);
		serverprops.put("mail.smtp.port", BuildConfig.smtpMailHostPort);
		serverprops.put("mail.smtp.auth", smtpMailAuth);
		serverprops.put("mail.smtp.debug", smtpMailDebugging);
		serverprops.put("mail.smtp.socketFactory.port", BuildConfig.smtpMailHostPort);
		serverprops.put("mail.smtp.starttls.enable",smtpMailStarttlsEnable);
		if(BuildConfig.smtpMailIsSSL)
			serverprops.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		serverprops.put("mail.smtp.socketFactory.fallback", "false");
 
        SecurityManager security = System.getSecurityManager();
        
        try
        {
            Authenticator authe = new SMTPAuthenticator();
            Session session = Session.getInstance(serverprops, authe);
            session.setDebug(BuildConfig.smtpMailDebugging);
 
            MimeMessage mimmsg = new MimeMessage(session);
            Address address = new InternetAddress(BuildConfig.smtpMailMailLabel, BuildConfig.smtpMailMailLabel);
            mimmsg.setText(msgBody);
            mimmsg.setSubject(msgSubject);
            mimmsg.setFrom(address);
            mimmsg.addRecipient(Message.RecipientType.TO, new InternetAddress(msgTo));
            mimmsg.setContent(msgBody, "text/html");
            Transport.send(mimmsg);
        } 
        catch (MessagingException mex) {
        	System.out.println("\n--Exception handling--");
        	//mex.printStackTrace();
        	Exception ex = mex;
        	do {
        		if (ex instanceof SendFailedException) {
        			SendFailedException sfex = (SendFailedException)ex;
        			Address[] invalid = sfex.getInvalidAddresses();
        			if (invalid != null) {
        				errorDetails += ("    ** Invalid Addresses");
        				if (invalid != null) {
        					for (int i = 0; i < invalid.length; i++) 
        						errorDetails += "\n"+("         " + invalid[i]);
                        }
                    }
        			Address[] validUnsent = sfex.getValidUnsentAddresses();
        			if (validUnsent != null) {
        				errorDetails += "\n"+("    ** ValidUnsent Addresses");
        				if (validUnsent != null) {
        					for (int i = 0; i < validUnsent.length; i++) 
        						errorDetails += "\n"+("         "+validUnsent[i]);
                        }
        			}
//        			Address[] validSent = sfex.getValidSentAddresses();
//        			if (validSent != null) {
//        				errorDetails += "\n"+("    ** ValidSent Addresses");
//        				if (validSent != null) {
//        					for (int i = 0; i < validSent.length; i++) 
//        						errorDetails += "\n"+("         "+validSent[i]);
//        				}
//                    }
                }
        		if (ex instanceof MessagingException) {
        			if (ex instanceof SMTPSendFailedException) {
        			    SMTPSendFailedException ssfe = (SMTPSendFailedException)ex;
        			    errorDetails += "SMTP SEND FAILED:";
        			    errorDetails += "\n  Command: " + ssfe.getCommand();
        			    errorDetails += "\n  RetCode: " + ssfe.getReturnCode();
        			    errorDetails += "\n  Response: " + ssfe.getMessage();
        			}
        			errorDetails += ex.getMessage();
        			ex = ((MessagingException)ex).getNextException();
        			errorDetails += "\n"+ex.getMessage();
        		} else {
        			ex = null;
        		}
            } 
        	while (ex != null);
        }       
        catch (Exception excep)
        {     
        	//excep.printStackTrace();
        	System.out.print("General Exception: ");
        	errorDetails += excep.getMessage();
        	
        	Integer taskId = 0;
			Integer workflowTemplateFk = 0;
			Integer projectId = 0;
			Integer personId = 0;
			Integer eventType = 59;
        }   
	}	
	
	private class SMTPAuthenticator extends javax.mail.Authenticator
    {
        public PasswordAuthentication getPasswordAuthentication()
        {
            return new PasswordAuthentication(BuildConfig.smtpMailFromUser, BuildConfig.smtpMailFromPass);
        }
    }
}  