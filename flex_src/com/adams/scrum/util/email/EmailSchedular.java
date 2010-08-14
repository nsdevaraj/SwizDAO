package com.adams.scrum.util.email;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import com.adams.scrum.dao.hibernate.DTPageDAO;
import com.adams.scrum.pojo.Events;
import com.adams.scrum.util.BuildConfig;

public final class EmailSchedular extends java.util.TimerTask {
	private String serverLocation = null;
	
	public EmailSchedular() {
		serverLocation = "http://"+BuildConfig.serverAddress+":"+BuildConfig.serverPort+"/DTFlex/";
    	eventsList = new ArrayList<Events>();
	}
	
	private List<Events> eventsList = null;
	
	private DTPageDAO dtPageDao = null;
	
	public DTPageDAO getDtPageDao() {
		return dtPageDao;
	}

	public void setDtPageDao(DTPageDAO dtPageDao) {
		this.dtPageDao = dtPageDao;
	}

	public void run(){
	    //try implementation
	    System.out.println("Sending mail...");
	    String sqlquery = "select t.task_ID, t.workflow_template_FK, p.project_Id, p.Project_Name, per.person_id, per.Person_Login, per.Person_Email, per.Person_Password, pr.profile_code, st.status_id, comp.Company_Name " +
	    		"from projects p, companies comp, status st, profiles pr, tasks t join persons per on per.Person_ID = t.person_FK " +
	    		"where TIMESTAMPDIFF(HOUR,t.t_date_creation, CURRENT_TIMESTAMP()) >48 " +
	    			"and st.status_label = REPLACE(REPLACE(pr.profile_code, \"EPR\", \"IMPMAIL\"), \"IND\", \"INDMAIL\") " +
	    			"and comp.Company_ID = per.Company_FK " +
	    			"and t.task_ID= (select max(t0.task_ID) " +
	    							"from tasks t0, workflow_templates w, status st " +
	    							"where t0.project_FK= p.Project_ID " +
	    								"and t0.workflow_template_FK = w.workflow_template_ID " +
	    								"and pr.Profile_ID = w.profile_FK " +
	    								"and pr.profile_code in ('EPR', 'IND') " +
	    								"and st.status_ID = t0.task_status_FK " +
	    								"and st.status_label in ('waiting', 'in_progress'))";
		StringBuffer urlLinkBuf = null;
		StringBuffer body = null;
	    try {
			List<?> lists = getDtPageDao().getQueryResult(sqlquery);
			String messageContent = "Messieurs,<div><div><br></div><div>Nous sommes en charge de la photogravure de la reference citee en objet.</div><div>Merci de bien vouloir consulter et valider le process technique en cliquant le lien suivant :</div><div><br></div><div><a href=";
			String postMessage = "</div><div><br></div><div>Vous y trouverez le fichier PDF agence dans l'onglet 'Files'.</div><div>Nous realiserons les photogravures sur reception de votre validation en ligne.</div><div>Merci de votre collaboration.</div><div><br></div></div>";
			EmailDispatcher dispatchEmail = new EmailDispatcher();
			dispatchEmail.openTransport();
			for(Object object: lists ) {
				urlLinkBuf = new StringBuffer("");
				body = new StringBuffer("");
				
				Object[] recordList = (Object[])object;
				Integer taskId = (Integer)recordList[0];
				Integer workflowTemplateFk = (Integer)recordList[1];
				Integer projectId = (Integer)recordList[2];
				String projectName = (String)recordList[3];
				Integer personId = (Integer)recordList[4];
				String impEmailUser = (String)recordList[5];
				String personEmail = (String)recordList[6];
				String impEmailPwd = (String)recordList[7];
				String profileCode = (String)recordList[8];
				Integer eventType = (Integer)recordList[9];
				String companyName = (String)recordList[10];
				
				/*System.out.println(taskId +"\t"+ projectId + "\t" + projectName + "\t" + personId 
						+"\t" + impEmailUser + "\t" + impEmailPwd + "\t" + profileCode + "\t" + eventType + "\t" + companyName);*/
				
				
				if(profileCode.equalsIgnoreCase("EPR")) {
					urlLinkBuf.append(serverLocation).append("ExternalMail/flexexternalmail.html?type=Prop%23ampuser=").append(impEmailUser).append("%23amppass=").append(impEmailPwd).append("%23ampIMPtaskId=").append(taskId).append("%23ampIMPprojId=").append(projectId);
				} else {
					urlLinkBuf.append(serverLocation).append("ExternalMail/flexexternalmail.html?type=Reader%23ampuser=").append(impEmailUser).append("%23amppass=").append(impEmailPwd).append("%23ampIMPtaskId=").append(taskId).append("%23ampIMPprojId=").append(projectId);
				}
				body.append(messageContent).append(serverLocation).append("ExternalMail/flexexternalmail.html?type=Prop%23ampuser=").append(impEmailUser).append("%23amppass=").append(impEmailPwd).append("%23ampIMPtaskId=").append(taskId).append("%23ampIMPprojId=").append(projectId).append(">Link -&gt;</a>").append(urlLinkBuf).append(postMessage);
				
				Message mailMessage = new Message();
				mailMessage.setSubject(projectName);
				mailMessage.setText(body.toString());
				mailMessage.setTo(personEmail);
				
				String error = null;
				if(!dispatchEmail.dispatch(mailMessage)) {
					error = dispatchEmail.getErrorDetails();
				}			
			}
			dispatchEmail.closeTransport();
			dtPageDao.bulkUpdate(eventsList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  }
 
}