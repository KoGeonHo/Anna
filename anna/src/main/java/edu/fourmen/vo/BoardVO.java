package edu.fourmen.vo;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO extends UserVO{
	
	private int Bidx;
	private String board_type;
	private String Title;
	private String Contents;
	private String Wdate;
	private String Location;
	private int Hit;
	private String isDel;
	private String Image1;
	private String Image2;
	private String Image3;
	private String Image4;
	private String Image5;
	private MultipartFile FileName1;
	private MultipartFile FileName2;
	private MultipartFile FileName3;
	private MultipartFile FileName4;
	private MultipartFile FileName5;
	private int Ccount;
	private int cntLike;
	

	public MultipartFile getFileName4() {
		return FileName4;
	}
	public void setFileName4(MultipartFile fileName4) {
		FileName4 = fileName4;
	}
	public MultipartFile getFileName5() {
		return FileName5;
	}
	public void setFileName5(MultipartFile fileName5) {
		FileName5 = fileName5;
	}
	public int getBidx() {
		return Bidx;
	}
	public void setBidx(int bidx) {
		Bidx = bidx;
	}

	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getContents() {
		return Contents;
	}
	public void setContents(String contents) {
		Contents = contents;
	}
	public String getWdate() {
		return Wdate;
	}
	public void setWdate(String wdate) {
		Wdate = wdate;
	}
	public String getLocation() {
		return Location;
	}
	public void setLocation(String location) {
		Location = location;
	}
	public int getHit() {
		return Hit;
	}
	public void setHit(int hit) {
		Hit = hit;
	}
	public String getIsDel() {
		return isDel;
	}
	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public String getImage1() {
		return Image1;
	}
	public void setImage1(String image1) {
		Image1 = image1;
	}
	public String getImage2() {
		return Image2;
	}
	public void setImage2(String image2) {
		Image2 = image2;
	}
	public String getImage3() {
		return Image3;
	}
	public void setImage3(String image3) {
		Image3 = image3;
	}
	public MultipartFile getFileName1() {
		return FileName1;
	}
	public void setFileName1(MultipartFile fileName1) {
		FileName1 = fileName1;
	}
	public MultipartFile getFileName2() {
		return FileName2;
	}
	public void setFileName2(MultipartFile fileName2) {
		FileName2 = fileName2;
	}
	public MultipartFile getFileName3() {
		return FileName3;
	}
	public void setFileName3(MultipartFile fileName3) {
		FileName3 = fileName3;
	}
	public String getImage4() {
		return Image4;
	}
	public void setImage4(String image4) {
		Image4 = image4;
	}
	public String getImage5() {
		return Image5;
	}
	public void setImage5(String image5) {
		Image5 = image5;
	}
	public int getCcount() {
		return Ccount;
	}
	public void setCcount(int ccount) {
		Ccount = ccount;
	}
	public int getCntLike() {
		return cntLike;
	}
	public void setCntLike(int cntLike) {
		this.cntLike = cntLike;
	}


	


	
	
}
