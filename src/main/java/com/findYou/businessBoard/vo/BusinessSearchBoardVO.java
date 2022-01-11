package com.findYou.businessBoard.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class BusinessSearchBoardVO {
	
	private String businessBoardSearchWord;
	private String businessBoardSearchType;
	private String businessBoardSearchCategory="b2bBoardRegDate";
	
	@Override 
  	public String toString() {
	  return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE); 
	}

	public String getBusinessBoardSearchWord() {
		return businessBoardSearchWord;
	}

	public void setBusinessBoardSearchWord(String businessBoardSearchWord) {
		this.businessBoardSearchWord = businessBoardSearchWord;
	}

	public String getBusinessBoardSearchType() {
		return businessBoardSearchType;
	}

	public void setBusinessBoardSearchType(String businessBoardSearchType) {
		this.businessBoardSearchType = businessBoardSearchType;
	}

	public String getBusinessBoardSearchCategory() {
		return businessBoardSearchCategory;
	}

	public void setBusinessBoardSearchCategory(String businessBoardSearchCategory) {
		this.businessBoardSearchCategory = businessBoardSearchCategory;
	}
	
	
	
}
