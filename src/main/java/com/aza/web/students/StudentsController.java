package com.aza.web.students;



import java.time.LocalDate;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.ModelAndView;

import com.aza.common.Page;
import com.aza.common.Search;
import com.aza.service.domain.Lesson;
import com.aza.service.domain.Payment;
import com.aza.service.domain.Students;
import com.aza.service.domain.User;
import com.aza.service.lesson.LessonService;
import com.aza.service.payment.PaymentService;
import com.aza.service.students.StudentsService;
import com.aza.service.user.UserService;


@Controller
@RequestMapping("/students/*")
public class StudentsController {

	@Autowired
	@Qualifier("studentsServiceImpl")
	private StudentsService studentsService;

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	@Autowired
	@Qualifier("lessonServiceImpl")
	private LessonService lessonService;

	@Autowired
	@Qualifier("paymentServiceImpl")
	private PaymentService paymentService;	
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	
	public StudentsController() {
		System.out.println(this.getClass());
	}

	// STUDENTS_RECORD
	@RequestMapping(value="listStudentsRecord",  method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView listStudentsRecord(@ModelAttribute("search") Search search, HttpSession session) throws Exception {

		System.out.println("/students/listStudentsRecord");

		String teacherId = ((User) session.getAttribute("user")).getUserId();

		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> listMap = studentsService.listStudentsRecord(search, teacherId);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)listMap.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		//  1 list
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/students/listStudentsRecord");
		mv.addObject("listStudentsRecord", listMap.get("list"));
		mv.addObject("resultPage", resultPage);
		mv.addObject("search", search);

		//  0 list
		search.setPageSize(50);	
		Map<String, Object> proposalMap = studentsService.listProposalStudents(search, teacherId);
		mv.addObject("listProposal", proposalMap.get("list"));

		return mv;			
	}

	@RequestMapping(value="/addStudentsRecord", method=RequestMethod.POST)
	public ModelAndView addStudentsRecord(@ModelAttribute("students") Students students, HttpSession session, @ModelAttribute("payment") Payment payment) throws Exception {

		System.out.println("/students/addStudentsRecord");

		User student = (User) session.getAttribute("user");
		String studentId = student.getUserId();

		students.setStudentId(studentId);
		
		String startDate = students.getLessonStartDate().replace("-", "/");
		students.setLessonStartDate(startDate);

		System.out.println(students);
		studentsService.addStudentsRecord(students);
		System.out.println("insert Code Test ==> "+students.getRecordCode());
		
		Students students2 = studentsService.getStudentsRecord(students.getRecordCode());
		System.out.println("students2 ?? => " + students2);
		payment.setStudentRecordNo(students2.getRecordCode());
		payment.setStudentId(studentId);
		payment.setCheckPay('N');	
		
		paymentService.addPayment(payment);
		System.out.println("add studentsRecord payment =>" + payment);
		ModelAndView mv = new ModelAndView();

		mv.setViewName("redirect:/");

		return mv;
	}

	@RequestMapping(value="updateStudentsRecord", method=RequestMethod.POST)
	public ModelAndView updateStudentsRecord(@ModelAttribute("students") Students students) throws Exception {

		System.out.println("/students/updateStudentsRecord");

		studentsService.updateStudentsRecord(students);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/students/getStudentsRecord/"+students.getRecordCode());

		return mv;
	}

	@RequestMapping(value="getStudentsRecord/{recordCode}", method=RequestMethod.GET)
	public ModelAndView getStudentsRecord(@PathVariable("recordCode") int recordCode) throws Exception {

		System.out.println("/students/getStudentsRecord");

		Students student = studentsService.getStudentsRecord(recordCode);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/students/getStudentsRecord");
		mv.addObject("student", student);

		return mv;
	}

	@RequestMapping(value="deleteStudentsRecord/{recordCode}")
	public ModelAndView deleteStudentsRecord(@PathVariable("recordCode") int recordCode) throws Exception {

		System.out.println("/students/deleteStudentsRecord");

		studentsService.deleteStudentsRecord(recordCode);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/students/listStudentsRecord");

		return mv;		
	}

	@RequestMapping(value="proposalStudents/{recordCode}/{proposal}")
	public ModelAndView proposalStudents(@PathVariable("recordCode") int recordCode, @PathVariable("proposal") char proposal) throws Exception {

		System.out.println("/students/proposalStudents");

		studentsService.proposalStudents(recordCode, proposal);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/students/listStudentsRecord");

		return mv;	
	}


