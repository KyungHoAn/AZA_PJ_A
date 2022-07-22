package com.aza.service.payment.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.catalina.connector.Response;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.aza.common.Search;
import com.aza.service.domain.Payment;
import com.aza.service.payment.PaymentDao;
import com.aza.service.payment.PaymentService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import lombok.Getter;
import lombok.ToString;




@Service("paymentServiceImpl")
public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	@Qualifier("paymentDaoImpl")
	private PaymentDao paymentDao;

	private String impKey="1382659815177138";
	private String impSecret="b4ed387e2dddc2215f36f73dd4d5d629989345453969f937d7cec4792813c76ef9459616ca548ef3";
	
	@ToString
	@Getter
	private class Response{
		private PaymentInfo response;
	}
	
	@ToString
	@Getter
	private class PaymentInfo{
		private int amount;
	}
	

	
	public void setPaymentDao(PaymentDao paymentDao) {
		this.paymentDao = paymentDao;
	}
	
	public PaymentServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public Payment getPayment(int payCode) throws Exception {
		// TODO Auto-generated method stub
		return paymentDao.getPayment(payCode);
	}

	@Override
	public void updatePayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("payment update start...");
		paymentDao.updatePayment(payment);
		System.out.println("update 성공.");
	}

	@Override
	public void addPayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub
		paymentDao.addPayment(payment);
	}
	
	@Override
	public void deletePayment(int payCode) throws Exception {
		// TODO Auto-generated method stub
		paymentDao.deletePayment(payCode);
		
	}
	
	
	@Override
	public Map<String, Object> listPayment(Search search) throws Exception {
		List<Payment> list = paymentDao.listPayment(search);
		int totalCount = paymentDao.totalPaymentCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public Map<String, Object> listPaymentBystudent(Search search) throws Exception {
		
		List<Payment> list = paymentDao.listPaymentBystudent(search);
		int totalCount = paymentDao.totalPaymentCountBystudent(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public Map<String, Object> listPaymentByParent(Search search) throws Exception {
		List<Payment> list = paymentDao.listPaymentByParent(search);
		int totalCount = paymentDao.totalPaymentCountByParent(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

//======================================================================================
	
	@Override
	@Scheduled(cron="0 0 0 * * *") // 
	@Bean
	public void addPaymentProcedure() throws Exception {
		paymentDao.addPaymentProcedure();		
	}	
	
//======================================================================================	
// API method
	@Override
	public String getToken() throws IOException {
		HttpsURLConnection conn = null;
		 
		URL url = new URL("https://api.iamport.kr/users/getToken");

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		JsonObject json = new JsonObject();

		json.addProperty("imp_key", impKey);
		json.addProperty("imp_secret", impSecret);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		
		bw.write(json.toString());
		bw.flush();
		bw.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
		
		System.out.println(response);

		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
	}

	@Override
	public int paymentInfo(String imp_uid, String access_token) throws Exception{
		  HttpsURLConnection conn = null;
		  
		    URL url = new URL("https://api.iamport.kr/payments/" + imp_uid);
		 
		    conn = (HttpsURLConnection) url.openConnection();
		 
		    conn.setRequestMethod("GET");
		    conn.setRequestProperty("Authorization", access_token);
		    conn.setDoOutput(true);
		 
		    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		    
		    Gson gson = new Gson();
		    
		    Response response = gson.fromJson(br.readLine(), Response.class);
		    
		    br.close();
		    conn.disconnect();
		    
		    return response.getResponse().getAmount();
	}

	@Override
	public void paymentCancle(String access_token, String imp_uid, int amount, String reason) throws Exception{
		
		System.out.println("===== payMentCancle() Start ======");
//		System.out.println(access_token); //
//		System.out.println(imp_uid); //
		
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/payments/cancel");
 
		conn = (HttpsURLConnection) url.openConnection();
 
		conn.setRequestMethod("POST");
 
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", access_token);
 
		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();
 
		json.addProperty("reason", reason); // 결제 취소 사유
		json.addProperty("imp_uid", imp_uid); 
		json.addProperty("amount", amount); // 결제금액
		json.addProperty("checksum", amount); // 
		
		System.out.println("Cancle json => " + json);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 
		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
 
		br.close();
		conn.disconnect();		
	}





}
