package com.findYou.message.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.message.vo.MessageVO;

@Mapper
public interface IMessageDao {

	public int insertMessage(MessageVO message);
	
	//보낸 쪽지함 조회
	public List<MessageVO> getMessageBySender(MessageVO message);
	
	//받은 쪽지함 조회
	public List<MessageVO> getMessageByReceiver(MessageVO message);
	
	public int deleteMessage(String message);
	
	public int getCountByReceiver(String receiver);
	
	public int getCountBySender(String sender);
	
	//쪽지 읽엇는지 여부 결정
	public int checkReadYn();
	
	
	//쪽지 읽었으면 여부를 Y로 바꿔줌
	public int updateReadYn();
}
