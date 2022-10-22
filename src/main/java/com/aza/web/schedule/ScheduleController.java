package com.aza.web.schedule;

import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aza.common.Page;
import com.aza.common.Search;
import com.aza.service.domain.Schedule;
import com.aza.service.domain.User;
import com.aza.service.lesson.LessonService;
import com.aza.service.user.UserService;


@Controller
@RequestMapping("/schedule/*")
public class ScheduleController {

	@Autowired
	@Qualifier("lessonServiceImpl")
	private LessonService lessonService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userservice;
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	public ScheduleController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value = "manageLessonSchedule")
	public ModelAndView manageLessonSchedule(@ModelAttribute("search") Search search, HttpSession session) throws Exception{
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);;
		String userRole = ((User)session.getAttribute("user")).getRole();
//		
//		ModelAndView model = new ModelAndView();
//		model.setViewName("/schedule/manageLessonSchedule");
//		return model;
		
		//CHOICE 생성 2022/06/25		
		if(userRole.equals("teacher")) {
			ModelAndView model = new ModelAndView();
			model.setViewName("/schedule/manageLessonSchedule");
			return model;
		} else if(userRole.equals("student")) {	
			String studentId = ((User)session.getAttribute("user")).getUserId();
			Map<String, Object> map = lessonService.listLessonSelectTeacher(search, studentId);
			System.out.println("===============");
			System.out.println(map);
			System.out.println("===============");
			Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);
			
			ModelAndView model = new ModelAndView();
			model.setViewName("/schedule/manageLessonSchedule");
			model.addObject("list",map.get("list"));
			model.addObject("resultPage",resultPage);
			model.addObject("search",search);
			
			return model;
		} else {
			String parentId = ((User)session.getAttribute("user")).getUserId();
			System.out.println("=-====-=-");
			System.out.println(parentId);
			System.out.println("=-====-=-");
//			Map<String, Object> map = lessonService.listLessonScheduleParent(search, parentId);
			Map<String, Object> map = userservice.listStudentRelationByParent(search, parentId);
			System.out.println("==============");
			System.out.println(map);
			System.out.println("==============");
			Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);
			ModelAndView model = new ModelAndView();
			
			model.setViewName("/schedule/manageLessonSchedule");
			model.addObject("list",map.get("list"));
			model.addObject("resultPage",resultPage);
			model.addObject("search",search);
			return model;
		}
	}
	
	@RequestMapping(value="addLessonSchedule", method=RequestMethod.POST)
	public ModelAndView addLessonSchedule(@ModelAttribute("search") Search search, HttpSession session, HttpServletRequest req) throws Exception{
		ModelAndView model = new ModelAndView();
		
		Schedule schedule = new Schedule();
		
		JSONObject json = new JSONObject();
		
		JSONParser parser = new JSONParser();
		
		String userId = ((User) session.getAttribute("user")).getUserId();
		System.out.println(userId);
		
		String[] alldata = req.getParameterValues("alldata");
		
		lessonService.deteteLessonScheduleAll(userId);
		for(int i=0; i<alldata.length; i++) {
//			Object obj = parser.parse(req.getParameterValues("alldata")[0]);
			Object obj = parser.parse(alldata[i]);
//			System.out.println(obj);
			JSONArray jsonA = (JSONArray) obj;
//			System.out.println(jsonA);
			
			for(int j=0; j<jsonA.size(); j++) {
				json = (JSONObject) jsonA.get(j);
				System.out.println(json);
				System.out.println("==============");
				String scheduleTitle = (String) json.get("title");
				String scheduleStartTime = (String) json.get("start");
				String scheduleEndTime = (String) json.get("end");
				
				schedule.setTeacherId(userId);
				schedule.setTitle(scheduleTitle);
				schedule.setStart(scheduleStartTime);
				schedule.setEnd(scheduleEndTime);
				lessonService.addLessonSchedule(schedule);
			}
		}
		model.setViewName("redirect:/schedule/manageLessonSchedule");
		return model;
	}
	
	@RequestMapping(value="getLessonSchedule")
	public ModelAndView getLessonSchedule(@RequestParam("scheduleCode") int scheduleCode) throws Exception{
		ModelAndView model  = new ModelAndView();
		Schedule schedule = lessonService.getLessonSchedule(scheduleCode);
		
		//json
		
		model.addObject("schedule", schedule);
		model.setViewName("/schedule/manageLessonSchedule");
		return model;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="listLessonSchedule", method=RequestMethod.POST)
	@ResponseBody
	public JSONObject listLessonSchedule(@ModelAttribute("search") Search search, HttpSession session, @RequestParam(required=false, value="teacherId") String teacherID) throws Exception{
		String role = ((User) session.getAttribute("user")).getRole();
		
		if(role.equals("teacher")) {
			String teacherId = ((User) session.getAttribute("user")).getUserId();
			
			Map<String, Object> map = lessonService.listLessonScheduleTeacher(search, teacherId);
			
			JSONObject json = new JSONObject();
			try {
				for(Map.Entry<String, Object> entry : map.entrySet()) {
					String key = entry.getKey();
					Object value = entry.getValue();
					
					json.put(key, value);
				}
			}catch(Exception e) {
				System.out.println("error");
			}
			System.out.println(json.toString());
			return json;
		}else if(role.equals("student")) {
			String studentId = ((User) session.getAttribute("user")).getUserId();
			
			Map<String, Object> map = lessonService.listLessonScheduleStudent(search, studentId);
			
			JSONObject json = new JSONObject();
			try {
				for(Map.Entry<String, Object> entry : map.entrySet()) {
					String key = entry.getKey();
					Object value = entry.getValue();
					
					json.put(key, value);
				}
			}catch(Exception e) {
				System.out.println("error");
			}
			System.out.println(json.toString());
			return json;
		} else {
			String parentId = ((User) session.getAttribute("user")).getUserId();
			
			Map<String, Object> map = lessonService.listLessonScheduleParent(search, parentId);
			
			JSONObject json = new JSONObject();
			try {
				for(Map.Entry<String, Object> entry : map.entrySet()) {
					String key = entry.getKey();
					Object value = entry.getValue();
					
					json.put(key, value);
				}
			}catch(Exception e) {
				System.out.println("error");
			}
			
			System.out.println(json.toString());
			return json;
		}
	}
}
