package com.aza.service.payment;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.aza.common.Search;
import com.aza.service.domain.Payment;

public interface PaymentService {
	// SELECT
	public Payment getPayment(int payCode) throws Exception;
	
	// UPDATE
	public void updatePayment(Payment payment) throws Exception;
	
	// ADD
	public void addPayment(Payment payment) throws Exception;
	
	// DELETE
	public void deletePayment(int payCode) throws Exception;
	
	// LIST
	public Map<String, Object> listPayment(Search search) throws Exception;
	
	//students List
	public Map<String, Object> listPaymentBystudent(Search search) throws Exception;
	//parent List
	public Map<String, Object> listPaymentByParent(Search search) throws Exception;
	
	// auto add
	public void addPaymentProcedure() throws Exception;
	
	//
	public String getToken() throws IOException;
	
	public int paymentInfo(String imp_uid, String access_token) throws Exception;
	
	public void paymentCancle(String access_token, String imp_uid, int amount, String reason) throws Exception;
	
}
