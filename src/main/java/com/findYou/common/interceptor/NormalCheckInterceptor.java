package com.findYou.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.findYou.login.vo.UserVO;

public class NormalCheckInterceptor extends HandlerInterceptorAdapter{

	
	//일반회원만 글쓰기, 수정, 삭제할 수 있다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		UserVO user = (UserVO)session.getAttribute("user");
		
		if(user == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}else {			
			if(user.getUserRole().equals("business")) {
				response.sendRedirect(request.getContextPath() + "/");
				return false;
			}else {			
				return true;
			}
		}
		
		
	}
}
