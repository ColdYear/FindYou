package com.findYou.recommendHobby.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class RecommendValueVO {

	public String mbti_value;
	public String activity_value;
	public String hobby_value;
	public int cash;
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public String getMbti_value() {
		return mbti_value;
	}
	public void setMbti_value(String mbti_value) {
		this.mbti_value = mbti_value;
	}
	public String getActivity_value() {
		return activity_value;
	}
	public void setActivity_value(String activity_value) {
		this.activity_value = activity_value;
	}
	public String getHobby_value() {
		return hobby_value;
	}
	public void setHobby_value(String hobby_value) {
		this.hobby_value = hobby_value;
	}
	public int getCash() {
		return cash;
	}
	public void setCash(int cash) {
		this.cash = cash;
	}
}
