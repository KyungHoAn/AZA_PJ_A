package com.aza.service.paper.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.aza.common.Search;
import com.aza.service.domain.Paper;
import com.aza.service.paper.PaperDao;

@Component
@PropertySource("classpath:/application.properties")
@Repository("paperDaoImpl")
public class PaperDaoImpl implements PaperDao {
	
	///Field
	@Autowired
	@Lazy
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public PaperDaoImpl() {
		System.out.println(this.getClass());
	}
	

	@Override
	public void addPaperHomework(Paper paper) throws Exception {
		sqlSession.insert("HomeworkMapper.addPaperHomework",paper);
	}

	@Override
	public Paper getPaperHomework(int homeworkCode) throws Exception {
		return sqlSession.selectOne("HomeworkMapper.getPaperHomework", homeworkCode);
	}

	@Override
	public void updatePaperHomework(Paper paper) throws Exception {
		sqlSession.update("HomeworkMapper.updatePaperHomework", paper);
	}

	@Override
	public void deletePaperHomework(int homeworkCode) throws Exception {
		sqlSession.delete("HomeworkMapper.deletePaperHomework", homeworkCode);
	}




	@Override
	public void updatePaperHomeworkCheck(int homeworkCode) throws Exception {
		sqlSession.update("HomeworkMapper.updatePaperHomeworkCheck",homeworkCode);
		
	}
	
//	@Override
//	public List<Paper> listPaperHomeworkByStudent(Search search, String lessonCode, String studentId) throws Exception {
//		search.setLessonCode(lessonCode);
//		search.setSearchId(studentId);
//		
//		return sqlSession.selectList("HomeworkMapper.listPaperHomeworkByStudent", search);
//	}
//
//	@Override
//	public List<Paper> listPaperHomeworkByTeacher(Search search, String lessonCode) throws Exception {
//		search.setLessonCode(lessonCode);
//		return sqlSession.selectList("HomeworkMapper.listPaperHomeworkByTeacher",search);
//	}
//
//	@Override
//	public int getListPaperHomeworkByStudentTotalCount(Search search, String lessonCode, String studentId) throws Exception {
//		search.setLessonCode(lessonCode);
//		search.setSearchId(studentId);
//		
//		return sqlSession.selectOne("HomeworkMapper.getListPaperHomeworkByStudentTotalCount", search);
//	}
//
//	@Override
//	public int getListPaperHomeworkByTeacherTotalCount(Search search, String lessonCode) throws Exception {
//		search.setLessonCode(lessonCode);
//		
//		return sqlSession.selectOne("HomeworkMapper.getListPaperHomeworkByTeacherTotalCount", search);
//	}
	
	@Override
	public List<Paper> listPaperHomeworkByLessonName(Search search, String studentId, String lessonName) throws Exception {
		
		search.setSearchId(studentId);
		search.setSearchLessonName(lessonName);
		
		return sqlSession.selectList("HomeworkMapper.listPaperHomeworkByLessonName",search);
	}
	
	@Override
	public List<Paper> listPaperHomeworkByStudent(Search search, String studentId) throws Exception {
		
		search.setSearchId(studentId);

		return sqlSession.selectList("HomeworkMapper.listPaperHomeworkByStudent", search);
	}

	@Override
	public List<Paper> listPaperHomeworkByTeacher(Search search, String teacherId) throws Exception {

		search.setSearchId(teacherId);
		
		return sqlSession.selectList("HomeworkMapper.listPaperHomeworkByTeacher", search);
	}
	
	@Override
	public List<Paper> listPaperHomeworkByParent(Search search, String parentId) throws Exception {
		
		search.setSearchId(parentId);
		return sqlSession.selectList("HomeworkMapper.listPaperHomeworkByParent", search);
	}

	@Override
	public int getListPaperHomeworkByStudentTotalCount(Search search, String studentId) throws Exception {

		search.setSearchId(studentId);
		
		return sqlSession.selectOne("HomeworkMapper.getListPaperHomeworkByStudentTotalCount", search);
	}

	@Override
	public int getListPaperHomeworkByTeacherTotalCount(Search search, String teacherId) throws Exception {

		search.setSearchId(teacherId);
		
		return sqlSession.selectOne("HomeworkMapper.getListPaperHomeworkByTeacherTotalCount", search);
	}
	
