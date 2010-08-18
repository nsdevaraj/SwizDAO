package com.adams.cambook.util;  
import java.io.BufferedReader;
import java.io.File; 
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.channels.FileChannel;
 
  
import java.nio.ByteBuffer;   
  
import java.util.ArrayList;  
import java.util.List;   
  
public class FileUtil {  
   	 public void copyDirectory(String from, String to) {
		 File sourceDir = new File(from);
		 File destDir = new File(to);
		 sourceDir.renameTo(destDir); 
	} 
   public String  doUpload(byte[] bytes, String fileName,String filePath) throws Exception  
   {  
	   try{
	       fileName = filePath + File.separator + fileName;
	       System.out.print(fileName);
	       File f = new File(fileName); 
	       File dir = new File(f.getParent());
	       if(dir.exists()==false){
	    	   dir.mkdirs();
	       }
	       FileOutputStream fos = new FileOutputStream(f);  
	       fos.write(bytes);  
	       fos.close();  
	       return "success";  
	   } catch (Exception e){
	       return "failure";  
	   }
   } 
	public List<String> getDownloadList(String path)  
   {  
       File dir = new File(path); 
       String[] children = dir.list();  
       List<String> dirList = new ArrayList<String>();  
       if (children == null) {  
              // Either dir does not exist or is not a directory  
          } else {  
              for (int i=0; i<children.length; i++) {  
                  // Get filename of file or directory  
                  dirList.add( children[i]);  
              }  
          }  
       return dirList;  
   } 
   public String doConvert(String filePath,String executable)  
   {   
	  String output = ""; 
   	  try { 
	   	  String command = executable+" "+filePath;
	      Process proc = Runtime.getRuntime().exec(command);  
	      System.out.println(command); 
	      BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));  
		  String line = null;  
		  while ((line = in.readLine()) != null) {
		   output+=line;
		   System.out.println(line);  
		  }  
	   }  
	   catch (Exception e) {  
	      e.printStackTrace();  
	   } 
	   return output;
   }
   public String createSubDir(String parentfolderName,String folderName)  
   {  
	   try {
		   String path = parentfolderName + File.separator + folderName;  
	       File f = new File(path);
	       if(f.exists()==false){
	    	   f.mkdirs();
	    	   return folderName;
	       }
	    } catch (Exception e){
	   }
	    return folderName;
   }
   public byte[] doDownload(String fileName)  
   {  
       FileInputStream fis;  
       byte[] data =null;  
       FileChannel fc;  
       try {  
           fis = new FileInputStream(fileName);  
           fc = fis.getChannel();  
           data = new byte[(int)(fc.size())];  
           ByteBuffer bb = ByteBuffer.wrap(data);  
           fc.read(bb);  
       } catch (FileNotFoundException e) {  
           // TODO  
       } catch (IOException e) {  
           // TODO  
       }  
       return data;  
   }  
}  