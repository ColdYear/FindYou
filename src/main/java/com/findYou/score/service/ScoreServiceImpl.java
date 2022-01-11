package com.findYou.score.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.blackList.dao.IBlackListDao;
import com.findYou.blackList.vo.BlackListVO;
import com.findYou.exception.BizNotEffectedException;
import com.findYou.message.dao.IMessageDao;
import com.findYou.message.vo.MessageVO;
import com.findYou.participation.dao.IParticipationDao;
import com.findYou.score.dao.IScoreDao;
import com.findYou.score.vo.ScoreVO;

@Service
public class ScoreServiceImpl {

	
	@Inject
	IScoreDao iScoreDao;
	
	@Inject
	IParticipationDao iParticipationDao;
	
	@Inject
	IBlackListDao iBlackListDao;
	
	@Inject
	IMessageDao iMessageDao;
	
	public int insertScore(ScoreVO score) throws BizNotEffectedException{
		
		int cnt = 0;
		ScoreVO vo = iScoreDao.getScoreMember(score);
		if(vo == null) {			
			cnt = iScoreDao.insert(score);
			if(cnt <= 0) throw new BizNotEffectedException();
		}
		
		//ScoreYN 컬럼을 Y로 바꾼다.
//		ParticipationVO part = new ParticipationVO();
//		part.setNormalPartBoardNumber(score.getMemberScoreBoardNumber());
//		part.setNormalPartId(score.getMemberScoreId());
//		iParticipationDao.updateScoreYN(part);
		
		//블랙리스트 로직
		//아이디 별로 평점 리스트를 불러와서 1점이 5개 이상이면 블랙리스트 테이블에 추가
		List<ScoreVO> scoreList = iScoreDao.getLowScoreList();
		BlackListVO member = new BlackListVO();
		MessageVO message = new MessageVO();
		String msgContent = "평점 1점을 5회 이상 받으셔서 주의 요망 회원으로 변경되었습니다. "
								+"자세한 내용은 공지사항을 확인해주세요."
								;
		for(ScoreVO scoreVO : scoreList) {
			if(iBlackListDao.getBlackList(scoreVO.getMemberScoreId()) == null) {				
				member.setMemId(scoreVO.getMemberScoreId());
				iBlackListDao.insertBlackList(member);
				
				//해당 사람한테 쪽지 보내기
				message.setMsgSender("운영자");
				message.setMsgReceiver(scoreVO.getMemberScoreId()); //받는사람
				message.setMsgContent(msgContent);
				iMessageDao.insertMessage(message);
			}
		}
		return cnt;
	}
	
	//해당 게시글(모임)에서 모든 사람이 평가를 받았는지
	public boolean checkEvaluate(ScoreVO score) {
		//현재 내가 평가한 사람 수
		int count = iScoreDao.countMember(score);
		
		//활동중인 사람 수
		int partCount = iParticipationDao.getJoinMemberCount(score.getMemberScoreBoardNumber());
		System.out.println("count = " + count);
		System.out.println("partCount = " + partCount);
		//전부다 평가 했다면?
		if(count == (partCount-1)) {
			return true;
		}else {
			return false;
		}		
	}
	
	
	public List<ScoreVO> getScoreList(ScoreVO score){
		List<ScoreVO> list = iScoreDao.getScoreList(score);
		return list;
	}
	
	
	//view/상세보기에서 평점보여주기
	public double getScoreById(String scoreId){
		String avgScore = iScoreDao.getScoreById(scoreId);
		if(avgScore == null) {
			return 0;
		}else {
			return Double.parseDouble(avgScore);
		}
	}
	
	public List<ScoreVO> checkMemberYn(String id) {
		List<ScoreVO> score = iScoreDao.checkMemberYn(id);
		return score;
	}
	
	public List<ScoreVO> socreBestRank() {
		List<ScoreVO> scoreBestRankList= iScoreDao.socreBestRank();
		return scoreBestRankList;
	}
	
	
	
}
