package com.findYou.score.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.findYou.score.vo.ScoreVO;

@Mapper
public interface IScoreDao {

	
	public int insert(ScoreVO score);
	
	
	//내가 평가한 사람이 몇명인지
	public int countMember(ScoreVO score);
	
	public ScoreVO getScoreMember(ScoreVO score);
	
	public List<ScoreVO> getScoreList(ScoreVO score); 
	
	
	public String getScoreById(String scoreId);
	
	public List<ScoreVO> checkMemberYn(String id);
	
	/**
	 * 
	* @methodName : cutBestRank 
	* @author     : pc13
	* @date       : 2022.01.05 
	* @return
	* 평점 순 1~10위 아이디
	 */
	public List<ScoreVO> socreBestRank();
	
	
	public List<ScoreVO> getLowScoreList();
}
