package com.adams.scrum.util;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

public class Abstract<T, PK extends Serializable>{
	public List<?> newList;
	public Long count;
	public List<?> findByName(String name){return newList;}
	public List<?> findByNames(String name1,String name2){return newList;}
	public List<?> findByCode(String name){return newList;}
	public List<?> findByNameId(String name,int id){return newList;}
	public List<?> findByIdName(int id,String name){return newList;}
	public List<?> findById(int subnum){return newList;}
	public List<?> findByNums(int subnum1,int subnum2){return newList;}
	public List<?> findByList(){return newList;}
	public List<?> findAll(){return newList;}
	public List<?> findByDate(Date date, int id){return newList;}
	public List<?> findByDateBetween(Date startDate, Date endDate){return newList;}
	public List<?> findByDateEnd(Date date, int id){return newList;}
	public List<?> findByDateBetweenEnd(Date startDate, Date endDate){return newList;}
	public List<?> findByPersonId(int id,int id1){return newList;}
	public List<?> findList(){return newList;}
	public List<?> findByDomainWorkFlow(int o){return newList;}
	public List<?> findByChatList(int id,int id1,int id2){return newList;}
	public List<?> findChatUserList(int senid1,int recid1,int senid2,int recid2,int projid){return newList;}
	public List<?> findWorkflowList(int domainfk){return newList;}
	public List<?> findTasksList(int projectfk){return newList;}
	public List<?> findNotesList(int taskfk){return newList;}
	public List<?> findPersonsList(int projectid){return newList;}
	public List<?> findProfilesList(int projectid){return newList;}
	public List<?> findDomain(String code){return newList;}
	public List<?> findByProfile(int profilefk){return newList;}
	public List<?> findByWorkFlowId(int workFlowfk){return newList;}
	public List<?> findByStopLabel(String str){return newList;}
	public List<?> findWorkflow(int categoryId){return newList;}
	public List<?> findByMailPersonId(int perid){return newList;}
	public List<?> findMailList(int projectfk){return newList;}
	public List<?> findByMailProfileId(int profileid){return newList;}
	public List<?> findMaxTaskId(){return newList;}
	public List<?> findByTaskId(int id){return newList;}
	public List<?> findByTeamLinesId(int profilefk,int projectfk){return newList;}
	public List<?> findByMailFileId(int fileId){return newList;}
	public List<?> findProjectId(int proId){return newList;}
	public List<?> create(T newInstance){return newList;}
	public List<?> read(PK id){return newList;}
	public List<?> update(T transientObject){return newList;}
	public List<?> directUpdate(T transientObject){return newList;}
	public List<?> bulkUpdate(List<?> objList){return newList;}
	public List<?> getList(){return newList;}
	public void deleteAll(){}
	public Long count(){return count;}
}