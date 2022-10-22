package com.aza.service.students.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.aza.common.Search;
import com.aza.service.domain.Students;
import com.aza.service.students.StudentsDao;

@Component
@PropertySource("classpath:/application.properties")
@Repository("studentsDaoImpl")
public class StudentsDaoImpl implements StudentsDao {

	// field
	@Autowired
	@Lazy
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSessionTemplate;
	
	
	// ctor
	public StudentsDaoImpl() {
		System.out.println("[ "+this.getClass()+" ] :: start");
	}
	
	
	// method
	public void setSqlSession(SqlSession sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	

	@Override
	public void addStudentsRecord(Students students) throws Exception {
		sqlSessionTemplate.insert("StudentsRecordMapper.addStudentsRecord", students);
	}

	@Override
	public Students getStudentsRecord(int recordCode) throws Exception {
		return sqlSessionTemplate.selectOne("StudentsRecordMapper.getStudentsRecord", recordCode);
	}

	@Override
	public void updateStudentsRecord(Students students) throws Exception {
		sqlSessionTemplate.update("StudentsRecordMapper.updateStudentsRecord", students);
	}

	@Override
	public void proposalStudents(int recordCode, char proposal) throws Exception {
		
		Students students = new Students();
		students.setRecordCode(recordCode);
		students.setProposal(proposal);
		
		sqlSessionTemplate.update("StudentsRecordMapper.proposalStudents", students);
	}

	@Override
	public void deleteStudentsRecord(int recordCode) throws Exception {
		sqlSessionTemplate.delete("StudentsRecordMapper.deleteStudentsRecord", recordCode);
	}

	@Override
	public List<Students> listProposalStudents(Search search, String teacherId) throws Exception {		
		search.setSearchId(teacherId);		
		return sqlSessionTemplate.selectList("StudentsRecordMapper.listProposalStudents", search);
		
	}
	@Override
	public int getProposalStudentsTotalCount(Search search, String teacherId) throws Exception {
		search.setSearchId(teacherId);
		return sqlSessionTemplate.selectOne("StudentsRecordMapper.getProposalStudentsTotalCount", search);
	}

	@Override
	public List<Students> listStudentsRecord(Search search, String teacherId) throws Exception {
		search.setSearchId(teacherId);
		System.out.println(search);
		return sqlSessionTemplate.selectList("StudentsRecordMapper.listStudentsRecord", search);
	}

	@Override
	public int getStudentsRecordTotalCount(Search search, String teacherId) throws Exception {
		search.setSearchId(teacherId);
		System.out.println(search);
		return sqlSessionTemplate.selectOne("StudentsRecordMapper.getStudentsRecordTotalCount", search);
	}
	
	@Override
	public List<Students> listStudentsRecordByStudent(Search search, String studentId) throws Exception{
		search.setSearchId(studentId);
		return sqlSessionTemplate.selectList("StudentsRecordMapper.listStudentsRecordByStudent", search);
	}
	
	@Override
	public int getStudentsRecordByStudentTotalCount(Search search, String studentId) throws Exception{
		search.setSearchId(studentId);
		return sqlSessionTemplate.selectOne("getStudentsRecordByStudentTotalCount", search);
	}

	@Override
	public void addStudentsAttendance(Students students) throws Exception {
		sqlSessionTemplate.insert("AttendanceMapper.addStudentsAttendance", students);
	}

	@Override
	public Students getStudentsAttendance(int attendanceCode) throws Exception {
		return sqlSessionTemplate.selectOne("AttendanceMapper.getStudentsAttendance", attendanceCode);
	}

	@Override
	public void updateStudentsAttendance(Students students) throws Exception {
		sqlSessionTemplate.update("AttendanceMapper.updateStudentsAttendance", students);
	}

	@Override
	public void deleteStudentsAttendance(int attendanceCode) throws Exception {
		sqlSessionTemplate.delete("AttendanceMapper.deleteStudentsAttendance", attendanceCode);
	}

	@Override
	public List<Students> listStudentsAttendance(Search search, String studentId, String lessonCode, String startMonth, String endMonth) throws Exception {
		search.setLessonCode(lessonCode);
		search.setSearchId(studentId);
		search.setSearchStartDate(startMonth);
		search.setSearchEndDate(endMonth);
		return sqlSessionTemplate.selectList("AttendanceMapper.listStudentsAttendance", search);
	}

	@Override
	public int getStudentsAttendanceTotalCount(Search search, String studentId, String lessonCode, String startMonth, String endMonth) throws Exception {	
		search.setLessonCode(lessonCode);
		search.setSearchId(studentId);
		search.setSearchStartDate(startMonth);
		search.setSearchEndDate(endMonth);
		return sqlSessionTemplate.selectOne("AttendanceMapper.getStudentsAttendanceTotalCount", search);
	}

	@Override
	public void addStudentsCharacter(Students students) throws Exception {
		sqlSessionTemplate.insert("CharacterMapper.addStudentsCharacter", students);
	}

	@Override
	public void updateStudentsCharacter(Students students) throws Exception {
		sqlSessionTemplate.update("CharacterMapper.updateStudentsCharacter", students);

	}

	@Override
	public void deleteStudentsCharacter(int characterCode) throws Exception {
		sqlSessionTemplate.delete("CharacterMapper.deleteStudentsCharacter", characterCode);

	}

	@Override
	public Students getStudentsCharacter(int characterCode) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("CharacterMapper.getStudentsCharacter", characterCode);
	}
	