	// ATTENDANCE 
	@RequestMapping("addStudentsAttendance")
	public ModelAndView addStudentsAttendance(@RequestBody Students students, ModelAndView mv) throws Exception {

		System.out.println("/students/addStudentsAttendance");

		studentsService.addStudentsAttendance(students);


		//ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/students/listStudentsAttendance");

		return mv;
	}

	@RequestMapping("updateStudentsAttendance")
	public ModelAndView updateStudentsAttendance(@RequestBody Students students, ModelAndView mv) throws Exception {

		System.out.println("/students/updateStudentsAttendance");

		studentsService.updateStudentsAttendance(students);

		//		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/students/listStudentsAttendance");

		return mv;
	}

	@RequestMapping("deleteStudentsAttendance")
	public ModelAndView deleteStudentsAttendance(@RequestParam("attendanceCode") int attendanceCode, ModelAndView mv) throws Exception {

		System.out.println("/students/deleteStudentsAttendance");

		studentsService.deleteStudentsAttendance(attendanceCode);

		//ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/students/listStudentsAttendance");

		return mv;
	}

	@RequestMapping("getStudentsAttendance")
	public Students getStudentsAttendance(@RequestParam("attendanceCode") int attendanceCode) throws Exception {

		System.out.println("/students/getStudentsAttendance");

		return studentsService.getStudentsAttendance(attendanceCode);
	}

	@RequestMapping("listStudentsAttendance")
	public ModelAndView listStudentsAttendance(@ModelAttribute("search") Search search, HttpSession session, @RequestParam(required = false) String studentId, @RequestParam(required = false) String lessonCode) throws Exception {

		System.out.println("/students/listStudentsAttendance");

		String searchStartDate = search.getSearchStartDate();
		String searchEndDate = search.getSearchEndDate();	

		System.out.println(search);

		if(search.getSearchStartDate() == null || search.getSearchStartDate().length() < 1) {
			LocalDate now = LocalDate.now();
			String prevMonth = Integer.toString(now.getMonthValue() - 1); 
			prevMonth = prevMonth.length() < 2 ? "0" + prevMonth : prevMonth;
			searchStartDate = now.format(DateTimeFormatter.ofPattern("yyyy/"+prevMonth+"/31"));
			searchEndDate = now.format(DateTimeFormatter.ofPattern("yyyy/MM/31"));			
		}


		String userId = ((User) session.getAttribute("user")).getUserId();

		System.out.println(userId);

		List students = (List) session.getAttribute("students");

		System.out.println("parent's studentList : "+ students);

		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		if(studentId==null || studentId.length() < 1) {
			studentId = ((User) students.get(0)).getFirstStudentId();			
		}

		List<User> studentsInfo = new ArrayList<User> ();

		for(int i = 0; i < students.size(); i++) { 
			String temp = ((User) students.get(i)).getFirstStudentId(); 
			User student = userService.getUser(temp);
			studentsInfo.add(student); 
		}

		User student = userService.getUser(studentId);

		System.out.println("student : "+student);

		search.setSearchId(studentId);
		List lessons = (List) studentsService.listStudentsRecordByStudent(search, studentId).get("list");

		//List<Lesson> lessons = (List<Lesson>) lessonService.listLessonStudent(search, studentId).get("list");

		if(lessonCode == null || lessonCode.length() < 1) {
			lessonCode = ((Students)lessons.get(0)).getLessonCode();
		}

		System.out.println("lessonCode : "+lessonCode);

		search.setCurrentPage(1);
		search.setPageSize(31);

		Map<String, Object> map = studentsService.listStudentsAttendance(search, studentId, lessonCode, searchStartDate, searchEndDate);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/students/listStudentsAttendance");
		mv.addObject("listStudentsRecord", map.get("list"));
		mv.addObject("resultPage", resultPage);
		mv.addObject("search", search);
		mv.addObject("studentInfo", studentsInfo);
		mv.addObject("lessons", lessons);

		return mv;			
	}

	//========================>Note
	
	//ÀÌ¹ÌÁö ¾÷·Îµå
	
	@RequestMapping( value="addStudentsNote", method=RequestMethod.GET )
	public ModelAndView addStudentsNote(HttpSession session) throws Exception{

		String userId = ((User)session.getAttribute("user")).getUserId();



		System.out.println("/students/addStudentsNote : GET");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/students/addStudentsNote2");

		return modelAndView;
	}

