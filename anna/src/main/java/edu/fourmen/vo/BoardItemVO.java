package edu.fourmen.vo;

import org.springframework.web.multipart.MultipartFile;

public class BoardItemVO extends UserVO {
	
	private int item_idx;
	private int uidx;
	private int cate_idx;
	private String Title;
	private String Content;
	private String nickname;
	private String wdate;
	private String addr1;
	private String addr2;
	private String addr_code; 
	
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	private MultipartFile file4;
	private MultipartFile file5;
	private MultipartFile file6;
	private MultipartFile file7;
	private MultipartFile file8;
	private MultipartFile file9;
	private MultipartFile file10;
	
	
	
	public  String image1;
	private String image2;
	private String image3;
	private String image4;
	private String image5;
	private String image6;
	private String image7;
	private String image8;
	private String image9;
	private String image10;
	private String fileName;
	private String Keyword;
	private String Price;
	private String offer;
	private int hit;
	private int state;
	
	private String SearchType;
	private String SearchVal;
	
	
	private int pageNum;
	private int amount;
	private int startNum;
	private int perPageNum;
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	//현재 페이지 번호, 한 페이지에 표출할 데이터 개수
	private Criteria cri;
	
	
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public String getSearchType() {
		return SearchType;
	}
	public void setSearchType(String searchType) {
		SearchType = searchType;
	}
	public String getSearchVal() {
		return SearchVal;
	}
	public void setSearchVal(String searchVal) {
		SearchVal = searchVal;
	}
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public int getUidx() {
		return uidx;
	}
	public void setUidx(int uidx) {
		this.uidx = uidx;
	}
	public int getCate_idx() {
		return cate_idx;
	}
	public void setCate_idx(int cate_idx) {
		this.cate_idx = cate_idx;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getAddr_code() {
		return addr_code;
	}
	public void setAddr_code(String addr_code) {
		this.addr_code = addr_code;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public MultipartFile getFile2() {
		return file2;
	}
	public void setFile2(MultipartFile file2) {
		this.file2 = file2;
	}
	public MultipartFile getFile3() {
		return file3;
	}
	public void setFile3(MultipartFile file3) {
		this.file3 = file3;
	}
	public MultipartFile getFile4() {
		return file4;
	}
	public void setFile4(MultipartFile file4) {
		this.file4 = file4;
	}
	public MultipartFile getFile5() {
		return file5;
	}
	public void setFile5(MultipartFile file5) {
		this.file5 = file5;
	}
	public MultipartFile getFile6() {
		return file6;
	}
	public void setFile6(MultipartFile file6) {
		this.file6 = file6;
	}
	public MultipartFile getFile7() {
		return file7;
	}
	public void setFile7(MultipartFile file7) {
		this.file7 = file7;
	}
	public MultipartFile getFile8() {
		return file8;
	}
	public void setFile8(MultipartFile file8) {
		this.file8 = file8;
	}
	public MultipartFile getFile9() {
		return file9;
	}
	public void setFile9(MultipartFile file9) {
		this.file9 = file9;
	}
	public MultipartFile getFile10() {
		return file10;
	}
	public void setFile10(MultipartFile file10) {
		this.file10 = file10;
	}
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
	public String getImage4() {
		return image4;
	}
	public void setImage4(String image4) {
		this.image4 = image4;
	}
	public String getImage5() {
		return image5;
	}
	public void setImage5(String image5) {
		this.image5 = image5;
	}
	public String getImage6() {
		return image6;
	}
	public void setImage6(String image6) {
		this.image6 = image6;
	}
	public String getImage7() {
		return image7;
	}
	public void setImage7(String image7) {
		this.image7 = image7;
	}
	public String getImage8() {
		return image8;
	}
	public void setImage8(String image8) {
		this.image8 = image8;
	}
	public String getImage9() {
		return image9;
	}
	public void setImage9(String image9) {
		this.image9 = image9;
	}
	public String getImage10() {
		return image10;
	}
	public void setImage10(String image10) {
		this.image10 = image10;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getKeyword() {
		return Keyword;
	}
	public void setKeyword(String keyword) {
		Keyword = keyword;
	}
	public String getPrice() {
		return Price;
	}
	public void setPrice(String price) {
		Price = price;
	}
	public String getOffer() {
		return offer;
	}
	public void setOffer(String offer) {
		this.offer = offer;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
