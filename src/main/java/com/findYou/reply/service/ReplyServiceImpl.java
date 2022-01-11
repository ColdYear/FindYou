package com.findYou.reply.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.reply.dao.IReplyDao;
import com.findYou.reply.vo.ReplyVO;

@Service
public class ReplyServiceImpl {

	@Inject
	IReplyDao iReplyDao;
	
	public List<ReplyVO> getReplyListByParent(ReplyVO replyVO){
		List<ReplyVO> b2bReplyList = iReplyDao.getReplyListByParent(replyVO);
		return b2bReplyList;
	}
	
	public void insertReply(ReplyVO reply) {
		iReplyDao.insertReply(reply);

	}
	
	public void updateReply(ReplyVO reply) throws BizNotEffectedException{
		int cnt = iReplyDao.updateReply(reply);
		if(cnt <= 0) throw new BizNotEffectedException();
	}
	
	public void deleteReply(ReplyVO reply) {
		iReplyDao.deleteReply(reply);
	}
	
	public List<ReplyVO> replyBestRank(){
		List<ReplyVO> replyBestRankList= iReplyDao.replyBestRank();
		return replyBestRankList;
	}
	
	
}