	@RequestMapping(value="addStudentsNote", method=RequestMethod.POST)
	public ModelAndView addStudentsNote(@ModelAttribute("students") Students students) throws Exception {

		System.out.println("/students/addStudentsNote : POST");

		studentsService.addStudentsNote(students);

		System.out.println("==="+students);
		ModelAndView modelAndView = new ModelAndView();	
		modelAndView.setViewName("redirect:/students/listStudentsNote");		

		return modelAndView;
	}
	
	@RequestMapping(value="updateStudentsNoteView", method=RequestMethod.POST)
	public ModelAndView updateStudentsNote(@RequestParam("noteCode") int noteCode, Students students, HttpSession session) throws Exception{
		
		System.out.println("/studentst/updateStudentsNote : GET");
		
		String studentsId = ((User) session.getAttribute("user")).getUserId();


		students= studentsService.getStudentsNote(noteCode);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/students/updateStudentsNote2");
		modelAndView.addObject("students", students);

		return modelAndView;		
		
	}

	@RequestMapping(value="updateStudentsNote", method=RequestMethod.POST)
	public ModelAndView updateStudentsNote(@ModelAttribute("students") Students students) throws Exception {

		System.out.println("/studentst/updateStudentsNote : POST");
		// Business Logic
		studentsService.updateStudentsNote(students);

		ModelAndView modelAndView = new ModelAndView();
		//		modelAndView.setViewName("redirect:/students/getStudentsNote?NoteCode="+students.getNoteCode());
		modelAndView.setViewName("redirect:/students/listStudentsNote");

		return modelAndView;

	}

	@RequestMapping(value="getStudentsNote", method=RequestMethod.GET)
	public ModelAndView getStudentsNote(@RequestParam("noteCode") int noteCode) throws Exception {

		System.out.println("students/getStudentsNote : GET");

		Students students = studentsService.getStudentsNote(noteCode);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("students/getStudentsNote");
		modelAndView.addObject("students", students);

		System.out.println("===="+students);

		return modelAndView;

	}

	@RequestMapping(value="deleteStudentsNote")
	public ModelAndView deleteStudentsNote(@RequestParam("noteCode") int noteCode, HttpSession session) throws Exception {

		System.out.println("/deleteStudentsNote");
		String studentId = ((User) session.getAttribute("user")).getUserId();

		studentsService.deleteStudentsNote(noteCode);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/students/listStudentsNote");

		return modelAndView;
	}

	@RequestMapping(value="listStudentsNote" ,method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView listStudentsNote(@ModelAttribute("search") Search search, HttpSession session) throws Exception {

		System.out.println("/students/listStudentsNote");

		String studentId = ((User) session.getAttribute("user")).getUserId();

		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> listMap = studentsService.listStudentsNote(search, studentId);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)listMap.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/students/listStudentsNote");
		mv.addObject("list", listMap.get("list"));
		mv.addObject("resultPage", resultPage);
		mv.addObject("search", search);		

		return mv;			
	}

	// CHARACTER testl===================================


