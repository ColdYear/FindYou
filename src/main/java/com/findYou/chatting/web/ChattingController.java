package com.findYou.chatting.web;

import java.util.List;

import javax.inject.Inject;
import javax.mail.Session;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.findYou.chatting.service.IChattingService;
import com.findYou.chatting.vo.ChattingVO;


@Controller
public class ChattingController {

	@Inject
	@Qualifier("chattingServiceImpl")
	IChattingService chattingService; 
	
	
	
	
	
	@ResponseBody
	@RequestMapping("chatListFind.wow")    //채팅 데이터 전송
	public List<ChattingVO> chatListFind(HttpSession session
									
									,int userChatNo
									,Model model) {
	
		System.out.println(userChatNo+"dddd");




	List<ChattingVO> getChatList=chattingService.getChatList(userChatNo);
	return getChatList;
	
	}
	
	@ResponseBody
	@RequestMapping("chatListFind_manager.wow")    //채팅 데이터 전송
	public List<ChattingVO> chatListFind_manager(HttpSession session
									
									,int userChatNo_send
									,Model model) {
	
		System.out.println(userChatNo_send+"dddd");




	List<ChattingVO> getChatList=chattingService.getChatList(userChatNo_send);
	return getChatList;
	
	}
	
	
	
	@ResponseBody
	@RequestMapping("chatRoomFind.wow")//채팅방 번호들 전송
	public List<ChattingVO> chatRoomFind(HttpSession session
									,Model model) {
		
	List<ChattingVO> getChatList=chattingService.getChat();
	
	return getChatList;	
	}
	
	@RequestMapping("chatNoFind.wow")
	public String chatNoFind(int sendUserNo,HttpSession session ) {
		
		System.out.println(sendUserNo);
	/*	if(session.getAttribute("sendUserNo") ==null) {*/
		session.setAttribute("sendUserNo", sendUserNo);
		/* } */
		return "redirect:/";
	}
	
	@RequestMapping("chat.wow")
	public String chat(Model model
			,String chat_history
			,String userId
			,String userRole
			,int userChatNo
			,HttpServletRequest req
			,HttpSession session
			,HttpServletResponse reps) {
	
		System.out.println(chat_history);
		String cahtHistory =chat_history;
		System.out.println(userId);

		//그 사람이 맞을때만 매니저랑 연결
		
		
		ChattingVO chatting=new ChattingVO();
		if(userRole.equals("manager")) {
		
			int a=	(int)session.getAttribute("sendUserNo");
			System.out.println(a);
			chatting.setUserId(userId);
			chatting.setChatHistory(cahtHistory);
			chatting.setChatNo(a);
			chatting.setMemRole(userRole);
			System.out.println(userRole);
			System.out.println(chatting);
			
			chattingService.insertChat(chatting);
	
		}else {
			chatting.setUserId(userId);
			chatting.setChatHistory(cahtHistory);
			chatting.setChatNo(userChatNo);
			chatting.setMemRole(userRole);
			System.out.println(userRole);
			System.out.println(chatting);
			chattingService.insertChat(chatting);
		}
		 
	
	


		
		
		return "redirect:/";
	}
}
