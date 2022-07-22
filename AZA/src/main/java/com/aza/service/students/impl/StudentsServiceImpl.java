package com.aza.service.students.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.aza.common.Search;
import com.aza.service.alert.AlertService;
import com.aza.service.domain.Alert;
import com.aza.service.domain.Students;
import com.aza.service.domain.User;
import com.aza.service.students.StudentsDao;
import com.aza.service.students.StudentsService;
import com.aza.service.user.UserService;

@Service("studentsServiceImpl")
public class StudentsServiceImpl implements StudentsService {
	

	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;

	@Autowired
	@Qualifier("studentsDaoImpl")
	private StudentsDao studentsDao;

	@Autowired
	@Qualifier("alertServiceImpl")
	private AlertService alertService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	public StudentsServiceImpl() {
		System.out.println("[ "+this.getClass()+" ] :: start");
	}

	public void setStudentsDao(StudentsDao studentsDao) {
		this.studentsDao = studentsDao;
	}

	@Override
	public void addStudentsRecord(Students students) throws Exception {
		studentsDao.addStudentsRecord(students);
	}

	@Override
	public Students getStudentsRecord(int recordCode) throws Exception {
		return studentsDao.getStudentsRecord(recordCode);
	}

	@Override
	public void updateStudentsRecord(Students students) throws Exception {
		studentsDao.updateStudentsRecord(students);
	}

	@Override
	public void proposalStudents(int recordCode, char proposal) throws Exception {
		studentsDao.proposalStudents(recordCode, proposal);
	}

	@Override
	public void deleteStudentsRecord(int recordCode) throws Exception {
		studentsDao.deleteStudentsRecord(recordCode);
	}

	@Override
	public Map<String, Object> listProposalStudents(Search search, String teacherId) throws Exception {
		List<Students> list = studentsDao.listProposalStudents(search, teacherId);
		int totalCount = studentsDao.getProposalStudentsTotalCount(search, teacherId);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	@Override
	public Map<String, Object> listStudentsRecord(Search search, String teacherId) throws Exception {
		List<Students> list = studentsDao.listStudentsRecord(search, teacherId);
		int totalCount = studentsDao.getStudentsRecordTotalCount(search, teacherId);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));

