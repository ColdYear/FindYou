package com.findYou.chatting.service;

import java.util.List;

import com.findYou.chatting.vo.ChattingVO;

public interface IChattingService {
	public List<ChattingVO> getChatList(int chatNo);
	public List<ChattingVO> getChat(); 
	public int insertChat(ChattingVO chattingVO);


}
