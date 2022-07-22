package com.aza.service.lesson;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.aza.common.Search;
import com.aza.service.domain.Book;
import com.aza.service.domain.Lesson;
import com.aza.service.domain.LessonBook;
import com.aza.service.domain.Schedule;

public interface LessonDao {
	//lesson : insert
	public void addLesson(Lesson lesson) throws Exception;
	
	//lesson : select
	public Lesson getLesson(String lessonCode) throws Exception;
	
	//lesson : update
	public void updateLesson(Lesson lesson) throws Exception;
	
	//lesson : delete
	public void deleteLesson(String lessonCode) throws Exception;
	
	//lesson : list
	public List<Lesson> listLessonTeacher(Search search, String userID) throws Exception;
	
	public List<Lesson> listLessonStudent(Search search, String userID) throws Exception;
	
	public List<Lesson> listLessonParent(Search seearch, String userID) throws Exception;
	
	public List<Lesson>	listLessonTime(String teacherId, String lessonDay) throws Exception;
	
	public int getLessonTeacherTotalCount(Search search, String searchKeyword) throws Exception;
	
	public int getLessonStudentTotalCount(Search search, String searchKeyword) throws Exception;
	
	public int getLessontimeTotalCount(String teacherId, String lessonDay) throws Exception;
	
	public int getLessonParentTotalCount(Search search, String searchKeyword) throws Exception;
	
	public List<Lesson> listSelectLessonName(Search search, String studentId) throws Exception;
//=======================================================
	
	//lessonBook : insert
	public void addLessonBook(Lesson lesson) throws Exception;
	
	public void addSameLessonbook(String lessonCode, String isbn) throws Exception;
	
	//lessonBook : list
	public List<Lesson> listLessonBook(Search search, String lessonCode) throws Exception;
	
	//lessonBook : delete
	public void deleteLessonBook(String isbn, String lessonCode) throws Exception;
	
	public List<Lesson> listBookTeacher(Search search, String teacherId) throws Exception;
	
	public int getLeesonBookTotalCount(Search serach, String searchKeyword) throws Exception;
	
	public List<Lesson> listLessonBookStudents(Search search, String studentsId) throws Exception;
	
	public List<Lesson> listLessonBookParents(Search search, String parentId) throws Exception;
	
	public int getLessonBookStudentsTotalCount(Search search, String searchKeyword) throws Exception;
	
	public int getLessonBookParentTotalCount(Search serach, String searchKeyword) throws Exception;
	
	//=======================================================	
	
	//schedule : add
	public void addLessonSchedule(Schedule schedule) throws Exception;
	
	//schedule : select
	public Schedule getLessonSchedule(int scheduleCode) throws Exception;
	
	//schedule : update
	public void updateLessonSchedule(Schedule schedule) throws Exception;
	
	//schedule : delete
	public void deleteLessonSchedule(int scheudleCode) throws Exception;
	
	//schedule : listTeacher
	public List<Schedule> listLessonScheduleTeacher(Search search, String teacherId) throws Exception;
	
	//schdule : studnet
	public List<Schedule> listLessonScheduleStudent(Search search, String studentId) throws Exception;
	
	public List<Schedule> listLessonSelectTeacher(Search search, String studentId) throws Exception;
	
	public List<Schedule> listLessonScheduleParent(Search search, String parentId) throws Exception;
	
	//schedule : delete all
	public void deteteLessonScheduleAll(String teacherId) throws Exception;
	
	public int getLessonScheduleTotalCount(Search search, String searchKeyword) throws Exception;
	
	public int getLessonScheduleStudentTotalCount(Search search, String studentId) throws Exception;

	public int getlistLessonSelectTeacherTotalCount(Search search, String searchKeyword) throws Exception;
	
	public int getlistLessonScheduleParentTotalCount(Search search, String parentId)throws Exception;
	
	
}
