package com.findYou.login.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class UserVO {

	private String userId;
	private String userName;
	private String userRole;
	private int  userChatNo;
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	public int getUserChatNo() {
		return userChatNo;
	}
	public void setUserChatNo(int userChatNo) {
		this.userChatNo = userChatNo;
	}
	
	
}
