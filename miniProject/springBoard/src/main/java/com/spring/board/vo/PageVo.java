package com.spring.board.vo;

public class PageVo {
	
	private int pageNo = 1;
	private String[] boardType;

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String[] getBoardType() {
		return boardType;
	}

	public void setBoardType(String[] boardType) {
		this.boardType = boardType;
	}
	
}
