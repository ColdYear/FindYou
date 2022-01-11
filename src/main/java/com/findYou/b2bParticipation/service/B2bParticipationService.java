package com.findYou.b2bParticipation.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.findYou.b2bParticipation.dao.B2bParticipationDao;
import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.businessBoard.vo.BusinessBoardVO;
import com.findYou.member.vo.MemberVO;

@Service
public class B2bParticipationService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	B2bParticipationDao b2bParticipationDao;
	
	public int insertOrDelete(B2bParticipationVO partVO) {
		
		B2bParticipationVO selectId = b2bParticipationDao.selectId(partVO);
		//참여하지 않았으면 등록가능
		if(selectId == null) {
			b2bParticipationDao.insertOrDelete(partVO);
		}else {
			// 참석여부 (Y/N)
			if(selectId.getB2bPartCancelYn().equals("Y")) {
				b2bParticipationDao.cancelN(partVO);
			}else {
				b2bParticipationDao.cancelY(partVO);
			}
		}
		int count = b2bParticipationDao.participationCount(partVO);
		return count;
	}
	
	
	public String calcleYn(B2bParticipationVO partVO) {
		String cancleYn = b2bParticipationDao.cancleYn(partVO);	
		if(cancleYn == null) {
			//참석여부 버튼을 누르지 않아 기록이 없어서 null로 나올 때 참여하지 않은 회원으로 
			cancleYn = "Y";
		}
		return cancleYn;
	}
	
	public List<B2bParticipationVO> b2bParticipationList(B2bParticipationVO partVO){
		List<B2bParticipationVO> participationList= b2bParticipationDao.b2bParticipationList(partVO);
		logger.info("participationList={}",participationList);
		return participationList;
	}
	
	public List<B2bParticipationVO> getTitleList(String b2bPartId){
		List<B2bParticipationVO> titleNumberList= b2bParticipationDao.getTitleList(b2bPartId);
		return titleNumberList;
	}
	
	public int deleteBusinessPartticipation(BusinessBoardVO board) {
		int cnt = b2bParticipationDao.deleteBusinessPartticipation(board);
		return cnt;
	}

	public int countPart(int b2bBoardIndex) {
		int count = b2bParticipationDao.countPart(b2bBoardIndex);
		return count;
	}
	

}
