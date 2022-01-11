package com.findYou.participation.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.participation.dao.IParticipationDao;
import com.findYou.participation.vo.ParticipationVO;

@Service
public class ParticipationServiceImpl {

	@Inject
	IParticipationDao iParticipationDao;
	
	
	public ParticipationVO getJoinMember(ParticipationVO joinMember) {
		ParticipationVO part = iParticipationDao.getJoinMember(joinMember);
		return part;
	}
	
	//참여하기 
	public boolean modifyJoinMember(ParticipationVO joinMember) throws BizNotEffectedException{
		
		ParticipationVO checkMember = iParticipationDao.getJoinMember(joinMember);
		int joinCount = iParticipationDao.getJoinMemberCount(joinMember.getNormalPartBoardNumber());
		if(checkMember == null && joinCount < joinMember.getNormalPartMemberCount()) {	 //@@@@@여기할차례 게시글 번호별 아이디로 판단해서 참여완료		
			int cnt = iParticipationDao.insertJoinMember(joinMember);
			if(cnt <= 0) throw new BizNotEffectedException();
			return true;
		}else {
			if(joinCount >= joinMember.getNormalPartMemberCount()) {
				return false;
			}else {
				//다시 참여되게 끔.. 취소여부만 'N'으로 바꿔줌
				iParticipationDao.updateParticipationMember(joinMember);
				return true;
			}
		}
	}
	
	//모임에 참가한 사람들 보기위해 게시판 번호를 통해 멤버리스트 조회
	public List<ParticipationVO> getJoinMemberListByBoardIndex(int boardIndex) throws BizNotFoundException{
		List<ParticipationVO> partList = iParticipationDao.getJoinMemberListByBoardIndex(boardIndex);
		if(partList == null) throw new BizNotFoundException();
		return partList;
	}
	
	public List<ParticipationVO> getJoinMemberListByIndex(int boardIndex) throws BizNotFoundException{
		List<ParticipationVO> partList = iParticipationDao.getJoinMemberListByIndex(boardIndex);
		if(partList == null) throw new BizNotFoundException();
		return partList;
	}
	
	
	//모임에 참여한 인원수확인
	public int joinMemberCount(int boardIndex){
		int cnt = iParticipationDao.getJoinMemberCount(boardIndex);
		return cnt;
	}
	
	//회원상세 조회 시, 회원이 참여한 활동내역 리스트
	public List<String> getBoardNumberListById(ParticipationVO joinMember) throws BizNotFoundException{
			List<String> partList = iParticipationDao.getBoardNumberById(joinMember);
			if(partList == null) throw new BizNotFoundException();
			return partList;
	}
	
	//취소하기
	public void deleteParticipationMember(ParticipationVO joinMember) throws BizNotEffectedException{
		int cnt = iParticipationDao.deleteParticiaptionMember(joinMember);
		if(cnt <= 0) throw new BizNotEffectedException();
	}
	
	
	//모임에 참여한 사람인지 판단
	public boolean checkBoardNumber(ParticipationVO joinMember) {
		List<ParticipationVO> partList = iParticipationDao.getJoinMemberListByBoardIndex(joinMember.getNormalPartBoardNumber());
		for(int i=0; i<partList.size(); i++) {
			if(partList.get(i).getNormalPartId().equals(joinMember.getNormalPartId())) {
				return true; //참여중인 사람이 있다
			}
		}
		return false; //참여중인 사람이 없다.
	}
	
	public void foreverDelete(String index) throws BizNotEffectedException{
		int cnt = iParticipationDao.foreverDeleteParticipationMember(index);
		if(cnt <= 0) throw new BizNotEffectedException();
	}
	
	
	public List<ParticipationVO> getAllPartList(ParticipationVO joinMember){
		List<ParticipationVO> list = iParticipationDao.getAllPartList(joinMember); 
		return list;
	}
	
	
}
