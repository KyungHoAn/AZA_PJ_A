package com.aza.web.message;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
	
	//connection했을때 CORS허용
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// TODO Auto-generated method stub
		registry.addEndpoint("/gs-guide-websocket").setAllowedOriginPatterns("*").withSockJS();
//		registry.addEndpoint("/ws").withSockJS();
	}
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		// TODO Auto-generated method stub
		registry.setApplicationDestinationPrefixes("/app"); 
        registry.enableSimpleBroker("/topic"); 
	}
	
}