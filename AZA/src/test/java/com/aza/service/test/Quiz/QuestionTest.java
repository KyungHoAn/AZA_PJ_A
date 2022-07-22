package com.aza.service.test.Quiz;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;



import com.aza.service.domain.Paper;
import com.aza.service.paper.PaperService;




@SpringBootTest
public class QuestionTest {
	@Autowired
	@Qualifier("paperServiceImpl")
	private PaperService paperService;
	

	//@Test
	public void testAddQuestion() throws Exception{
		Paper paper = new Paper();
		paper.setQuizCode(1000);
		paper.setQuestionNo(3);
		paper.setQuestionContent("123+321 =???");
		paper.setTeacherAnswer("444 입니다");
		paper.setAnswerCheck('0');
		
		System.out.println("==>> "+paper);
		
		paperService.addPaperQuestion(paper);
	}
	
	//@Test
	public void testGetQuestion() throws Exception {
		Paper paper = new Paper();
		paper.setQuestionCode(1000);
		
		paperService.getPaperQuestion(paper.getQuestionCode());
	}
	
	//@Test
	public void testUpdateQuestion() throws Exception {
		Paper paper = new Paper();
		paper.setQuestionContent("111+111 =???");
		paper.setTeacherAnswer("222입니다");
		paper.setStudentAnswer("333");
		paper.setAnswerCheck('0');
		paper.setFeedBackContent("틀렸습니다. 공부하세요");
		paper.setQuestionCode(1002);
		
		paperService.updatePaperQuestion(paper);
		
	}
	
	//@Test
	public void testDeleteQuestion() throws Exception {
		Paper paper = new Paper();
		paper.setQuestionCode(1002);
		
		paperService.deletePaperQuestion(paper.getQuestionCode());
	}
	
	//@Test
	public void testListPaperQuestion() throws Exception{
		Paper paper = new Paper();
		paper.setQuizCode(1000);
		
		paperService.listPaperQuestion(paper.getQuizCode());
	}
	
	//@Test
	public void testAddPaperChoice() throws Exception{
		Paper paper = new Paper();
		paper.setQuestionCode(1001);
		paper.setChoiceNo(1);
		paper.setChoiceContent("1");
		
		paperService.addPaperChoice(paper);
	}
	
	//@Test
	public void testGetPaperChoice() throws Exception{
		Paper paper = new Paper();
		paper.setChoiceCode(1007);
		
		paperService.getPaperChoice(paper.getChoiceCode());
	}
	
	//@Test
	public void testUpdatePaperChoice() throws Exception {
		Paper paper = new Paper();
		paper.setChoiceCode(1007);
		paper.setChoiceContent("333");
		
		paperService.updatePaperChoice(paper);
	}
	
	//@Test
	public void testDeletePaperChoice() throws Exception {
		Paper paper = new Paper();
		paper.setChoiceCode(1007);
		
		paperService.deletePaperChoice(paper.getChoiceCode());
	}
	
	//@Test
	public void testListPaperChoice() throws Exception {
		Paper paper = new Paper();
		paper.setQuestionCode(1000);
		
		paperService.listPaperChoice(paper.getQuestionCode());
	}
	
	

}
