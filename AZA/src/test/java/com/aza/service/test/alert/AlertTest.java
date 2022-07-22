package com.aza.service.test.alert;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import com.aza.common.Search;
import com.aza.service.alert.AlertService;
import com.aza.service.domain.Alert;

@SpringBootTest
public class AlertTest {

	@Autowired
	@Qualifier("alertServiceImpl")
	private AlertService alertService;

//	@Test
	public void testGetAlert() throws Exception {

		Alert alert = new Alert();

		alert = alertService.getAlert(1044);

		System.out.println(alert);
	}

//	@Test
	public void testAddAlert() throws Exception {

		Alert alert = new Alert();

		alert.setReceiverId("student5");
		alert.setLessonCode("X1LXRV7M");
		alert.setAlertContent("수납일 7일전 입니다.");

		alertService.addAlert(alert);

	}

	//@Test :: 부모 다수일 경우 relation에서 부모 찾아서 ADDAELRT 써야함
	public void testAddAlertAttendance() throws Exception {

		Alert alert = new Alert();

		alert.setReceiverId("student11");
		alert.setLessonCode("ABCD1234");
		alert.setAlertContent("도망");

		alertService.addAlertAttendance(alert);
	
	}


	
//	@Test
	public void testReadAlert() throws Exception {
		
		alertService.readAlert(1044);
		
	}
	
//	@Test
	public void testDeleteAlert() throws Exception {
		
		alertService.deleteAlert(1045);
	}


	@Test
	public void testListAlert() throws Exception {
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String,Object> map = alertService.listAlert(search, "parent11");

		List<Object> list = (List<Object>)map.get("list");

		System.out.println(list);

		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}



}
