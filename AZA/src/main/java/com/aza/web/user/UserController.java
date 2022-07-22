package com.aza.web.user;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aza.common.Page;
import com.aza.common.Search;
import com.aza.service.domain.Lesson;
import com.aza.service.domain.User;
import com.aza.service.lesson.LessonService;
import com.aza.service.user.UserService;

@Controller
@CrossOrigin(origins="*", allowedHeaders="*")
@RequestMapping("/user/*")
public class UserController {

	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("lessonServiceImpl")
	private LessonService lessonService;

	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

		
	public UserController(){
		System.out.println(this.getClass());
	}
	
	
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public ModelAndView addUser() throws Exception{
		System.out.println("[Controller] => /user/addUser : GET");
		ModelAndView mv= new ModelAndView();
		mv.setViewName("/user/join");
		return mv;
	}
	
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public ModelAndView addUser( @ModelAttribute("user") User user) throws Exception{
		userService.addUser(user);
		System.out.println("[Controller] => /user/addUser : POST");
		return new ModelAndView("/login");
	}	

	@RequestMapping( value="/login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/login : GET");

		return "redirect:/login";
	}
	
	// test : login
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("user") User user , HttpSession session,HttpServletRequest request, RedirectAttributes rttr ) throws Exception{
		System.out.println("/user/login");
		ModelAndView mv= new ModelAndView();
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		System.out.println(dbUser);
		session = request.getSession();
		if(dbUser!=null && user.getUserId() != null){
			session.setAttribute("user", dbUser);
			
			if(!user.getPassword().equals(dbUser.getPassword())) {
				System.out.println("LOGIN NOPE!!!!!!!!!!!!!!");
				mv.addObject("msg","nope");
				return new ModelAndView("/login");
			}
			
			// teacher 
			if(dbUser.getRole().equals("teacher")) {
				//rttr.setAttribute("user", dbUser);
				mv.setViewName("redirect:/index");
			}
			
			// student 
			if(dbUser.getRole().equals("student")) {
				
				Search search = new Search();
				search.setPageSize(pageSize);
				search.setCurrentPage(1);
				
				List<Lesson> studentLessons = (List) lessonService.listSelectLessonName(search, dbUser.getUserId()).get("list");
				session.setAttribute("studentLessons", studentLessons);
				System.out.println("session check lesson"+session.getAttribute("studentLessons"));
				
				mv.setViewName("redirect:/index");
			}
			
			// parent 
			if(dbUser.getRole().equals("parent")) {
				
				//////////////////////////////////////부모 첫번째자녀 추가///////////////////////////
				User getFirstStudentIdByParent = userService.firstStudentIdByParent(dbUser.getUserId());
				/////////////////////////////////////////////////////////////////////////////////////////
				
				Search search = new Search();
				search.setPageSize(pageSize);
				search.setCurrentPage(1);
				List<User> students = (List) userService.listRelationByParent(search, dbUser.getUserId()).get("list");
				List<User> studentsInfo  = new ArrayList<User>();
				session.setAttribute("students", students);
				
				for(User student : students) {
					User studentInfo = userService.getUser(student.getFirstStudentId());
					studentsInfo.add(studentInfo);
				}
				/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				User parentFirstStudent = userService.getUser(getFirstStudentIdByParent.getFirstStudentId());
				/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				session.setAttribute("studentsInfo", studentsInfo);
				session.setAttribute("firstStudent", parentFirstStudent);
				mv.setViewName("redirect:/index");
			}
			System.out.println(session.getAttribute("user"));
			System.out.println("Login okokgoodgood");

			return mv; // 
		} else {
			System.out.println("LOGIN NOPE!!!!!!!!!!!!!!");
			return new ModelAndView("/login"); // 
		}
	
	}
	
	@RequestMapping( value="/logout", method=RequestMethod.GET )
	public ModelAndView logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
				
		return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value={"getUser"},method=RequestMethod.GET)
	public ModelAndView getUser (@ModelAttribute("search") Search search, HttpSession session,@RequestParam(required = false) String studentId) throws Exception{
		System.out.println("==========");
		System.out.println("getUser start.....");
		System.out.println("==========");
		
		ModelAndView model = new ModelAndView();
		String userId = ((User) session.getAttribute("user")).getUserId();
		search.setSearchId(userId);

		User user = userService.getUser(userId);
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);	 
		
		if(user.getRole().equals("parent")) {
			Map<String, Object> map = userService.listRelationByParent(search, userId);
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			
			model.addObject("list", map.get("list"));
			model.addObject("resultPage", resultPage);
			model.addObject("search", search);
			System.out.println(map.get("list"));
			System.out.println("parent");
			
			List students = (List) session.getAttribute("students");
			
			
			
			if(studentId==null || studentId.length() < 1) {
				studentId = ((User) students.get(0)).getFirstStudentId();			
			}
			
			List<User> studentsInfo = new ArrayList<User> ();

			for(int i = 0; i < students.size(); i++) { 
				String temp = ((User) students.get(i)).getFirstStudentId(); 
				User student = userService.getUser(temp);
				studentsInfo.add(student);
				
				
			}
			model.addObject("studentsInfo",studentsInfo);
			model.addObject("students",students);
			System.out.println("======students========="+students);
			System.out.println("======studentsInfo========="+studentsInfo);

		}	
		
		model.addObject("user", user);
		model.setViewName("/user/getUser");
		
		return model;
	}
	
	//
	@RequestMapping(value="getUserView", method=RequestMethod.POST)
	public ModelAndView updateUser(@ModelAttribute("User") User user) throws Exception {
		
		ModelAndView model = new ModelAndView();
		userService.updateUser(user);
		model.setViewName("redirect:/user/getUser?userId="+user.getUserId());
		return model;
	}
	
	//
	@RequestMapping(value="updateUser", method = RequestMethod.GET)
	public ModelAndView updateUser (@RequestParam("userId")String userId) throws Exception {
		ModelAndView model = new ModelAndView();
		User user = userService.getUser(userId);
		model.addObject("user",user);
		model.setViewName("/user/updateUser");
		return model;
	}
	
	@RequestMapping( value="quit", method=RequestMethod.GET )
	public String deleteUser() throws Exception{
		System.out.println("[Controller] => /user/deleteUser : GET");
		return "/user/quit";

	}
	
	@RequestMapping( value="quit", method=RequestMethod.POST )
	public ModelAndView deleteUser(@ModelAttribute("user") User user, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		User member = (User)session.getAttribute("user");
		ModelAndView mv = new ModelAndView();
		
		String dbpwd=member.getPassword();
		String pwd=user.getPassword();
		if(!(dbpwd.equals(pwd))) {
			rttr.addFlashAttribute("msg", false);
			mv.setViewName("/user/quit");
			return mv;
		}
		userService.deleteUser(user);
		session.invalidate();
		mv.setViewName("/login");

		System.out.println("[Controller] => delete okok");
		return mv;
		

	}
	
	@RequestMapping( value="addRelation", method=RequestMethod.GET )
	public ModelAndView addRelation() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();

		System.out.println("/user/addRelation : GET");
		
		//return "redirect:/user/addUserView.jsp";
		return modelAndView;
	}
	
	@RequestMapping( value="addRelation", method=RequestMethod.POST )
	public ModelAndView addRelation( @ModelAttribute("user") User user ) throws Exception{
		
		ModelAndView model = new ModelAndView();

		System.out.println("/user/addRelation : POST");
		userService.addRelation(user);
		model.addObject("user",user);
		
		return new ModelAndView("redirect:/user/getUser");

	}	
	
	@RequestMapping(value="getRelation",method=RequestMethod.GET)
	public ModelAndView getRelation (@RequestParam("relationCode")int relationCode) throws Exception{
		return new ModelAndView("/user/getRelation","user",userService.getRelation(relationCode));
	}


	@RequestMapping( value="updateRelation", method=RequestMethod.POST )
	public ModelAndView updateRelation(@RequestParam("currentPage") int currentPage,@RequestParam("relationCode")int relationCode) throws Exception{

		System.out.println("/user/updateRelation : POST");
		//Business Logic
		
		User user = userService.getRelation(relationCode);
		user.setRelationCode(relationCode);
		userService.updateRelation(user);
		
//		 relationCode = userService.getRelation(user.getRelationCode());
//		
//		if(user.getRelationCode()==relationCode.getRelationCode()){
//			session.setAttribute("user", relationCode);
//		}
		
		return new ModelAndView("redirect:/user/updateRelation?relationCode="+user.getRelationCode());
	}
	
	@RequestMapping(value="listRelation",method=RequestMethod.GET)
	public ModelAndView listRelation (@RequestParam("parentId")String parentId,HttpSession session) throws Exception{
		
		Search search = new Search();
		int totalCount = (int) userService.listRelation(search, parentId).get("totalCount");
		search.setCurrentPage(1);
		search.setPageSize(totalCount);
		
		return new ModelAndView("/user/listRelation","user",userService.listRelation(search, parentId));
	}

	// ID search start 1. page
		@RequestMapping(value="findId")
		public String findIdView() {
			System.out.println("ID gogogo");
			return "user/findId";
		}
		
		// ID Search 
		@RequestMapping(value="find_id", method=RequestMethod.POST)
		public String findIdAction(User vo, Model model) throws Exception {
			User user = userService.findId(vo);
			
			if(user == null) { 
				model.addAttribute("check", 1);
				System.out.println("ID NONO");
			} else { 
				model.addAttribute("check", 0);
				model.addAttribute("id", user.getUserId());
				System.out.println("ID YESYESYES");
			}
			System.out.println("come on ID");
			
			return "user/findId";
		}
		
		@RequestMapping(value="findPassword")
		public String findPasswordView() {
			System.out.println("FIND PASSWORD :3");
			return "user/findPassword";
		}
		
     
		@RequestMapping(value="find_password", method=RequestMethod.POST)

		public String findPasswordAction(User vo, Model model) throws Exception {
			User user = userService.findPassword(vo);
			
			if(user == null) { 
				model.addAttribute("check", 1);
				System.out.println("PASSWORD NONONONO");
			} else { 
				model.addAttribute("check", 0);
				model.addAttribute("updateid", user.getUserId());
				System.out.println("CHANGE PASSWORDDDDDDDD");
			}
			System.out.println("<<CHANGE PASSWORD>>");
			return "user/findPassword";
		}
		
		@RequestMapping(value="update_password", method=RequestMethod.POST)
		public String updatePasswordAction(@RequestParam(value="updateid", defaultValue="", required=false) String id,
											User vo) throws Exception {
			vo.setUserId(id);
			System.out.println(vo);
			userService.updatePassword(vo);
			System.out.println("updatePassword good :3");
			return "/login";
		}

}
