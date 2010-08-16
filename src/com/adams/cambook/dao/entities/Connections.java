package com.adams.cambook.dao.entities;

import java.io.Serializable;

public class Connections implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int ConnectionId;
    
	private int personFK;
	
	private int connectionFK;
	
	public int getConnectionId() {
		return ConnectionId;
	}
	public void setConnectionId(int connectionId) {
		ConnectionId = connectionId;
	}
	public int getPersonFK() {
		return personFK;
	}
	public void setPersonFK(int personFK) {
		this.personFK = personFK;
	}
	public int getConnectionFK() {
		return connectionFK;
	}
	public void setConnectionFK(int connectionFK) {
		this.connectionFK = connectionFK;
	}
	


}
