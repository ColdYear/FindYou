package com.findYou.notice.service;

import java.util.List;

import javax.inject.Inject;

import com.findYou.exception.BizNotEffectedException;
import com.findYou.notice.vo.NoticeVO;

public interface INoticeService {
	
	public List<NoticeVO> getNoticeList();
	public void insertNoticeBoard(NoticeVO notice) throws BizNotEffectedException;
	public NoticeVO getNotice(String boNo);
	public void updateNotice(NoticeVO board) throws BizNotEffectedException;
	public void deleteNotice(NoticeVO board) throws BizNotEffectedException;

	public List<NoticeVO> 	noticeBoardList14();
	public List<NoticeVO> 	noticeBoardList58();
		
	
	

}
