package com.findYou.message.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.findYou.common.vo.PagingVO;
import com.findYou.exception.BizNotEffectedException;
import com.findYou.message.service.MessageServiceImpl;
import com.findYou.message.vo.MessageVO;

@Controller
public class MessageController {

	@Inject
	MessageServiceImpl messageServiceImpl;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@ResponseBody
	@RequestMapping("/message/sendMessage")
	public String sendMessage(MessageVO message) {
		try{
			String sender = message.getMsgSender();
			String receiver = message.getMsgReceiver();
			if(sender.equals(receiver)) {
				return "false";
			}
			messageServiceImpl.insertMessage(message);
		}catch(BizNotEffectedException ebe) {
			ebe.printStackTrace();
		}
		return "true";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/message/getReceiveMessageList")
	public Map<String, Object> getReceiveMessageList(String receiver){
		logger.info("receiver = {}",receiver);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		PagingVO paging = new PagingVO();
		int count = messageServiceImpl.getCountByReceiver(receiver);
		logger.info("count = {}",count);
		paging.setTotalRowCount(count);
		paging.pageSetting();
		map.put("pagingVO", paging);
		
		int firstRow = 0;
		int lastRow = 0;
		List<MessageVO> msgList = messageServiceImpl.getMessageByReceiver(receiver,firstRow, lastRow);
		logger.info("msgList = {}", msgList);
		map.put("list", msgList);
		
		//쪽지함 다 읽었다고 업데이트해주기
		messageServiceImpl.updateReadYn();
		
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/message/getSendMessageList")
	public Map<String, Object> getSendMessageList(String sender){
		logger.info("sender = {}", sender);
		Map<String, Object> map = new HashMap<String, Object>();
		
		PagingVO paging = new PagingVO();
		int count = messageServiceImpl.getCountBySender(sender);
		logger.info("count = {}",count);
		paging.setTotalRowCount(count);
		paging.pageSetting();
		map.put("pagingVO", paging);
		
		int firstRow = 0;
		int lastRow = 0;
		List<MessageVO> msgList = messageServiceImpl.getMessageBySender(sender, firstRow, lastRow);
		map.put("list", msgList);
		
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/message/deleteMessage")
	public void deleteMessage(@RequestParam("msgCheck") List<String> msgCheck) {
		
		logger.info("msgCheck = {}", msgCheck);
		
		try {
			messageServiceImpl.deleteMessage(msgCheck);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
		}
	}
	
	
	
	@RequestMapping("/message/messageList.wow")
	public String messageList() {
	
		return "mypage/message";
	}
	
	
	@ResponseBody
	@RequestMapping("/message/receivePaging")
	public Map<String, Object> getSendMessageListByReceivepaging(String receiver, int curPage){
		logger.info("sender = {}", receiver);
		Map<String, Object> map = new HashMap<String, Object>();
		
		//paging 셋팅
		PagingVO paging = new PagingVO();
		paging.setCurPage(curPage);
		int count = messageServiceImpl.getCountByReceiver(receiver);
		logger.info("count = {}",count);
		paging.setTotalRowCount(count);
		paging.pageSetting();
		
		map.put("pagingVO", paging);
		
		logger.info("pagingVO = {}",paging);
		
		int firstRow = paging.getFirstRow();
		int lastRow = paging.getLastRow();
		
		List<MessageVO> msgList = messageServiceImpl.getMessageByReceiver(receiver, firstRow, lastRow);
		logger.info("msgList = {}", msgList);
		map.put("list", msgList);

		return map;
	}
	
	@ResponseBody
	@RequestMapping("/message/sendPaging")
	public Map<String, Object> getSendMessageListBySendpaging(String sender, int curPage){
		logger.info("sender = {}", sender);
		Map<String, Object> map = new HashMap<String, Object>();
		
		//paging 셋팅
		PagingVO paging = new PagingVO();
		paging.setCurPage(curPage);
		int count = messageServiceImpl.getCountBySender(sender);
		logger.info("count = {}", count);
		paging.setTotalRowCount(count);
		paging.pageSetting();
		
		map.put("pagingVO", paging);
		
		logger.info("pagingVO = {}",paging);
		int firstRow = paging.getFirstRow();
		int lastRow = paging.getLastRow();
		
		
		List<MessageVO> msgList = messageServiceImpl.getMessageBySender(sender, firstRow, lastRow);
		map.put("list", msgList);

		return map;
	}
	
	
	

	
	
}
