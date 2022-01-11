package com.findYou.businessBoard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.businessBoard.vo.BusinessBoardVO;
import com.findYou.businessBoard.vo.BusinessSearchBoardVO;

@Mapper
public interface IBusinessBoardDao {
	
	
	/**
	 * 
	* @methodName : getTotalRowCount 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param searchVO
	* @return int
	* DB에 있는 총 데이터의 개수를 가져옴
	 */
	public int getTotalRowCount(BusinessSearchBoardVO searchVO);
	
	
	/**
	 * 
	* @methodName : getBusinessBoardList 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param searchVO
	* @return List<BusinessBoardVO>
	* 검색 조건에 맞는 사업자 게시판 리스트 조회
	 */
	public List<BusinessBoardVO> getBusinessBoardList(BusinessSearchBoardVO searchVO);
	
	
	/**
	 * 
	* @methodName : getBusinessBoard 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param boNo
	* @return BusinessBoardVO
	* 게시글 번호에 맞는 사업자 게시글 조회
	 */
	public BusinessBoardVO getBusinessBoard(int b2bBoardIndex);
	
	
	/**
	 * 
	* @methodName : updateBusinessBoard 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param board
	* @return int
	* 사업자 게시글 수정
	 */
	public int updateBusinessBoard(BusinessBoardVO board);
	
	
	/**
	 * 
	* @methodName : deleteBusinessBoard 
	* @author     : pc34 
	* @date       : 2021.12.04 
	* @param board
	* @return int
	* 사업자 게시글 삭제
	* 
	 */
	public int deleteBusinessBoard(BusinessBoardVO board);
	
	/**
	 * 
	* @methodName : insertBusinessBoard 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param board
	* @return int
	* 사업자 게시글 삽입
	 */
	public int insertBusinessBoard(BusinessBoardVO board);
	
	/**
	 * 
	* @methodName : increaseHit 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param boNo
	* @return int
	* 조회수 증가
	 */
	public int increaseHit(int boNo);

	

	
	/**
	 * 
	* @methodName : b2bUpDelButton 
	* @author     : pc13
	* @date       : 2022.12.30 
	* @param partVO
	* @return
	* 수정삭제버튼 여부 확인
	 */
	public String b2bUpDelButton(B2bParticipationVO partVO);

	/**
	 * 
	* @methodName : homeBoardList 
	* @author     : pc13
	* @date       : 2022.01.04 
	* @return
	* 메인 홈 게시판 리스트 최신순 1~4개 불러오기
	 */
	public List<BusinessBoardVO> homeBoardList14();
	
	/**
	 * 
	* @methodName : homeBoardList 
	* @author     : pc13
	* @date       : 2022.01.04 
	* @return
	* 메인 홈 게시판 리스트 최신순 5~8개 불러오기
	 */
	public List<BusinessBoardVO> homeBoardList58();
	
	
	/**
	 * 
	* @methodName : cutBestRank 
	* @author     : pc13
	* @date       : 2022.01.05 
	* @return
	* 조회수 랭킹 10위까지
	 */
	public List<BusinessBoardVO> cutBestRank();
	
}
