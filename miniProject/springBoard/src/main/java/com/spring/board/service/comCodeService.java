package com.spring.board.service;

import java.util.List;

import com.spring.comCode.vo.ComCodeVo;

public interface comCodeService {

	public List<ComCodeVo> selectComCodeList() throws Exception;

	public List<ComCodeVo> phoneCodeList() throws Exception;
}
