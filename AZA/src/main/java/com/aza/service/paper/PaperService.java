package com.aza.service.paper;

import java.util.List;
import java.util.Map;

import com.aza.common.Search;
import com.aza.service.domain.Paper;

public interface PaperService {
	
	//PaperQuiz :: INSERT
	public void addPaperQuiz(Paper paper) throws Exception;
	
	//PaperQuiz :: SELECT
	public Paper getPaperQuiz(int quizCode) throws Exception;
	
	//PaperQuiz :: UPDATE
	public void updatePaperQuiz(Paper paper) throws Exception;
	
	//PaperQuiz :: DELETE
	public void deletePaperQuiz(int quizCode) throws Exception;
	
	//PaperQuiz :: LIST 
	public Map<String, Object> listPaperQuizTeacher(Search search, String teacherId) throws Exception;
	public Map<String, Object> listPaperQuizStudent(Search search, String studentId) throws Exception;

	
	//PaperQuestion :: INSERT
//	public void addPaperQuestion(Paper paper) throws Exception;
	public void addPaperQuestion(List<Paper> questionList) throws Exception;
	
	//PaperQuestion :: SELECT
	public Paper getPaperQuestion(int questionCode) throws Exception;
	//public Map<String,Object> getPaperQuestion(int quizCode) throws Exception;
	
	//PaperQuestion :: UPDATE
	//public void updatePaperQuestion(Paper paper) throws Exception;
	public void updatePaperQuestion(List<Paper> updateQuestionList) throws Exception;
	
	//PaperQuestion :: DELETE
	public void deletePaperQuestion(int questionCode) throws Exception;
	
	//PaperQuestion :: LIST
	public Map<String,Object> listPaperQuestion(int quizCode) throws Exception;
	
	//PaperFeedBack :: INSERT
	
	//PaperFeedBack :: DELETE
	
	//PaperFeedBack :: UPDATE

	//PaperSubmitAnswer :: UPDATE	
	
	//PaperAnswerCheck :: UPDATE
	
	//Choice :: INSERT
	public void addPaperChoice(Paper paper) throws Exception;
	//Choice :: SELECT
	public Paper getPaperChoice(int choiceCode) throws Exception;
	//Choice :: UPDATE
	public void updatePaperChoice(Paper paper) throws Exception;
	//Choice :: DELETE
	public void deletePaperChoice(int choiceCode) throws Exception;
	//Choice :: LIST
	public Map<String,Object> listPaperChoice(int questionCode) throws Exception;
	
	
	//========================================
	
	//PaperHomework :: INSERT
	public void addPaperHomework(Paper paper) throws Exception;
	
	//PaperHomework :: SELECT
	public Paper getPaperHomework(int homeworkCode) throws Exception;
	
	//PaperHomework :: UPDATE
	public void updatePaperHomework(Paper paper) throws Exception;
	
	//PaperHomework :: DELETE
	public void deletePaperHomework(int homeworkCode) throws Exception;
	
	//PaperHomework :: LIST
//	public Map<String, Object> listPaperHomeworkByStudent(Search search, String LessonCode, String StudentId) throws Exception;
	public Map<String, Object> listPaperHomeworkByStudent(Search search,  String studentId) throws Exception;
	
	//PaperHomework :: LIST
//	public Map<String, Object> listPaperHomeworkByTeacher(Search search, String LessonCode) throws Exception;
	public Map<String, Object> listPaperHomeworkByTeacher(Search search, String teacherId) throws Exception;
	
	//PaperHomework :: LIST 
	public Map<String, Object> listPaperHomeworkByParent(Search search, String parentId) throws Exception;
	
	//PaperHomeworkCheck :: UPDATE
	public void updatePaperHomeworkCheck(int homeworkCode) throws Exception;
	
	//listPaperHomeworkByLessonName
	public Map<String, Object> listPaperHomeworkByLessonName(Search search, String studentId, String lessonName) throws Exception;
	
}
