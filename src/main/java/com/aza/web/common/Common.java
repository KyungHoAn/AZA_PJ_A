package com.aza.web.common;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aza.service.domain.User;

@Controller
public class Common {

	public Common() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value={"/", "/index"})
	public @ResponseBody ModelAndView firstPageController(HttpSession session) {
		
		ModelAndView mv = new ModelAndView();
		User dbUser = new User();
		dbUser = (User) session.getAttribute("user");
		
		if(dbUser == null) {
			mv.setViewName("/login");
		} else {
		
			if(dbUser.getRole().equals("teacher")) {
				//rttr.setAttribute("user", dbUser);
				mv.setViewName("/index_teacher");
			}
			
			if(dbUser.getRole().equals("student")) {
				mv.setViewName("/index_student");
			}
		
			if(dbUser.getRole().equals("parent")) {
				mv.setViewName("/index_parent");
			}
		}
		return mv;
	}
	
	@RequestMapping("/home")
	public @ResponseBody ModelAndView homeController(HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		String role = user.getRole();
		
		ModelAndView mv = new ModelAndView();
		
		if(role.equals("teacher")) {
			mv.setViewName("/common/home_teacher");
		}
		
		if(role.equals("student")) {
			mv.setViewName("/common/home_student");
		}
		
		if(role.equals("parent")) {
			mv.setViewName("/common/home_parent");
		}

		return mv;
	}
	
	
	// 부모님 -> 자녀관리
	@RequestMapping("/parent/kids") 
	public ModelAndView parentKidsController(HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/common/sub_bar_parent");
		mv.addObject("user", user);
		
		return mv;
		
	}
	
	// 학생 -> 수업관리
	@RequestMapping("/student/lesson")
	public  ModelAndView studentLessonController(HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/common/sub_bar_student");
		mv.addObject("user", user);
		
		return mv;
	}
	
	// 선생님 -> 수업관리
	@RequestMapping("/teacher/manageLesson")
	public  ModelAndView teacherLessonController(HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/common/sub_bar_teacher_manageLesson");
		mv.addObject("user", user);
		
		return mv;
	}
	
	// 선생님 -> 학생관리
	@RequestMapping("/teacher/manageStudent")
	public  ModelAndView teacherStudentController(HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/common/sub_bar_teacher_manageStudent");
		mv.addObject("user", user);
		
		return mv;
	}
	
	
	
	
	

}
