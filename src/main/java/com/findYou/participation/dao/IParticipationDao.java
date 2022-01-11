package com.findYou.participation.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.participation.vo.ParticipationVO;

@Mapper
public interface IParticipationDao {

	/**
	 * 
	* @methodName : insertJoinMember 
	* @author     : 여인욱 
	* @date       : 2021.12.14 
	* @param joinMember
	* @return int
	* 참여하기 눌렀을 때 DB목록에 추가한다.
	 */
	public int insertJoinMember(ParticipationVO joinMember);
	
	/**
	 * 
	* @methodName : getJoinMember 
	* @author     : 여인욱 
	* @date       : 2021.12.14 
	* @param joinMemId
	* @return ParticipationVO
	* 해당 아이디가 DB에 있는지 확인하기 위해 사용
	* 
	 */
	public ParticipationVO getJoinMember(ParticipationVO joinMember);
	
	/**
	 * 
	* @methodName : getJoinMemberCount 
	* @author     : 여인욱
	* @date       : 2021.12.14 
	* @param BoardNumber
	* @return int
	* 각 게시판 별 몇명이 참가하였는지 반환
	 */
	public int getJoinMemberCount(int BoardNumber);
	
	
	/**
	 * 
	* @methodName : getJoinMemberList 
	* @author     : 여인욱 
	* @date       : 2021.12.14 
	* @param normalPartBoardIndex
	* @return List<ParticipationVO>
	* 참여 목록 눌렀을 때 게시판(모임)에 참여한 회원목록리스트를 조회함
	 */
	public List<ParticipationVO> getJoinMemberListByBoardIndex(int normalPartBoardIndex);
	
	/**
	 * 
	* @methodName : getBoardNumberById 
	* @author     : 여인욱 
	* @date       : 2021.12.15 
	* @param joinMember
	* @return List<String>
	* 회원이 참여한 게시판 번호를 출력함.
	 */
	public List<String> getBoardNumberById(ParticipationVO joinMember);
	
	/**
	 * 
	* @methodName : deleteParticiaptionMember 
	* @author     : 여인욱 
	* @date       : 2021.12.15 
	* @param joinMember
	* @return int
	* 참여한 모임 취소하기
	 */
	public int deleteParticiaptionMember(ParticipationVO joinMember);
	
	
	/**
	 * 
	* @methodName : updateParticipationMember 
	* @author     : 여인욱 
	* @date       : 2021.12.15 
	* @param joinMember
	* @return int
	* 참가 > 취소 > 참가 할 경우 취소여부 다시 N으로 수정
	 */
	public int updateParticipationMember(ParticipationVO joinMember);
	
	/**
	 * 
	* @methodName : foreverDeleteParticipationMember 
	* @author     : pc34 
	* @date       : 2021.12.22 
	* @param index
	* @return int
	* 참여한 게시글 자체가 삭제될 때 참여한 인원 모두 삭제되야함
	 */
	public int foreverDeleteParticipationMember(String index);

	
	public int updateScoreYN(ParticipationVO part);
	
	public List<ParticipationVO> getJoinMemberListByIndex(int normalPartBoardIndex);
	
	
	public List<ParticipationVO> getAllPartList(ParticipationVO joinMember);
}














