package com.aza.service.alert.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.aza.common.Search;
import com.aza.service.alert.AlertDao;
import com.aza.service.alert.AlertService;
import com.aza.service.domain.Alert;

@Service("alertServiceImpl")
public class AlertServiceImpl implements AlertService {

	@Autowired
	@Qualifier("alertDaoImpl")
	private AlertDao alertDao;
	
	public AlertServiceImpl() {
		System.out.println("[ "+this.getClass()+" ] :: start");
	}
	
	public void setAlertDao(AlertDao alertDao) {
		this.alertDao = alertDao;
	}
	
	@Override
	public void addAlert(Alert alert) throws Exception {
		alertDao.addAlert(alert);
	}
	
	@Override
	public void addAlertAttendance(Alert alert) throws Exception {
		alertDao.addAlertAttendance(alert);
	}
	
	@Override
	@Scheduled(cron="0 0 0 * * *") // 매일 00시 마다 실행
	@Bean
	public void addAlertPayment() throws Exception {
		alertDao.addAlertPayment();
		System.out.println("돌아가라 수납알림");
	}

	@Override
	public Alert getAlert(int alertCode) throws Exception {
		return alertDao.getAlert(alertCode);
	}

	@Override
	public void readAlert(int alertCode) throws Exception {
		alertDao.readAlert(alertCode);
	}

	@Override
	public void deleteAlert(int alertCode) throws Exception {
		alertDao.deleteAlert(alertCode);
	}

	@Override
	public Map<String, Object> listAlert(Search search, String receiverId) throws Exception {
		search.setSearchId(receiverId);
		
		
		List<Alert> list = alertDao.listAlert(search, receiverId);
		int totalCount = alertDao.getAlertTotalCount(search, receiverId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public List<Alert> getAlertPayment(Search search,String receiverId)throws Exception {
		return alertDao.getAlertPayment(search,receiverId);
	}
	
	
	
	@Override
	public List<Alert> getAlertByDate(Search search)throws Exception{
		return alertDao.getAlertByDate(search);
		
	}
	
	public int alertCreateList(int alertCode)throws Exception{
		return alertDao.alertCreateList(alertCode);
		
		
	}

}
