package com.findYou.notice.vo;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;



public class NoticeVO {
	

	
	private int noticeBoardIndex;           
	private String noticeBoardWriter;       
	private String noticeBoardTitle;        
	private String noticeBoardContent;      
	private String noticeBoardRegDate;      
	private String noticeBoardModDate;      
	private String noticeBoardDelYn;
	public int getNoticeBoardIndex() {
		return noticeBoardIndex;
	}
	public void setNoticeBoardIndex(int noticeBoardIndex) {
		this.noticeBoardIndex = noticeBoardIndex;
	}
	public String getNoticeBoardWriter() {
		return noticeBoardWriter;
	}
	public void setNoticeBoardWriter(String noticeBoardWriter) {
		this.noticeBoardWriter = noticeBoardWriter;
	}
	public String getNoticeBoardTitle() {
		return noticeBoardTitle;
	}
	public void setNoticeBoardTitle(String noticeBoardTitle) {
		this.noticeBoardTitle = noticeBoardTitle;
	}
	public String getNoticeBoardContent() {
		return noticeBoardContent;
	}
	public void setNoticeBoardContent(String noticeBoardContent) {
		this.noticeBoardContent = noticeBoardContent;
	}
	public String getNoticeBoardRegDate() {
		return noticeBoardRegDate;
	}
	public void setNoticeBoardRegDate(String noticeBoardRegDate) {
		this.noticeBoardRegDate = noticeBoardRegDate;
	}
	public String getNoticeBoardModDate() {
		return noticeBoardModDate;
	}
	public void setNoticeBoardModDate(String noticeBoardModDate) {
		this.noticeBoardModDate = noticeBoardModDate;
	}
	public String getNoticeBoardDelYn() {
		return noticeBoardDelYn;
	}
	public void setNoticeBoardDelYn(String noticeBoardDelYn) {
		this.noticeBoardDelYn = noticeBoardDelYn;
	}        
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	

	
	

}
