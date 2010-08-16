package com.adams.cambook.dao.entities;

import java.io.Serializable;
import java.util.Set;

public class Persons implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int PersonId;
	
	private String personFirstname;
	private String personLastname;
	private String personEmail;
	private int personRelations;
	private String personPassword;
	private int tweetId;
	private int personAvailability;
	private FileDetails personPhotoFK;
	private String personMobile;
	private String personQuestion;
	private String personPostalCode;
	private String personAnswer;
	private String personCity;
	private String personCountry;
	private boolean activated;
	private Set<Persons> connectionSet;
	public Set<Notes> getNotesSet() {
		return notesSet;
	}
	public void setNotesSet(Set<Notes> notesSet) {
		this.notesSet = notesSet;
	}
	private Set<Notes> notesSet;
	
	public Set<Persons> getConnectionSet() {
		return connectionSet;
	}
	public void setConnectionSet(Set<Persons> connectionSet) {
		this.connectionSet = connectionSet;
	}
	public int getPersonId() {
		return PersonId;
	}
	public void setPersonId(int personId) {
		PersonId = personId;
	}
	public String getPersonFirstname() {
		return personFirstname;
	}
	public void setPersonFirstname(String personFirstname) {
		this.personFirstname = personFirstname;
	}
	public String getPersonLastname() {
		return personLastname;
	}
	public void setPersonLastname(String personLastname) {
		this.personLastname = personLastname;
	}
	public String getPersonEmail() {
		return personEmail;
	}
	public void setPersonEmail(String personEmail) {
		this.personEmail = personEmail;
	}
	public int getPersonRelations() {
		return personRelations;
	}
	public void setPersonRelations(int personRelations) {
		this.personRelations = personRelations;
	}
	public String getPersonPassword() {
		return personPassword;
	}
	public void setPersonPassword(String personPassword) {
		this.personPassword = personPassword;
	}
	public int getTweetId() {
		return tweetId;
	}
	public void setTweetId(int tweetId) {
		this.tweetId = tweetId;
	}
	public int getPersonAvailability() {
		return personAvailability;
	}
	public void setPersonAvailability(int personAvailability) {
		this.personAvailability = personAvailability;
	} 
	
	public FileDetails getPersonPhotoFK() {
		return personPhotoFK;
	}
	public void setPersonPhotoFK(FileDetails personPhotoFK) {
		this.personPhotoFK = personPhotoFK;
	}
	public String getPersonMobile() {
		return personMobile;
	}
	public void setPersonMobile(String personMobile) {
		this.personMobile = personMobile;
	}
	public String getPersonQuestion() {
		return personQuestion;
	}
	public void setPersonQuestion(String personQuestion) {
		this.personQuestion = personQuestion;
	}
	public String getPersonPostalCode() {
		return personPostalCode;
	}
	public void setPersonPostalCode(String personPostalCode) {
		this.personPostalCode = personPostalCode;
	}
	public String getPersonAnswer() {
		return personAnswer;
	}
	public void setPersonAnswer(String personAnswer) {
		this.personAnswer = personAnswer;
	}
	public String getPersonCity() {
		return personCity;
	}
	public void setPersonCity(String personCity) {
		this.personCity = personCity;
	}
	public String getPersonCountry() {
		return personCountry;
	}
	public void setPersonCountry(String personCountry) {
		this.personCountry = personCountry;
	}
	public boolean isActivated() {
		return activated;
	}
	public void setActivated(boolean activated) {
		this.activated = activated;
	}

}
