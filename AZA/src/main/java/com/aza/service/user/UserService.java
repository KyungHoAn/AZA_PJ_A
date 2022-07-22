package com.aza.service.user;

import java.util.List;
import java.util.Map;

import com.aza.common.Search;
import com.aza.service.domain.User;

public interface UserService {
	
	//User :: INSERT È¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	public void addUser(User user) throws Exception; //
	
	//User :: SELECT
	public User getUser(String userId) throws Exception; //
	
	//User :: UPDATE
	public void updateUser(User user) throws Exception; //
	
	//User :: DELETE
	public void deleteUser(User user) throws Exception; //
	
	//User :: CheckDuplication
	public int checkDuplication(String userId) throws Exception; //
	public int checkStudent(String firstStudentId) throws Exception;
	
	//User :: updateAlertState
	public void updateAlertState(User user) throws Exception;
	
	//User :: updateStopAlertStartTime
	public void updateStopAlertStartTime(User user) throws Exception;
	
	//User :: updateStopAlertEndTime
	public void updateStopAlertEndTime(User user) throws Exception;
	
	//User :: updateCheck
	public void updateCheck(User user) throws Exception; // ÀÚµ¿·Î±×ÀÎ. login¿¡ ºÙÀÌ±â
	
	//Relation :: INSERT ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½È¸ ï¿½ï¿½ï¿½ï¿½ï¿½ß°ï¿½
	public void addRelation(User user) throws Exception;
	
	//Relation :: SELECT
	public User getRelation(int relationCode) throws Exception;

	//Relation :: UPDATE
	public void updateRelation(User user) throws Exception;
	
	//Relation :: DELETE
	public void deleteRelation(int relationCode) throws Exception;
	
	//Relation :: LIST By Student
	public Map<String, Object> listRelationByStudent(Search search, String studentId) throws Exception;
	
	//Relation :: LIST By parent
	public Map<String, Object> listRelationByParent(Search search, String parentId) throws Exception;
	
	//Relation :: LIST BY parent studentname
	public Map<String, Object> listStudentRelationByParent(Search search, String parentId) throws Exception;
	
	// private phoneAuth
	public void sendSMS(String phone,String message) throws Exception;

	int phoneAuth() throws Exception;
	
	public User findId(User user)throws Exception;
	
	public User findPassword(User user)throws Exception;
	
	public void updatePassword(User user)throws Exception;

	int confirmCode(String code) throws Exception;

	public User checkPhone(User user)throws Exception;
	
	public User firstStudentIdByParent(String parentId) throws Exception;

	Map<String, Object> listRelation(Search search, String parentId) throws Exception;

}