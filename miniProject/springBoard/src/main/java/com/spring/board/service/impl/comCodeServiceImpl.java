package com.spring.board.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.ComCodeDao;
import com.spring.board.service.comCodeService;
import com.spring.comCode.vo.ComCodeVo;

@Service
public class comCodeServiceImpl implements comCodeService{
	
	@Autowired
	ComCodeDao comCodeDao;
	
	@Override
	public List<ComCodeVo> selectComCodeList() throws Exception {
		// TODO Auto-generated method stub
		return comCodeDao.selectComCodeList();
	}
	
	@Override
	public List<ComCodeVo> phoneCodeList() throws Exception {
		// TODO Auto-generated method stub
		return comCodeDao.phoneCodeList();
	}
	
	
}
