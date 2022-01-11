package com.findYou.attach.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.attach.dao.IAttachDao;
import com.findYou.attach.vo.AttachVO;
import com.findYou.exception.BizException;
import com.findYou.exception.BizNotFoundException;

@Service
public class AttachServiceImpl {
	
	@Inject
	private IAttachDao attachDao;
	
	public List<AttachVO> getAttaches(AttachVO attach) throws BizException{
		List<AttachVO> attaches = attachDao.getAttaches(attach);
		if(attaches == null) {
			throw new BizNotFoundException("첨부파일 [" + attach.getAtchParentNo() + "]에 대한 조회 실패");
		}
		return attaches;
	}
	
	//게시판 번호에 맞는 이미지파일 이름 불러오기
	public AttachVO getAttachByParentNo(AttachVO attach) throws BizNotFoundException{
		AttachVO attachVO = attachDao.getAttachFirstListByParentNo(attach);
		if(attachVO == null) {
			throw new BizNotFoundException();
		}
		return attachVO;
	}
	
	public int deleteBusinessAttach(int atchParentNo) {
		 int cnt = attachDao.deleteBusinessAttach(atchParentNo);
		 return cnt;
	}

	public void b2bdeleteAttach(int[] atchNo) {
		if(atchNo != null) {
			for (int i = 0; i < atchNo.length; i++) {
				int delNo= attachDao.deleteAttach(atchNo[i]);
			}
			
		}
	}
	
	
	
	
}