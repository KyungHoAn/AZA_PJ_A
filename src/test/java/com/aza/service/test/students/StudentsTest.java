package com.aza.service.test.students;

import static org.junit.Assert.assertEquals;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import com.aza.common.Search;
import com.aza.service.alert.AlertService;
import com.aza.service.domain.Alert;
import com.aza.service.domain.Message;
import com.aza.service.domain.Students;
import com.aza.service.students.StudentsService;

@SpringBootTest
public class StudentsTest {

	@Autowired
	@Qualifier("studentsServiceImpl")
	private StudentsService studentsService;

	@Autowired
	@Qualifier("alertServiceImpl")
	private AlertService alertService;
	
	@Autowired
	private MongoTemplate mongoTemplate;
	

	

	//@Test
	public void testInsert() {
		Message message = new Message("teacher1","student12","test1","2022-06-09 19:44:44");
		mongoTemplate.insert(message);
		System.out.println(message);
	}
	
	//@Test
public void deleteMessage() throws Exception {
		
		Criteria criteria = new Criteria("_id");
		criteria.is("62a1b6a6ebde4458dade0781");

		Query qr = new Query(criteria);
		
		mongoTemplate.remove(qr, "message");
	}

	// STUDNETS_RECORD

	//	@Test :: get
	public void testGetStudentsRecord() throws Exception {

		Students students = new Students();

		students = studentsService.getStudentsRecord(1023);

		System.out.println(students);

	}


		@Test // :: add
	public void testAddStudentsRecord() throws Exception {

		Students students = new Students();

		//students.setLessonCode("KNODWC8X");
		students.setLessonCode("KNODWC8X");
		students.setStudentId("student11");
		students.setLessonStartDate("2022/06/08"); 
		students.setFees(10000);
		students.setPayDueDate("30");

		System.out.println(students);

		studentsService.addStudentsRecord(students);

	}


	//	@Test // :: update
	public void testUpdateStudentsRecord() throws Exception {

		Students students = studentsService.getStudentsRecord(1023);

		students.setPayDueDate("20");

		System.out.println(students);

		studentsService.updateStudentsRecord(students);

	}


	//	@Test // :: proposal
	public void testProposalStudents() throws Exception {

		studentsService.proposalStudents(1050, '1'); // ����

		System.out.println(studentsService.getStudentsRecord(1080));
	}


	//	@Test // :: delete
	public void testDeleteStudentsRecord() throws Exception {

		studentsService.deleteStudentsRecord(1040);

		System.out.println(studentsService.getStudentsRecord(1040));
	}


	//	@Test // :: listProposal (0 : ���� ��û��)
	public void testListProposalStudents() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(1);
		Map<String,Object> map = studentsService.listProposalStudents(search, "teacher1");

		List<Object> list = (List<Object>)map.get("list");

		System.out.println(list);

		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);

	}


//	@Test // :: listProposal (1 : ���� ��û�Ϸ�)
	public void testListStudentsRecord() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(1);
		
		System.out.println("search"+search);
		
		Map<String,Object> map = studentsService.listStudentsRecord(search, "teacher1");

		List<Object> list = (List<Object>)map.get("list");

		System.out.println(list);

		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);

	}


	///////////////////////////////////////////////////////////////////////
	// ATTENDANCE

	//	@Test
	public void testGetStudentsAttendance() throws Exception {

		Students students = new Students();

		students = studentsService.getStudentsAttendance(1020);

		System.out.println(students);

	}

		@Test
	public void testAddStudentsAttendance() throws Exception {

		Students students = new Students();
		students.setStudentId("student11");
		students.setLessonCode("KNODWC8X");
		students.setAttendanceDate("20220610");
		students.setAttendanceState("도망");

		System.out.println(students);

		studentsService.addStudentsAttendance(students);

	}

//	@Test
	public void testUpdateStudentsAttendance() throws Exception {

		Students students = studentsService.getStudentsAttendance(1065);
		
		System.out.println("test :"+students);
		
		
		studentsService.updateStudentsAttendance(students);

		System.out.println(studentsService.getStudentsAttendance(1065));

	}


	//	@Test
	public void testDeleteStudentsAttendance() throws Exception {

		studentsService.deleteStudentsAttendance(1023);

	}


//		@Test
	public void testListStudentsAttendance() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String,Object> map = studentsService.listStudentsAttendance(search, "student11", "ABCD1234", "2022/06/03", "2022/06/05");

		// between and => �ʰ� ~ ����

		List<Object> list = (List<Object>)map.get("list");

		System.out.println(list);

		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);


	}
	
	////////////////////////////////////////////////////////
	// NOTE
