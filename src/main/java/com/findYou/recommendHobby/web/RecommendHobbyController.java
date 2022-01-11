package com.findYou.recommendHobby.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.findYou.attach.service.AttachServiceImpl;
import com.findYou.attach.vo.AttachVO;
import com.findYou.exception.BizNotFoundException;
import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.recommendHobby.service.IRecommendHobbyService;
import com.findYou.recommendHobby.vo.RecommendHobbyVO;
import com.findYou.recommendHobby.vo.RecommendValueVO;

@Controller
public class RecommendHobbyController {

	@Inject
	@Qualifier("recommendHobbyServiceImpl")
	IRecommendHobbyService hobbyService;
	
	
	  @Inject
	  AttachServiceImpl attachService;
	 
	

	@RequestMapping("/recommendHobby/recommend.wow")
	public String recommend(Model model) {
	
		return "recommendHobby/recommend";
	}
	@RequestMapping("/recommendHobby/recommendSelect.wow")
	public String recommendSelect(Model model) {
		List<RecommendHobbyVO> mbtiList =hobbyService.mbtiList();
		model.addAttribute("mbtiList", mbtiList);
		return "recommendHobby/recommendSelect";
	}
	
	
	@RequestMapping("/recommendHobby/recommendResult.wow")
	public String recommendresult(Model model ,HttpSession session
									,String mbti_value
									,String activity_value
									,String hobby_value
									,int cash) throws BizNotFoundException {
		
		RecommendValueVO valueVO =new RecommendValueVO();
		if(mbti_value !=null) {
			valueVO.setMbti_value(mbti_value);		
		}
		if(hobby_value!=null) {
			valueVO.setHobby_value(hobby_value);	
		}
		if(activity_value!=null) {
			valueVO.setActivity_value(activity_value);	
		}
		valueVO.setCash(cash);
	List<NormalBoardVO> boardList =hobbyService.searchResult(valueVO);
	
	
	
		System.out.println(boardList);
		ArrayList<String> list =new ArrayList<>();
		AttachVO temp = new AttachVO();
		for (NormalBoardVO normalBoardVO : boardList) {
			temp.setAtchCategory("NORMAL");
			temp.setAtchParentNo(normalBoardVO.getNormalBoardIndex());
			AttachVO attach =attachService.getAttachByParentNo(temp);		
			list.add(attach.getAtchFileName());
		}
	
		model.addAttribute("list", list);
		model.addAttribute("boardList", boardList);

		return "recommendHobby/recommendResult";
		
	}
	
	
	//mbti만 입력시
	//mbti와 활동만 입력 상황
	//mbti 활동 취미까지 입력상
	@ResponseBody
	@RequestMapping("/recommendHobby/mbti_value.wow")
	public String mbti_value(Model model,HttpSession session
			,String mbti_value) {
		session.setAttribute("mbti_value", mbti_value);
		return "";
	}
	@ResponseBody
	@RequestMapping("/recommendHobby/activity_value.wow")
	public String activity_value(Model model,HttpSession session
			,String activity_value) {
		session.setAttribute("activity_value", activity_value);
		return "";
	}
	@ResponseBody
	@RequestMapping("/recommendHobby/next_hobby.wow")
	public List<RecommendHobbyVO> next_hobby(Model model,HttpSession session
			,@RequestParam(value ="recActiceYn", required=false)String recActiceYn
			,@RequestParam(value ="recMbti", required=false)String recMbti) {
		
		if(recActiceYn.equals("활동적")) {
			recActiceYn = "active";
		}else if (recActiceYn.equals("비활동적")){
			recActiceYn = "inactive";		
		}
		RecommendHobbyVO hobbyVO =new RecommendHobbyVO();
		hobbyVO.setRecActiceYn(recActiceYn);
		hobbyVO.setRecMbti(recMbti);
		List<RecommendHobbyVO> hobby = hobbyService.hobbyList(hobbyVO);
		 System.out.println(hobby);
		 System.out.println("여까지는 옴");
		 return hobby;
	}
}
