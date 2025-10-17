package com.spring.board.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.ComCodeDao;
import com.spring.comCode.vo.ComCodeVo;

@Repository
public class ComCodeDaoImpl implements ComCodeDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ComCodeVo> selectComCodeList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("comCode.selectComCodeList");
	}
	
	@Override
	public List<ComCodeVo> phoneCodeList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("comCode.phoneCodeList");
	}
	
}
