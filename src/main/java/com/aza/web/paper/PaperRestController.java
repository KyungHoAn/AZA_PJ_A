package com.aza.web.paper;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.aza.common.Search;
import com.aza.service.domain.User;
import com.aza.service.lesson.LessonService;
import com.aza.service.paper.PaperService;
import com.aza.service.user.UserService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/paper/rest/*")
public class PaperRestController {
	
	   // field
	   @Autowired
	   @Qualifier("userServiceImpl")
	   private UserService userService;
	   
	   @Autowired
	   @Qualifier("paperServiceImpl")
	   private PaperService paperService;
	   
		@Autowired
		@Qualifier("lessonServiceImpl")
		private LessonService lessonService;
		
		@RequestMapping("listPaperQuiz")
		public Map<String, Object> listPaperQuiz(HttpSession session) throws Exception {
			
			Map result = null;
			System.out.println("/paper/rest/listPaperQuiz");
			
			User dbUser = (User) session.getAttribute("user");		
			String userId = dbUser.getUserId();
			
			User user = userService.getUser(userId);
			
			Search search = new Search();
			int totalCount;
			
			if(user.getRole().equals("student")) {
				totalCount = (int) paperService.listPaperQuizStudent(search, userId).get("totalCount");
				search.setCurrentPage(1);
				search.setPageSize(totalCount);
				
				result = paperService.listPaperQuizStudent(search, userId);
				
			}else if(user.getRole().equals("teacher")) {
				totalCount = (int) paperService.listPaperQuizTeacher(search, userId).get("totalCount");
				search.setCurrentPage(1);
				search.setPageSize(totalCount);
				
				result = paperService.listPaperQuizTeacher(search, userId);
			}
			
			return result;			
		}
		
		@RequestMapping("listPaperHomework")
		public Map<String, Object> listPaperHomework(HttpSession session) throws Exception {
			
			Map result = null;
			System.out.println("/paper/rest/listPaperHomework");
			
			User dbUser = (User) session.getAttribute("user");		
			String userId = dbUser.getUserId();
			
			User user = userService.getUser(userId);
			
			Search search = new Search();
			int totalCount;
			
			if(user.getRole().equals("student")) {
				totalCount = (int) paperService.listPaperHomeworkByStudent(search, userId).get("totalCount");
				search.setCurrentPage(1);
				search.setPageSize(totalCount);
				
				result = paperService.listPaperHomeworkByStudent(search, userId);
				
			}else if(user.getRole().equals("teacher")) {
				totalCount = (int) paperService.listPaperHomeworkByTeacher(search, userId).get("totalCount");
				search.setCurrentPage(1);
				search.setPageSize(totalCount);
				
				result = paperService.listPaperHomeworkByTeacher(search, userId);
			}else {
				totalCount = (int) paperService.listPaperHomeworkByParent(search, userId).get("totalCount");
				search.setCurrentPage(1);
				search.setPageSize(totalCount);
				
				result = paperService.listPaperHomeworkByParent(search, userId);
			}
			
			return result;			
		}
		
		@RequestMapping("listPaperHomeworkByLessonName")
		public Map<String, Object> listPaperHomeworkByLessonName(HttpSession session, @RequestParam(required = false, value = "lessonName") String lessonName) throws Exception {
			
			System.out.println("/students/rest/listStudentsRecord");
			
			User dbUser = (User) session.getAttribute("user");		
			String teacherId = dbUser.getUserId();
			Search search = new Search();
			search.setSearchId(dbUser.getUserId());
			search.setSearchLessonName(lessonName);
			
			
			return paperService.listPaperHomeworkByLessonName(search, dbUser.getUserId(), lessonName);			
		}
		
}
