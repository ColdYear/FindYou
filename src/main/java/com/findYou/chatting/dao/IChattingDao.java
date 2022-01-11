package com.findYou.chatting.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.chatting.vo.ChattingVO;

@Mapper
public interface IChattingDao {

	public int insertChat(ChattingVO chattingVO);
	public List<ChattingVO> getChatList(int chatNo);	
	public List<ChattingVO> getChat(); 
 
	
}
