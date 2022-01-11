package com.findYou.normalBoard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.businessBoard.vo.BusinessBoardVO;
import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.normalBoard.vo.NormalSearchBoardVO;

@Mapper
public interface INormalBoardDao {
	
	/**
	 * 
	* @methodName : getTotalRowCount 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param searchVO
	* @return int
	* DB에 있는 총 데이터의 개수를 가져옴
	 */
	public int getTotalRowCount(NormalSearchBoardVO searchVO);
	
	/**
	 * 
	* @methodName : getNormalBoardList 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param searchVO
	* @return List<NormalBoardVO>
	* 검색 조건에 맞는 일반 게시판 리스트 조회
	 */
	public List<NormalBoardVO> getNormalBoardList(NormalSearchBoardVO searchVO);
	
	

	/**
	 * 
	* @methodName : getTitleByIndex 
	* @author     : pc34 
	* @date       : 2021.12.14 
	* @param list
	* @return List<String>
	* 게시글 번호를 받아서 그 번호에 맞는 제목 리스트 추출
	 */
	public String getTitleByIndex(int list);
	
	
	/**
	 * 
	* @methodName : getNormalBoard 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param boNo
	* @return NormalBoardVO
	* 게시글 번호에 맞는 일반 게시글 조회
	 */
	public NormalBoardVO getNormalBoard(String boNo);
	
	
	/**
	 * 
	* @methodName : updateNormalBoard 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param board
	* @return int
	* 일반 게시글 수정
	 */
	public int updateNormalBoard(NormalBoardVO board);
	
	
	/**
	 * 
	* @methodName : deleteNormalBoard 
	* @author     : pc34 
	* @date       : 2021.12.04 
	* @param board
	* @return int
	* 일반 게시글 삭제
	* 
	 */
	public int deleteNormalBoard(String normalBoardIndex);
	
	/**
	 * 
	* @methodName : insertNormalBoard 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param board
	* @return int
	* 일반 게시글 삽입
	 */
	public int insertNormalBoard(NormalBoardVO board);
	
	/**
	 * 
	* @methodName : increaseHit 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param boNo
	* @return int
	* 조회수 증가
	 */
	public int increaseNormalBoardHit(int boNo);
	
	
	/**
	 * 
	* @methodName : homeBoardList 
	* @author     : pc13
	* @date       : 2022.01.04 
	* @return
	* 메인 홈 게시판 리스트 최신순 1~4개 불러오기
	 */
	public List<NormalBoardVO> homeNormalBoardList14();
	
	/**
	 * 
	* @methodName : homeBoardList 
	* @author     : pc13
	* @date       : 2022.01.04 
	* @return
	* 메인 홈 게시판 리스트 최신순 5~8개 불러오기
	 */
	public List<NormalBoardVO> homeNormalBoardList58();
	
	/**
	 * 
	* @methodName : myPageMeetingList 
	* @author     : pc13
	* @date       : 2022.01.07 
	* @return
	* 마이페이지에서 내가 만든 모임 리스트 불러오기
	 */
	public List<NormalBoardVO> myPageMeetingList(String userId);
	
	
	
	
}
