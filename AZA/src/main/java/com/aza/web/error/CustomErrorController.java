package com.aza.web.error;



import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class CustomErrorController implements ErrorController{

	// field
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// ctor
	public CustomErrorController() {}

	
	// method
	@GetMapping(value="/error")
	public String Error(HttpServletRequest request) {
		
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		
		int statusCode = Integer.valueOf(status.toString());
		String errorPath = "/error/errorCommon";
		
		HttpStatus httpStatus = HttpStatus.valueOf(statusCode);
		
		if(status != null) {
			
			logger.info("httpStatus : "+statusCode);
			
			if(statusCode == HttpStatus.BAD_REQUEST.value()) {
				
				errorPath = "/error/error400";
			}
			
			if(statusCode == HttpStatus.UNAUTHORIZED.value()) {
				
				errorPath = "/error/error401";
			}
			
			if(statusCode == HttpStatus.FORBIDDEN.value()) {
				
				errorPath = "/error/error403";
			}
			
			if(statusCode == HttpStatus.NOT_FOUND.value()) {
				
				errorPath = "/error/error404";
			}

			if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				
				errorPath = "/error/error500";
			}			
		}
		
		return errorPath;		
	}
	
	public String getErrorPath() {
		return null;
	}


}
