package edu.fourmen.vo;

public class PageMaker extends BoardItemVO{
	
	private int totalCount; // 게시글 총합을 구함
	private int startPage; // 시작 게시글
	private int endPage; // 마지막 게시글
	private boolean prev; //
	private boolean next; //
	private int pageNum; // 화면에 보여줄 게시글 수
	private int displayPageNum = 10; // < 1 2 3 4 5 6 7 8 9 10 > 페이지바?
	private int page; //
	private String SearchType;
	private String SearchVal;
	private String board_type;
	private String keyword;
	private String nickName;
	
	
	
	
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
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
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if (page <=1) { //page가 1보다 적으면
			this.page = 1; //page의 값을 1로 한다.
			return;
		}
		this.page = page;
	}
	
	public void calcData() {
		
		endPage = (int)(Math.ceil(getPage()/(double)displayPageNum)*displayPageNum); //마지막 페이지 설정 10 20 30
		
		startPage = (endPage - displayPageNum)+1; //첫페이지 설정 1 11 21
		
		int tempEndPage = (int)(Math.ceil(totalCount/(double)getPageNum())); //리스트 마지막 페이지
		
		if(endPage > tempEndPage) { //endPage가 리스트 마지막 페이지보다 높다면 일치시킨다.
				endPage = tempEndPage;
				
		prev = startPage == 1 ? false:true; //시작 페이지가 1이면 false를 리턴하고 1이 아니면 true를 리턴해서 나타나게 한다.
		next = endPage*getPageNum() >= totalCount? false:true; //endPage에 위치한 게시글까지 합쳐도 게시글의 총합보다 낮으면 true를 줘서
																//나타나게 하고 총합보디 높다면 false를 줘서 안나타나게 한다.
			
		}
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
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	
	

}
