package com.aza.web.paper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.aza.common.Page;
import com.aza.common.Search;
import com.aza.service.domain.Paper;
import com.aza.service.domain.User;
import com.aza.service.lesson.LessonService;
import com.aza.service.paper.PaperService;
import com.aza.service.students.StudentsService;
import com.aza.service.user.UserService;

@Controller
@CrossOrigin(origins="*", allowedHeaders="*")
@RequestMapping("/paper/*")
public class PaperController {
	
	@Autowired
	@Qualifier("paperServiceImpl")
	private PaperService paperService; 
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("studentsServiceImpl")
	private StudentsService studentsService;
	
	@Autowired
	@Qualifier("lessonServiceImpl")
	private LessonService lessonService;
	
	public PaperController() {
		System.out.println(this.getClass());
	}
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	//Quiz
	@RequestMapping(value="listPaperQuiz", method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView listPaperQuiz(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
		
		System.out.println("/paper/listPaperQuiz");
		
		String userId = ((User) session.getAttribute("user")).getUserId();
		
		User user = userService.getUser(userId);
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String,Object> map = new HashMap();
		System.out.println("====>=>=>"+user.getRole());
		
		if(user.getRole().equals("student") || user.getRole().equals("parent")) {
			map = paperService.listPaperQuizStudent(search, userId);
		}else if(user.getRole().equals("teacher")) {
			map = paperService.listPaperQuizTeacher(search, userId);
		}
		
		System.out.println("========================================================"+map.get("list"));
		System.out.println("========================================================"+(Integer)map.get("totalCount"));
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/paper/listPaperQuiz");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search",search);
		
		return modelAndView;
	}
	
	@RequestMapping(value="addPaperQuiz", method=RequestMethod.GET)
	public ModelAndView addPaperQuiz(HttpSession session, Search search) throws Exception {
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		
		System.out.println("/paper/addPaperQuiz : GET");
		
		User dbUser = userService.getUser(userId);
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = lessonService.listLessonTeacher(search, userId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		System.out.println("==============>>>>>>>>>>>>>>>"+userId);
		System.out.println("==============>>>>>>>>>>>>>>>"+map.get("list"));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/paper/addPaperQuiz");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search",search);
		
		return modelAndView;
	}
	
	@RequestMapping(value="addPaperQuiz", method=RequestMethod.POST)
	public ModelAndView addPaperQuiz(@ModelAttribute("paper") Paper paper, String questionContent, String teacherAnswer, String feedBackContent, String studentAnswer) throws Exception {

		
		List<Paper> questionList = new ArrayList<Paper>();
		
		System.out.println("/paper/addPaperQuiz : POST");
		
		System.out.println("===beforeAddPaperQuiz"+paper);
		
		paperService.addPaperQuiz(paper);
		System.out.println("===afterAddPaperQuiz"+paper);
		
		String[] q = questionContent.split(",");
		String[] t = teacherAnswer.split(",");
//		String[] s = studentAnswer.split(",");
//		String[] f = feedBackContent.split(",");
		for(int i=0; i<q.length; i++) {
			Paper p = new Paper();
			p.setQuizCode(paper.getQuizCode());
			p.setQuestionNo(i+1);
			p.setQuestionContent(q[i]);
			p.setTeacherAnswer(t[i]);
//			p.setStudentAnswer(s[i]);
//			p.setFeedBackContent(f[i]);
			questionList.add(p);
		}
		System.out.println("questionList=====>>>>=============>>>>>"+questionList);
		paperService.addPaperQuestion(questionList);
//		paperService.addPaperChoice(paper);
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/paper/listPaperQuiz");
		
		return modelAndView;
	}
	
