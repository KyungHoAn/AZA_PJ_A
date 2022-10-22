package com.aza.service.domain;

public class User {
	
	private String userId;
	private String role;
	private String userName;
	private String phone;
	private String school;
	private String grade;
	private String birth;
	private String parentPhone;
	private String password;
	private String stopAlertStartTime;
	private String stopAlertEndTime;
	private char alertState;
	private String firstStudentId;
	private String firstStudentName;
	private int relationCode;
	private String relationName;
	private char check;
	
	
	public User() {
			
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getParentPhone() {
		return parentPhone;
	}

	public void setParentPhone(String parentPhone) {
		this.parentPhone = parentPhone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getStopAlertStartTime() {
		return stopAlertStartTime;
	}

	public void setStopAlertStartTime(String stopAlertStartTime) {
		this.stopAlertStartTime = stopAlertStartTime;
	}

	public String getStopAlertEndTime() {
		return stopAlertEndTime;
	}

	public void setStopAlertEndTime(String stopAlertEndTime) {
		this.stopAlertEndTime = stopAlertEndTime;
	}

	public char getAlertState() {
		return alertState;
	}

	public void setAlertState(char alertState) {
		this.alertState = alertState;
	}
	

	public String getFirstStudentId() {
		return firstStudentId;
	}

	public void setFirstStudentId(String firstStudentId) {
		this.firstStudentId = firstStudentId;
	}

	public String getFirstStudentName() {
		return firstStudentName;
	}

	public void setFirstStudentName(String firstStudentName) {
		this.firstStudentName = firstStudentName;
	}

	public int getRelationCode() {
		return relationCode;
	}

	public void setRelationCode(int relationCode) {
		this.relationCode = relationCode;
	}

	public String getRelationName() {
		return relationName;
	}

	public void setRelationName(String relationName) {
		this.relationName = relationName;
	}

	public char getCheck() {
		return check;
	}

	public void setCheck(char check) {
		this.check = check;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", role=" + role + ", userName=" + userName + ", phone=" + phone + ", school="
				+ school + ", grade=" + grade + ", birth=" + birth + ", parentPhone=" + parentPhone + ", password="
				+ password + ", stopAlertStartTime=" + stopAlertStartTime + ", stopAlertEndTime=" + stopAlertEndTime
				+ ", alertState=" + alertState + ", firstStudentId=" + firstStudentId + ", firstStudentName="
				+ firstStudentName + ", relationCode=" + relationCode + ", relationName=" + relationName + ", check="
				+ check + "]";
	}
	
	

}
