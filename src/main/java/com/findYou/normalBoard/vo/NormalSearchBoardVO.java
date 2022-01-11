package com.findYou.normalBoard.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class NormalSearchBoardVO {
	private String normalBoardSearchType = "TOTAL";
	private String normalBoardSearchWord;
	private String normalBoardOrderType = "DAY";
	
	
	
	

	public String getNormalBoardSearchType() {
		return normalBoardSearchType;
	}
	public void setNormalBoardSearchType(String normalBoardSearchType) {
		this.normalBoardSearchType = normalBoardSearchType;
	}
	public String getNormalBoardSearchWord() {
		return normalBoardSearchWord;
	}
	public void setNormalBoardSearchWord(String normalBoardSearchWord) {
		this.normalBoardSearchWord = normalBoardSearchWord;
	}
	public String getNormalBoardOrderType() {
		return normalBoardOrderType;
	}
	public void setNormalBoardOrderType(String normalBoardOrderType) {
		this.normalBoardOrderType = normalBoardOrderType;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
}
