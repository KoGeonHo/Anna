package edu.fourmen.vo;

public class SlideVO {
	private int Sidx;
	private int Order_num;	
	private String image;
	private String Sdate;
	private String Edate;
	
	
	public int getSidx() {
		return Sidx;
	}
	public void setSidx(int sidx) {
		Sidx = sidx;
	}
	public int getOrder_num() {
		return Order_num;
	}
	public void setOrder_num(int order_num) {
		Order_num = order_num;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getSdate() {
		return Sdate;
	}
	public void setSdate(String sdate) {
		Sdate = sdate;
	}
	public String getEdate() {
		return Edate;
	}
	public void setEdate(String edate) {
		Edate = edate;
	}
	
}