	@RequestMapping(value="addStudentsCharacter", method=RequestMethod.GET)
	public ModelAndView addStudentsCharacter
	(ModelAndView mv, HttpSession session, @ModelAttribute("search") Search search) throws Exception {

		System.out.println("/students/addStudentsCharacter :: GET :: ï¿½Ü¼ï¿½ View");

		String teacherId = ((User) session.getAttribute("user")).getUserId();

		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> listMap = studentsService.listStudentsRecord(search, teacherId);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)listMap.get("totalCount")).intValue(), pageUnit, pageSize);

		mv.addObject("list", listMap.get("list"));
		mv.addObject("resultPage", resultPage);
		mv.addObject("search", search);

		mv.setViewName("/students/addStudentsCharacter");


		return mv;		
	}

	// character add!
	@RequestMapping(value="addStudentsCharacter", method=RequestMethod.POST)
	public ModelAndView addStudentsCharacter
	(@ModelAttribute("students") Students students, ModelAndView mv, 
			HttpSession session,@ModelAttribute("search") Search search,@ModelAttribute("userStudent") User user2) throws Exception {
		
		System.out.println("/students/addStudentsCharacter :: POST :: ");
		String teacherId = ((User) session.getAttribute("user")).getUserId();
		students.setTeacherId(teacherId);
		//ï¿½ß°ï¿½..
		students.setStudentId(user2.getUserId());
		
		studentsService.addStudentsCharacter(students);
		System.out.println("add CharacterCode ==> " + students.getCharacterCode());
		students = studentsService.getStudentsCharacter(students.getCharacterCode());
		mv.setViewName("/students/getStudentsCharacter");
		mv.addObject("students",students);
		search.setSearchId(teacherId);

		Map<String, Object> list = studentsService.listStudentsCharacter(search);
		System.out.println("update list ==>> " + list);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)list.get("totalCount")).intValue(), pageUnit, pageSize);

		mv.addObject("list", list.get("list"));
		mv.addObject("resultPage", resultPage);
		mv.addObject("search", search);

		return mv;
	}



	@RequestMapping(value="updateStudentsCharacterView", method=RequestMethod.POST)
	public ModelAndView updateStudentsCharacterView(@RequestParam("characterCode") int characterCode,Students students,ModelAndView mv,HttpSession session) throws Exception {

		
		System.out.println("/students/updateStudentsCharacterView :: GET :: VIEW");

		String teacherId = ((User) session.getAttribute("user")).getUserId();
		students.setTeacherId(teacherId);

		System.out.println("update characterCode => " + characterCode);

		students= studentsService.getStudentsCharacter(characterCode);

		mv.addObject("students",students);
		mv.setViewName("/students/updateStudentsCharacter");

		return mv;		
	}

	@RequestMapping(value="updateStudentsCharacter", method=RequestMethod.POST)
	public ModelAndView updateStudentsCharacter

	(@ModelAttribute("students") Students students,ModelAndView mv,HttpSession session,@ModelAttribute("search") Search search) throws Exception {

		System.out.println("/students/updateStudentsCharacter :: POST :: ");


		String teacherId = ((User) session.getAttribute("user")).getUserId();
		search.setSearchId(teacherId);

		Map<String, Object> list = studentsService.listStudentsCharacter(search);
		System.out.println("update list ==>> " + list);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)list.get("totalCount")).intValue(), pageUnit, pageSize);

		mv.addObject("list", list.get("list"));
		mv.addObject("resultPage", resultPage);
		mv.addObject("search", search);

		studentsService.updateStudentsCharacter(students);

		mv.addObject("students",students);	

		mv.setViewName("/students/getStudentsCharacter");

		return mv;		
	}

	@RequestMapping(value="deleteStudentsCharacter")
	public ModelAndView deleteStudentsCharacter(@RequestParam("characterCode") int characterCode, ModelAndView mv, HttpSession session) throws Exception {

		System.out.println("/students/deleteStudentsCharacter");
		String teacherId = ((User) session.getAttribute("user")).getUserId();
		Students students = new Students();
		students.setTeacherId(teacherId);


		System.out.println(characterCode);
		studentsService.deleteStudentsCharacter(characterCode);

		mv.setViewName("redirect:/students/addStudentsCharacter");

		return mv;		
	}



	@RequestMapping(value="getStudentsCharacter/{characterCode}")
	public ModelAndView getStudentCharacter
	(@PathVariable("characterCode") int characterCode, @RequestParam("studentId") String studentId, ModelAndView mv,@ModelAttribute("search") Search search, HttpSession session) throws Exception{

		System.out.println("getStudentsCharacter ... ");

		//List
		String teacherId = ((User) session.getAttribute("user")).getUserId();
		search.setSearchId(teacherId);
		Map<String, Object> listMap = studentsService.listStudentsCharacter(search);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)listMap.get("totalCount")).intValue(), pageUnit, pageSize);

		System.out.println("GET Code  ====>> " + characterCode);
		Students students = studentsService.getStudentsCharacter(characterCode);

		mv.addObject("students",students);		
		mv.addObject("list", listMap.get("list"));
		mv.addObject("resultPage", resultPage);
		mv.addObject("search", search);
		
		mv.setViewName("/students/getStudentsCharacter");

		return mv;
	}
	//========= Test ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ get, ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ insert view
	@RequestMapping(value = "getCheckStudentsCharacter")
	public ModelAndView getCheckStudentsCharacter
		(@ModelAttribute("search") Search search, Students students, ModelAndView mv, @RequestParam("studentId") String studentId, HttpSession session) throws Exception{
		String teacherId = ((User) session.getAttribute("user")).getUserId();
		search.setSearchId(teacherId);
		search.setSearchKeyword(studentId);
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("teacherId => " + teacherId + " / ");
		System.out.println("studentId => " + studentId);

		// empty character
		if(studentsService.checkCharacterTotalCount(search) < 1) {
			// add list
			Map<String, Object> listMap = studentsService.listStudentsRecord(search, teacherId);
			System.out.println("check search Keyword=> " + search.getSearchKeyword() + "teacherId => " + teacherId);
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)listMap.get("totalCount")).intValue(), pageUnit, pageSize);
			User userStudent = userService.getUser(studentId);
			mv.addObject("list", listMap.get("list"));
			mv.addObject("resultPage", resultPage);
			mv.addObject("search", search);
			mv.addObject("userStudent", userStudent);
			mv.setViewName("/students/addStudentsCharacter");
		}else {
			// !empty character
			students = studentsService.getCheckStudentsCharacter(search);
			// get list
			Map<String, Object> list = studentsService.listStudentsCharacter(search);
			System.out.println("update list ==>> " + list);
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)list.get("totalCount")).intValue(), pageUnit, pageSize);

			mv.addObject("list", list.get("list"));
			mv.addObject("resultPage", resultPage);
			mv.addObject("search", search);
			mv.addObject("students",students);
			System.out.println("student Character ==> " + students);
			mv.setViewName("/students/getStudentsCharacter");
		}
		
		return mv;
	}
