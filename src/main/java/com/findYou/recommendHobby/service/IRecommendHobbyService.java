package com.findYou.recommendHobby.service;

import java.util.List;

import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.recommendHobby.vo.RecommendHobbyVO;
import com.findYou.recommendHobby.vo.RecommendValueVO;

public interface IRecommendHobbyService {

	public List<RecommendHobbyVO> mbtiList();
	public List<RecommendHobbyVO> hobbyList(RecommendHobbyVO test);
	public List<NormalBoardVO> searchResult(RecommendValueVO valueVO);

}
