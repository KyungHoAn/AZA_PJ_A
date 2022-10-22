package com.aza.service.payment;

import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;

import com.aza.common.Search;
import com.aza.service.domain.Payment;

public interface PaymentDao {
	
	// SELECT
	public Payment getPayment(int payCode) throws Exception;
	
	// UPDATE
	public void updatePayment(Payment payment) throws Exception;
	
	// ADD
	public void addPayment(Payment payment) throws Exception;
	
	// DELETE
	public void deletePayment(int paycode) throws Exception;
	
	// LIST
	public List<Payment> listPayment(Search search) throws Exception;
	
	// auto add
	public void addPaymentProcedure() throws Exception;
	
	// totalCount
	public int totalPaymentCount(Search search) throws Exception;
	
	//studentList
	public List<Payment> listPaymentBystudent(Search search) throws Exception;
	public int totalPaymentCountBystudent(Search search) throws Exception;
	
	//parentList
	public List<Payment> listPaymentByParent(Search search) throws Exception;
	public int totalPaymentCountByParent(Search search) throws Exception;
	
}