//========================
	// Exam
	@RequestMapping(value={"manageStudentsExam", "manageStudentsExam/{studentId}"}, method= {RequestMethod.GET, RequestMethod.POST}) 
	public ModelAndView manageStudentsExam (HttpSession session, @PathVariable(value = "studentId", required = false) String kidId) throws Exception {
		
		System.out.println("/students/manageStudentsExam");
		
		User user = (User) session.getAttribute("user");
		String studentId = "";
		
		if(user.getRole().equals("parent")) {
			
			if(kidId == null || kidId.length() < 1) {				
				List students = (List) session.getAttribute("students");				
				studentId = ((User) students.get(0)).getFirstStudentId();						
			} else {
				studentId = kidId;
			}
			
		} else {
			
			studentId = user.getUserId();
			
		}
		
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/students/exam");
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(1);
		search.setSearchId(studentId);
		Map<String, Object> temp1 = studentsService.listStudentsExamByStudent(search);
		int totalCount = (int) temp1.get("totalCount");
		search.setPageSize(totalCount);
		
		Map<String, Object> temp2 = studentsService.listStudentsExamByStudent(search);
		List<Students> examList = (List<Students>) temp2.get("list");
		List<String> subjectList = new ArrayList<String>();
		for(Students data : examList) {
			String subject = data.getExamSubject();
			if(!subjectList.contains(subject)) {
				subjectList.add(subject);
			}
		}
		
		mv.addObject("subjectList", subjectList);
		
		return mv;
	}
	
	@RequestMapping(value="addStudentsExam")
	public ModelAndView addStudentsExam(HttpSession session, ModelAndView mv, @ModelAttribute Students student) throws Exception {
		
		System.out.println("/students/manageStudentsExam");
		System.out.println("mv : "+mv);
		
		User user = (User) session.getAttribute("user");
		String studentId = user.getUserId();
		
		student.setStudentId(studentId);
		
		System.out.println(student);
		studentsService.addStudentsExam(student);

		mv.setViewName("redirect:/students/manageStudentsExam");
		
		return mv;
	}
	
	@RequestMapping(value="updateStudentsExam")
	public ModelAndView updateStudentsExam(HttpSession session, ModelAndView mv, @ModelAttribute Students data) throws Exception {
		System.out.println("/students/updateStudentsExam");
		System.out.println("mv : "+mv);
		
		User user = (User) session.getAttribute("user");
		String studentId = user.getUserId();
		int examCode = data.getExamCode();
		int examScore = data.getExamScore();
		
		Students exam = studentsService.getStudentsExam(examCode);
		exam.setStudentId(studentId);
		exam.setExamScore(examScore);

		System.out.println("exam : "+ exam);
		
		studentsService.updateStudentsExam(exam);

		mv.setViewName("redirect:/students/manageStudentsExam");
		
		return mv;
	}
	
	@RequestMapping(value="deleteStudentsExam")
	public ModelAndView deleteStudentsExam(ModelAndView mv, @RequestParam("examCode") int examCode) throws Exception {
		
		System.out.println("/students/deleteStudentsExam");
		
		studentsService.deleteStudentsExam(examCode);

		mv.setViewName("redirect:/students/manageStudentsExam");
		
		return mv;
	}
	
	
}
