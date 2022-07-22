package com.aza.service.alert;

import java.util.List;

import com.aza.common.Search;
import com.aza.service.domain.Alert;

public interface AlertDao {

	public void addAlert(Alert alert) throws Exception;
	
	public void addAlertAttendance(Alert alert) throws Exception;
	
	public void addAlertPayment() throws Exception;
	
	public Alert getAlert(int alertCode) throws Exception;
	
	public void readAlert(int alertCode) throws Exception;
	
	public void deleteAlert(int alertCode) throws Exception;
	
	public List<Alert> listAlert(Search search, String receiverId) throws Exception;
	
	public int getAlertTotalCount(Search search, String receiverId) throws Exception;

	public List<Alert> getAlertPayment(Search search, String receiverId) throws Exception;

	public List<Alert> getAlertByDate(Search search) throws Exception;
	
	public int alertCreateList(int alertCode)throws Exception;

}
