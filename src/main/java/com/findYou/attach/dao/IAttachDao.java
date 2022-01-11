package com.findYou.attach.dao;

import java.util.List;

import com.findYou.attach.vo.AttachVO;

public interface IAttachDao {

	/**
	 * 
	* @methodName : insertAttach 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param attach
	* @return int
	* 첨부파일 등록하기
	 */
	public int insertAttach(AttachVO attach);
	
	
	/**
	 * 
	* @methodName : deleteAttach 
	* @author     : 여인욱
	* @date       : 2021.12.04 
	* @param atchNo
	* @return int
	* 첨부파일 삭제하기
	 */
	public int deleteAttach(int atchNo);
	
	
	/**
	 * 
	* @methodName : getAttach 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param atchNo
	* @return AttachVO
	* 첨부파일 상세조회
	 */
	public List<AttachVO> getAttaches(AttachVO attach);
	
		
	/**
	 * 
	* @methodName : getAttachByParentNoList 
	* @author     : 여인욱 
	* @date       : 2021.12.04 
	* @param attach
	* @return List<AttachVO>
	*  부모번호에 따른 목록 조회
	 */
	public List<AttachVO> getAttachByParentNoList(AttachVO attach);

	/**
	 * 
	* @methodName : getAttachFirstListByParentNo 
	* @author     : pc34 
	* @date       : 2021.12.11 
	* @return List<AttachVO>
	* list화면에서 대표사진을 보여주기 위해서, 
	* 게시글 별로 사진 하나씩만 가져와서 보여준다.
	 */
	public AttachVO getAttachFirstListByParentNo(AttachVO attach);
	
	
	public AttachVO getAttachFirstListByParentNo2(int parentNo);
	
	/**
	 * 
	* @methodName : increaseDownHit 
	* @author     : 여인욱
	* @date       : 2021.12.04 
	* @param atchNo
	* @return int
	* 첨부파일 다운로드 횟수 증가
	 */
	public int increaseDownHit(int atchNo);
	
	
	/**
	 * 
	* @methodName : deleteBusinessAttach 
	* @author     : pc13
	* @date       : 2021.12.24 
	* @param atchParentNo
	* @return
	* 게시글 삭제할 때 첨부파일 기록 삭제
	 */
	public int deleteBusinessAttach(int atchParentNo);
	
	
	
}
