package com.adams.cambook.dao.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

public class Notes implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int noteId;
	private String description;
	private Date creationDate;
	private int createdPersonFK; 
	private FileDetails FileObj;
	private int noteType;
	private Set<Notes> notesSet;
	private int personFK;
	private int noteFK;
	public int getNoteFK() {
		return noteFK;
	}
	public void setNoteFK(int noteFK) {
		this.noteFK = noteFK;
	}
	public int getPersonFK() {
		return personFK;
	}
	public void setPersonFK(int personFK) {
		this.personFK = personFK;
	}
	private int noteStatusFK;
	 
	public int getNoteId() {
		return noteId;
	}
	public void setNoteId(int noteId) {
		this.noteId = noteId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	
	public int getCreatedPersonFK() {
		return createdPersonFK;
	}
	public void setCreatedPersonFK(int createdPersonFK) {
		this.createdPersonFK = createdPersonFK;
	}
	public FileDetails getFileObj() {
		return FileObj;
	}
	public void setFileObj(FileDetails fileObj) {
		FileObj = fileObj;
	}
	public int getNoteType() {
		return noteType;
	}
	public void setNoteType(int noteType) {
		this.noteType = noteType;
		this.noteFK = noteType;
	} 
	public Set<Notes> getNotesSet() {
		return notesSet;
	}
	public void setNotesSet(Set<Notes> notesSet) {
		this.notesSet = notesSet;
	}
	public int getNoteStatusFK() {
		return noteStatusFK;
	}
	public void setNoteStatusFK(int noteStatusFK) {
		this.noteStatusFK = noteStatusFK;
	}

}
