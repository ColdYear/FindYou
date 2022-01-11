package com.findYou.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.findYou.login.vo.UserVO;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
//		String ajax = request.getHeader("X-requested-with");
		UserVO user = (UserVO)session.getAttribute("user");
		if(user == null) {
			response.sendRedirect(request.getContextPath() + "/login/normalLogin.wow");
			return false;
		}else {
			return true;
		}		
	}
}
