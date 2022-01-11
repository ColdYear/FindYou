package com.findYou.member.vo;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.groups.Default;

import org.apache.commons.lang3.builder.ToStringBuilder;


public class MemberVO {

	@NotBlank(message = "이용약관 동의는 필수입니다.", groups = {Default.class})
	private String agreeYn;
	
	@NotBlank(message = "개인정보 수집 동의는 필수입니다.", groups = {Default.class})
	private String privacyYn;
	
	private String eventYn;
	@NotBlank(message = "아이디는 필수로 입력해야합니다.", groups = {Default.class})
	private String memId;         
	
	@NotBlank(message = "비밀번호는 필수로 입력해야합니다.", groups = {Default.class})
	private String memPass;       
	
	@NotBlank(message = "회원이름은 필수로 입력해야합니다.", groups = {Default.class})
	private String memName;       
	@NotBlank
	private char memGender; 
	
	private String memRole;     
	//주민번호 VO 추가 
	
	@NotBlank(message = "상호명은 필수로 입력해야합니다.", groups = {Default.class})
	private String memCompanyName;
	
	@NotBlank(message = "사업자번호는 필수로 입력해야합니다.", groups = {Default.class})
	private String memB2bNumber;  
	
	@NotBlank(message = "회원우편주소는 필수로 입력해야합니다.", groups = {Default.class})
	private int memZip;           
	
	@NotBlank(message = "회원도로명주소는 필수로 입력해야합니다.", groups = {Default.class})
	private String memRoadAddr;   
	
	@NotBlank(message = "회원상세주소는 필수로 입력해야합니다.", groups = {Default.class})
	private String memDetailedAddr;
	
	@NotBlank(message = "회원휴대전화번호는 필수로 입력해야합니다.", groups = {Default.class})
	private String memHp;   
	
	@NotBlank(message = "이메일는 필수로 입력해야합니다.", groups = {Default.class})
	@Email(message = "이메일 형식이 아닙니다.")
	private String memEmail; 
	
	private String memIp;         
	private int memChatNo;
	
	private String memDelYn;
	
	private String memAddrX; //주소 X좌표
	private String memAddrY; //주소 Y좌표
	private double memDist;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemPass() {
		return memPass;
	}
	public void setMemPass(String memPass) {
		this.memPass = memPass;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemRole() {
		return memRole;
	}
	public void setMemRole(String memRole) {
		this.memRole = memRole;
	}
	public String getMemCompanyName() {
		return memCompanyName;
	}
	public void setMemCompanyName(String memCompanyName) {
		this.memCompanyName = memCompanyName;
	}
	public String getMemB2bNumber() {
		return memB2bNumber;
	}
	public void setMemB2bNumber(String memB2bNumber) {
		this.memB2bNumber = memB2bNumber;
	}
	public int getMemZip() {
		return memZip;
	}
	public void setMemZip(int memZip) {
		this.memZip = memZip;
	}
	public String getMemRoadAddr() {
		return memRoadAddr;
	}
	public void setMemRoadAddr(String memRoadAddr) {
		this.memRoadAddr = memRoadAddr;
	}
	public String getMemDetailedAddr() {
		return memDetailedAddr;
	}
	public void setMemDetailedAddr(String memDetailedAddr) {
		this.memDetailedAddr = memDetailedAddr;
	}
	public String getMemHp() {
		return memHp;
	}
	public void setMemHp(String memHp) {
		this.memHp = memHp;
	}
	public String getMemEmail() {
		return memEmail;
	}
	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
	}
	public String getMemIp() {
		return memIp;
	}
	public void setMemIp(String memIp) {
		this.memIp = memIp;
	}
	public String getMemDelYn() {
		return memDelYn;
	}
	public void setMemDelYn(String memDelYn) {
		this.memDelYn = memDelYn;
	}
	public char getMemGender() {
		return memGender;
	}
	public void setMemGender(char memGender) {
		this.memGender = memGender;
	}
	public String getAgreeYn() {
		return agreeYn;
	}
	public void setAgreeYn(String agreeYn) {
		this.agreeYn = agreeYn;
	}
	public String getPrivacyYn() {
		return privacyYn;
	}
	public void setPrivacyYn(String privacyYn) {
		this.privacyYn = privacyYn;
	}
	public String getEventYn() {
		return eventYn;
	}
	public void setEventYn(String eventYn) {
		this.eventYn = eventYn;
	}
	
	public String getMemAddrX() {
		return memAddrX;
	}
	public void setMemAddrX(String memAddrX) {
		this.memAddrX = memAddrX;
	}
	public String getMemAddrY() {
		return memAddrY;
	}
	public void setMemAddrY(String memAddrY) {
		this.memAddrY = memAddrY;
	}
	public int getMemChatNo() {
		return memChatNo;
	}
	public void setMemChatNo(int memChatNo) {
		this.memChatNo = memChatNo;
	}
	public double getMemDist() {
		return memDist;
	}
	public void setMemDist(double memDist) {
		this.memDist = memDist;
	}      
		
	
}