package com.findYou.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.findYou.login.vo.UserVO;

public class BusinessCheckInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		UserVO user = (UserVO)session.getAttribute("user");

		if(user == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}else {			
			if(user.getUserRole().equals("normal")) {
				response.sendRedirect(request.getContextPath() + "/");
				return false;
			}else {
				return true;			
			}
		}
	}
}
