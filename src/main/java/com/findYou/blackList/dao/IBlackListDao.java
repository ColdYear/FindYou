package com.findYou.blackList.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.blackList.vo.BlackListVO;
@Mapper
public interface IBlackListDao {

	//블랙리스트 멤버 조회
	public BlackListVO getBlackList(String id);
	
	//블랙리스트 삽입
	public int insertBlackList(BlackListVO member);
	
	//사업자 게시판 회원 상세보기 성별/블랙리스트 여부
	public List<BlackListVO> businessGenderCheck();
	
	
}