		return map;
	}
	
	@Override
	public Map<String, Object> listStudentsRecordByStudent(Search search, String studentId) throws Exception {
		List<Students> list = studentsDao.listStudentsRecordByStudent(search, studentId);
		int totalCount = studentsDao.getStudentsRecordByStudentTotalCount(search, studentId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));

		return map;
	}
	
	@Override
	public Map<String, Object> listTotalStudentsRecord(Search search, String teacherId) throws Exception {
		
		List<Students> temp1 = studentsDao.listStudentsRecord(search, teacherId);
		List<Students> temp2 = studentsDao.listProposalStudents(search, teacherId);
		
		List<Students> totalList = new ArrayList<>();
		totalList.addAll(temp2);
		totalList.addAll(temp1);
		
		int totalCount = studentsDao.getProposalStudentsTotalCount(search, teacherId) + studentsDao.getStudentsRecordTotalCount(search, teacherId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", totalList );
		map.put("totalCount", new Integer(totalCount));
	
		return map;
	}
	
	

	@Override
	public void addStudentsAttendance(Students students) throws Exception {
		
		studentsDao.addStudentsAttendance(students);
		
		String attendanceState = students.getAttendanceState();
		String studentId = students.getStudentId();
		
		if(attendanceState.equals("Ãâ¼®")) {
			Search search = new Search();
			search.setCurrentPage(1);
			search.setPageSize(pageSize);
			
			List<User> parents = (List<User>) userService.listRelationByStudent(search, studentId).get("list");
			int totalCount = (int) userService.listRelationByStudent(search, studentId).get("totalCount");

			
			if(totalCount != 0) {
				for(User parent : parents) {
					Alert alert = new Alert();
					
					String parentId = parent.getUserId();
					System.out.println(parent);
					
					alert.setReceiverId(parentId);
					alert.setStudentId(studentId);
					alert.setLessonCode(students.getLessonCode());
					alert.setAlertContent(students.getAttendanceState());				
					alertService.addAlertAttendance(alert);
				}
			}
		}
	}

	@Override
	public Students getStudentsAttendance(int attendanceCode) throws Exception {
		return studentsDao.getStudentsAttendance(attendanceCode);
	}

	@Override
	public void updateStudentsAttendance(Students students) throws Exception {
		studentsDao.updateStudentsAttendance(students);

		String attendanceState = students.getAttendanceState();
		String studentId = students.getStudentId();
		
		if (attendanceState.equals("µµ¸Á") || attendanceState.equals("Á¶Åð") || attendanceState.equals("Ãâ¼®") ) {
			Search search = new Search();
			search.setCurrentPage(1);

			search.setPageSize(pageSize);
			
			List<User> parents = (List<User>) userService.listRelationByStudent(search, studentId).get("list");
			int totalCount = (int) userService.listRelationByStudent(search, studentId).get("totalCount");
			
			System.out.println(totalCount);
			
			if(totalCount > 0) {
				for(User parent : parents) {
					Alert alert = new Alert();
					
					String parentId = parent.getUserId();
					System.out.println(parent);
					
					alert.setReceiverId(parentId);
					alert.setStudentId(studentId);
					alert.setLessonCode(students.getLessonCode());
					alert.setAlertContent(students.getAttendanceState());				
					alertService.addAlertAttendance(alert);
				}
			}
		}
	}

	@Override
	public void deleteStudentsAttendance(int attendanceCode) throws Exception {
		studentsDao.deleteStudentsAttendance(attendanceCode);

	}

	@Override
	public Map<String, Object> listStudentsAttendance(Search search, String studentId, String lessonCode, String startMonth, String endMonth) throws Exception {
		List<Students> list = studentsDao.listStudentsAttendance(search, studentId, lessonCode, startMonth, endMonth);
		int totalCount = studentsDao.getStudentsAttendanceTotalCount(search, studentId, lessonCode, startMonth, endMonth);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));

		return map;
	}
	
	@Override
	public void addStudentsCharacter(Students students) throws Exception {
		studentsDao.addStudentsCharacter(students);

	}

	@Override
	public void updateStudentsCharacter(Students students) throws Exception {
		studentsDao.updateStudentsCharacter(students);

	}

	@Override
	public void deleteStudentsCharacter(int characterCode) throws Exception {
		studentsDao.deleteStudentsCharacter(characterCode);

	}

	@Override
	public Students getStudentsCharacter(int characterCode) throws Exception {
		// TODO Auto-generated method stub
		return studentsDao.getStudentsCharacter(characterCode);
	}
	
	@Override
	public Map<String, Object> listStudentsCharacter(Search search) throws Exception {
		List<Students> list = studentsDao.listStudentsCharacter(search);
		int totalCount = studentsDao.getStudentsCharacterTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public int checkCharacterTotalCount(Search search) throws Exception {

		return studentsDao.checkCharacterTotalCount(search);
	}

	@Override
	public void addStudentsExam(Students students) throws Exception {
		studentsDao.addStudentsExam(students);
		
	}

	@Override
	public void updateStudentsExam(Students students) throws Exception {
		studentsDao.updateStudentsExam(students);
		
	}

	@Override
	public void deleteStudentsExam(int examCode) throws Exception {
		// TODO Auto-generated method stub
		studentsDao.deleteStudentsExam(examCode);
		
	}

	@Override
	public Students getStudentsExam(int examCode) throws Exception {
		
		return studentsDao.getStudentsExam(examCode);
	}

	@Override
	public Map<String, Object> listStudentsExam(Search search) throws Exception {
	
		List<Students> list = studentsDao.listStudentsExam(search);
		int totalCount = studentsDao.getStudentsExamTotalCount(search);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public Map<String, Object> listStudentsExamByStudent(Search search) throws Exception {
		List<Students> list = studentsDao.listStudentsExamByStudent(search);
		int totalCount = studentsDao.getStudentsExamTotalCountByStudent(search);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	@Override
	public void addStudentsNote(Students students) throws Exception {
		studentsDao.addStudentsNote(students);
	}

	@Override
	public Students getStudentsNote(int noteCode) throws Exception {
		return studentsDao.getStudentsNote(noteCode);
	}

	@Override
	public void updateStudentsNote(Students students) throws Exception {
		studentsDao.updateStudentsNote(students);
	}

	@Override
	public void deleteStudentsNote(int noteCode) throws Exception {
		studentsDao.deleteStudentsNote(noteCode);
	}

	@Override
	public Map<String, Object> listStudentsNote(Search search, String studentId) throws Exception {
		List<Students> list = studentsDao.listStudentsNote(search, studentId);
		int totalCount = studentsDao.getStudentsNoteTotalCount(search, studentId);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("list",list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override
	public Students getCheckStudentsCharacter(Search search) throws Exception {
		// TODO Auto-generated method stub
		return studentsDao.getCheckStudentsCharacter(search);
	}
	
	@Override
	public Map<String, Object> listStudentsRecordByLessonName(Search search, String lessonCode) throws Exception {
		List<Students> list = studentsDao.listStudentsRecordByLessonName(search, lessonCode);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		return map;
	}
	
	/*
	 * @Override public Map<String, Object> listStudentsRecordDistinct(Search
	 * search, String teacherId) throws Exception { List<Students> list =
	 * studentsDao.listStudentsRecordDistinct(search, teacherId);
	 * 
	 * Map<String,Object> map = new HashMap<String,Object>(); map.put("list", list);
	 * 
	 * return map; }
	 */






}
