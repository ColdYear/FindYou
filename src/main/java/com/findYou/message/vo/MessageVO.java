package com.findYou.message.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class MessageVO {

	private int msgIndex;         
	private String msgSender;     
	private String msgReceiver;   
	private String msgContent;    
	private String msgRecTime;
	private String msgReadYn;
	
	private int firstRow;
	private int lastRow;
	
	
	
	public String getMsgReadYn() {
		return msgReadYn;
	}
	public void setMsgReadYn(String msgReadYn) {
		this.msgReadYn = msgReadYn;
	}
	public int getFirstRow() {
		return firstRow;
	}
	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}
	public int getLastRow() {
		return lastRow;
	}
	public void setLastRow(int lastRow) {
		this.lastRow = lastRow;
	}
	public int getMsgIndex() {
		return msgIndex;
	}
	public void setMsgIndex(int msgIndex) {
		this.msgIndex = msgIndex;
	}
	public String getMsgSender() {
		return msgSender;
	}
	public void setMsgSender(String msgSender) {
		this.msgSender = msgSender;
	}
	public String getMsgReceiver() {
		return msgReceiver;
	}
	public void setMsgReceiver(String msgReceiver) {
		this.msgReceiver = msgReceiver;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public String getMsgRecTime() {
		return msgRecTime;
	}
	public void setMsgRecTime(String msgRecTime) {
		this.msgRecTime = msgRecTime;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
}
