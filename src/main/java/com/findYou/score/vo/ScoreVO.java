package com.findYou.score.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class ScoreVO {
	private int memberScoreIndex; 
	private int memberScoreBoardNumber;
	private String memberScoreId; 
	private String memberScore;
	private String memberScoreTester;
	
	//평점 1점 개수
	private int lowCount;
	
	public int getMemberScoreIndex() {
		return memberScoreIndex;
	}
	public void setMemberScoreIndex(int memberScoreIndex) {
		this.memberScoreIndex = memberScoreIndex;
	}
	public int getMemberScoreBoardNumber() {
		return memberScoreBoardNumber;
	}
	public void setMemberScoreBoardNumber(int memberScoreBoardNumber) {
		this.memberScoreBoardNumber = memberScoreBoardNumber;
	}
	public String getMemberScoreId() {
		return memberScoreId;
	}
	public void setMemberScoreId(String memberScoreId) {
		this.memberScoreId = memberScoreId;
	}
	public String getMemberScore() {
		return memberScore;
	}
	public void setMemberScore(String memberScore) {
		this.memberScore = memberScore;
	}
	public String getMemberScoreTester() {
		return memberScoreTester;
	}
	public void setMemberScoreTester(String memberScoreTester) {
		this.memberScoreTester = memberScoreTester;
	}
	
	public int getLowCount() {
		return lowCount;
	}
	public void setLowCount(int lowCount) {
		this.lowCount = lowCount;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
}
