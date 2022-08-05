package edu.fourmen.vo;

public class ChatMessageVO extends BoardItemVO{
	
	private long cidx;
	private int uidx;
	private int invited;
	private String content;
	private int chat_host;
	private int item_idx;
	private String nickName;
	
	
	public ChatMessageVO(){}
	
	
	
	
	public ChatMessageVO(long cidx, int uidx, int invited, String content, int chat_host,  int item_idx, String nickName) {
		this.cidx = cidx;
		this.uidx = uidx;
		this.invited = invited;
		this.content = content;
		this.chat_host = chat_host;
		this.item_idx = item_idx;
		this.nickName = nickName;
	
	
	
	
	}

	public String getNickName() {
		return nickName;
	}


	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public long getCidx() {
		return cidx;
	}



	public void setCidx(long cidx) {
		this.cidx = cidx;
	}



	public int getUidx() {
		return uidx;
	}



	public void setUidx(int uidx) {
		this.uidx = uidx;
	}



	public int getInvited() {
		return invited;
	}



	public void setInvited(int invited) {
		this.invited = invited;
	}



	public String getcontent() {
		return content;
	}



	public void setcontent(String content) {
		this.content = content;
	}

	public int getChat_host() {
		return chat_host;
	}



	public void setChat_host(int chat_host) {
		this.chat_host = chat_host;
	}


	public int getItem_idx() {
		return item_idx;
	}



	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}

	

	
	
}
