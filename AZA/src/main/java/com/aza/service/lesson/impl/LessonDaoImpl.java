package com.aza.service.lesson.impl;

import java.util.ArrayList;
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
import com.aza.service.domain.Book;
import com.aza.service.domain.Lesson;
import com.aza.service.domain.LessonBook;
import com.aza.service.domain.Schedule;
import com.aza.service.lesson.LessonDao;

@Component
@PropertySource("classpath:/application.properties")
@Repository("lessonDaoImpl")
public class LessonDaoImpl implements LessonDao {

	@Autowired
	@Lazy
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSessionTemplate;
	
	public void seqSqlSession(SqlSession sqlSession) {
		System.out.println("Test");
		this.sqlSessionTemplate = sqlSession;
		// TODO Auto-generated constructor stub
	}
	
	public LessonDaoImpl() {
		System.out.println(this.getClass()+"] pleas start !!!!!!!");
	}

	@Override
	public void addLesson(Lesson lesson) throws Exception {
		// TODO Auto-generated method stub
		
		
		sqlSessionTemplate.insert("LessonMapper.addLesson", lesson);
	}

	@Override
	public Lesson getLesson(String lessonCode) throws Exception {
		return sqlSessionTemplate.selectOne("LessonMapper.getLesson",lessonCode);
	}

	@Override
	public void updateLesson(Lesson lesson) throws Exception {
		sqlSessionTemplate.update("LessonMapper.updateLesson",lesson);
		// TODO Auto-generated method stub
	}

	@Override
	public void deleteLesson(String lessonCode) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.delete("LessonMapper.lessonDeleteLessonBook", lessonCode);
		sqlSessionTemplate.delete("LessonMapper.deleteLesson", lessonCode);
		
	}

	@Override
	public List<Lesson> listLessonTeacher(Search search, String userID) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(userID);
		
		return sqlSessionTemplate.selectList("LessonMapper.listLessonTeacher",search);			
	}
	
	@Override
	public int getLessonTeacherTotalCount(Search search, String searchKeyword) throws Exception {
		// TODO Auto-generated method stub
		
		search.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("LessonMapper.getLessonTeacherTotalCount",search);
	}
	
	@Override
	public List<Lesson> listLessonStudent(Search search, String userID) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(userID);
		
		return sqlSessionTemplate.selectList("LessonMapper.listLessonStudents",search);
	}
	
	@Override
	public int getLessonStudentTotalCount(Search search, String searchKeyword) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("LessonMapper.getLessonStudentTotalCount",search);
	}
	
	@Override
	public List<Lesson> listLessonTime( String teacherId, String lessonDay) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("teacherId", teacherId);
		map.put("lessonDay", lessonDay);
		return sqlSessionTemplate.selectList("LessonMapper.listLessonTime",map);
	}
	
	@Override
	public int getLessontimeTotalCount(String teacherId, String lessonDay) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("teacherId", teacherId);
		map.put("lessonDay", lessonDay);
		return sqlSessionTemplate.selectOne("LessonMapper.getLessonTimeTotalCount",map);
	}

	@Override
	public List<Lesson> listLessonParent(Search search, String userID) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(userID);
		return sqlSessionTemplate.selectList("LessonMapper.listLessonParent",search);
	}

	@Override
	public int getLessonParentTotalCount(Search search, String searchKeyword) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("LessonMapper.getlistLessonParent",searchKeyword);
	}
	
	@Override
	public List<Lesson> listSelectLessonName(Search search, String studentId) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(studentId);
		return sqlSessionTemplate.selectList("LessonMapper.listSelectLessonName",search);
	}
	
