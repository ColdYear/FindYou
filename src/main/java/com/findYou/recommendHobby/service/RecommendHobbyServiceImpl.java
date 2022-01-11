package com.findYou.recommendHobby.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.findYou.member.vo.MemberVO;
import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.recommendHobby.dao.IRecommendHobbyDao;
import com.findYou.recommendHobby.vo.RecommendHobbyVO;
import com.findYou.recommendHobby.vo.RecommendValueVO;

@Service
public class RecommendHobbyServiceImpl  implements IRecommendHobbyService{

	@Inject
	IRecommendHobbyDao hobbyDao;
	@Override
	public List<RecommendHobbyVO> mbtiList() {

		return hobbyDao.mbtiList();
	}
	@Override
	public List<RecommendHobbyVO> hobbyList(RecommendHobbyVO test) {
		
		return hobbyDao.hobbyList(test);
	}
	@Override
	public List<NormalBoardVO> searchResult(RecommendValueVO valueVO) {
			
		return hobbyDao.searchResult(valueVO);
	}


}
