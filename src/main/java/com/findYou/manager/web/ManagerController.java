package com.findYou.manager.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.findYou.blackList.service.BlackListServiceImpl;
import com.findYou.blackList.vo.BlackListVO;
import com.findYou.chatting.service.IChattingService;
import com.findYou.chatting.vo.ChattingVO;
import com.findYou.member.service.IMemberService;
import com.findYou.member.vo.MemberVO;
import com.findYou.score.service.ScoreServiceImpl;

@Controller
public class ManagerController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Inject
	@Qualifier("memberServiceImpl")
	IMemberService memberService;
	
	@Inject
	@Qualifier("chattingServiceImpl")
	IChattingService chattingService; 
	
	@Inject
	BlackListServiceImpl blackListServiceImpl;
	
	@Inject
	ScoreServiceImpl scoreServiceImpl;
	
	@RequestMapping("/manager/manager.wow")
	public String managerPage(Model model
			,@ModelAttribute("member")MemberVO member) {
		List<MemberVO> list = memberService.managerViewMember(member);
		List<String> genderList = new ArrayList<String>();
		List<String> roleList = new ArrayList<String>();
		//블랙리스트 판별
		for(int i=0; i<list.size(); i++) {
			BlackListVO blackMember = blackListServiceImpl.getBlackList(list.get(i).getMemId());
			if(blackMember != null) {
				genderList.add("criminal");
				roleList.add("blacklist");
			}else {
				if(list.get(i).getMemGender() == '남') {
					genderList.add("man");
				}else {					
					genderList.add("woman");
				}
				roleList.add(list.get(i).getMemRole());
			}
		}
		
		//평점가져오기
		List<String> scoreList = new ArrayList<String>();
		String score = "";
		for(int i=0; i<list.size(); i++) {			
			double temp_score = scoreServiceImpl.getScoreById(list.get(i).getMemId());
			if(temp_score == 0) {
				score = "0";
			}else {				
				score = String.format("%.1f", temp_score);
			}
			scoreList.add(score +"점");
		}
		
		model.addAttribute("list" ,list);
		model.addAttribute("genderList", genderList);
		model.addAttribute("roleList", roleList);
		model.addAttribute("scoreList", scoreList);
		
		return "manager/manager";
		
		
	}
	@ResponseBody
	@RequestMapping("manager/chatListFind_managerController.wow")    //채팅 데이터 전송
	public List<ChattingVO> chatListFind_manager(HttpSession session
			
									,int userChatNo_send
									,Model model) {
		System.out.println("여기 들어옴");
		System.out.println(userChatNo_send+"dddd");
	
		session.setAttribute("userChatNo", userChatNo_send);
		
	List<ChattingVO> getChatList=chattingService.getChatList(userChatNo_send);
	return getChatList;
	
	}
	@ResponseBody
	@RequestMapping("manager/chat_no.wow")    //채팅 데이터 전송
	public int caht_no(HttpSession session
			
									,Model model) {
		int no =(int)session.getAttribute("userChatNo");
		return no;
	
	}
	
	
	
	@RequestMapping("manager/chat.wow")
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
		System.out.println("여까지는 옴 ");
		//그 사람이 맞을때만 매니저랑 연결
		System.out.println(userChatNo +"assadsad");
		ChattingVO chatting=new ChattingVO();
		if(userRole.equals("manager")) {
				
		
			chatting.setUserId(userId);
			chatting.setChatHistory(cahtHistory);
			chatting.setChatNo((int)session.getAttribute("userChatNo"));
			chatting.setMemRole(userRole);
			System.out.println(userRole);
			System.out.println(chatting);
			
			chattingService.insertChat(chatting);
	
		}else {
			chatting.setUserId(userId);
			chatting.setChatHistory(cahtHistory);
			chatting.setChatNo((int)session.getAttribute("userChatNo"));
			chatting.setMemRole(userRole);
			System.out.println(userRole);
			System.out.println(chatting);
			chattingService.insertChat(chatting);
		}
		 
	
	


		
		
		return "redirect:/";
	}
}
