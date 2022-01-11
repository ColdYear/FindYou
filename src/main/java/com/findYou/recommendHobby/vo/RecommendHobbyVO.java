package com.findYou.recommendHobby.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class RecommendHobbyVO {

	private int recIndex;         
	private String recMbti;       
	private String recActiceYn;   
	private String recHobby;
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public int getRecIndex() {
		return recIndex;
	}
	public void setRecIndex(int recIndex) {
		this.recIndex = recIndex;
	}
	public String getRecMbti() {
		return recMbti;
	}
	public void setRecMbti(String recMbti) {
		this.recMbti = recMbti;
	}
	public String getRecActiceYn() {
		return recActiceYn;
	}
	public void setRecActiceYn(String recActiceYn) {
		this.recActiceYn = recActiceYn;
	}
	public String getRecHobby() {
		return recHobby;
	}
	public void setRecHobby(String recHobby) {
		this.recHobby = recHobby;
	}      
}
