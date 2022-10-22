package com.aza.web.message;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import com.aza.service.domain.Greeting;
import com.aza.service.domain.HelloMessage;
import com.aza.service.domain.Message;
import com.aza.service.message.impl.MessageServiceImpl;
import com.mongodb.client.MongoCollection;

@CrossOrigin
@Controller
public class MessageController {


	@Autowired
	@Qualifier("messageServiceImpl")
	private MessageServiceImpl messageServiceImpl;
	
	@RequestMapping("/message")
	public ModelAndView messageView(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/message/message");
		
		return mv;
	}


	@MessageMapping("/getMessage/{userId}/{otherId}")
	@SendTo("/topic/getMessage")
	public List getMessage(@DestinationVariable("userId") String userId,@DestinationVariable("otherId") String otherId) throws Exception {
		Thread.sleep(150);

		List list = messageServiceImpl.getMessage(userId, otherId);
		  
		System.out.println(list);
		 		
		return list;
	}
	

	@MessageMapping("/addMessage")
	@SendTo("/topic/showAddMessage")
	public Message addMessage(Message message) throws Exception {
		Thread.sleep(150);
		System.out.println("showAddMessage : "+message);
		messageServiceImpl.addMessage(message.getReceiverId(), message.getSenderId(), message.getMessageContent(), message.getMessageCreateAt());
	
		return message;
	}
	

	//@MessageExceptionHandler(MessageConversionException.class)
	@MessageMapping("/deleteMessage/{_id}")
	@SendTo("/topic/getMessage")
	public List deleteMessage(@DestinationVariable String _id, @Payload(required= false)Message message) throws Exception {
		Thread.sleep(150);
		System.out.println("deleteMessage : "+message);
				
		Message deleted = messageServiceImpl.deleteMessage(_id);
		
		List list = messageServiceImpl.getMessage(deleted.getSenderId(), deleted.getReceiverId());
		return list;	
	}
}