//	@Test
		public void testAddStudentsNote() throws Exception {
			
			Students students = new Students();
			
			students.setStudentId("student11");
			students.setNoteTitle("123");
			students.setNoteContent("�̺е� ��ư� ���е� ��ƴ�");
			
			studentsService.addStudentsNote(students);
			System.out.println(students);

		}
		
		

//		@Test
		public void testGetStudentsNote() throws Exception {
			
			Students students = new Students();
			
			students = studentsService.getStudentsNote(1002);
			
			System.out.println(students);
			
		}
		
//		@Test
		public void testUpdateStudentsNote() throws Exception {
			
			Students students = new Students();
			
			students.setNoteTitle("�̺а�����");
			students.setNoteContent("�޷�");
			students.setNoteCode(1002);
			
			studentsService.updateStudentsNote(students);
		}
		
//		@Test
		public void testGetStudentsNoteListByStudentId() throws Exception {
			
			Search search = new Search();
			search.setCurrentPage(1);
			search.setPageSize(2);
			search.setSearchId("student11");
			
			Map<String,Object> map = studentsService.listStudentsNote(search, search.getSearchId());
			
			List<Object> list = (List<Object>)map.get("list");
			
			System.out.println(list);
			
			Integer totalCount = (Integer)map.get("totalCount");
			System.out.println(totalCount);
			
			
		}
		
/////////////////////////////
// Character
//		 @Test //get Test OK
		public void testGetCharacter() throws Exception{
			
			Students students = new Students();
			
			students = studentsService.getStudentsCharacter(1000);
			//Assert.assertEquals("student21", students.getStudentId());
			System.out.println(students);
			
		}
		
//		@Test // add Test OK
		public void testAddCharacter() throws Exception{
			
			Students students = new Students();
			students.setStudentId("studetns11");
			students.setTeacherId("teacher1");
			students.setCharacterContent("Test_Content!!");
			
			studentsService.addStudentsCharacter(students);
			System.out.println(students);
			
		}
		
		//@Test //update test OK
		public void testUpdateCharacter() throws Exception{
			
			
			  Students stu = new Students(); 
			  stu.setCharacterCode(1000);
			  stu.setCharacterContent("Update Test===");
			  
			  studentsService.updateStudentsCharacter(stu);	
		}
		
		//@Test // delete Test OK
		public void testDeleteCharacter() throws Exception{
					
			studentsService.deleteStudentsCharacter(1000);
		}
		
/////////////////////////////////////////
// EXAM
		//@Test // get Test Ok
		public void testGetExam() throws Exception{
			
			Students stu = new Students();
			
			stu = studentsService.getStudentsExam(1002);
			System.out.println("Test ===========>>>> " + stu);
			
			
		}
		
		//@Test // add test Ok
		public void testAddExam() throws Exception{
			
			Students stu = new Students();
			stu.setStudentId("students21");
			stu.setExamYear("1111");
			stu.setExamSemester("2");
			stu.setExamTerm("2");
			stu.setExamSubject("�׽�Ʈ");
			stu.setExamScore(50);
			
			studentsService.addStudentsExam(stu);
			System.out.println(stu);
			
		}
		
		//@Test //update Test Ok
		public void testUpdateExam() throws Exception{
			
			Students stu = studentsService.getStudentsExam(1000);
			System.out.println("Code : 1000 Exam ==>> " + stu);
			stu.setExamSubject("!..update �׽�Ʈ..!");
			stu.setExamScore(50);
			
			studentsService.updateStudentsExam(stu);
			
		}
		//@Test // delete Test Ok
		public void testDeleteExam() throws Exception{
			
			studentsService.deleteStudentsExam(1000);
		}
		
	//	@Test
		public void testListExam() throws Exception{
			
			Search search = new Search();
			search.setCurrentPage(1);
			search.setPageSize(3);	
			search.setSearchId("student21");	
			search.setSearchKeyword("수학");	
			
			
			System.out.println("����=====================");
			
			Map<String, Object> map = studentsService.listStudentsExam(search);
			System.out.println("listExam map ===> " + map);
			
			List<Object> list = (List<Object>)map.get("list");
			assertEquals(1,list.size());
			System.out.println("listExam check ===> " + list);
			
			System.out.println("listExam ====>> "+list);
			
			Integer totalCount = (Integer)map.get("totalCount");
			System.out.println("listExam TotalCount ====>> " + totalCount);
			System.out.println("listExam 서치 ====>> " + search);
			
		}

}
