package com.aza.common.web;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.aza.service.domain.User;


@Slf4j
public class LogonCheckInterceptor implements  HandlerInterceptor {

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("======================================LogonCheckInterceptor");
        HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");

        if (user != null) {    /* 로그인 되어 있는 경우 */
            response.sendRedirect("/index");
 
        }
        return true;
	}
}//end of class