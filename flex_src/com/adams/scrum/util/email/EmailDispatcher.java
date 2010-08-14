package com.adams.scrum.util.email;

import java.util.Date;
import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.URLName;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.adams.scrum.util.BuildConfig;
import com.sun.mail.smtp.SMTPAddressFailedException;
import com.sun.mail.smtp.SMTPAddressSucceededException;
import com.sun.mail.smtp.SMTPSendFailedException;
import com.sun.mail.smtp.SMTPTransport;

public class EmailDispatcher {

	String cc = null, bcc = null, url = null;
	String file = null;
	//String protocol = null, host = null;
	String record = null;	// name of folder in which to record mail
	boolean debug = false;
	boolean verbose = false;
	String port = "smtp";
	private Session session = null;
	private Properties props = null;
	private SMTPTransport t = null;
	private String errorDetails = null;
	
	public String getErrorDetails() {
		return errorDetails;
	}

	public void setErrorDetails(String errorDetails) {
		this.errorDetails = errorDetails;
	}

	public EmailDispatcher() {
		
	}

	public void openTransport() {
		try {
			props = System.getProperties();
			// Get a Session object		
			session = Session.getInstance(props, null);
			if (debug)
				session.setDebug(true);
			if (BuildConfig.mailHost != null)
				props.put("mail." + port + ".host", BuildConfig.mailHost );
			if (BuildConfig.mailAuth)
				props.put("mail." + port + ".auth", "true");
			
			t = (SMTPTransport)session.getTransport(port);
			if (BuildConfig.mailAuth) {
				t.connect(BuildConfig.mailHost , BuildConfig.mailUser, BuildConfig.mailPassword);
			} else {
				t.connect();
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	public void closeTransport() {
		try {
			t.close();
			session = null;
			props = null;
		} catch (MessagingException e) {
			e.printStackTrace();
		}		
	}
	
    public boolean dispatch(com.adams.scrum.util.email.Message message) {
    	Message msg = null;
    	boolean dispatchSuccess = true;
    	try {
			msg = buildMessage(session, message);
    		try {
    			t.sendMessage(msg, msg.getAllRecipients());
    		} finally {
    			if (verbose) {
    				System.out.println("Response: " + t.getLastServerResponse());
    			}
    		}
    		System.out.println("\nMail was sent successfully.");
    		//saveACopy(url, protocol, host, user, password, record, session, msg);
    		//TODO make a note in DB
		} catch (Exception e) {
		    /*
		     * Handle SMTP-specific exceptions.
		     */
		    handleFailedException(e);
		    dispatchSuccess = false;
		}
		return dispatchSuccess;
    }

	private Message buildMessage(Session session, com.adams.scrum.util.email.Message message) throws MessagingException, AddressException {
		Message msg = new MimeMessage(session);
		if (BuildConfig.mailFrom != null)
			msg.setFrom(new InternetAddress(BuildConfig.mailFrom));
		else
			msg.setFrom();

		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(message.getTo(), false));
		if (message.getCc()!= null)
			msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(message.getCc(), false));
		if (message.getBcc()!= null)
			msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(message.getBcc(), false));

		msg.setSubject(message.getSubject());
		msg.setText(message.getText());
		msg.setHeader("Content-Type", "text/html");
		msg.setSentDate(new Date());
		return msg;
	}

	private void handleFailedException(Exception e) {
		String errorDetails = "";
		if (e instanceof SendFailedException) {
			MessagingException sfe = (MessagingException)e;
			if (sfe instanceof SMTPSendFailedException) {
			    SMTPSendFailedException ssfe = (SMTPSendFailedException)sfe;
			    errorDetails += "SMTP SEND FAILED:";
			    if (verbose)
			    	errorDetails += "\n"+ ssfe.toString();
			    errorDetails += "\n  Command: " + ssfe.getCommand();
			    errorDetails += "\n  RetCode: " + ssfe.getReturnCode();
			    errorDetails += "\n  Response: " + ssfe.getMessage();
			} else {
			    if (verbose)
			    	errorDetails += "\nSend failed: " + sfe.toString();
			}
			Exception ne;
			while ((ne = sfe.getNextException()) != null && ne instanceof MessagingException) {
			    sfe = (MessagingException)ne;
			    if (sfe instanceof SMTPAddressFailedException) {
			    	SMTPAddressFailedException ssfe = (SMTPAddressFailedException)sfe;
			    	errorDetails += "\nADDRESS FAILED:";
			    	if (verbose)
			    		errorDetails += "\n"+ssfe.toString();
			    	errorDetails += "\n  Address: " + ssfe.getAddress();
			    	errorDetails += "\n  Command: " + ssfe.getCommand();
			    	errorDetails += "\n  RetCode: " + ssfe.getReturnCode();
			    	errorDetails += "\n  Response: " + ssfe.getMessage();
			    } else if (sfe instanceof SMTPAddressSucceededException) {
			    	errorDetails += "\nADDRESS SUCCEEDED:";
			    	SMTPAddressSucceededException ssfe = (SMTPAddressSucceededException)sfe;
			    	if (verbose)
			    		errorDetails += "\n"+ssfe.toString();
			    	errorDetails += "\n  Address: " + ssfe.getAddress();
			    	errorDetails += "\n  Command: " + ssfe.getCommand();
			    	errorDetails += "\n  RetCode: " + ssfe.getReturnCode();
			    	errorDetails += "\n  Response: " + ssfe.getMessage();
			    }
			}
		} else {
			System.out.println("Got Exception: " + e);
			if (verbose) {
			    e.printStackTrace();
			    errorDetails = e.getMessage();
			}
		}
		this.errorDetails = errorDetails;
	}

	private static void saveACopy(String url, String protocol, String host,
			String user, String password, String record, Session session,
			Message msg) throws NoSuchProviderException, MessagingException {
		/*
	     * Save a copy of the message, if requested.
	     */
	    if (record != null) {
			// Get a Store object
			Store store = null;
			if (url != null) {
			    URLName urln = new URLName(url);
			    store = session.getStore(urln);
			    store.connect();
			} else {
			    if (protocol != null)		
				store = session.getStore(protocol);
			    else
				store = session.getStore();
	
			    // Connect
			    if (host != null || user != null || password != null)
				store.connect(host, user, password);
			    else
				store.connect();
			}

			// Get record Folder.  Create if it does not exist.
			Folder folder = store.getFolder(record);
			if (folder == null) {
			    System.err.println("Can't get record folder.");
			    System.exit(1);
			}
			if (!folder.exists())
			    folder.create(Folder.HOLDS_MESSAGES);
	
			Message[] msgs = new Message[1];
			msgs[0] = msg;
			folder.appendMessages(msgs);
	
			System.out.println("Mail was recorded successfully.");
	    }
	}

}
