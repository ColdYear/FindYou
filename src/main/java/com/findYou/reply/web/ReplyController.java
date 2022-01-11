package com.findYou.reply.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.reply.service.ReplyServiceImpl;
import com.findYou.reply.vo.ReplyVO;

@RestController
public class ReplyController {

	@Inject
	@Qualifier("replyServiceImpl")
	ReplyServiceImpl replyServiceImpl;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/reply/replyList"
			, produces = "application/json;charset=utf-8")
	public Map<String, Object> replyList(ReplyVO replyVO) {
			logger.info("replyList에서 replyVO = {}", replyVO);
			List<ReplyVO> replyList = replyServiceImpl.getReplyListByParent(replyVO);
			logger.info("replyList={}",replyList.toString() );
			Map<String, Object> map = new HashMap<String, Object>();
			
			if(replyList.size() == 0) {
				map.put("warn", "댓글 목록이 없습니다.");
			}
			map.put("result", true);
			map.put("data", replyList);
			return map;
	}
	
	
	@RequestMapping(value="/reply/replyRegist"
			, produces = "application/json;charset=utf-8")
	public Map<String, Object> replyRegist(ReplyVO reply){
		logger.info("replyVO = {}", reply);
		replyServiceImpl.insertReply(reply);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("data", "등록 끝");
		return map;
		
	}
	
	@RequestMapping(value="/reply/replyModify"
			, produces = "application/json;charset=utf-8")
	public Map<String, Object> replyModify(ReplyVO reply){
		logger.info("수정할 때 replyVO = {}",reply);
		try{
			replyServiceImpl.updateReply(reply);
		}catch(BizNotEffectedException ebe) {
			ebe.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("data", "수정 끝");
		return map;
	}
	
	@RequestMapping(value="/reply/replyDelete"
			, produces = "application/json;charset=utf-8")
	public Map<String, Object> replyDelete(ReplyVO reply){
		replyServiceImpl.deleteReply(reply);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("data", "삭제 끝");
		return map;
	}
	
	
	
	
	
}
