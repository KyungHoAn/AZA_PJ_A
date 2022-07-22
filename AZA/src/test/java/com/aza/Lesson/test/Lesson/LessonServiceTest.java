package com.aza.Lesson.test.Lesson;

import static org.junit.Assert.assertEquals;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import com.aza.common.Search;
import com.aza.service.domain.Book;
import com.aza.service.domain.Lesson;
import com.aza.service.domain.LessonBook;
import com.aza.service.domain.Schedule;
import com.aza.service.lesson.LessonService;
import com.aza.service.user.UserService;

//@RunWith(SpringRunner.class)
@SpringBootTest
public class LessonServiceTest {

	private static final int Object = 0;
	@Autowired
	@Qualifier("lessonServiceImpl")
	private LessonService lessonService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//ok
//	@Test
	public void testAddLesson() throws Exception{
		Lesson lesson = new Lesson();
		
//		lesson.setLessonCode("11111111");
		lesson.setTeacherId("teacher1");
		lesson.setLessonName("경호가 듣는 노래");
		lesson.setLessonPlace("bitcamp");
		lesson.setLessonDay("월화수목금");
		lesson.setLessonStartTime("10:50");
		lesson.setLessonEndTime("19:30");
		lesson.setSubject("경호");
		lesson.setFees(4500);
		
		lessonService.addLesson(lesson);
		
		//lesson = lessonService.getLesson("");
		System.out.println(lesson);
		System.out.println("============");
		
	}
	
	//OK
	//@Test
	public void testGetLesson() throws Exception{
		Lesson lesson = new Lesson();
		
		lesson = lessonService.getLesson("agho1216");
		
		System.out.println(lesson);
	}
	
	//ok
	//@Test
	public void updateLesson() throws Exception{
		Lesson lesson = new Lesson();
		lesson = lessonService.getLesson("QE8OWXXL");
//		lesson.setLessonCode("QE8OWXXL");
		lesson.setLessonName("WebSocket");
		lessonService.updateLesson(lesson);
		
		System.out.println(lesson);
//		Lesson lesson = lessonService.getLesson("QE8OWXXL");
//		
//		lesson.setLessonName("MongoDB");
//		
//		lessonService.updateLesson(lesson);
//		lesson = lessonService.getLesson("abcd1234");
//		System.out.println(lesson);	
		
	}
	
	//@Test
	public void deleteLesson() throws Exception{
		lessonService.deleteLesson("EDF43234");
	}
	
	//OK
	//@Test
	public void testlistLessonTeacher() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = lessonService.listLessonTeacher(search,"ho1112");
//		Map<String, Object> map = lessonService.listLesson(search,"student5");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
//		assertEquals(3, list.size());
		
		System.out.println(list);
				
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);	
	}	
	
	//OK
	@Test
	public void testlistLessonStudent() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = lessonService.listLessonStudent(search,"student01");
//		Map<String, Object> map = lessonService.listLesson(search,"student5");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
//		assertEquals(3, list.size());
		
		System.out.println(list);
				
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);	
	}
	
	//OK
	//@Test
	public void testlistLessonParent() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(9);
		Map<String, Object> map = lessonService.listLessonParent(search, "parent01");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
	//@Test
	public void testlessonNameselect() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(9);
		Map<String, Object> map = lessonService.listSelectLessonName(search, "student01");

		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		System.out.println(list);
	}

	//@Test
	public void testLessonTime() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(9);
		Map<String, Object> map = lessonService.listLessonTime("teacher51", "월");

		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
	//OK
	//@Test
	public void testaddLessonBook() throws Exception{
		Lesson lesson = new Lesson();
//		Book book = new Book();
		
		lesson.setIsbn("1");
		lesson.setBookTitle("lauv");
		lesson.setPublisher("pop");
		lesson.setBookPrice("90000");
		lesson.setAuthor("lauv");
		lesson.setBookYear("2020");
		lesson.setBookImg("2020");
		lesson.setLessonCode("agho1216");
		lessonService.addLessonBook(lesson);
	}
	
	//OK
	//@Test
	public void testlistLessonBook() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = lessonService.listLessonBook(search, "teacher51");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
//		assertEquals(3, list.size());
		
		System.out.println(list);
				
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);	
	}
	
	//@Test
	public void testListBookTeacher() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(8);
		Map<String, Object> map = lessonService.listLessonBook(search,"teacher51");
		
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("book");
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);	
	}
	
	//OK
	//@Test
	public void testListLessonBookStudent() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(9);
		Map<String, Object> map = lessonService.listLessonBookStudetns(search, "student01");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
	//@Test
	public void testListLessonBookParent() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(9);
		Map<String, Object> map = lessonService.listLessonBookParent(search, "parent01");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
	//OK
	//@Test
//	public void testDeleteLessonBook() throws Exception{
//		lessonService.deleteLessonBook("1");
//	}
	
	//OK
	//@Test
	public void testaddLessonSchedule() throws Exception{
		Schedule schedule = new Schedule();
		
		schedule.setTeacherId("teacher51");
		schedule.setStart("2022-06-10T04:00:00.000Z");
		schedule.setEnd("2022-06-14T04:00:00.000Z");
		schedule.setTitle("화이팅");
		
		System.out.println(schedule);
	}
		
	//OK
	//@Test
	public void testgetLessonSchedule() throws Exception{
		Schedule schedule = new Schedule();
		
		schedule = lessonService.getLessonSchedule(1002);		
		
		System.out.println(schedule);
	}
	
	//OK
	//@Test
	public void testupdateLessonSchedule() throws Exception{
		Schedule schedule = lessonService.getLessonSchedule(1021);
		System.out.println(schedule);
		schedule.setScheduleStartDate("2022/06/05");
		schedule.setScheduleContent("lany-all 4 Nothing!");
		
		lessonService.updateLessonSchedule(schedule);
	}
	
	//OK
	//@Test
	public void testDeleteLessonSchedule() throws Exception{
		lessonService.deleteLessonSchedule(1022);
	}

	
	//OK
	//@Test
	public void listLessonSchedule() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(8);
		Map<String, Object> map = lessonService.listLessonScheduleTeacher(search,"teacher51");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
//		assertEquals(3, list.size());
		
		System.out.println(list);
//				
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);	
	}
	
	//OK
	//@Test
	public void listLessonScheduleStudents() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(9);
		Map<String, Object> map = lessonService.listLessonScheduleStudent(search, "student01");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
	//OK
	//@Test
	public void listLessonScheduleParent() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(9);
		Map<String, Object> map = lessonService.listLessonScheduleParent(search, "parent01");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
	//@Test
	public void testlistSelectTesacher() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(8);
		Map<String, Object> map = lessonService.listLessonSelectTeacher(search, "student5");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
	//@Test
	public void testlistRelationByParent() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(8);
		Map<String, Object> map = userService.listStudentRelationByParent(search, "parent01");
		System.out.println(map);
		
		List<Object> list = (List<Object>)map.get("list");
		
		System.out.println(list);
	}
}
