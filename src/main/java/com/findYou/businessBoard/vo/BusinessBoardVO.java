package com.findYou.businessBoard.vo;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.findYou.attach.vo.AttachVO;

public class BusinessBoardVO {

	private int b2bBoardIndex;    
	private String b2bBoardWriter;
	private String b2bBoardTemplate;
	private String b2bBoardCategory;
	private String b2bBoardTitle; 
	private String b2bBoardContent;
	private int b2bBoardDeadlineNumber;
	private String b2bBoardRegDate;
	private String b2bBoardModDate;
	private int b2bBoardHit;      
	private String b2bBoardDeadlineYn;
	private String b2bBoardDelYn; 
	private String b2bBoardRoadAddress;
	private String b2bBoardCost;  
	private String b2bBoardZip;   
	private String b2bBoardHour;  
	private String b2bBoardDetailedAddr;
	private String b2bBoardDate;  
	
	//사업자 게시판 리스트 보일 때 보이는 사진...
	private String b2bFirstAttachName;
	
	//게시판 리스트 템플릿마다 리스트 색변하게.
	private String b2bColor;
	
	private List<AttachVO> b2bAttaches;
	//등록되있던 첨부파일 삭제로 바꿀때
	private int[] atchDelNo;

	private String b2bCompanyName;
	
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
	public int getB2bBoardIndex() {
		return b2bBoardIndex;
	}

	public void setB2bBoardIndex(int b2bBoardIndex) {
		this.b2bBoardIndex = b2bBoardIndex;
	}

	public String getB2bBoardWriter() {
		return b2bBoardWriter;
	}

	public void setB2bBoardWriter(String b2bBoardWriter) {
		this.b2bBoardWriter = b2bBoardWriter;
	}

	public String getB2bBoardTemplate() {
		return b2bBoardTemplate;
	}

	public void setB2bBoardTemplate(String b2bBoardTemplate) {
		this.b2bBoardTemplate = b2bBoardTemplate;
	}

	public String getB2bBoardCategory() {
		return b2bBoardCategory;
	}

	public void setB2bBoardCategory(String b2bBoardCategory) {
		this.b2bBoardCategory = b2bBoardCategory;
	}

	public String getB2bBoardTitle() {
		return b2bBoardTitle;
	}

	public void setB2bBoardTitle(String b2bBoardTitle) {
		this.b2bBoardTitle = b2bBoardTitle;
	}

	public String getB2bBoardContent() {
		return b2bBoardContent;
	}

	public void setB2bBoardContent(String b2bBoardContent) {
		this.b2bBoardContent = b2bBoardContent;
	}

	public int getB2bBoardDeadlineNumber() {
		return b2bBoardDeadlineNumber;
	}

	public void setB2bBoardDeadlineNumber(int b2bBoardDeadlineNumber) {
		this.b2bBoardDeadlineNumber = b2bBoardDeadlineNumber;
	}

	public String getB2bBoardRegDate() {
		return b2bBoardRegDate;
	}

	public void setB2bBoardRegDate(String b2bBoardRegDate) {
		this.b2bBoardRegDate = b2bBoardRegDate;
	}

	public String getB2bBoardModDate() {
		return b2bBoardModDate;
	}

	public void setB2bBoardModDate(String b2bBoardModDate) {
		this.b2bBoardModDate = b2bBoardModDate;
	}

	public int getB2bBoardHit() {
		return b2bBoardHit;
	}

	public void setB2bBoardHit(int b2bBoardHit) {
		this.b2bBoardHit = b2bBoardHit;
	}

	public String getB2bBoardDeadlineYn() {
		return b2bBoardDeadlineYn;
	}

	public void setB2bBoardDeadlineYn(String b2bBoardDeadlineYn) {
		this.b2bBoardDeadlineYn = b2bBoardDeadlineYn;
	}

	public String getB2bBoardDelYn() {
		return b2bBoardDelYn;
	}

	public void setB2bBoardDelYn(String b2bBoardDelYn) {
		this.b2bBoardDelYn = b2bBoardDelYn;
	}

	public String getB2bBoardRoadAddress() {
		return b2bBoardRoadAddress;
	}

	public void setB2bBoardRoadAddress(String b2bBoardRoadAddress) {
		this.b2bBoardRoadAddress = b2bBoardRoadAddress;
	}

	public String getB2bBoardCost() {
		return b2bBoardCost;
	}

	public void setB2bBoardCost(String b2bBoardCost) {
		this.b2bBoardCost = b2bBoardCost;
	}

	public String getB2bBoardZip() {
		return b2bBoardZip;
	}

	public void setB2bBoardZip(String b2bBoardZip) {
		this.b2bBoardZip = b2bBoardZip;
	}

	public String getB2bBoardHour() {
		return b2bBoardHour;
	}

	public void setB2bBoardHour(String b2bBoardHour) {
		this.b2bBoardHour = b2bBoardHour;
	}

	public String getB2bBoardDetailedAddr() {
		return b2bBoardDetailedAddr;
	}

	public void setB2bBoardDetailedAddr(String b2bBoardDetailedAddr) {
		this.b2bBoardDetailedAddr = b2bBoardDetailedAddr;
	}

	public String getB2bBoardDate() {
		return b2bBoardDate;
	}

	public void setB2bBoardDate(String b2bBoardDate) {
		this.b2bBoardDate = b2bBoardDate;
	}

	public String getB2bColor() {
		return b2bColor;
	}


	public void setB2bColor(String b2bColor) {
		this.b2bColor = b2bColor;
	}


	public List<AttachVO> getB2bAttaches() {
		return b2bAttaches;
	}


	public void setB2bAttaches(List<AttachVO> b2bAttaches) {
		this.b2bAttaches = b2bAttaches;
	}


	public String getB2bFirstAttachName() {
		return b2bFirstAttachName;
	}


	public void setB2bFirstAttachName(String b2bFirstAttachName) {
		this.b2bFirstAttachName = b2bFirstAttachName;
	}


	public int[] getAtchDelNo() {
		return atchDelNo;
	}


	public void setAtchDelNo(int[] atchDelNo) {
		this.atchDelNo = atchDelNo;
	}


	public String getB2bCompanyName() {
		return b2bCompanyName;
	}


	public void setB2bCompanyName(String b2bCompanyName) {
		this.b2bCompanyName = b2bCompanyName;
	}

	


	

}
