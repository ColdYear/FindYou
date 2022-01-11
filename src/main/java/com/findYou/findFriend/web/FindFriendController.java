package com.findYou.findFriend.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.findYou.blackList.service.BlackListServiceImpl;
import com.findYou.blackList.vo.BlackListVO;
import com.findYou.exception.BizNotFoundException;
import com.findYou.member.service.MemberServiceImpl;
import com.findYou.member.vo.MemberVO;

@Controller
public class FindFriendController {
	
	@Inject
	@Qualifier("memberServiceImpl")
	MemberServiceImpl memberServiceImpl;

	
	@Inject
	BlackListServiceImpl blackListServiceImpl;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@ResponseBody
	@RequestMapping(value="findFriend/load")
	public Map<String, Object> load(MemberVO member, @RequestParam("userId") String userId) {
		try {
			logger.info("userId = {}", userId);
			Map<String, Object> map = new HashMap<String, Object>();
			//로그인한 사람 외의 정보 가져오기
			List<MemberVO> memberList = memberServiceImpl.getMemberList(member);
			
			//로그인한 사람의 정보 가져오기
			MemberVO login_member = memberServiceImpl.getMember(userId);
			MemberVO centerUser = null;
			logger.info("login_member = {}", login_member);
			double center_x = Double.parseDouble(login_member.getMemAddrX());
			double center_y = Double.parseDouble(login_member.getMemAddrY());
			
			//로그인한 정보는 리스트에서 제외			
			 for(int i=0; i<memberList.size(); i++) {
				 if(login_member.getMemId().equals(memberList.get(i).getMemId())) {
					 centerUser = memberList.get(i);
					 memberList.remove(i);
				 }
			 }
			 map.put("centerUser", centerUser);
			 
			double x;
			double y;
			double result;
			//거리계산해서 3km 안에있는 사람만 리스트에 유지
			
			List<MemberVO> finalMembers = new ArrayList<MemberVO>();
			 for(int i=0; i<memberList.size(); i++) { 
				 x = Double.parseDouble(memberList.get(i).getMemAddrX()); 
				 y = Double.parseDouble(memberList.get(i).getMemAddrY());
				 result = distance(center_x, center_y, x, y);
				 logger.info("member = {}", memberList.get(i).getMemId());
				 logger.info("result = {}", result);
				 
				 if(memberList.size() != 0) {					 
					 if(result <= 3.0) {
						 MemberVO temp_member = memberList.get(i);
						 String res = String.format("%.2f", result);
						 temp_member.setMemDist(Double.parseDouble(res));
						 finalMembers.add(temp_member);
					 } 
				 }
			 }
			 
			 List<MemberVO> finalMembers2 = new ArrayList<MemberVO>();
			 //블랙리스트 필터링
			 BlackListVO blackMember = null;
			 MemberVO temp2_member;
			 for(int i=0; i<finalMembers.size(); i++) {
				 blackMember = blackListServiceImpl.getBlackList(finalMembers.get(i).getMemId());
				 if(blackMember != null) {
					 temp2_member = finalMembers.get(i);
					 temp2_member.setMemGender('적');
					 finalMembers2.add(temp2_member);
				 }else {
					 finalMembers2.add(finalMembers.get(i));
				 }
			 }
			logger.info("finalMembers = {}", finalMembers);
			map.put("memberList_length", finalMembers.size());
			map.put("memberList", finalMembers);
			return map;
		}catch(BizNotFoundException ebf) {
			ebf.printStackTrace();
		}
		return null;
	}
	
	
	private static double distance(double x1, double y1, double x2, double y2) {
		double theta = y1 - y2;
		double dist = Math.sin(deg2rad(x1)) * Math.sin(deg2rad(x2)) + Math.cos(deg2rad(x1)) * Math.cos(deg2rad(x2)) * Math.cos(deg2rad(theta));
		
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;
		dist = dist * 1.609344;
		return dist;
		
	}
	
	 	private static double deg2rad(double deg) {
	        return (deg * Math.PI / 180.0);
	    }
	     
	    // This function converts radians to decimal degrees
	    private static double rad2deg(double rad) {
	        return (rad * 180 / Math.PI);
	    }

	@RequestMapping("/findFriend/findFriend.wow")
	public String findFriend() {
		return "findFriend/findFriend";
	}


}
