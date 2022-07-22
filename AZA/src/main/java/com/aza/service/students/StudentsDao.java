package com.aza.service.students;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.aza.common.Search;
import com.aza.service.domain.Students;

public interface StudentsDao {

	// STUDENTS_RECORD :: INSERT
	public void addStudentsRecord(Students students) throws Exception;

	// STUDENTS_RECORD :: SELECT
	public Students getStudentsRecord(int recordCode) throws Exception;

	// STUDENTS_RECORD :: UPDATE 
	public void updateStudentsRecord(Students students) throws Exception;

	// STUDENTS_RECORD :: Proposal
	public void proposalStudents(int recordCode, char proposal) throws Exception;

	// STUDENTS_RECORD :: DELETE 
	public void deleteStudentsRecord(int recordCode) throws Exception;

	// STUDENT_RECORD :: LIST -  (proposal 0)
	public List<Students> listProposalStudents(Search search, String teacherId) throws Exception;

	// STUDENT_RECORD :: Total Count -  (proposal 0)
	public int getProposalStudentsTotalCount(Search search, String teacherId) throws Exception;

	// STUDENT_RECORD :: LIST - (proposal 2)
	public List<Students> listStudentsRecord(Search search, String teacherId) throws Exception;

	// STUDENT_RECORD :: Total Count -  (proposal 2)
	public int getStudentsRecordTotalCount(Search search, String teacherId) throws Exception;
	
	public List<Students> listStudentsRecordByStudent(Search search, String studentId) throws Exception;
	
	public int getStudentsRecordByStudentTotalCount(Search search, String studentId) throws Exception;


	// ATTENDANCE :: INSERT
	public void addStudentsAttendance(Students students) throws Exception;

	// ATTENDANCE :: SELECT
	public Students getStudentsAttendance(int attendanceCode) throws Exception;

	// ATTENDANCE :: UPDATE
	public void updateStudentsAttendance(Students students) throws Exception;

	// ATTENDANCE :: DELETE
	public void deleteStudentsAttendance(int attendanceCode) throws Exception;

	// ATTENDANCE :: LIST
	public List<Students> listStudentsAttendance(Search search, String studentId, String lessonCode, String startMonth, String endMonth) throws Exception;

	// ATTENDANCE :: Total Count
	public int getStudentsAttendanceTotalCount(Search search, String studentId, String lessonCode, String startMonth, String endMonth) throws Exception;


	// characters ========================================
	// INSERT
	public void addStudentsCharacter(Students students) throws Exception;

	// UPDATE
	public void updateStudentsCharacter(Students students) throws Exception;

	// DELETE
	public void deleteStudentsCharacter(int characterCode) throws Exception;

	//  SELECT
	public Students getStudentsCharacter(int characterCode) throws Exception;
	
	// LIST
	public List<Students> listStudentsCharacter(Search search) throws Exception;
	public int getStudentsCharacterTotalCount(Search search) throws Exception;
	
	//
	public int checkCharacterTotalCount(Search search)throws Exception;
	public Students getCheckStudentsCharacter(Search search) throws Exception;
	
	// exam ================================================
	// INSERT
	public void addStudentsExam(Students students) throws Exception;

	// UPDATE
	public void updateStudentsExam(Students students) throws Exception;

	// DELETE
	public void deleteStudentsExam(int examCode)throws Exception;

	// SELECT
	public Students getStudentsExam(int examCode) throws Exception;

	// List SELECT
	public List<Students> listStudentsExam(Search search) throws Exception;

	// TotalCount
	public int getStudentsExamTotalCount(Search search) throws Exception;

	// ListByStudent
	public List<Students> listStudentsExamByStudent(Search search) throws Exception;
	public int getStudentsExamTotalCountByStudent(Search search) throws Exception;
	
	//// Note
	// StudentsNote :: INSERT
	public void addStudentsNote(Students students) throws Exception;

	// StudentsNote :: SELECT
	public Students getStudentsNote(int noteCode) throws Exception;

	// StudentsNote :: UPDATE
	public void updateStudentsNote(Students students) throws Exception;

	// StudentsNote :: DELETE
	public void deleteStudentsNote(int noteCode) throws Exception;

	// StudentsNote :: LIST
	public List<Students> listStudentsNote(Search search, String studentId) throws Exception;

	// StudentsNote :: Total Count
	public int getStudentsNoteTotalCount(Search search, String studentId) throws Exception;
	
	// listStudentsRecordByLessonName
	public List<Students> listStudentsRecordByLessonName(Search search, String lessonCode) throws Exception;
	
	//listStudentsRecordDistinct
	//public List<Students> listStudentsRecordDistinct(Search search, String teacherId) throws Exception;

}
