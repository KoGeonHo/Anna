package edu.fourmen.vo;

import org.springframework.web.multipart.MultipartFile;

public class QnAVO {
	private int qidx;
	private int uidx;
	private String userNickName;
	private String qType;
	private String title;
	private String contents;
	private MultipartFile attachFile;
	private String attach;
	private String wDate;
	private int state;
	private int ans_uidx;
	private String answer;
	private String ans_date;
	private String isDel;

	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public String getIsDel() {
		return isDel;
	}
	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	public int getQidx() {
		return qidx;
	}
	public void setQidx(int qidx) {
		this.qidx = qidx;
	}
	public int getUidx() {
		return uidx;
	}
	public void setUidx(int uidx) {
		this.uidx = uidx;
	}
	public String getqType() {
		return qType;
	}
	public void setqType(String qType) {
		this.qType = qType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public MultipartFile getAttachFile() {
		return attachFile;
	}
	public void setAttachFile(MultipartFile attachFile) {
		this.attachFile = attachFile;
	}
	public String getAttach() {
		return attach;
	}
	public void setAttach(String attach) {
		this.attach = attach;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getAns_uidx() {
		return ans_uidx;
	}
	public void setAns_uidx(int ans_uidx) {
		this.ans_uidx = ans_uidx;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getAns_date() {
		return ans_date;
	}
	public void setAns_date(String ans_date) {
		this.ans_date = ans_date;
	}
	
	
}