	@RequestMapping(value="managePaperQuiz", method=RequestMethod.GET)
	public ModelAndView managePaperQuiz(@RequestParam("quizCode") int quizCode, HttpSession session, Search search) throws Exception {
		
		System.out.println("=+=+=+=+=+>>>>>>>>>>>"+((User) session.getAttribute("user")).getUserId());
		User dbUser = userService.getUser(((User) session.getAttribute("user")).getUserId());
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = lessonService.listLessonTeacher(search, ((User) session.getAttribute("user")).getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		System.out.println("==============>>>>>>>>>>>>>>>"+((User) session.getAttribute("user")).getUserId());
		System.out.println("==============>>>>>>>>>>>>>>>"+map.get("list"));
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		System.out.println("paper/managePaperQuiz : GET");
		
		Paper paper = paperService.getPaperQuiz(quizCode);
		
		Map<String,Object> mapQuestion = paperService.listPaperQuestion(quizCode);
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("paper/managePaperQuiz");
		modelAndView.addObject("paper", paper);
		modelAndView.addObject("user", dbUser);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("listQuestion", mapQuestion.get("listQuestion"));
		
		System.out.println("===="+paper);
		System.out.println("=============>>>>>>>>>>>>>>>>>>>>>>>>>>>"+map.get("list"));
		System.out.println("=============>>>>>>>>>>>>>>>>>>>>>>>>>>>"+mapQuestion.get("listQuestion"));
 
		return modelAndView;

	}
	
//	@RequestMapping(value="updatePaperQuiz", method=RequestMethod.POST)
//	public ModelAndView updatePaperQuiz(@ModelAttribute("paper") Paper paper) throws Exception {
//		
//		System.out.println("/paper/updatePaperQuiz : POST");
//		// Business Logic
//		paperService.updatePaperQuiz(paper);
//		//paperService.updatePaperQuestion(paper);
//		//paperService.updatePaperChoice(paper);
//		
//		System.out.println("=========>>>>>>>>>>"+paper);
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("redirect:/paper/managePaperQuiz?quizCode="+paper.getQuizCode());
//		
//		return modelAndView;
//						
//	}
	
	@RequestMapping(value="updatePaperQuiz", method=RequestMethod.POST)
	public ModelAndView updatePaperQuiz(@ModelAttribute("paper") Paper paper, String questionContent, String teacherAnswer, String feedBackContent, String studentAnswer) throws Exception {
		
		System.out.println("/paper/updatePaperQuiz : POST");
		
		List<Paper> updateQuestionList = new ArrayList<Paper>();	
		
		// Business Logic
		paperService.updatePaperQuiz(paper);
		
		System.out.println("===afterAddPaperQuiz"+paper);
		
		String[] q = questionContent.split(",");
		String[] t = teacherAnswer.split(",");
		String[] s = null;
		if(studentAnswer != null) {
			s = studentAnswer.split(",");
		}
		String[] f = null;
		if(feedBackContent != null) {
			f = feedBackContent.split(",");
		}
		
		for(int i=0; i<q.length; i++) {
			Paper p = new Paper();
			p.setQuizCode(paper.getQuizCode());
			p.setQuestionNo(i+1);
			p.setQuestionContent(q[i]);
			p.setTeacherAnswer(t[i]);
			updateQuestionList.add(p);
		}
		System.out.println("questionList=====>>>>=============>>>>>"+updateQuestionList);
		
		paperService.updatePaperQuestion(updateQuestionList);
		
		//paperService.updatePaperChoice(paper);
		
		System.out.println("=========>>>>>>>>>>"+paper);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/paper/managePaperQuiz?quizCode="+paper.getQuizCode());
		
		return modelAndView;
		
	}
	
//	@RequestMapping(value="updatePaperQuestion", method=RequestMethod.POST)
//	public ModelAndView updatePaperQuestion(@ModelAttribute("paper") Paper paper) throws Exception {
//		
//		System.out.println("/paper/updatePaperQuestion : POST");
//		// Business Logic
//		paperService.updatePaperQuestion(paper);
//		//paperService.updatePaperChoice(paper);
//		
//		System.out.println("=========>>>>>>>>>>"+paper);
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("redirect:/paper/managePaperQuiz?quizCode="+paper.getQuizCode());
//		
//		return modelAndView;
//						
//	}
	
	@RequestMapping(value="deletePaperQuiz")
	public ModelAndView deletePaperQuiz(@RequestParam("quizCode") int quizCode, int questionCode, int choiceCode, HttpSession session) throws Exception {
		
		System.out.println("/deletePaperQuiz");
		String studentId = ((User) session.getAttribute("user")).getUserId();
		
		paperService.deletePaperQuiz(quizCode);
		//paperService.deletePaperQuestion(questionCode);
		//paperService.deletePaperChoice(choiceCode);
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/paper/listPaperQuiz");
		
		return modelAndView;
	}
	
	
	//HOMEWORK
	@RequestMapping(value="listPaperHomework", method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView listPaperHomework(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
		
		System.out.println("/paper/listPaperHomework");
		
		String userId = ((User) session.getAttribute("user")).getUserId();
		
		User user = userService.getUser(userId);
		
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = new HashMap();
		System.out.println("====>=>=>"+user.getRole());
		
		if(user.getRole().equals("student")) {
			map = paperService.listPaperHomeworkByStudent(search, userId);
		}else if(user.getRole().equals("teacher")) {
			map = paperService.listPaperHomeworkByTeacher(search, userId);
		}else {
			map = paperService.listPaperHomeworkByParent(search, userId);
		}

		
		System.out.println("========================================================"+map.get("list"));
		System.out.println("========================================================"+(Integer)map.get("totalCount"));
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/paper/listPaperHomework");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search",search);
		
		return modelAndView;
	}
	
	@RequestMapping( value="addPaperHomework", method=RequestMethod.GET )
	public ModelAndView addPaperHomework(@ModelAttribute("search") Search search, HttpSession session) throws Exception{
	
		System.out.println("/paper/addPaperHomework : GET");
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		String userId = ((User)session.getAttribute("user")).getUserId();
		User dbUser = userService.getUser(((User) session.getAttribute("user")).getUserId());
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = lessonService.listLessonTeacher(search, userId);
		Map<String, Object> map2 = studentsService.listStudentsRecord(search, userId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		System.out.println("==============>>>>>>>>>>>>>>>"+userId);
		System.out.println("==============>>>>>>>>>>>>>>>"+map.get("list"));
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/paper/addPaperHomework");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("listStudents", map2.get("list"));
		modelAndView.addObject("user", dbUser);
		
		return modelAndView;
	}
	
	@RequestMapping(value="addPaperHomework", method=RequestMethod.POST)
	public ModelAndView addPaperHomework(@ModelAttribute("paper") Paper paper) throws Exception {
	
		System.out.println("/paper/addPaperHomework : POST");

		System.out.println("===>"+paper);
		paperService.addPaperHomework(paper);
		

		
		ModelAndView modelAndView = new ModelAndView();	
		modelAndView.setViewName("redirect:/paper/listPaperHomework");		

		return modelAndView;
	}
	
	@RequestMapping(value="updatePaperHomework", method=RequestMethod.POST)
	public ModelAndView updatePaperHomework(@ModelAttribute("paper") Paper paper) throws Exception {
		
		System.out.println("/paper/updatePaperHomework : POST");
		// Business Logic
		paperService.updatePaperHomework(paper);
		System.out.println("=========>>>>>>>>>>"+paper);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/paper/managePaperHomework?homeworkCode="+paper.getHomeworkCode());
		
		return modelAndView;
						
	}
	
	@RequestMapping(value="managePaperHomework", method=RequestMethod.GET)
	public ModelAndView managePaperHomework(@RequestParam("homeworkCode") int homeworkCode, HttpSession session, Search search) throws Exception {
		
		System.out.println("=+=+=+=+=+>>>>>>>>>>>"+((User) session.getAttribute("user")).getUserId());
		User dbUser = userService.getUser(((User) session.getAttribute("user")).getUserId());
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = lessonService.listLessonTeacher(search, ((User) session.getAttribute("user")).getUserId());
		Map<String, Object> map2 = studentsService.listStudentsRecord(search, ((User) session.getAttribute("user")).getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		System.out.println("==============>>>>>>>>>>>>>>>"+((User) session.getAttribute("user")).getUserId());
		System.out.println("==============>>>>>>>>>>>>>>>"+map.get("list"));
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		System.out.println("paper/managePaperHomework : GET");
		
		Paper paper = paperService.getPaperHomework(homeworkCode);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("paper/managePaperHomework");
		modelAndView.addObject("paper", paper);
		modelAndView.addObject("user", dbUser);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("listStudents", map2.get("list"));
		
		System.out.println("===="+paper);
 
		return modelAndView;

	}
	
	@RequestMapping(value="deletePaperHomework")
	public ModelAndView deletePaperHomework(@RequestParam("homeworkCode") int homeworkCode, HttpSession session) throws Exception {
		
		System.out.println("/deletePaperHomework");
		String studentId = ((User) session.getAttribute("user")).getUserId();
		
		paperService.deletePaperHomework(homeworkCode);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/paper/listPaperHomework");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updatePaperHomeworkCheck")
	public ModelAndView updatePaperHomeworkCheck(@RequestParam("homeworkCode") int homeworkCode) throws Exception {
		
		System.out.println("==updatePaperHomeworkCheck");
		
		paperService.updatePaperHomeworkCheck(homeworkCode);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/paper/managePaperHomework?homeworkCode="+homeworkCode);
		
		return modelAndView;
	}
	
}
