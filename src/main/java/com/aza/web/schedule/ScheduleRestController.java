package com.aza.web.schedule;

import java.util.ArrayList;
import java.util.List;
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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.aza.common.Search;
import com.aza.service.domain.Schedule;
import com.aza.service.domain.User;
import com.aza.service.lesson.LessonService;

@CrossOrigin(origins="*", allowedHeaders="*")
@RestController
@RequestMapping("/schedule/rest/*")
public class ScheduleRestController {

	@Autowired
	@Qualifier("lessonServiceImpl")
	private LessonService lessonService;
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	public ScheduleRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="getSchedule/{scheduleCode}",method=RequestMethod.GET)
	public Schedule getSchedule(@PathVariable int scheduleCode) throws Exception{
		return lessonService.getLessonSchedule(scheduleCode);
	}
	
	@RequestMapping(value="addLessonSchedule", method=RequestMethod.POST)
	public Map<String, Object> addLessonSchedule(@ModelAttribute("search") Search search, Map<String,Object> result, HttpSession session, HttpServletRequest req) throws Exception{
		Schedule schedule = new Schedule();
		String userId = ((User) session.getAttribute("user")).getUserId();
		String scheduleContent = req.getParameter("content");
		String startTime = req.getParameter("startTime");
		String endTime = req.getParameter("endTime");
		String defId = req.getParameter("defId");
		
		try {
			schedule.setTeacherId(userId);
			schedule.setTitle(scheduleContent);
			schedule.setStart(startTime);
			schedule.setEnd(endTime);
			schedule.setScheduleStartDate(defId);
			lessonService.addLessonSchedule(schedule);
			result.put("success", true);
		} catch(Exception e) {
			result.put("success", false);
		}
		return result;
	}
	
	@PostMapping(value = "deleteSchedule")
	@ResponseBody
	public void deleteSchedule(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest req, HttpServletResponse res) throws Exception {
		try {
			String teacherId = ((User) session.getAttribute("user")).getUserId();
			map.put("teacherID", teacherId);
			lessonService.deleteLessonSchedule(map);
			map.put("success", true);
		} catch(Exception e) {
			map.put("success", false);
		}
	}
	
	
	@RequestMapping(value= "listLessonSchedule", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listLessonSchedule(@ModelAttribute("search") Search search,
			HttpSession session,
			@RequestParam(required=false, value="teacherId") String teacherID) throws Exception{
		
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
			return lessonService.listLessonScheduleTeacher(search, teacherId);
			
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
			return lessonService.listLessonScheduleStudent(search, studentId);
		} else {
			String parentId = ((User)session.getAttribute("user")).getUserId();
			//추가
			int totalCount = (int) lessonService.listLessonScheduleParent(search, parentId).get("totalCount");
			search.setCurrentPage(1);
			search.setPageSize(totalCount);
			
			Map<String, Object> map = lessonService.listLessonScheduleParent(search, parentId);
			
			JSONObject json = new JSONObject();
			try {
				for(Map.Entry<String, Object> entry:map.entrySet()) {
					String key = entry.getKey();
					Object value = entry.getValue();
					
					json.put(key, value);
				}
			}catch(Exception e) {
				System.out.println("schedule parent error");
			}
			return lessonService.listLessonScheduleParent(search, parentId);
		}
	}
}
