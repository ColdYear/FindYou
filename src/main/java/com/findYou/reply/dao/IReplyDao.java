package com.findYou.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.reply.vo.ReplyVO;

@Mapper
public interface IReplyDao {
	
		
	/**
	 * 
	* @methodName : getReplyListByParent 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param searchVO
	* @return List<ReplyVO>
	* 게시글 번호에 맞는 댓글 리스트 조회
	 */
	public List<ReplyVO> getReplyListByParent(ReplyVO replyVO);

	
	/**
	 * 
	* @methodName : getReply 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param reNo
	* @return ReplyVO
	* 댓글 가져오기
	 */
	public ReplyVO getReply(int reNo);

	
	/**
	 * 
	* @methodName : updateReply 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param reply
	* @return int
	* 댓글 수정
	 */
	public int updateReply(ReplyVO reply);

	
	/**
	 * 
	* @methodName : deleteReply 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param reply
	* @return int
	* 댓글 삭제
	 */
	public int deleteReply(ReplyVO reply);

	
	/**
	 * 
	* @methodName : insertReply 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param reply
	* @return int
	* 댓글 삽입
	 */
	public int insertReply(ReplyVO reply);

	/**
	 * 
	* @methodName : replyBestRank 
	* @author     : pc13
	* @date       : 2022.01.05 
	* @return\
	* 댓글 많은 게시글 1~10위 불러오기
	 */
	public List<ReplyVO> replyBestRank();
	
	
	
	
}
