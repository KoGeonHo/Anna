package edu.fourmen.vo;

<<<<<<< HEAD
public class SearchVO {
=======
public class SearchVO extends BoardItemVO{
>>>>>>> parent of 7248137 (Merge branch 'master' into seongmin)
	private String SearchType;
	private String SearchVal;
	private String board_type;
	
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
