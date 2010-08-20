package com.adams.cambook.dao.entities;

import java.io.Serializable;
import java.util.Date;

public class FileDetails implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public int getFileID() {
		return fileID;
	}
	public void setFileID(int fileID) {
		this.fileID = fileID;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public Date getFiledate() {
		return filedate;
	}
	public void setFiledate(Date filedate) {
		this.filedate = filedate;
	}
	public int getPersonFK() {
		return personFK;
	}
	public void setPersonFK(int personFK) {
		this.personFK = personFK;
	}
	private int fileID;
	private String filename;
	private String filepath;
	private Date filedate;
	private int personFK;
}
