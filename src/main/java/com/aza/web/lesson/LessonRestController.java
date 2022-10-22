package com.aza.web.lesson;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.aza.common.Page;
import com.aza.common.Search;
import com.aza.service.book.BookService;
import com.aza.service.domain.Lesson;
import com.aza.service.domain.User;
import com.aza.service.lesson.LessonService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/lesson/rest/*")
public class LessonRestController {

   @Autowired
   @Qualifier("lessonServiceImpl")
   private LessonService lessonService;
   
   @Value("${pageUnit}")
   int pageUnit;
   
   @Value("${pageSize}")
   int pageSize;
   
   public LessonRestController() {
      // TODO Auto-generated constructor stub
      System.out.println(this.getClass());
   }
   
   @RequestMapping(value = "listLesson", method = RequestMethod.POST)
   @ResponseBody
   public Map<String, Object> listLesson(@ModelAttribute("search") Search search, HttpSession session) throws Exception{
      
      System.out.println("rest/listLesson -> 시작");
      String role = ((User)session.getAttribute("user")).getRole();
      
      if(role.equals("teacher")) {
         String teacherId = ((User) session.getAttribute("user")).getUserId();
         
         int totalCount = (int)lessonService.listLessonTeacher(search, teacherId).get("totalCount");
         System.out.println(totalCount);
         search.setCurrentPage(1);
         search.setPageSize(50);
         System.out.println("<===========");
         System.out.println(lessonService.listLessonTeacher(search, teacherId));
         System.out.println("===========>");
         
         session.setAttribute("role", role);
         
         return lessonService.listLessonTeacher(search, teacherId);
         
      } else if(role.equals("student")){
         String studentId = ((User)session.getAttribute("user")).getUserId();
         
         int totalCount = (int)lessonService.listLessonStudent(search, studentId).get("totalCount");
         search.setCurrentPage(1);
         search.setPageSize(50);
         
         session.setAttribute("role", role);
         return lessonService.listLessonStudent(search, studentId);
      } else {
         String parentId = ((User)session.getAttribute("user")).getUserId();
         
         int totalCount =(int)lessonService.listLessonParent(search, parentId).get("totalCount");
         search.setCurrentPage(1);
         search.setPageSize(50);
         
         session.setAttribute("role", role);
         return lessonService.listLessonParent(search, parentId);
      }
   }
   
   @RequestMapping(value="checkLessonCode/{lessonCode}")
   public boolean checkLessonCode(@PathVariable("lessonCode") String lessonCode) throws Exception {
      
      Lesson lesson = lessonService.getLesson(lessonCode);
      
      if (lesson == null) {
         return false;
      }
      return true;
   }
   //@RequestParam(required = false, value = "lessonCode") String lessonCode,
   @RequestMapping(value="addLessonBook", method=RequestMethod.POST)
   public ModelAndView addLessonBook(@RequestParam(required = false,value="lessonCode") String lessonCode, HttpServletRequest request) throws Exception{
      System.out.println("rest addLessonBook Controller 실행");
      ModelAndView model = new ModelAndView();
      String isbn = request.getParameter("isbn");
//      String lessonCode = request.getParameter("lessonCode");
      System.out.println("=========");
      System.out.println("isbn=> "+isbn);
      System.out.println("lessonCode=> "+lessonCode);
      System.out.println("=========");
      
      Lesson lesson = new Lesson();
      try {
         BookService crawler = new BookService();
         String url = URLEncoder.encode(isbn, "UTF-8");
         String response = crawler.search(url);
                  
         String[] fields = {"title","link","publisher","description","image","author","price","isbn","pubdate"};
         Map<String, Object> result = crawler.getResult(response, fields);
         
         if(result.size() >0)
            System.out.println("total->"+result.get("total"));
         
         List<Map<String,Object>> items = (List<Map<String, Object>>) result.get("result");
         
         for(Map<String,Object> item : items) {
            System.out.println("===============================");
            for(String field : fields) {
               System.out.println(field+"->"+item.get(field));
               if(field.equals("title")) {
                  lesson.setBookTitle(item.get(field));
               }
               if(field.equals("author")) {
                  lesson.setAuthor(item.get(field));
               }
               if(field.equals("price")) {
                  lesson.setBookPrice(item.get(field));
               }
//               if(field.equals("isbn")) {
//                  lesson.setIsbn(item.get(field));
//               }
               if(field.equals("publisher")) {
                  lesson.setPublisher(item.get(field));
               }
               if(field.equals("pubdate")) {
                  lesson.setBookYear(item.get(field));
               }
               if(field.equals("image")) {
                  lesson.setBookImg(item.get(field));
                }
               if(field.equals("pudate")) {
                  lesson.setBookYear(item.get(field));
               }
               lesson.setLessonCode(lessonCode);
               lesson.setIsbn(isbn);
            }
            System.out.println("==========");
            System.out.println(lesson);
               System.out.println("==========");
         }         
//         System.out.println(response);
      } catch (Exception e) {
         e.printStackTrace();
      }
      
      try {
         lessonService.addLessonBook(lesson);
      } catch (Exception e){
         System.out.println("<<<<<<<<>>>>>>>>");
         System.out.println("lesson_book 에 저장");
         lessonService.addSameLessonBook(lessonCode, isbn);
      }
      model.setViewName("redirect:/lesson/manageLessonBook");
      return model;
   }

   
   @RequestMapping(value= "manageLessonBook")
   @ResponseBody
   public Map<String, Object> manageLessonBook(HttpSession session) throws Exception{
      System.out.println("rest -> manageLessonBook 시작");
      User user = (User)session.getAttribute("user");
      String teacherId = user.getUserId();
      Search search = new Search();
      
      int totalCount = (int)lessonService.listLessonBook(search, teacherId).get("totalCount");
      search.setCurrentPage(1);
      search.setPageSize(totalCount);
      return lessonService.listLessonBook(search, teacherId);
   }
   
   
   
//   @RequestMapping(value="manageLessonBook")
//   public Map<String, Object> manageLessonBook(@ModelAttribute("search") Search search, HttpSession session) throws Exception{
//
//      //lesson code와 lessonName 가져와야함      
//      System.out.println("manageLessonBook실행");
//      if(search.getCurrentPage()==0) {
//         search.setCurrentPage(1);
//      }
//      search.setPageSize(pageSize);
////      String role = ((User) session.getAttribute("user")).getRole();
//            
//      String teacherId = ((User) session.getAttribute("user")).getUserId();
//      
//      Map<String, Object> lessonName = lessonService.listBookTeacher(teacherId);
//      
//      Map<String, Object> map = lessonService.listLessonBook(search, teacherId);
//      
//      Page resultPage = new Page(search.getCurrentPage(),
//            ((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);
//      
//      ModelAndView model = new ModelAndView();
//      model.setViewName("/lesson/manageLessonBook");
//      model.addObject("book",lessonName.get("book"));
//      model.addObject("list",map.get("list"));
//      model.addObject("resultPage",resultPage);
//      model.addObject("search",search);
//      System.out.println(model);
//
//      return null;
//   }

   @RequestMapping(value = "deleteLessonBook", method = RequestMethod.GET)
   public void deleteLessonBook(@RequestParam(value="isbn", required=false) String isbn, @RequestParam(value="lessonCode",required=false) String lessonCode, HttpServletRequest request) throws Exception{
      System.out.println("===========");
      System.out.println("deleteLessonBook restController");
      System.out.println("===========");
      String is = request.getParameter("isbn");
      System.out.println(is);
      System.out.println("===========");
//      String lessonCode = request.getParameter("lessonCode");
//      System.out.println(isbn);
      
      lessonService.deleteLessonBook(is, lessonCode);
   }
   
//   @RequestMapping(value = "deleteLessonBook")
//   public void deleteLessonBook(@RequestParam(value="isbn") String isbn) throws Exception{
//      System.out.println("===========");
//      System.out.println("deleteLessonBook restController");
//      System.out.println("===========");
//      
//      lessonService.deleteLessonBook(isbn);
//   }

   @RequestMapping("/listLessonTime")
   public List listLessonTime(HttpSession session, @RequestParam(required = false) String lessonDay) throws Exception{
      String teacherId = ((User) session.getAttribute("user")).getUserId();
      String day ="";
      switch(lessonDay){
         case "0": day = "일";
            break;
         case "1": day = "월";
            break;
         case "2": day = "화";
            break;
         case "3": day = "수";
            break;
         case "4": day = "목";
            break;
         case "5": day = "금";
            break;
         case "6": day = "토";
            break;
      }
      
      
      Map<String, Object> map = lessonService.listLessonTime(teacherId, day);
      
      return (List) map.get("list");

   }
}

      
      
      
      