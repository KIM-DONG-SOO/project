package com.spring.board.dao;

import java.util.List;

import com.spring.comCode.vo.ComCodeVo;

public interface ComCodeDao {

	public List<ComCodeVo> selectComCodeList() throws Exception;
	
	public List<ComCodeVo> phoneCodeList() throws Exception;
}
