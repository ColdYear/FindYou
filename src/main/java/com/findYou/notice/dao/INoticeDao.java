package com.findYou.notice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.notice.vo.NoticeSearchVO;
import com.findYou.notice.vo.NoticeVO;
@Mapper
public interface INoticeDao {
	
	/**
	 * 
	* @methodName : getTotalRowCount 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param searchVO
	* @return int
	* DB에 있는 총 데이터의 개수를 가져옴
	 */
	public int getTotalRowCount(NoticeSearchVO searchVO);
	
	
	/**
	 * 
	* @methodName : getNoticeList 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param searchVO
	* @return List<NoticeVO>
	* 검색 조건에 맞는 공지사항 게시판 리스트 조회
	 */
	public List<NoticeVO> getNoticeList();
	
	
	/**
	 * 
	* @methodName : getNotice 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param boNo
	* @return NoticeVO
	* 게시글 번호에 맞는 공지사항 게시글 조회
	 */
	public NoticeVO getNotice(String boNo);
	
	
	/**
	 * 
	* @methodName : updateNotice 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param board
	* @return int
	* 공지사항 게시글 수정
	 */
	public int updateNotice(NoticeVO board);
	
	
	/**
	 * 
	* @methodName : deleteNotice 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param board
	* @return int
	* 공지사항 게시글 삭제
	* 
	 */
	public int deleteNotice(NoticeVO board);
	
	/**
	 * 
	* @methodName : insertNotice 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param board
	* @return
	* 공지사항 게시글 삽입
	 */
	public int insertNotice(NoticeVO board);
	
	
	/**
	 * 
	* @methodName : noticeBoardList14 
	* @author     : pc13
	* @date       : 2022.01.06 
	* @return
	* 공지사항 최근 1~4번 불러오기
	 */
	public List<NoticeVO> noticeBoardList14();
	
	/**
	 * 
	* @methodName : noticeBoardList14 
	* @author     : pc13
	* @date       : 2022.01.06 
	* @return
	* 공지사항 최근 5~8번 불러오기
	 */
	public List<NoticeVO> noticeBoardList58();
	
	
	
}
