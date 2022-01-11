package com.findYou.b2bParticipation.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class B2bParticipationVO {

	private int b2bPartIndex;
	private int b2bPartBoardNumber;
	private String b2bPartId;
	private String b2bPartAddr;
	private String b2bPartCancelYn;

	private String b2bPartName;
	private String b2bCategory;

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

	public int getB2bPartIndex() {
		return b2bPartIndex;
	}

	public void setB2bPartIndex(int b2bPartIndex) {
		this.b2bPartIndex = b2bPartIndex;
	}

	public int getB2bPartBoardNumber() {
		return b2bPartBoardNumber;
	}

	public void setB2bPartBoardNumber(int b2bPartBoardNumber) {
		this.b2bPartBoardNumber = b2bPartBoardNumber;
	}

	public String getB2bPartId() {
		return b2bPartId;
	}

	public void setB2bPartId(String b2bPartId) {
		this.b2bPartId = b2bPartId;
	}

	public String getB2bPartAddr() {
		return b2bPartAddr;
	}

	public void setB2bPartAddr(String b2bPartAddr) {
		this.b2bPartAddr = b2bPartAddr;
	}

	public String getB2bPartCancelYn() {
		return b2bPartCancelYn;
	}

	public void setB2bPartCancelYn(String b2bPartCancelYn) {
		this.b2bPartCancelYn = b2bPartCancelYn;
	}

	public String getB2bPartName() {
		return b2bPartName;
	}

	public void setB2bPartName(String b2bPartName) {
		this.b2bPartName = b2bPartName;
	}

	public String getB2bCategory() {
		return b2bCategory;
	}

	public void setB2bCategory(String b2bCategory) {
		this.b2bCategory = b2bCategory;
	}

}
