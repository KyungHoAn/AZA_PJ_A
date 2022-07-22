package com.aza.service.user.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.aza.common.Search;
import com.aza.service.domain.User;
import com.aza.service.user.UserDao;
import com.aza.service.user.UserService;


@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	
	///Field
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	///Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addUser(User user) throws Exception {

		String p = "parent";
		
		if(user.getRole().equals(p)) {
			userDao.addUserbyParent(user);
		} else {
			userDao.addUser(user);

		}
		
		System.out.println(user);
		
		
	//	userDao.addRelation(user);
	}

	@Override
	public User getUser(String userId) throws Exception {
		return userDao.getUser(userId);
	}

	@Override
	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}

	@Override
	public void deleteUser(User user) throws Exception {
		userDao.deleteUser(user);

	}

	@Override
	public int checkDuplication(String userId) throws Exception {
		int cnt = userDao.checkDuplication(userId);
		return cnt;
	}
	
	@Override
	public int checkStudent(String firstStudentId) throws Exception {
		int cnt = userDao.checkStudent(firstStudentId);
		return cnt;
	}

	@Override
	public void updateAlertState(User user) throws Exception {
		userDao.updateAlertState(user);
	}

	@Override
	public void updateStopAlertStartTime(User user) throws Exception {
		userDao.updateStopAlertStartTime(user);
	}

	@Override
	public void updateStopAlertEndTime(User user) throws Exception {
		userDao.updateStopAlertEndTime(user);
	}

	@Override
	public void addRelation(User user) throws Exception {
		userDao.addRelation(user);
	}

//	@Override
//	public void deleteRelation(String userId) throws Exception {
//		userDao.deleteRelation(userId);
//	}

	public void deleteRelation(int relationCode) throws Exception {
		userDao.deleteRelation(relationCode);
	}

//	@Override
//	public User getRelation(String firstStudentId, String parentId) throws Exception {
//		return userDao.getRelation(firstStudentId, parentId);
//	}
	
	@Override
	public User getRelation(int relationCode) throws Exception {
		return userDao.getRelation(relationCode);
	}

	@Override
	public void updateRelation(User user) throws Exception {
		userDao.updateRelation(user);
	}

	@Override
	public Map<String, Object> listRelationByStudent(Search search, String studentId) throws Exception {
		List<User> list = userDao.listRelationByStudent(search, studentId);

		int totalCount = userDao.getListRelationByStudentTotalCount(search, studentId);

		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		return map;
	}
	
	@Override
	public Map<String, Object> listRelationByParent(Search search, String parentId) throws Exception {
		List<User> list = userDao.listRelationByParent(search, parentId);
		int totalCount = userDao.getListRelationByParentTotalCount(search, parentId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public Map<String, Object> listStudentRelationByParent(Search search, String parentId) throws Exception {
		List<User> list = userDao.listStudentRelationByParent(search, parentId);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		return map;
	}
	
	public Map<String, Object> listRelation(Search search, String parentId) throws Exception {
		List<User> list = userDao.listRelation(search, parentId);
		int totalCount = userDao.getListRelationTotalCount(search, parentId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}



	@Override
	public void updateCheck(User user) throws Exception {
		userDao.updateCheck(user);
	}
	
	private static String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {
	    String space = " ";                    // one space
	    String newLine = "\n";                 // new line
	    

	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(url)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();

	    SecretKeySpec signingKey;
	    String encodeBase64String;
		try {
			
			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
		    encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			encodeBase64String = e.toString();
		}
	    

	  return encodeBase64String;
	}
	
	public void sendSMS(String phone,String message) {
		String hostNameUrl = "https://sens.apigw.ntruss.com";     		
		String requestUrl= "/sms/v2/services/";                   		
		String requestUrlType = "/messages";                      		
		String accessKey = "pCopjZ18V8WkJ8SWIYkw";                     	
		String secretKey = "mB2GFPQwS5lPvVJlvQMYq6U4NK974amLmg4E3VEt";  	
		String serviceId = "ncp:sms:kr:286287947040:aza";    						// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project >
		String method = "POST";											
		String timestamp = Long.toString(System.currentTimeMillis()); 	// current timestamp (epoch)
		requestUrl += serviceId + requestUrlType;
		//String apiUrl = hostNameUrl + requestUrl;
		String apiUrl = "https://sens.apigw.ntruss.com/sms/v2/services/ncp:sms:kr:286287947040:aza/messages";
		// JSON 
		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
	    JSONArray  toArr = new JSONArray();

	    //toJson.put("subject","");							
	    //toJson.put("content","sms test in spring 111");	
	    //toJson.put("to",phone);	
	    toJson.put("to",phone);						
	    toArr.add(toJson);
	    
	    bodyJson.put("type","SMS");							
	    //bodyJson.put("contentType","");					
	    //bodyJson.put("countryCode","82");					
	    bodyJson.put("from","01032030796");							
	    //bodyJson.put("subject","");						
	    bodyJson.put("content",message);	
	    bodyJson.put("messages", toArr);					
	    
	    //String body = bodyJson.toJSONString();
	    String body = bodyJson.toString();
	    
	    System.out.println(body);
	    
        try {
            URL url = new URL(apiUrl);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            
            wr.write(body.getBytes());
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" +" " + responseCode);
            if(responseCode == 202) { // 
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            
            System.out.println(response.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
	}

	
	
	@Override
	public int phoneAuth() throws Exception {
		Random random  = new Random();
		random.setSeed(System.currentTimeMillis());  	
    	int num = (random.nextInt(1000000) % 1000000);
    	return num;
		
	}

	@Override
	public User findId(User user) throws Exception {
		return userDao.findId(user);
	}

	@Override
	public User findPassword(User user) throws Exception {
		return userDao.findPassword(user);
	}

	@Override
	public void updatePassword(User user) throws Exception {
		userDao.updatePassword(user);
	}

	@Override
	public int confirmCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public User checkPhone(User user) throws Exception {
		return userDao.checkPhone(user);
		}
	
	@Override
	public User firstStudentIdByParent(String parentId) throws Exception {
		return userDao.firstStudentIdByParent(parentId);
	}
	
}