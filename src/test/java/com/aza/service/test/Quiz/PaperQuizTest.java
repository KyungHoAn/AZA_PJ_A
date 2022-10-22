package com.aza.service.test.Quiz;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.stereotype.Service;

import com.aza.common.Search;
import com.aza.service.domain.Paper;
import com.aza.service.domain.User;
import com.aza.service.paper.PaperService;
import com.aza.service.user.UserService;



@SpringBootTest
public class PaperQuizTest {
	@Autowired
	@Qualifier("paperServiceImpl")
	private PaperService paperService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	//@Test // add test OK
	void testAddQuiz() throws Exception{
		Paper paper = new Paper();
		paper.setLessonName("bit1 java");
		paper.setStudentName("student3");
		paper.setQuizTitle("minuss3");
		
		
		System.out.println("==>> BeforeAddPaperQuiz"+paper);
		paperService.addPaperQuiz(paper);
		System.out.println("=======>>AfterAddPaperQuiz"+paper);
		
	}
	//@Test // get test OK
	void testGetQuiz() throws Exception{
		Paper paper = paperService.getPaperQuiz(1000);
		System.out.println(paper);
	}
	
	//@Test // update test OK
	void testUpdateQuiz() throws Exception{
		Paper paper = paperService.getPaperQuiz(1008);
		
		paper.setQuizSubmitDate("2022/06/08");
		paper.setQuizScore(50);
		
		paperService.updatePaperQuiz(paper);
		
	}
	//@Test // delete test OK
	void testDeleteQuiz() throws Exception{
		paperService.deletePaperQuiz(1008);
		
	}
	
	//  list
	//@Test // list Test OK // totalCount OK
//	void testListPaperQuizT() throws Exception{
//		Search search = new Search();
//		search.setCurrentPage(1);
//		search.setPageSize(3);	
//		search.setSearchKeyword("ABCD1234");
//		search.setSearchId("student22");
//		
//		User user = userService.getUser("teacher2");
//		System.out.println("role!! ==>> " + user.getRole());
//		if(user.getRole() != "teacher" ) {
//		search.setSearchCondition(user.getRole());
//		search.setSearchId("student22"); 
//		}else {
//			search.setSearchCondition(null);
//		}
//		
//		System.out.println("search ==> " + search);
//		
//		Map<String, Object> map = paperService.listPaperQuizTeacher(search);
//		List<Object> list = (List<Object>)map.get("list");
//		Integer totalCount = (Integer)map.get("totalCount");
//		System.out.println("Quiz TotalCount ====>> " + totalCount);
//		System.out.println("Quiz List ==>> " + list);
//		
//	}
//	
//	// list
//	//@Test
//	void testListPaperQuizS() throws Exception{
//		Search search = new Search();
//		search.setCurrentPage(1);
//		search.setPageSize(3);	
//		search.setSearchKeyword("ABCD1234");
//		search.setSearchId("student22");
//		
//		Map<String, Object> map = paperService.listPaperQuizStudent(search);
//		List<Object> list = (List<Object>)map.get("list");
//		Integer totalCount = (Integer)map.get("totalCount");
//		
//		System.out.println("Quiz list========== ");
//		System.out.println(" SearchId====>> " + search.getSearchId());
//		System.out.println("Quiz TotalCount ====>> " + totalCount);
//		System.out.println("Quiz List ==>> " + list);
//	}
	
	//=== ===================================================================
	//@Test
//	public void testAddQuestion() throws Exception{
//		Paper paper = new Paper();
//		paper.setQuizCode(1001);
//		paper.setQuestionNo(3);
//		paper.setQuestionContent("123+321 =???");
//		paper.setTeacherAnswer("list Test");
//		paper.setAnswerCheck('0');
//		
//		System.out.println("==>> "+paper);
//		
//		paperService.addPaperQuestion(paper);
//	}
	
	//@Test
	public void testGetQuestion() throws Exception {
		Paper paper = new Paper();
		paper.setQuestionCode(1000);
		
		paperService.getPaperQuestion(paper.getQuestionCode());
		System.out.println();
	}
	
	//@Test
	public void testUpdateQuestion() throws Exception {
		Paper paper = new Paper();
		paper.setQuestionContent("111+111 =???");
		paper.setTeacherAnswer("Test update");
		paper.setStudentAnswer("333");
		paper.setAnswerCheck('0');
		paper.setFeedBackContent("�����ϼ���");
		paper.setQuestionCode(1002);
		
		paperService.updatePaperQuestion(paper);
		
	}
	
