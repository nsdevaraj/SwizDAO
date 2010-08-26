package com.adams.cambook.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.TransformerConfigurationException;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.xml.sax.SAXException;

import com.adams.cambook.dao.entities.Persons;
import com.adams.cambook.dao.hibernate.CambookPageDAO;
import com.adams.cambook.util.EncryptUtil;

/**
 * Receives the HTTP upload request from Flex and generates valid XML.
 */
public class UploadHandler extends HttpServlet {
    private static final String CONTENT_TYPE = "text/xml; charset=utf-8";
    private CambookPageDAO dao = null;
    private EncryptUtil encryptUtil = null;
    /**
     * Initialize of the servlet handler.
     * 
     * @param config
     * @throws ServletException
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        System.out.println("servlet upload handler inititalized");
        ServletContext context = getServletContext();
		WebApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(context);
		dao = (CambookPageDAO) applicationContext.getBean("pagingDAO");
    }
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException { 
		System.out.println("UploadHandler called.");
		System.out.println("***************************");
		encryptUtil = new EncryptUtil();
		String enUsername = request.getParameter("eun")!=null?request.getParameter("eun"):"";
		String enPassword = request.getParameter("eps")!=null?request.getParameter("eps"):"";
		
		System.out.println("UploadHandler enUsername:"+enUsername);
		System.out.println("UploadHandler enUsername:"+enPassword);
		int userId = 0;
		try {
			userId = getUserId(encryptUtil.getDecryptedString(enUsername), encryptUtil.getDecryptedString(enPassword));
			System.out.println("User Id:"+userId);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}

    
    /**
     * @param request
     * @param response
     * @throws ServletException
     */
    public void doPost(HttpServletRequest request, 
                       HttpServletResponse response) throws ServletException {
    	System.out.println("UploadHandler doPost Called...");
        response.setContentType(CONTENT_TYPE); // Set the servlet's response type to text/XML.
        PrintWriter out = null;
        
        encryptUtil = new EncryptUtil();
        
        File disk = null;
        FileItem item = null;
        DiskFileItemFactory factory = new DiskFileItemFactory(); // We use the FileUpload package provided by Apache to process the request.
        String statusMessage = "";
        String fileName = "";
        String filePath = "";
        String encrptUsername = "";
        String encrptPassword = "";
        int userId = 0;
        
        ListIterator iterator = null;
        List items = null;
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            out = response.getWriter();
            items = upload.parseRequest(request);
            iterator = items.listIterator();
            
            while( iterator.hasNext() ) // Loop over the items in the request.
            {
              item = (FileItem) iterator.next();

              // If the current item is an HTML form field...
              if( item.isFormField() )
              {
            	  if (item.getFieldName().equalsIgnoreCase("userEncrptName")){
            		  encrptUsername = item.getString();   // Get the userEncrptName value and store it.
            		  System.out.println("UploadHandler doPost Called...encrptUsername :"+encrptUsername);
                  }
            	  else if (item.getFieldName().equalsIgnoreCase("passEncrptName")){
            		  encrptPassword = item.getString();   // Get the passEncrptName value and store it.
            		  System.out.println("UploadHandler doPost Called...encrptPassword :"+encrptPassword);
            	  }
            	  else if (item.getFieldName().equalsIgnoreCase("fileName")){
                	fileName = item.getString();   // Get the fileName value and store it.
                	 System.out.println("UploadHandler doPost Called...fileName :"+fileName);
                } else if (item.getFieldName().equalsIgnoreCase("filePath")){
                	filePath = item.getString();   // Get the filePath value and store it.
                	System.out.println("UploadHandler doPost Called...filePath :"+filePath);
                }
            	  
            	try { 
          			userId = getUserId(encryptUtil.getDecryptedString(URLDecoder.decode(encrptUsername, "UTF8")), encryptUtil.getDecryptedString(URLDecoder.decode(encrptPassword, "UTF8")));
          			System.out.println("User Id:"+userId);
          		} catch (Exception e1) {
          			e1.printStackTrace();
          		}
              } else {  // If the item is a file...
                    // Use an ImageInputStream to stream the file. 
            	  	if(userId!=0){
	                    InputStream fileInputStream = item.getInputStream();
	                	
	                	System.out.println("File written path:"+filePath + File.separator + fileName);
	                	disk = new File(filePath + File.separator + fileName); // Instantiate a File object for the file to be written.
	                	File dir = new File(disk.getParent());
	         	       	if(dir.exists()==false) 
	         	    	   dir.mkdirs();
	         	        
	                	
	                    System.out.println("AbsolutePath:"+new File(filePath).getAbsolutePath());
	                    item.write(disk); // Write the uploaded file to disk.
	                    
	                    // Get a Calendar object and fetch the current time from it.                    
	                    Calendar calendar = Calendar.getInstance();
	                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM.dd.yy hh:mm:ss aaa");
	                    statusMessage = "File successfully written to server at " + simpleDateFormat.format(calendar.getTime());
	                   
	                    // If you're processing multiple files, you'd place  these lines outside of the loop.
	                    fileInputStream.close();
            	  	}
              }
            }
            if(userId!=0){
            	out.print("success");
            }
            else{
            	out.print("Authendication Failed");
            }
            out.close();      
            // Close the output.
        }
        catch (TransformerConfigurationException tcException) {
        	System.out.println(tcException.getMessage());
            //tcException.printStackTrace();
        	statusMessage = "Failure";
        }
        catch (FileUploadException fileUploadException) {
        	System.out.println(fileUploadException.getMessage());
        	if(fileUploadException.getMessage().toLowerCase().contains("stream ended unexpectedly")) {
        		statusMessage = "Failure: File Upload is Cancelled.";
        	}
            //fileUploadException.printStackTrace();
        }
        catch (IOException ioException) {
        	System.out.println(ioException.getMessage());
        	statusMessage = "Failure";
            //ioException.printStackTrace();
        }
        catch (SAXException saxException) {
        	System.out.println(saxException.getMessage());
        	statusMessage = "Failure";
            //saxException.printStackTrace();
        }
        catch (NullPointerException exception) {
            System.out.println(exception.getMessage());
            statusMessage = "Failure";
            //exception.printStackTrace();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            statusMessage = "Failure";
            e.printStackTrace();
        }
        System.out.println("statusMessage:"+statusMessage);
    }
    private int getUserId(String username, String password) {
		int userId = 0;
		List<?> userList;
		try {
			System.out.println("UploadHandler Username:"+username);
			System.out.println("UploadHandler Password:"+password);
			userList = dao.paginationListViewStr("Persons.findByName", username, 0, 1);
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
}
