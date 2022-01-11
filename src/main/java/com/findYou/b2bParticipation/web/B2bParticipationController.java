package com.findYou.b2bParticipation.web;

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
import org.springframework.web.bind.annotation.RestController;

import com.findYou.b2bParticipation.service.B2bParticipationService;
import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.blackList.service.BlackListServiceImpl;
import com.findYou.blackList.vo.BlackListVO;
import com.findYou.businessBoard.service.BusinessBoardServiceImpl;
import com.findYou.businessBoard.vo.BusinessBoardVO;
import com.findYou.exception.BizNotFoundException;
import com.findYou.member.service.MemberServiceImpl;
import com.findYou.member.vo.MemberVO;
import com.findYou.normalBoard.service.NormalBoardServiceImpl;
import com.findYou.participation.vo.ParticipationVO;
import com.findYou.score.service.ScoreServiceImpl;
import com.findYou.score.vo.ScoreVO;

@RestController
public class B2bParticipationController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	B2bParticipationService b2bParticipationService;
	
	@Inject
	@Qualifier("memberServiceImpl")
	MemberServiceImpl memberServiceImpl;
	
	
	@Inject
	@Qualifier("businessBoardServiceImpl")
	BusinessBoardServiceImpl businessBoardServiceImpl; 
	
	
	@Inject
	@Qualifier("normalBoardServiceImpl")
	NormalBoardServiceImpl normalBoardServiceImpl;
	
	@Inject
	@Qualifier("scoreServiceImpl")
	ScoreServiceImpl scoreServiceImpl;
	
	@Inject
	@Qualifier("blackListServiceImpl")
	BlackListServiceImpl blackListServiceImpl ;
	

	
	@RequestMapping(value="/b2bParticipation/b2bParticipationAddr.wow")
	public Map<String, Object> getB2bParticipationAddr(B2bParticipationVO partVO) throws BizNotFoundException {
		logger.info("partVO={}",partVO);
		Map<String, Object> map = new HashMap<String, Object>();
		String b2bPartAddr= memberServiceImpl.getAddr(partVO);
		logger.info("addr={}",b2bPartAddr);
		
		partVO.setB2bPartAddr(b2bPartAddr);
		partVO.setB2bPartId(partVO.getB2bPartId());
		partVO.setB2bPartBoardNumber(partVO.getB2bPartBoardNumber());
		int count = b2bParticipationService.insertOrDelete(partVO);
		
		//소개글 내용 가져오기
		BusinessBoardVO getBoard = businessBoardServiceImpl.getBusinessBoard(partVO.getB2bPartBoardNumber());
		String b2bContent = getBoard.getB2bBoardContent();
		map.put("b2bContent", b2bContent);
		map.put("result", true);
		map.put("data", count);
		
		return map;
	
	}
	
	@RequestMapping(value="/b2bParticipation/b2bCancleYn.wow")
	public Map<String, Object> cancleYn(B2bParticipationVO partVO){
		String cancleYn = b2bParticipationService.calcleYn(partVO);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("data", cancleYn);
		return map;
	}
	
	
	@RequestMapping(value="/b2bParticipation/b2bParticipationList.wow")
	public Map<String, Object> b2bParticipationList(B2bParticipationVO partVO){
		List<B2bParticipationVO>	participationList=	b2bParticipationService.b2bParticipationList(partVO);
		logger.info("participationList={}",participationList);
		Map<String, Object> map = new HashMap<String, Object>();
		
		

			map.put("result", true);
			map.put("data", participationList);

		
		return map;
	}
	
	@RequestMapping(value="/b2bParticipation/b2bParticipationMember.wow")
	public Map<String, Object> getMemNameBoardTitle(B2bParticipationVO partVO){
		Map<String, Object> map = new HashMap<String, Object>();
		logger.info("partVO={}",partVO);
		List<String> title = new ArrayList<>();
		
		
		String gender = null;
		try {
			//성별 확인
			MemberVO member = memberServiceImpl.getMember(partVO.getB2bPartId());
			char gen = member.getMemGender();
			String id = member.getMemId();

			
			List<BlackListVO> blackList= blackListServiceImpl.businessGenderCheck();

			if(gen == '남') {
				gender = "man.png";
			}else {
				gender = "woman.png";
			}
			for (int i = 0; i < blackList.size(); i++) {
				if(blackList.get(i).getMemId().equals(id)) {
					gender = "criminal.png";
				}else {
					gender = gender;
				}
				
			}
			
			MemberVO PartId = memberServiceImpl.getMember(partVO.getB2bPartId());
			String b2bPartId =	PartId.getMemId();
			String getName = PartId.getMemName();
			List<B2bParticipationVO> titleNumberList = b2bParticipationService.getTitleList(b2bPartId);
			logger.info("titleNumberList={}",titleNumberList);
			title = businessBoardServiceImpl.getTitleByIndex(titleNumberList);
			
			List<ScoreVO> scoreVO = scoreServiceImpl.checkMemberYn(b2bPartId);
			double temp_score=0.0;
			String score ="";
			if(scoreVO.size() > 0) {
				temp_score = scoreServiceImpl.getScoreById(b2bPartId);
				score = String.format("%.1f", temp_score);
			}else {
				score = "0";
			}
			//멤버 상세보기 누른 아이디값 //추가
			map.put("participationId", b2bPartId);
			
			map.put("score", score);
			map.put("gender", gender);
			map.put("length", title.size());
			map.put("title", title);
			map.put("getName", getName);
			
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return map;
		
	}

	
	
	
	
	
}
