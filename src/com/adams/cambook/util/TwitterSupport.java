package com.adams.cambook.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.adams.cambook.dao.entities.Notes;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;

public class TwitterSupport {

	private String twitterId = null;
	private String twitterPassword = null;
	private int personId;
	public TwitterSupport(String twitterId, String twitterPassword, int personId) {
		this.twitterId = twitterId;
		this.twitterPassword = twitterPassword;
		this.personId = personId;
	}

	public void updateNewTweet() {
		
		Twitter tw = new TwitterFactory().getInstance(twitterId, twitterPassword);
		
		try { 
			tw.updateStatus("my First Java Update.");
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List<Notes> getTwitterUpdates() {
		List<Notes> notesSet = new ArrayList<Notes>();
		Twitter tw = new TwitterFactory().getInstance(twitterId, twitterPassword);
		Paging paging = new Paging(1, 5);
		List<Status> statuses;
		try {
			System.out.print("tw:"+tw);
			statuses = tw.getUserTimeline(paging);
		    for (Status status : statuses) {
		    	Notes note = new Notes();
		    	note.setCreatedPersonFK(personId);
		    	note.setCreationDate(status.getCreatedAt());
		    	note.setDescription(status.getText());
		    	note.setNoteType(3);
		    	
		    	notesSet.add(note);
		    	
		        System.out.println(status.getUser().getName() + ":" +
		                           status.getText());
		    }
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return notesSet;
	}
	
}
