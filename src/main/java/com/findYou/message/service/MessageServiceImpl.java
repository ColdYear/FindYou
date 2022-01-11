package com.findYou.message.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.exception.BizNotEffectedException;
import com.findYou.message.dao.IMessageDao;
import com.findYou.message.vo.MessageVO;

@Service
public class MessageServiceImpl {
	
	@Inject
	IMessageDao iMessageDao;
	
	//쪽지 보내기
	public int insertMessage(MessageVO message) throws BizNotEffectedException{
		int cnt = iMessageDao.insertMessage(message);
		if(cnt <= 0) throw new BizNotEffectedException();
		return cnt;
	}
	
	public List<MessageVO> getMessageBySender(String id, int firstRow, int lastRow){
		MessageVO message = new MessageVO();
		message.setMsgSender(id);
		if(firstRow == 0 && lastRow == 0) {			
			message.setFirstRow(1);
			message.setLastRow(15);
		}else {
			message.setFirstRow(firstRow);
			message.setLastRow(lastRow);
		}
		List<MessageVO> sendList = iMessageDao.getMessageBySender(message);
		
		return sendList;
	}
	
	public List<MessageVO> getMessageByReceiver(String id, int firstRow, int lastRow){
		MessageVO message = new MessageVO();
		message.setMsgReceiver(id);
		if(firstRow == 0 && lastRow == 0) {			
			message.setFirstRow(1);
			message.setLastRow(15);
		}else {
			message.setFirstRow(firstRow);
			message.setLastRow(lastRow);
		}
		List<MessageVO> receiveList = iMessageDao.getMessageByReceiver(message);
		
		return receiveList;
	}
	
	public void deleteMessage(List<String> message) throws BizNotEffectedException{
		
		for(int i=0; i<message.size(); i++) {			
			int cnt = iMessageDao.deleteMessage(message.get(i));
			if(cnt <= 0) throw new BizNotEffectedException();
		}
	}
	
	public int getCountByReceiver(String receiver) {
		int cnt = iMessageDao.getCountByReceiver(receiver);
		return cnt;
	}
	
	public int getCountBySender(String sender) {
		int cnt = iMessageDao.getCountBySender(sender);
		return cnt;
	}
	
	public int checkReadYn() {
		int cnt = iMessageDao.checkReadYn();
		return cnt;
	}
	
	public void updateReadYn() {
		iMessageDao.updateReadYn();
	}
	
}
