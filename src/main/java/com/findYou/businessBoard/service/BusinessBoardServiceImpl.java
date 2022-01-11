package com.findYou.businessBoard.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.findYou.attach.dao.IAttachDao;
import com.findYou.attach.vo.AttachVO;
import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.businessBoard.dao.IBusinessBoardDao;
import com.findYou.businessBoard.vo.BusinessBoardVO;
import com.findYou.businessBoard.vo.BusinessSearchBoardVO;
import com.findYou.code.dao.ICodeDao;
import com.findYou.code.vo.CodeVO;
import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.normalBoard.dao.INormalBoardDao;
import com.findYou.participation.vo.ParticipationVO;
@Service
public class BusinessBoardServiceImpl {
	
	@Inject
//	@Qualifier("iBusinessBoardDao")
	IBusinessBoardDao iBusinessBoardDao;
	
	@Inject
	ICodeDao iCodeDao;
	
	@Inject
	IAttachDao iAttachDao;
	
	@Inject
	INormalBoardDao iNormalBoardDao; 
	
	
	public List<BusinessBoardVO> getBusinessBoardList(BusinessSearchBoardVO searchVO){
		List<BusinessBoardVO> businessBoardList = iBusinessBoardDao.getBusinessBoardList(searchVO);
		return businessBoardList;
	}
	
	
	
	
	public BusinessBoardVO getBusinessBoard(int b2bBoardIndex) throws BizNotFoundException{

		BusinessBoardVO getBoard = iBusinessBoardDao.getBusinessBoard(b2bBoardIndex);
		if(getBoard == null) {
			throw new BizNotFoundException();
		}
		return getBoard;
	}
	
	
	
	public int updateBusinessBoard(BusinessBoardVO board, int[] atchNo) throws BizNotEffectedException{
		int cnt = iBusinessBoardDao.updateBusinessBoard(board);
		if(cnt <=0) {
			throw new BizNotEffectedException();
		}
		List<AttachVO> attachList = board.getB2bAttaches();
		
		if(attachList != null) {
			
			for(int i=0; i<attachList.size(); i++) {
				
				iAttachDao.insertAttach(attachList.get(i));
			}
		}
		if(atchNo != null) {
			for (int i = 0; i < atchNo.length; i++) {
				int delNo= iAttachDao.deleteAttach(atchNo[i]);
			}
			
		}
		return cnt;
	}
	public int deleteBusinessBoard(BusinessBoardVO board) {
		 int cnt = iBusinessBoardDao.deleteBusinessBoard(board);
		 return cnt;
	}

	public int insertBusinessBoard(BusinessBoardVO board) throws BizNotEffectedException{
		int cnt = iBusinessBoardDao.insertBusinessBoard(board);
		if(cnt <= 0) new BizNotEffectedException();
		for (int i = 0; i < board.getB2bAttaches().size(); i++) {
			AttachVO attach = board.getB2bAttaches().get(i);
			attach.setAtchParentNo(board.getB2bBoardIndex());
			int attachCnt = iAttachDao.insertAttach(attach);
			if(attachCnt <= 0) new BizNotEffectedException();
		}	
		return cnt;
	}
	public List<CodeVO> getCodeListByParent(String parentCode){
		List<CodeVO> codeList = iCodeDao.getCodeListByParent(parentCode);
		return codeList;
	}
	public void increseBusinessBoardHit(int BoardIndex) {
		iBusinessBoardDao.increaseHit(BoardIndex);
	}
	

	 public String b2bUpDelButton(B2bParticipationVO partVO) {
		 String b2bPartId = iBusinessBoardDao.b2bUpDelButton(partVO);
		 return b2bPartId;
	 }

		public List<String> getTitleByIndex(List<B2bParticipationVO> list) throws BizNotFoundException{
			
			List<String> titleList = new ArrayList<String>();
			String tempTitle = null;
			for(int i=0; i<list.size(); i++) {
				if(list.get(i).getB2bCategory().equals("normal")) {				
					tempTitle = iNormalBoardDao.getTitleByIndex(list.get(i).getB2bPartBoardNumber());
				}else {
					tempTitle = iBusinessBoardDao.getBusinessBoard(list.get(i).getB2bPartBoardNumber()).getB2bBoardTitle();						
				}
				titleList.add(tempTitle);
				if(tempTitle == null) throw new BizNotFoundException();
			}
			return titleList;
		}

		public List<BusinessBoardVO> homeBoardList14(){
			List<BusinessBoardVO> businessBoardList= iBusinessBoardDao.homeBoardList14();
			return businessBoardList;
		}
		
		public List<BusinessBoardVO> homeBoardList58(){
			List<BusinessBoardVO> businessBoardList= iBusinessBoardDao.homeBoardList58();
			return businessBoardList;
		}
		
		
		public List<BusinessBoardVO> cutBestRank(){
			List<BusinessBoardVO> cntBestRankList= iBusinessBoardDao.cutBestRank();
			return cntBestRankList;
		}
		
		
		
	 
}
