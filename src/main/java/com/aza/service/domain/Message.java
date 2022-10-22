package com.aza.service.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.MongoId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

public class Message {

	@Id
	private String _id;
	
	private String receiverId;
	private String senderId;
	private String messageContent;
	private String messageCreateAt;
	private String messageReadAt;
	
	
	
	public Message() {
	}


	public Message(String _id, String receiverId, String senderId, String messageContent, String messageCreateAt) {
		super();
		this._id = _id;
		this.receiverId = receiverId;
		this.senderId = senderId;
		this.messageContent = messageContent;
		this.messageCreateAt = messageCreateAt;
	}
	
	public Message(String _id, String receiverId, String senderId) {
		super();
		this._id = _id;
		this.receiverId = receiverId;
		this.senderId = senderId;
	}
	

	public Message(String receiverId, String senderId, String messageContent, String messageCreateAt) {
		super();
		this.receiverId = receiverId;
		this.senderId = senderId;
		this.messageContent = messageContent;
		this.messageCreateAt = messageCreateAt;
	}
	

	public Message(String _id, String receiverId, String senderId, String messageContent, String messageCreateAt,
			String messageReadAt) {
		super();
		this._id = _id;
		this.receiverId = receiverId;
		this.senderId = senderId;
		this.messageContent = messageContent;
		this.messageCreateAt = messageCreateAt;
		this.messageReadAt = messageReadAt;
	}

	
	public String get_id() {
		return _id;
	}


	public void set_id(String _id) {
		this._id = _id;
	}


	public String getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}
	public String getSenderId() {
		return senderId;
	}
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	public String getMessageCreateAt() {
		return messageCreateAt;
	}
	public void setMessageCreateAt(String messageCreateAt) {
		this.messageCreateAt = messageCreateAt;
	}
	public String getMessageReadAt() {
		return messageReadAt;
	}
	public void setMessageReadAt(String messageReadAt) {
		this.messageReadAt = messageReadAt;
	}
	
	@Override
	public String toString() {
		return "Message [_id=" + _id + ", receiverId=" + receiverId + ", senderId=" + senderId
				+ ", messageContent=" + messageContent + ", messageCreateAt=" + messageCreateAt + ", messageReadAt="
				+ messageReadAt + "]";
	}


	
}
