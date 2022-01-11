package com.findYou.normalBoard.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.attach.dao.IAttachDao;
import com.findYou.attach.vo.AttachVO;
import com.findYou.businessBoard.dao.IBusinessBoardDao;
import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.member.dao.IMemberDao;
import com.findYou.member.vo.MemberVO;
import com.findYou.normalBoard.dao.INormalBoardDao;
import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.normalBoard.vo.NormalSearchBoardVO;
import com.findYou.participation.dao.IParticipationDao;
import com.findYou.participation.vo.ParticipationVO;

@Service
public class NormalBoardServiceImpl {
	
	@Inject
	INormalBoardDao iNormalBoardDao;
	
	@Inject
	IBusinessBoardDao iBusinessBoardDao;
	
	@Inject
	IAttachDao iAttachDao;
	
	@Inject
	IMemberDao iMemberDao;
	
	@Inject
	IParticipationDao iParticipationDao;
	
	//리스트 불러오기
	public List<NormalBoardVO> getNormalBoardList(NormalSearchBoardVO search){
		List<NormalBoardVO> normalList = iNormalBoardDao.getNormalBoardList(search);
		
		//색깔 구분...
		for(NormalBoardVO normalBoardVO : normalList) {			
			if(normalBoardVO.getNormalBoardTemplate().equals("HB00")) {
				normalBoardVO.setNormalBoardColor("#f3969a");
			}else if(normalBoardVO.getNormalBoardTemplate().equals("CB00")) {
				normalBoardVO.setNormalBoardColor("#ffce67");
			}else {
				normalBoardVO.setNormalBoardColor("#78c2ad");
			}
		}
		return normalList;
	}
	
	public List<String> getTitleByIndex(List<ParticipationVO> list) throws BizNotFoundException{
		
		List<String> titleList = new ArrayList<String>();
		String tempTitle = null;
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getNormalpartCategory().equals("normal")) {				
				tempTitle = iNormalBoardDao.getTitleByIndex(list.get(i).getNormalPartBoardNumber());
			}else {
				tempTitle = iBusinessBoardDao.getBusinessBoard(list.get(i).getNormalPartBoardNumber()).getB2bBoardTitle();						
			}
			titleList.add(tempTitle);
			if(tempTitle == null) throw new BizNotFoundException();
		}
		return titleList;
	}
	

	//아이디에 맞는 게시글 하나 불러오기
	public NormalBoardVO getNormalBoard(String normalBoardIndex) throws BizNotFoundException{
		NormalBoardVO normalBoardVO = iNormalBoardDao.getNormalBoard(normalBoardIndex);
		if(normalBoardVO == null) throw new BizNotFoundException();
		return normalBoardVO;
	}
	
	
	//게시글 수정하기
	public void modifyNormalBoard(NormalBoardVO normalBoardVO, int[] atchDelNo) throws BizNotEffectedException{
		int cnt = iNormalBoardDao.updateNormalBoard(normalBoardVO);
		if(cnt <= 0) throw new BizNotEffectedException();
		
		List<AttachVO> attachList = normalBoardVO.getAttaches();
		if(attachList != null) {
			for(AttachVO attach : attachList) {
				attach.setAtchParentNo(normalBoardVO.getNormalBoardIndex());
				iAttachDao.insertAttach(attach);
			}
		}
		
		if(atchDelNo != null) {
			for(int i=0; i<atchDelNo.length; i++) {				
				int attachCnt = iAttachDao.deleteAttach(atchDelNo[i]);
				if(attachCnt <= 0)throw new BizNotEffectedException();
			}
		}
		
	}
	
	
	//게시글 삭제하기
	public void removeNormalBoard(String normalBoardIndex) throws BizNotEffectedException{
		int cnt = iNormalBoardDao.deleteNormalBoard(normalBoardIndex);
		if(cnt <= 0) throw new BizNotEffectedException();
	}
	
	
	//게시글 삽입하기
	public void insertNormalBoard(NormalBoardVO normalBoardVO) throws BizNotEffectedException, BizNotFoundException{
		//게시글 삽입
		int cnt = iNormalBoardDao.insertNormalBoard(normalBoardVO);
		
		//활동 내역 삽입
		ParticipationVO joinMember = new ParticipationVO();
		MemberVO member = iMemberDao.getMember(normalBoardVO.getNormalBoardWriter());
		if(member == null) throw new BizNotFoundException();
		joinMember.setNormalPartBoardNumber(normalBoardVO.getNormalBoardIndex());
		joinMember.setNormalPartId(normalBoardVO.getNormalBoardWriter());
		joinMember.setNormalPartAddr(member.getMemRoadAddr());
		iParticipationDao.insertJoinMember(joinMember);
		
		//첨부파일 삽입
		List<AttachVO> attachList = normalBoardVO.getAttaches();
		if(attachList != null) {
			for(AttachVO attach : attachList) {
				attach.setAtchParentNo(normalBoardVO.getNormalBoardIndex());
				iAttachDao.insertAttach(attach);
				
			}
		}
		if(cnt <= 0) throw new BizNotEffectedException();
		
	}
	
	//조회수 증가
	public void increaseNormalBoardHit(String normalBoardIndex) throws BizNotEffectedException{
		int cnt = iNormalBoardDao.increaseNormalBoardHit(Integer.parseInt(normalBoardIndex));
		if(cnt <= 0) throw new BizNotEffectedException();
	}
	
	public List<NormalBoardVO> homeNormalBoardList14(){
		List<NormalBoardVO> normalBoardList= iNormalBoardDao.homeNormalBoardList14();
		return normalBoardList;
	}
	
	public List<NormalBoardVO> homeNormalBoardList58(){
		List<NormalBoardVO> normalBoardList= iNormalBoardDao.homeNormalBoardList58();
		return normalBoardList;
	}
	
	
	//내가 만든 모임 게시물 리스트
	public List<NormalBoardVO> myPageMeetingList(String userId){
		List<NormalBoardVO> normalBoardList= iNormalBoardDao.myPageMeetingList(userId);
		return normalBoardList;
	}
	
	
	
}


















