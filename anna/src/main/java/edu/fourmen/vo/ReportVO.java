package edu.fourmen.vo;

import org.springframework.web.multipart.MultipartFile;

public class ReportVO {
	
	private int ridx;
	private int bidx;
	private int item_idx;
	private int repoter;
	private int target;
	private int evidence;
	private String attach;
	private int report_type;
	private String contents;
	private String report_date;
	private String ban;
	private String ban_date;
	
	MultipartFile file1;
	
	
	
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public int getRidx() {
		return ridx;
	}
	public void setRidx(int ridx) {
		this.ridx = ridx;
	}
	public int getBidx() {
		return bidx;
	}
	public void setBidx(int bidx) {
		this.bidx = bidx;
	}
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public int getRepoter() {
		return repoter;
	}
	public void setRepoter(int repoter) {
		this.repoter = repoter;
	}
	public int getTarget() {
		return target;
	}
	public void setTarget(int target) {
		this.target = target;
	}
	public int getEvidence() {
		return evidence;
	}
	public void setEvidence(int evidence) {
		this.evidence = evidence;
	}
	public String getAttach() {
		return attach;
	}
	public void setAttach(String attach) {
		this.attach = attach;
	}
	public int getReport_type() {
		return report_type;
	}
	public void setReport_type(int report_type) {
		this.report_type = report_type;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getReport_date() {
		return report_date;
	}
	public void setReport_date(String report_date) {
		this.report_date = report_date;
	}
	public String getBan() {
		return ban;
	}
	public void setBan(String ban) {
		this.ban = ban;
	}
	public String getBan_date() {
		return ban_date;
	}
	public void setBan_date(String ban_date) {
		this.ban_date = ban_date;
	}
	
	
	
	
	
	
	
}
