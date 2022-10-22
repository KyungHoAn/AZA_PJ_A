package com.aza.service.message.impl;

import java.util.List;

import org.bson.types.ObjectId;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.MongoDatabaseFactory;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.DeleteMapping;

import com.aza.service.domain.Message;
import com.aza.service.students.StudentsDao;
import com.aza.service.students.StudentsService;
import com.aza.service.user.UserDao;
import com.aza.service.user.UserService;
import com.mongodb.client.MongoDatabase;

@Service("messageServiceImpl")
public class MessageServiceImpl {

	@Autowired
	private MongoTemplate mongoTemplate;

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;

	@Autowired
	@Qualifier("studentsServiceImpl")
	private StudentsService studentsService;

	@Autowired
	@Qualifier("studentsDaoImpl")
	private StudentsDao studentsDao;

	public MessageServiceImpl() {
		System.out.println(this.getClass());
	}
	
	public List getMessage(String userId, String otherId) throws Exception {
		System.out.println("getMessage : start");
		
		Criteria criteria = new Criteria();
		criteria.orOperator(Criteria.where("receiverId").is(userId).and("senderId").is(otherId), Criteria.where("senderId").is(userId).and("receiverId").is(otherId));
		Query qr = new Query(criteria);
		qr.with(Sort.by("messageCreateAt").ascending());
		
		List list = mongoTemplate.find(qr, Message.class);
		
		System.out.println(list + " :getmessageService list");
		
		return list;
	}

	public void addMessage(String receiverId, String senderId, String messageContent, String messageCreateAt)
			throws Exception {

		System.out.println("addMessage : start");

		Message message = new Message(receiverId, senderId, messageContent, messageCreateAt);
		mongoTemplate.insert(message);

		System.out.println(message);
	}

	public Message deleteMessage(String _id) throws Exception {
		
		System.out.println("delete"+_id);
		Criteria criteria = new Criteria("_id");
		criteria.is(new ObjectId(_id));
		Query qr = new Query(criteria);

		return mongoTemplate.findAndRemove(qr, Message.class);
	}


	public void readMessage(String receiverId, String senderId, String messageReadAt) throws Exception {

		Criteria criteria = Criteria.where("receiverId").is(receiverId).and("senderId").is(senderId)
				.and("messageReadAt").exists(false);
		Query qr = new Query(criteria);
		Update update = new Update();
		update.set("messageReadAt", messageReadAt);

		mongoTemplate.updateMulti(qr, update, "message");

	}

}
