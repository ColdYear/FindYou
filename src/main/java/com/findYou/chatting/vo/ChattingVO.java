package com.findYou.chatting.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class ChattingVO {
	private int chatNo;           
	private int historyNo;        
	private String userId;        
	private String chatHistory;
	private String historyTime;
	private String memRole;
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public int getChatNo() {
		return chatNo;
	}
	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}
	public int getHistoryNo() {
		return historyNo;
	}
	public void setHistoryNo(int historyNo) {
		this.historyNo = historyNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getHistoryTime() {
		return historyTime;
	}
	public void setHistoryTime(String historyTime) {
		this.historyTime = historyTime;
	}
	public String getMemRole() {
		return memRole;
	}
	public void setMemRole(String memRole) {
		this.memRole = memRole;
	}
	public String getChatHistory() {
		return chatHistory;
	}
	public void setChatHistory(String chatHistory) {
		this.chatHistory = chatHistory;
	}   
	
}
