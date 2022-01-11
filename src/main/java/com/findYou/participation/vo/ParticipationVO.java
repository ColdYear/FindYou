package com.findYou.participation.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class ParticipationVO {
	         
	private int normalPartBoardNumber;      
	private String normalPartId;      
	private String normalPartName;
	private String normalPartAddr;
	private int normalPartMemberCount;
	private String normalpartCategory;
	
	//성별 구별
	private String gender;
	
	public int getNormalPartMemberCount() {
		return normalPartMemberCount;
	}

	public void setNormalPartMemberCount(int normalPartMemberCount) {
		this.normalPartMemberCount = normalPartMemberCount;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	public int getNormalPartBoardNumber() {
		return normalPartBoardNumber;
	}
	public void setNormalPartBoardNumber(int normalPartBoardNumber) {
		this.normalPartBoardNumber = normalPartBoardNumber;
	}
	public String getNormalPartId() {
		return normalPartId;
	}
	public void setNormalPartId(String normalPartId) {
		this.normalPartId = normalPartId;
	}
	public String getNormalPartName() {
		return normalPartName;
	}

	public void setNormalPartName(String normalPartName) {
		this.normalPartName = normalPartName;
	}

	public String getNormalPartAddr() {
		return normalPartAddr;
	}
	public void setNormalPartAddr(String normalPartAddr) {
		this.normalPartAddr = normalPartAddr;
	}

	public String getNormalpartCategory() {
		return normalpartCategory;
	}

	public void setNormalpartCategory(String normalpartCategory) {
		this.normalpartCategory = normalpartCategory;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	

	
	
	
	
}
