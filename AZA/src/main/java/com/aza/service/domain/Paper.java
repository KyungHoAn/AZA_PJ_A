package com.aza.service.domain;

import java.util.Date;
import java.util.List;

public class Paper {
	
	private int quizCode;
	private int questionCode;
	private int choiceCode;
	private String lessonCode;
	private String studentId;
	private String quizTitle;
	private int quizScore;
	private String quizCreateAt;
	private String quizSubmitDate;
	private int questionNo;
	private String questionContent;
	private String teacherAnswer;
	private String studentAnswer;
	private String feedBackContent;
	private char answerCheck;
	private int choiceNo;
	private String choiceContent;
	
	private char homeworkCheck;
	private String homeworkTitle;
	private String homeworkContent;
	private String homeworkCreateAt;
	private String homeworkDueDate;
	private int homeworkCode;
	
//	private Lesson lessonName;
//	private Students studentName;
	private Lesson teacherId;
	
	private String studentName;
	private String lessonName;
	
	
	public Paper() {
		
	}


	public int getQuizCode() {
		return quizCode;
	}


	public void setQuizCode(int quizCode) {
		this.quizCode = quizCode;
	}


	public int getQuestionCode() {
		return questionCode;
	}


	public void setQuestionCode(int questionCode) {
		this.questionCode = questionCode;
	}


	public int getChoiceCode() {
		return choiceCode;
	}


	public void setChoiceCode(int choiceCode) {
		this.choiceCode = choiceCode;
	}


	public String getLessonCode() {
		return lessonCode;
	}


	public void setLessonCode(String lessonCode) {
		this.lessonCode = lessonCode;
	}


	public String getStudentId() {
		return studentId;
	}


	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}


	public String getQuizTitle() {
		return quizTitle;
	}


	public void setQuizTitle(String quizTitle) {
		this.quizTitle = quizTitle;
	}


	public int getQuizScore() {
		return quizScore;
	}


	public void setQuizScore(int quizScore) {
		this.quizScore = quizScore;
	}


	public String getQuizCreateAt() {
		return quizCreateAt;
	}


	public void setQuizCreateAt(String quizCreateAt) {
		this.quizCreateAt = quizCreateAt;
	}


	public String getQuizSubmitDate() {
		return quizSubmitDate;
	}


	public void setQuizSubmitDate(String quizSubmitDate) {
		this.quizSubmitDate = quizSubmitDate;
	}


	public int getQuestionNo() {
		return questionNo;
	}


	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}


	public String getQuestionContent() {
		return questionContent;
	}


	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}


	public String getTeacherAnswer() {
		return teacherAnswer;
	}


	public void setTeacherAnswer(String teacherAnswer) {
		this.teacherAnswer = teacherAnswer;
	}


	public String getStudentAnswer() {
		return studentAnswer;
	}


	public void setStudentAnswer(String studentAnswer) {
		this.studentAnswer = studentAnswer;
	}


	public String getFeedBackContent() {
		return feedBackContent;
	}


	public void setFeedBackContent(String feedBackContent) {
		this.feedBackContent = feedBackContent;
	}


	public char getAnswerCheck() {
		return answerCheck;
	}


	public void setAnswerCheck(char answerCheck) {
		this.answerCheck = answerCheck;
	}


	public int getChoiceNo() {
		return choiceNo;
	}


	public void setChoiceNo(int choiceNo) {
		this.choiceNo = choiceNo;
	}


	public String getChoiceContent() {
		return choiceContent;
	}


	public void setChoiceContent(String choiceContent) {
		this.choiceContent = choiceContent;
	}


	public char getHomeworkCheck() {
		return homeworkCheck;
	}


	public void setHomeworkCheck(char homeworkCheck) {
		this.homeworkCheck = homeworkCheck;
	}


	public String getHomeworkTitle() {
		return homeworkTitle;
	}


	public void setHomeworkTitle(String homeworkTitle) {
		this.homeworkTitle = homeworkTitle;
	}


	public String getHomeworkContent() {
		return homeworkContent;
	}


	public void setHomeworkContent(String homeworkContent) {
		this.homeworkContent = homeworkContent;
	}


	public String getHomeworkCreateAt() {
		return homeworkCreateAt;
	}


	public void setHomeworkCreateAt(String homeworkCreateAt) {
		this.homeworkCreateAt = homeworkCreateAt;
	}


	public String getHomeworkDueDate() {
		return homeworkDueDate;
	}


	public void setHomeworkDueDate(String homeworkDueDate) {
		this.homeworkDueDate = homeworkDueDate;
	}


	public int getHomeworkCode() {
		return homeworkCode;
	}


	public void setHomeworkCode(int homeworkCode) {
		this.homeworkCode = homeworkCode;
	}


//	public Lesson getLessonName() {
//		return lessonName;
//	}
//
//
//	public void setLessonName(Lesson lessonName) {
//		this.lessonName = lessonName;
//	}
//
//	public Students getStudentName() {
//		return studentName;
//	}
//	
//	
//	public void setStudentName(Students studentName) {
//		this.studentName = studentName;
//	}

	public Lesson getTeacherId() {
		return teacherId;
	}


	public void setTeacherId(Lesson teacherId) {
		this.teacherId = teacherId;
	}


	public String getStudentName() {
		return studentName;
	}


	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}


	public String getLessonName() {
		return lessonName;
	}


	public void setLessonName(String lessonName) {
		this.lessonName = lessonName;
	}


	@Override
	public String toString() {
		return "Paper [quizCode=" + quizCode + ", questionCode=" + questionCode + ", choiceCode=" + choiceCode
				+ ", lessonCode=" + lessonCode + ", studentId=" + studentId + ", quizTitle=" + quizTitle
				+ ", quizScore=" + quizScore + ", quizCreateAt=" + quizCreateAt + ", quizSubmitDate=" + quizSubmitDate
				+ ", questionNo=" + questionNo + ", questionContent=" + questionContent + ", teacherAnswer="
				+ teacherAnswer + ", studentAnswer=" + studentAnswer + ", feedBackContent=" + feedBackContent
				+ ", answerCheck=" + answerCheck + ", choiceNo=" + choiceNo + ", choiceContent=" + choiceContent
				+ ", homeworkCheck=" + homeworkCheck + ", homeworkTitle=" + homeworkTitle + ", homeworkContent="
				+ homeworkContent + ", homeworkCreateAt=" + homeworkCreateAt + ", homeworkDueDate=" + homeworkDueDate
				+ ", homeworkCode=" + homeworkCode + ", teacherId=" + teacherId + ", studentName=" + studentName
				+ ", lessonName=" + lessonName + "]";
	}





	




	


	
	

	



	
	
}
