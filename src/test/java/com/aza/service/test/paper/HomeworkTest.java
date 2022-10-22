package com.aza.service.test.paper;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import com.aza.common.Search;
import com.aza.service.domain.Paper;
import com.aza.service.paper.PaperService;


//@RunWith(SpringRunner.class)
@SpringBootTest
//@WebAppConfiguration
public class HomeworkTest {
	
	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("paperServiceImpl")
	private PaperService paperService;
	
	//@Test
	public void testAddHomework() throws Exception {
		Paper paper = new Paper();
		
		paper.setStudentName("학생3");
		paper.setLessonName("비트고2 자바스크립트");
		paper.setHomeworkTitle("프로젝트");
		paper.setHomeworkContent("분석설계");
		paper.setHomeworkDueDate("2022/06/17");
		paper.setHomeworkCheck('0');
		
		System.out.println("==>"+paper);
		paperService.addPaperHomework(paper);
		
	}
	
	//@Test
	public  void testGetHomework() throws Exception {
		Paper paper = new Paper();
		paper.setHomeworkCode(1009);
		
		paperService.getPaperHomework(paper.getHomeworkCode());
	}
	
	//@Test
	public void testUpdateHomework() throws Exception {
		Paper paper = new Paper();
		
		paper.setHomeworkCode(1009);
		paper.setHomeworkTitle("미니프로젝트");
		paper.setHomeworkContent("분석설계");
		paper.setHomeworkDueDate("2022/06/08");

		paperService.updatePaperHomework(paper);
	}
	
	//@Test
	public void testUpdateHomeworkCheck() throws Exception {
		Paper paper = new Paper();
		
		paper.setHomeworkCode(1009);
		
		paperService.updatePaperHomeworkCheck(paper.getHomeworkCode());
	}
	
	//@Test
	public void testDeleteHomework() throws Exception {
		Paper paper = new Paper();
		paper.setHomeworkCode(1009);
		
		paperService.deletePaperHomework(paper.getHomeworkCode());
	}
	
	//@Test
	public void testListHomeworkByStudent() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3); 
		search.setSearchId("student3");
		
		Map<String,Object> map = paperService.listPaperHomeworkByStudent(search,search.getSearchId());
		
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
	
}
