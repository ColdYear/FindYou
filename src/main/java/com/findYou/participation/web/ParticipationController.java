package com.findYou.participation.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.findYou.blackList.service.BlackListServiceImpl;
import com.findYou.blackList.vo.BlackListVO;
import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.login.vo.UserVO;
import com.findYou.member.service.MemberServiceImpl;
import com.findYou.member.vo.MemberVO;
import com.findYou.normalBoard.service.NormalBoardServiceImpl;
import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.participation.service.ParticipationServiceImpl;
import com.findYou.participation.vo.ParticipationVO;
import com.findYou.score.service.ScoreServiceImpl;
import com.findYou.score.vo.ScoreVO;

@RestController
public class ParticipationController {
	
	@Inject
	@Qualifier("memberServiceImpl")
	MemberServiceImpl memberServiceImpl;
	
	@Inject
	@Qualifier("participationServiceImpl")
	ParticipationServiceImpl participationServiceImpl;
	
	@Inject
	@Qualifier("normalBoardServiceImpl")
	NormalBoardServiceImpl normalBoardServiceImpl;
	
	@Inject
	@Qualifier("scoreServiceImpl")
	ScoreServiceImpl scoreServiceImpl;
	
	@Inject
	BlackListServiceImpl blackListServiceImpl;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="participation/load",
					  produces="application/json;charset=utf-8")
	public Map<String, Object> load(ParticipationVO joinMember){
		logger.info("joinMember = {}",joinMember.toString());
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		try{
			NormalBoardVO normalBoardVO = normalBoardServiceImpl.getNormalBoard(Integer.toString(joinMember.getNormalPartBoardNumber()));
			int count = participationServiceImpl.joinMemberCount(joinMember.getNormalPartBoardNumber()); //현재 참여중인 수.
			if(Integer.parseInt(normalBoardVO.getNormalBoardDeadlineNumber()) <= count) {
				map.put("result", false); //모집인원이 꽉차서 마감됬다.
			}
			map.put("normalBoard", normalBoardVO);
			map.put("count", count);
			
			ParticipationVO part = participationServiceImpl.getJoinMember(joinMember);
			if(part != null) { //참여중인것
				map.put("partYN", true);
			}else { //참여중이 아닌 것
				map.put("partYN", false);
			}
			
		}catch(BizNotFoundException e) {
			e.printStackTrace();
		}
		
		if(participationServiceImpl.checkBoardNumber(joinMember)) {
			//모임에 참여한 사람인 것 -> 취소하기 버튼 활성화
			map.put("data", "취소하기");
			map.put("id", "cancel_button");
		}else {
			//모임에 참여 안한 사람인 것 -> 참여하기 버튼 활성화
			map.put("data", "참여하기");
			map.put("id", "join_button");
		}
		
		return map;
	}

	
	@RequestMapping(value="participation/join",
					  produces = "application/json;charset=utf-8")
	public Map<String, Object> join(UserVO user, String normalBoardIndex, int normalBoardDeadlineNumber) {
		logger.info("UserVO = {}",user.toString());
		boolean result = true;
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			MemberVO member = memberServiceImpl.getMember(user.getUserId());
			
			ParticipationVO joinMember = new ParticipationVO();
			joinMember.setNormalPartId(member.getMemId());
			joinMember.setNormalPartBoardNumber(Integer.parseInt(normalBoardIndex));
			joinMember.setNormalPartAddr(member.getMemRoadAddr() + member.getMemDetailedAddr());
			joinMember.setNormalPartMemberCount(normalBoardDeadlineNumber);
			result = participationServiceImpl.modifyJoinMember(joinMember);
			logger.info("joinMember = {}", joinMember);
			logger.info("result = ",result);
			Integer partCount = participationServiceImpl.joinMemberCount(Integer.parseInt(normalBoardIndex));
			map.put("result", result);
			map.put("data", joinMember);
			map.put("count",partCount);
			
			NormalBoardVO board = normalBoardServiceImpl.getNormalBoard(normalBoardIndex);
			map.put("normalBoard", board);
			return map;
		}catch(BizNotFoundException ebf) {
			ebf.printStackTrace();
		}catch(BizNotEffectedException ebe) {
			ebe.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping(value="participation/joinMemberList",
			produces = "application/json;charset=utf-8")
	public Map<String, Object> joinMemberList(String normalBoardIndex){
		Map<String, Object> partMap = new HashMap<String, Object>();
		try{
			List<ParticipationVO> partList = participationServiceImpl.getJoinMemberListByIndex(Integer.parseInt(normalBoardIndex));
			partMap.put("result", true);
			partMap.put("data",partList);
			
		}catch(BizNotFoundException ebf) {
			ebf.printStackTrace();
		}
		return partMap;
	}
	
	
	
	@RequestMapping(value="participation/joinMember",
			produces = "application/json;charset=utf-8")
	public Map<String, Object> joinMember(ParticipationVO joinMember){
		Map<String, Object> partMap = new HashMap<String, Object>();
		
		logger.info("normalPartId = {}", joinMember.getNormalPartId());
		
		//아이디를 통해 이름을 얻는다.
		try{
			MemberVO member = memberServiceImpl.getMember(joinMember.getNormalPartId());
			String name = member.getMemName();
			partMap.put("name", name);
			
			char gender = member.getMemGender();
			partMap.put("gender", gender);
			
			List<ParticipationVO> partList = participationServiceImpl.getAllPartList(joinMember);
			
			List<String> titleList = normalBoardServiceImpl.getTitleByIndex(partList);
			logger.info("titleList = {}", titleList);
			partMap.put("activity", titleList);
			
			List<ScoreVO> scoreVO = scoreServiceImpl.checkMemberYn(joinMember.getNormalPartId());
			String score = "";
			if(scoreVO.size() > 0) {				
				double avgScore = scoreServiceImpl.getScoreById(joinMember.getNormalPartId());
				score = String.format("%.1f", avgScore);
			}else {
				score = "0";
			}
			
			//블랙리스트 여부판단
			BlackListVO blackMember = blackListServiceImpl.getBlackList(joinMember.getNormalPartId());
			logger.info("blackmember = {}", blackMember);
			if(blackMember == null) {
				partMap.put("blackList", false);
			}else {
				partMap.put("blackList", true);
			}
			
			partMap.put("score", score);
		}catch(BizNotFoundException ebf) {
			ebf.printStackTrace();
		}
		
		return partMap;
	}
	
	@RequestMapping(value="participation/delete"
					, produces="application/json;charset=utf-8")
	public Map<String, Object> deleteJoinMember(ParticipationVO joinMember){		
		logger.info("ParticipationVO = {}",joinMember.toString());
		Map<String, Object> partMap = new HashMap<String, Object>();
		
		try{
			participationServiceImpl.deleteParticipationMember(joinMember);
			int count = participationServiceImpl.joinMemberCount(joinMember.getNormalPartBoardNumber());
			
			partMap.put("count", count);
			
			NormalBoardVO board = normalBoardServiceImpl.getNormalBoard(Integer.toString(joinMember.getNormalPartBoardNumber()));
			partMap.put("normalBoard", board);
		}catch(BizNotEffectedException ebe) {
			ebe.printStackTrace();
		}catch(BizNotFoundException ebf) {
			ebf.printStackTrace();
		}
		
		return partMap;
	}
}


















