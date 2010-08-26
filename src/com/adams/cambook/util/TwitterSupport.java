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
import twitter4j.User;

public class TwitterSupport {

	private String twitterId = null;
	private String twitterPassword = null;
	private int personId;
	public TwitterSupport(String twitterId, String twitterPassword, int personId) {
		this.twitterId = twitterId;
		this.twitterPassword = twitterPassword;
		this.personId = personId;
	}

	public String updateNewTweet(String message) {
		String returnMsg = "Success";
		try {
			Twitter tw = new TwitterFactory().getInstance(twitterId, twitterPassword);
			tw.updateStatus(message);
		} catch (TwitterException e) {
			if(e.getStatusCode()==304) {
				returnMsg = "Not Modified: There was no new data to return.";
			} else if(e.getStatusCode()==400) {
				returnMsg = "Bad Request: The request was invalid. An accompanying error message will explain why. This is the status code will be returned during rate limiting.";
			} else if(e.getStatusCode()==401) {
				returnMsg = "Invalid Credentials!";
			} else if(e.getStatusCode()==403) {
				returnMsg = "Forbidden. User authenticated properly but is not in a required role for this resource; contact the API team for appropriate access.";
			} else if(e.getStatusCode()==404) {
				returnMsg = "Unknown. There is nothing at this URL, which means the resource does not exist.";
			} else if(e.getStatusCode()==406) {
				returnMsg = "Not Acceptable. One or more of the parameters are not suitable for the resource. The track parameter, for example, would throw this error if:\n"+
						    "* The track keyword is too long or too short.\n"+
						    "* The bounding box specified is invalid.\n"+
						    "* No predicates defined for filtered resource, for example, neither track nor follow parameter defined.\n"+
						    "* Follow userid cannot be read.";
			} else if(e.getStatusCode()==413) {
				returnMsg = "Too Long. A parameter list is too long. The track parameter, for example, would throw this error if:\n"+
			    "* Too many track tokens specified for role; contact API team for increased access.\n"+
			    "* Too many bounding boxes specified for role; contact API team for increased access.\n"+
			    "* Too many follow userids specified for role; contact API team for increased access.";
			} else if(e.getStatusCode()==416) {
				returnMsg = "Range Unacceptable. Possible reasons are:\n"+
			    "* Count parameter is not allowed in role.\n"+
			    "* Count parameter value is too large.";
			} else if(e.getStatusCode()==420) {
				returnMsg = "Enhance Your Calm: Returned by the Search and Trends API when you are being rate limited.";
			} else if(e.getStatusCode()==500) {
				returnMsg = "Server Internal Error. You shouldn't see this error. If you do contact API team.";
			} else if(e.getStatusCode()==502) {
				returnMsg = "Bad Gateway: Twitter is down or being upgraded.";
			} else if(e.getStatusCode()==503) {
				returnMsg = "Service Overloaded. You shouldn't see this error on the streaming API. If you do contact API team.";
			} else {
				returnMsg = "Unknown Error: Seems to be network related problem.";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMsg;
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
	
	public static void main(String args[]) {
		try {
			TwitterSupport tws = new TwitterSupport("harinshankar@gmail.com", "nagahari", 1);
			tws.updateNewTweet("Checking my update from Java");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