	@Override
	public int getListPaperHomeworkByParentTotalCount(Search search, String parentId) throws Exception {
		
		search.setSearchId(parentId);
		
		return sqlSession.selectOne("HomeworkMapper.getListPaperHomeworkByParentTotalCount", search); 
	}


//	@Override
//	public void addPaperQuestion(Paper paper) throws Exception {
//		sqlSession.insert("QuestionMapper.addPaperQuestion", paper);
//	}
	
	@Override
	public void addPaperQuestion(List<Paper> questionList) throws Exception {
		sqlSession.insert("QuestionMapper.addPaperQuestion", questionList);
	}

	@Override
	public Paper getPaperQuestion(int questionCode) throws Exception {
		return sqlSession.selectOne("QuestionMapper.getPaperQuestion",questionCode);
	}
	
//	@Override
//	public List<Paper> getPaperQuestion(int quizCode) throws Exception {
//		return sqlSession.selectList("QuestionMapper.getPaperQuestion", quizCode);
//	}

//	@Override
//	public void updatePaperQuestion(Paper paper) throws Exception {
//		sqlSession.update("QuestionMapper.updatePaperQuestion",paper);
//	}
	
	@Override
	public void updatePaperQuestion(List<Paper> updateQuestionList) throws Exception {
		sqlSession.update("QuestionMapper.updatePaperQuestion", updateQuestionList);
	}

	@Override
	public void deletePaperQuestion(int questionCode) throws Exception {
		sqlSession.delete("QuestionMapper.deletePaperQuestion",questionCode);
	}

	@Override
	public List<Paper> listPaperQuestion(int quizCode) throws Exception {
		return sqlSession.selectList("QuestionMapper.listPaperQuestion",quizCode);
	}

	@Override
	public void addPaperChoice(Paper paper) throws Exception {
		sqlSession.insert("ChoiceMapper.addPaperChoice", paper);
	}

	@Override
	public Paper getPaperChoice(int choiceCode) throws Exception {
		return sqlSession.selectOne("ChoiceMapper.getPaperChoice", choiceCode);
	}

	@Override
	public void updatePaperChoice(Paper paper) throws Exception {
		sqlSession.update("ChoiceMapper.updatePaperChoice",paper);
	}

	@Override
	public void deletePaperChoice(int choiceCode) throws Exception {
		sqlSession.delete("ChoiceMapper.deletePaperChoice", choiceCode);
	}

	@Override
	public List<Paper> listPaperChoice(int questionCode) throws Exception {
		return sqlSession.selectList("ChoiceMapper.listPaperChoice",questionCode);
	}
	//== 
	@Override
	public Paper getPaperQiuz(int quizCode) throws Exception {
		
		return sqlSession.selectOne("QuizMapper.getPaperQuiz",quizCode);
	}

	@Override
	public void addPaperQiuz(Paper paper) throws Exception {
		sqlSession.insert("QuizMapper.addPaperQuiz", paper);

	}

	@Override
	public void updatePaperQuiz(Paper paper) throws Exception {
		sqlSession.update("QuizMapper.updatePaperQuiz", paper);

	}

	@Override
	public void deletePaperQuiz(int quizCode) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("QuizMapper.deletePaperQuiz",quizCode);

	}
//====================================================================
//	@Override
//	public List<Paper> listPaperQuiz(Search search) throws Exception {
//		// TODO Auto-generated method stub
//		return sqlSession.selectList("QuizMapper.listPaperQuiz", search);
//	}


	@Override
	public List<Paper> listPaperQuizTeacher(Search search, String teacherId) throws Exception {

		search.setSearchId(teacherId);
		
		return sqlSession.selectList("QuizMapper.listPaperQuizTeacher", search);
	}

	@Override
	public List<Paper> listPaperQuizStudent(Search search, String studentId) throws Exception {

		search.setSearchId(studentId);
		
		return sqlSession.selectList("QuizMapper.listPaperQuizStudent", search);
	}

	@Override
	public int getPaperQuizTotalCountStudent(Search search, String studentId) throws Exception {

		search.setSearchId(studentId);
		
		return sqlSession.selectOne("QuizMapper.getPaperQuizTotalCountStudent",search);
	}
	
	
	@Override
	public int getPaperQuizTotalCountTeacher(Search search, String teacherId) throws Exception {

		search.setSearchId(teacherId);
		
		return sqlSession.selectOne("QuizMapper.getPaperQuizTotalCountTeacher",search);
	}


}