//	==================================

	@Override
	public void addLessonBook(Lesson lesson) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.insert("LessonMapper.addLessonBook",lesson);
	}
	

	@Override
	public void addSameLessonbook(String lessonCode, String isbn) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("lessonCode", lessonCode);
		map.put("isbn", isbn);
		
		sqlSessionTemplate.insert("LessonMapper.addsameLessonBook",map);
	}


	@Override
	public List<Lesson> listLessonBook(Search search, String teacherId) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(teacherId);
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("teacherId", teacherId);
//		map.put("endRowNum", search.getEndRowNum()+"");
//		map.put("startRowNum", search.getStartRowNum()+"");
		return sqlSessionTemplate.selectList("LessonMapper.listLessonBook",search);
	}
	public int getLeesonBookTotalCount(Search search, String searchKeyword) throws Exception{
		search.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("LessonMapper.getLessonBookTotalCount",search);
	}
	
	@Override
	public void deleteLessonBook(String isbn, String lessonCode) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isbn", isbn);
		map.put("lessonCode", lessonCode);
		try {
			sqlSessionTemplate.delete("LessonMapper.deleteLessonBook", map);
			sqlSessionTemplate.delete("LessonMapper.deleteBook",isbn);
		}catch(Exception e) {
			sqlSessionTemplate.delete("LessonMapper.deleteLessonBook", map);
		}
	}
	
	@Override
	public List<Lesson> listBookTeacher(Search search, String teacherId) throws Exception {
		// TODO Auto-generated method stub
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		map.put("teacherId", teacherId); 
		search.setSearchId(teacherId);
		return sqlSessionTemplate.selectList("LessonMapper.listBookTeacher", search);
	}
	public int getLessonBootTeacherTotalCount(Search search, String searchKeyword) throws Exception{
		search.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("LessonMapper.getLessonBookTeacherTotalCount",search);
	}
	
	@Override
	public List<Lesson> listLessonBookStudents(Search search, String studentsId) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(studentsId);
		return sqlSessionTemplate.selectList("LessonMapper.listLessonBookStudents", search);
	}

	@Override
	public int getLessonBookStudentsTotalCount(Search search, String searchKeyword) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("LessonMapper.getLessonBookStudentsTotalCount",searchKeyword);
	}
	
	@Override
	public List<Lesson> listLessonBookParents(Search search, String parentId) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(parentId);
		return sqlSessionTemplate.selectList("LessonMapper.listLessonBookParent",search);
	}

	@Override
	public int getLessonBookParentTotalCount(Search serach, String searchKeyword) throws Exception {
		// TODO Auto-generated method stub
		serach.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("LessonMapper.getLessonBookParentTotalCount",searchKeyword);
	}
	
//	==================================


	@Override
	public void addLessonSchedule(Schedule schedule) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.insert("ScheduleMapper.addLessonSchedule",schedule);
	}

	@Override
	public Schedule getLessonSchedule(int scheduleCode) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("ScheduleMapper.getLessonSchedule",scheduleCode);

 	}

	@Override
	public void updateLessonSchedule(Schedule schedule) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.update("ScheduleMapper.updateLessonSchedule", schedule);
	}

	@Override
	public void deleteLessonSchedule(int scheduleCode) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("scheduleCode", scheduleCode);
		sqlSessionTemplate.delete("ScheduleMapper.deleteLessonSchedule",map);
	}

	@Override
	public List<Schedule> listLessonScheduleTeacher(Search search, String teacherId) throws Exception {
		search.setSearchId(teacherId);
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("teacherId", teacherId);
//		map.put("endRowNum", search.getEndRowNum()+"");
//		map.put("startRowNum", search.getStartRowNum()+"");
		return sqlSessionTemplate.selectList("ScheduleMapper.listLessonScheduleTeacher",search);	
	}
	
	@Override
	public int getLessonScheduleTotalCount(Search search, String searchKeyword) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("ScheduleMapper.getLessonScheduleTeacherTotalCount",search);
	}
	

	@Override
	public List<Schedule> listLessonScheduleStudent(Search search, String studentId) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(studentId);
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		map.put("studentId", studentId);
////		map.put("teacherId", teacherId);
//		
		return sqlSessionTemplate.selectList("ScheduleMapper.listLessonScheduleStudents",search);
	}
	
	@Override
	public int getLessonScheduleStudentTotalCount(Search search, String serachKeyword) throws Exception {
		// TODO Auto-generated method stub
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("studentId", studentId);
//		map.put("teacherId",teacherId);
		search.setSearchKeyword(serachKeyword);
		return sqlSessionTemplate.selectOne("ScheduleMapper.getLessonScheduleStudentsTotalCount",search);
	}

	@Override
	public List<Schedule> listLessonScheduleParent(Search search, String parentId) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(parentId);
		
		return sqlSessionTemplate.selectList("ScheduleMapper.listLessonScheduleParent",search);
	}

	@Override
	public int getlistLessonScheduleParentTotalCount(Search search, String serachKeyword) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchKeyword(serachKeyword);

		return sqlSessionTemplate.selectOne("ScheduleMapper.getlistLessonScheduleParentTotalCount",search);
	}
	
	@Override
	public void deteteLessonScheduleAll(String teacherId) throws Exception {
		// TODO Auto-generated method stub
		sqlSessionTemplate.delete("ScheduleMapper.deleteAll",teacherId);
	}

	@Override
	public List<Schedule> listLessonSelectTeacher(Search search, String studentId) throws Exception {
		// TODO Auto-generated method stub
		search.setSearchId(studentId);
		
		return sqlSessionTemplate.selectList("ScheduleMapper.listLessonSelectTeacher",search);
	}

	@Override
	public int getlistLessonSelectTeacherTotalCount(Search search, String searchKeyword) throws Exception {
		search.setSearchKeyword(searchKeyword);
		return sqlSessionTemplate.selectOne("ScheduleMapper.getlistLessonSelectTeacherTotalCount",search);
	}


//	@Override
//	public List<Schedule> getCalendar() throws Exception{
//		List<Schedule> calendar = null;
//		
//		calendar = sqlSessionTemplate.selectList("ScheduleMapper.getLessonSchedule");
//		return calendar;
//	}
}