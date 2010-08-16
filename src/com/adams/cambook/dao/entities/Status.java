package com.adams.cambook.dao.entities;

import java.io.Serializable;

public class Status implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int statusID;
	private String type;
	private String statusLabel;
	public int getStatusID() {
		return statusID;
	}
	public void setStatusID(int statusID) {
		this.statusID = statusID;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatusLabel() {
		return statusLabel;
	}
	public void setStatusLabel(String statusLabel) {
		this.statusLabel = statusLabel;
	}

}
