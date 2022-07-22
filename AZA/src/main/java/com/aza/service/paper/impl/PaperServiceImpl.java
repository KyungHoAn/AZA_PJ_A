package com.aza.service.paper.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.aza.common.Search;
import com.aza.service.domain.Paper;
import com.aza.service.paper.PaperDao;
import com.aza.service.paper.PaperService;

@Service("paperServiceImpl")
public class PaperServiceImpl implements PaperService {
	
	///Field
	@Autowired
	@Qualifier("paperDaoImpl")
	private PaperDao paperDao;
	public void setPaperDao(PaperDao paperDao) {
		this.paperDao = paperDao;
	}
	
	///Constructor
	public PaperServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addPaperHomework(Paper paper) throws Exception {
		paperDao.addPaperHomework(paper);
	}

	@Override
	public Paper getPaperHomework(int homeworkCode) throws Exception {
		return paperDao.getPaperHomework(homeworkCode);
	}

	@Override
	public void updatePaperHomework(Paper paper) throws Exception {
		paperDao.updatePaperHomework(paper);
	}

	@Override
	public void deletePaperHomework(int homeworkCode) throws Exception {
		paperDao.deletePaperHomework(homeworkCode);
	}

//	@Override
//	public Map<String, Object> listPaperHomeworkByStudent(Search search, String lessonCode, String StudentId) throws Exception {
//		
//		List<Paper> list = paperDao.listPaperHomeworkByStudent(search, lessonCode, StudentId);
//		int totalCount = paperDao.getListPaperHomeworkByStudentTotalCount(search, lessonCode, StudentId);
//		
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("list", list);
//		map.put("totalCount", new Integer(totalCount));
//		
//		return map;
//	}
	
	@Override
	public Map<String, Object> listPaperHomeworkByStudent(Search search, String studentId) throws Exception {
		
		List<Paper> list = paperDao.listPaperHomeworkByStudent(search, studentId);
		int totalCount = paperDao.getListPaperHomeworkByStudentTotalCount(search, studentId);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public Map<String, Object> listPaperHomeworkByLessonName(Search search, String studentId, String lessonName) throws Exception {
		
		List<Paper> list = paperDao.listPaperHomeworkByLessonName(search, studentId, lessonName);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list", list);
		
		return map;
	}
	
//	@Override
//	public Map<String, Object> listPaperHomeworkByTeacher(Search search, String lessonCode) throws Exception {
//		
//		List<Paper> list = paperDao.listPaperHomeworkByTeacher(search, lessonCode);
//		int totalCount = paperDao.getListPaperHomeworkByTeacherTotalCount(search, lessonCode);
//		
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("list", list);
//		map.put("totalCount", new Integer(totalCount));
//		
//		return map;
//	}
	

	@Override
	public Map<String, Object> listPaperHomeworkByTeacher(Search search, String teacherId) throws Exception {

		List<Paper> list = paperDao.listPaperHomeworkByTeacher(search, teacherId);
		int totalCount = paperDao.getListPaperHomeworkByTeacherTotalCount(search, teacherId);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public Map<String, Object> listPaperHomeworkByParent(Search search, String parentId) throws Exception {
		List<Paper> list = paperDao.listPaperHomeworkByParent(search, parentId);
		int totalCount = paperDao.getListPaperHomeworkByParentTotalCount(search, parentId);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updatePaperHomeworkCheck(int homeworkCode) throws Exception {
		paperDao.updatePaperHomeworkCheck(homeworkCode);
	}

//	@Override
//	public void addPaperQuestion(Paper paper) throws Exception {
//		paperDao.addPaperQuestion(paper);
//	}
	
	@Override
	public void addPaperQuestion(List<Paper> questionList) throws Exception {
		paperDao.addPaperQuestion(questionList);
	}

	@Override
	public Paper getPaperQuestion(int questionCode) throws Exception {
		return paperDao.getPaperQuestion(questionCode);
	}
	
//	@Override
//	public Map<String, Object> getPaperQuestion(int quizCode) throws Exception {
//		
//		List<Paper> listQuestion = paperDao.getPaperQuestion(quizCode);
//		
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("listQuestion", listQuestion);
//		
//		return map;
//	}

//	@Override
//	public void updatePaperQuestion(Paper paper) throws Exception {
//		paperDao.updatePaperQuestion(paper);
//	}
	
	@Override
	public void updatePaperQuestion(List<Paper> updateQuestionList) throws Exception {
		paperDao.updatePaperQuestion(updateQuestionList);
	}

	@Override
	public void deletePaperQuestion(int questionCode) throws Exception {
		paperDao.deletePaperQuestion(questionCode);
	}

	@Override
	public Map<String, Object> listPaperQuestion(int quizCode) throws Exception {
		
		List<Paper> listQuestion = paperDao.listPaperQuestion(quizCode);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("listQuestion", listQuestion);
		
		return map;
	}
//=========================== Choice
	@Override
	public void addPaperChoice(Paper paper) throws Exception {
		paperDao.addPaperChoice(paper);
	}

	@Override
	public Paper getPaperChoice(int choiceCode) throws Exception {
		return paperDao.getPaperChoice(choiceCode);
	}

	@Override
	public void updatePaperChoice(Paper paper) throws Exception {
		paperDao.updatePaperChoice(paper);
	}

	@Override
	public void deletePaperChoice(int choiceCode) throws Exception {
		paperDao.deletePaperChoice(choiceCode);
	}

	@Override
	public Map<String, Object> listPaperChoice(int questionCode) throws Exception {
		
		List<Paper> list = paperDao.listPaperQuestion(questionCode);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		
		return map;
	}

	//== 
	@Override
	public void addPaperQuiz(Paper paper) throws Exception {
		paperDao.addPaperQiuz(paper);
		
	}

	@Override
	public Paper getPaperQuiz(int quizCode) throws Exception {
		// TODO Auto-generated method stub
		return paperDao.getPaperQiuz(quizCode);
	}

	@Override
	public void updatePaperQuiz(Paper paper) throws Exception {
		// TODO Auto-generated method stub
		paperDao.updatePaperQuiz(paper);
	}

	@Override
	public void deletePaperQuiz(int quizCode) throws Exception {
		paperDao.deletePaperQuiz(quizCode);
		
	}

	@Override
	public Map<String, Object> listPaperQuizTeacher(Search search, String teacherId) throws Exception {
		List<Paper> list = paperDao.listPaperQuizTeacher(search, teacherId);
		int totalCount = paperDao.getPaperQuizTotalCountTeacher(search, teacherId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		
		return map;
	}


	@Override
	public Map<String, Object> listPaperQuizStudent(Search search, String studentId) throws Exception {
		
		List<Paper> list = paperDao.listPaperQuizStudent(search, studentId);
		int totalCount = paperDao.getPaperQuizTotalCountStudent(search, studentId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		
		return map;
	}
	


	
}