	@Override
	public List<Students> listStudentsCharacter(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("CharacterMapper.listStudentsCharacter", search);
	}


	@Override
	public int getStudentsCharacterTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("CharacterMapper.getStudentsCharacterTotalCount",search);
	}
	
	@Override
	public int checkCharacterTotalCount(Search search) throws Exception {
		
		return sqlSessionTemplate.selectOne("CharacterMapper.checkCharacterTotalCount",search);
	}
	
	// exam =========================================
	@Override
	public void addStudentsExam(Students students) throws Exception {
		sqlSessionTemplate.insert("ExamMapper.addStudentsExam", students);
		
	}


	@Override
	public void updateStudentsExam(Students students) throws Exception {
		sqlSessionTemplate.update("ExamMapper.updateStudentsExam", students);
		
	}


	@Override
	public void deleteStudentsExam(int examCode) throws Exception {
		sqlSessionTemplate.delete("ExamMapper.deleteStudentsExam", examCode);
		
	}


	@Override
	public Students getStudentsExam(int examCode) throws Exception {
		return sqlSessionTemplate.selectOne("ExamMapper.getStudentsExam",examCode);
	}


	@Override
	public int getStudentsExamTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("ExamMapper.getStudentsExamTotalCount", search);
	}


	@Override
	public List<Students> listStudentsExam(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("ExamMapper.listStudentsExam", search);
	}
	
	@Override
	public List<Students> listStudentsExamByStudent(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("ExamMapper.listStudentsExamByStudent", search);
	}


	@Override
	public int getStudentsExamTotalCountByStudent(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("ExamMapper.getStudentsExamTotalCountByStudent", search);
	}
	
	//== NOTE ===================================================
	@Override
	public void addStudentsNote(Students students) throws Exception {
		sqlSessionTemplate.insert("StudentsNoteMapper.addStudentsNote", students);
	}


	@Override
	public Students getStudentsNote(int noteCode) throws Exception {
		return sqlSessionTemplate.selectOne("StudentsNoteMapper.getStudentsNote", noteCode);
	}


	@Override
	public void updateStudentsNote(Students students) throws Exception {
		sqlSessionTemplate.update("StudentsNoteMapper.updateStudentsNote", students);
	}


	@Override
	public void deleteStudentsNote(int noteCode) throws Exception {
		sqlSessionTemplate.delete("StudentsNoteMapper.deleteStudentsNote", noteCode);
	}


	@Override
	public List<Students> listStudentsNote(Search search, String studentId) throws Exception {
		search.setSearchId(studentId);
		return sqlSessionTemplate.selectList("StudentsNoteMapper.listStudentsNote", search);
	}


	@Override
	public int getStudentsNoteTotalCount(Search search, String studentId) throws Exception {
		search.setSearchId(studentId);
		return sqlSessionTemplate.selectOne("StudentsNoteMapper.getStudentsNoteTotalCount", search);
	}


	@Override
	public Students getCheckStudentsCharacter(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("CharacterMapper.getCheckStudentsCharacter",search);
	}
	
	@Override
	public List<Students> listStudentsRecordByLessonName(Search search, String lessonCode) throws Exception {
		search.setLessonCode(lessonCode);
		return sqlSessionTemplate.selectList("StudentsRecordMapper.listStudentsRecordByLessonName", search);
	}
	
	/*
	 * @Override public List<Students> listStudentsRecordDistinct(Search search,
	 * String teacherId) throws Exception { search.setSearchId(teacherId); return
	 * sqlSessionTemplate.selectList(
	 * "StudentsRecordMapper.listStudentsRecordDistinct", search); }
	 */








	
}
