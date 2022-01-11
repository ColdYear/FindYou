package com.findYou.chatting.service;

import java.util.List;

import javax.inject.Inject;


import org.springframework.stereotype.Service;

import com.findYou.chatting.dao.IChattingDao;
import com.findYou.chatting.vo.ChattingVO;
@Service
public class ChattingServiceImpl implements IChattingService{

	@Inject
	IChattingDao chattingDao;


	@Override
	public List<ChattingVO> getChatList(int chatNo) {
			
		return chattingDao.getChatList(chatNo);
	}


	@Override
	public List<ChattingVO> getChat() {
		
		return chattingDao.getChat();
	}


	@Override
	public int insertChat(ChattingVO chattingVO) {
		chattingDao.insertChat(chattingVO);
		return 0;
	}





	

}