	//@Test
	public void testDeleteQuestion() throws Exception {
		Paper paper = new Paper();
		paper.setQuestionCode(1002);
		
		paperService.deletePaperQuestion(paper.getQuestionCode());
	}
	
///	@Test
	public void testListPaperQuestion() throws Exception{
//		Paper paper = new Paper();
//		paper.setQuizCode(1000);

		Map<String, Object> map = paperService.listPaperQuestion(1001);
		List<Object> list = (List<Object>)map.get("list");
		System.out.println("Test list ==> " + list);
//		paperService.listPaperQuestion(paper.getQuizCode());
//		System.out.println(paper);
	}
	
	//@Test
	public void testAddPaperChoice() throws Exception{
		Paper paper = new Paper();
		paper.setQuestionCode(1001);
		paper.setChoiceNo(2);
		paper.setChoiceContent("2");
		
		paperService.addPaperChoice(paper);
	}
	
	//@Test
	public void testGetPaperChoice() throws Exception{
		Paper paper = new Paper();
		paper.setChoiceCode(1001);
		
		paperService.getPaperChoice(paper.getChoiceCode());
	}
	
	//@Test
	public void testUpdatePaperChoice() throws Exception {
		Paper paper = new Paper();
		paper.setChoiceCode(1001);
		paper.setChoiceContent("TEST update");
		
		paperService.updatePaperChoice(paper);
	}
	
	//@Test
	public void testDeletePaperChoice() throws Exception {
		Paper paper = new Paper();
		paper.setChoiceCode(1000);
		
		paperService.deletePaperChoice(paper.getChoiceCode());
	}
	
//	@Test
	public void testListPaperChoice() throws Exception {
//		Paper paper = new Paper();
//		paper.setQuestionCode(1001);
		
		Map<String, Object> map = paperService.listPaperChoice(1001);
		List<Object> list = (List<Object>)map.get("list");
		
//		paperService.listPaperChoice(paper.getQuestionCode());
		System.out.println("Test list ======= " + list);
	}
	
	//========================= HomeWork
	//@Test
	public void testAddHomework() throws Exception {
		Paper paper = new Paper();
		
		paper.setStudentId("student31");
		paper.setLessonCode("abcd1234");
		paper.setHomeworkTitle("Test01");
		paper.setHomeworkContent("test_content");
		paper.setHomeworkDueDate("2022/06/08");
		paper.setHomeworkCheck('0');
		
		System.out.println("HomeWork==>"+paper);
		paperService.addPaperHomework(paper);
		
	}
	
	//@Test
	public  void testGetHomework() throws Exception {
//		Paper paper = new Paper();
//		paper.setHomeworkCode(1004);
		
		
		Paper paper = paperService.getPaperHomework(1004);
		System.out.println("homework_test ==>"+paper.getHomeworkContent());
	}
	
	//@Test
	public void testUpdateHomework() throws Exception {
		Paper paper = new Paper();
		
		paper.setHomeworkCode(1004);
		paper.setHomeworkTitle("updateTest");
		paper.setHomeworkContent("updateTest");
		paper.setHomeworkDueDate("2022/06/10");

		paperService.updatePaperHomework(paper);
	}
	
	//@Test
	public void testUpdateHomeworkCheck() throws Exception {
		Paper paper = new Paper();
		
		paper.setHomeworkCode(1004);
		
		paperService.updatePaperHomeworkCheck(paper.getHomeworkCode());
	}
	
	//@Test
	public void testDeleteHomework() throws Exception {
		Paper paper = new Paper();
		paper.setHomeworkCode(1004);
		
		paperService.deletePaperHomework(paper.getHomeworkCode());
	}
	//@Test
	public void testListHomeworkByStudent() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3); 
		search.setSearchId("student31");
		search.setLessonCode("abcd1234");
		
		Map<String,Object> map = paperService.listPaperHomeworkByStudent(search, search.getSearchId());
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println("==========="+list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println("==="+totalCount);
	}
	
	//@Test
	public void testListHomeworkByTeacher() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3); 
		search.setLessonCode("abcd1234");
		
		Map<String,Object> map = paperService.listPaperHomeworkByTeacher(search, search.getLessonCode());
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println("==========="+list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println("==="+totalCount);
	}
	
	//================================================================
	//@Test
	void testAdd() throws Exception {
		
		Paper paper = new Paper();

	}
}
