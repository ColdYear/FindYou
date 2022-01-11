package com.findYou.recommendHobby.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.recommendHobby.vo.RecommendHobbyVO;
import com.findYou.recommendHobby.vo.RecommendValueVO;
@Mapper
public interface IRecommendHobbyDao {
	
	public List<RecommendHobbyVO> mbtiList();
	public List<RecommendHobbyVO> hobbyList(RecommendHobbyVO test);
	public List<NormalBoardVO> searchResult(RecommendValueVO valueVO);
}
