package com.findYou.normalBoard.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.findYou.attach.vo.AttachVO;

public class NormalBoardVO {
	private int normalBoardIndex;           
	private String normalBoardWriter;       
	private String normalBoardTemplate;  
	@NotBlank(message="카테고리를 선택해주세요")
	private String normalBoardCategory;
	@NotBlank(message="제목을 입력해주세요")
	private String normalBoardTitle; 
	@NotBlank(message="도로명주소를 입력해주세요")
	private String normalBoardRoadAddress; //도로명주소
	@NotBlank(message="상세주소를 입력해주세요")
	private String normalBoardDetailedAddr; //상세주소
	@NotBlank(message="우편번호를 입력해주세요")
	private String normalBoardZip;
	@NotBlank(message="시간을 선택해주세요")
	private String normalBoardHour; //임시 시간
	@NotBlank(message="날짜를 선택해주세요")
	private String normalBoardDate; //임시 기간
	private String normalBoardFood;
	@NotBlank(message="비용을 입력해주세요")
	private String normalBoardCost;
	@NotBlank(message="소개글을 입력해주세요")
	private String normalBoardContent;
	@NotBlank(message="모집인원을 입력해주세요")
	private String normalBoardDeadlineNumber;  
	
	private String normalBoardRegDate;      
	private String normalBoardModDate;      
	private int normalBoardHit;             
	private String normalBoardDeadlineYn;   
	private String normalBoardDelYn;
	private String normalBoardCategoryNm;
	
	private String normalBoardColor;
	
	private List<AttachVO> attaches;
	
	private int[] atchDelNo;
	
	public int[] getAtchDelNo() {
		return atchDelNo;
	}
	public void setAtchDelNo(int[] atchDelNo) {
		this.atchDelNo = atchDelNo;
	}
	public List<AttachVO> getAttaches() {
		return attaches;
	}
	public void setAttaches(List<AttachVO> attaches) {
		this.attaches = attaches;
	}
	public String getNormalBoardCategoryNm() {
		return normalBoardCategoryNm;
	}
	public void setNormalBoardCategoryNm(String normalBoardCategoryNm) {
		this.normalBoardCategoryNm = normalBoardCategoryNm;
	}	
	public String getNormalBoardColor() {
		return normalBoardColor;
	}
	public void setNormalBoardColor(String normalBoardColor) {
		this.normalBoardColor = normalBoardColor;
	}
	public int getNormalBoardIndex() {
		return normalBoardIndex;
	}
	public void setNormalBoardIndex(int normalBoardIndex) {
		this.normalBoardIndex = normalBoardIndex;
	}
	public String getNormalBoardWriter() {
		return normalBoardWriter;
	}
	public void setNormalBoardWriter(String normalBoardWriter) {
		this.normalBoardWriter = normalBoardWriter;
	}
	public String getNormalBoardTemplate() {
		return normalBoardTemplate;
	}
	public void setNormalBoardTemplate(String normalBoardTemplate) {
		this.normalBoardTemplate = normalBoardTemplate;
	}
	public String getNormalBoardCategory() {
		return normalBoardCategory;
	}
	public void setNormalBoardCategory(String normalBoardCategory) {
		this.normalBoardCategory = normalBoardCategory;
	}
	public String getNormalBoardTitle() {
		return normalBoardTitle;
	}
	public void setNormalBoardTitle(String normalBoardTitle) {
		this.normalBoardTitle = normalBoardTitle;
	}

	public String getNormalBoardRoadAddress() {
		return normalBoardRoadAddress;
	}
	public void setNormalBoardRoadAddress(String normalBoardRoadAddress) {
		this.normalBoardRoadAddress = normalBoardRoadAddress;
	}
	public String getNormalBoardDetailedAddr() {
		return normalBoardDetailedAddr;
	}
	public void setNormalBoardDetailedAddr(String normalBoardDetailedAddr) {
		this.normalBoardDetailedAddr = normalBoardDetailedAddr;
	}
	public String getNormalBoardZip() {
		return normalBoardZip;
	}
	public void setNormalBoardZip(String normalBoardZip) {
		this.normalBoardZip = normalBoardZip;
	}
	public String getNormalBoardHour() {
		return normalBoardHour;
	}
	public void setNormalBoardHour(String normalBoardHour) {
		this.normalBoardHour = normalBoardHour;
	}
	public String getNormalBoardDate() {
		return normalBoardDate;
	}
	public void setNormalBoardDate(String normalBoardDate) {
		this.normalBoardDate = normalBoardDate;
	}
	public String getNormalBoardFood() {
		return normalBoardFood;
	}
	public void setNormalBoardFood(String normalBoardFood) {
		this.normalBoardFood = normalBoardFood;
	}
	public String getNormalBoardCost() {
		return normalBoardCost;
	}
	public void setNormalBoardCost(String normalBoardCost) {
		this.normalBoardCost = normalBoardCost;
	}
	public String getNormalBoardContent() {
		return normalBoardContent;
	}
	public void setNormalBoardContent(String normalBoardContent) {
		this.normalBoardContent = normalBoardContent;
	}
	public String getNormalBoardDeadlineNumber() {
		return normalBoardDeadlineNumber;
	}
	public void setNormalBoardDeadlineNumber(String normalBoardDeadlineNumber) {
		this.normalBoardDeadlineNumber = normalBoardDeadlineNumber;
	}
	public String getNormalBoardRegDate() {
		return normalBoardRegDate;
	}
	public void setNormalBoardRegDate(String normalBoardRegDate) {
		this.normalBoardRegDate = normalBoardRegDate;
	}
	public String getNormalBoardModDate() {
		return normalBoardModDate;
	}
	public void setNormalBoardModDate(String normalBoardModDate) {
		this.normalBoardModDate = normalBoardModDate;
	}
	public int getNormalBoardHit() {
		return normalBoardHit;
	}
	public void setNormalBoardHit(int normalBoardHit) {
		this.normalBoardHit = normalBoardHit;
	}
	public String getNormalBoardDeadlineYn() {
		return normalBoardDeadlineYn;
	}
	public void setNormalBoardDeadlineYn(String normalBoardDeadlineYn) {
		this.normalBoardDeadlineYn = normalBoardDeadlineYn;
	}
	public String getNormalBoardDelYn() {
		return normalBoardDelYn;
	}
	public void setNormalBoardDelYn(String normalBoardDelYn) {
		this.normalBoardDelYn = normalBoardDelYn;
	}       
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
}
