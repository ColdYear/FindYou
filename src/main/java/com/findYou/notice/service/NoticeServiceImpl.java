package com.findYou.notice.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.exception.BizNotEffectedException;
import com.findYou.member.vo.MemberVO;
import com.findYou.notice.dao.INoticeDao;
import com.findYou.notice.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements INoticeService {

	@Inject
	INoticeDao noticeDao;
	
	@Override
	public List<NoticeVO> getNoticeList(){
		List<NoticeVO> noticeList = noticeDao.getNoticeList();
		
		return noticeList;
		
		
	}
	@Override
	public void insertNoticeBoard(NoticeVO notice) throws BizNotEffectedException{
		int cnt = noticeDao.insertNotice(notice);
		if(cnt <= 0) {
			throw new BizNotEffectedException();
			
		
		}

	}
	@Override
	public NoticeVO getNotice(String boNo) {
		NoticeVO notice =noticeDao.getNotice(boNo);
		
		
		return notice;
	}
	@Override
	public void updateNotice(NoticeVO board) throws BizNotEffectedException{
		int cnt = noticeDao.updateNotice(board);
		if(cnt <=0) {
			throw new BizNotEffectedException();
		}
	}
	@Override
	public void deleteNotice(NoticeVO board) throws BizNotEffectedException {
		int cnt = noticeDao.deleteNotice(board);
		if(cnt <=0) {
			throw new BizNotEffectedException();
		}
		
	}
	
	@Override
	public List<NoticeVO> noticeBoardList14() {
		List<NoticeVO> noticeBoardList14= noticeDao.noticeBoardList14();
		return noticeBoardList14;
	}
	@Override
	public List<NoticeVO> noticeBoardList58() {
		List<NoticeVO> noticeBoardList58= noticeDao.noticeBoardList58();
		return noticeBoardList58;

	}
	
	
	
	
	
}
