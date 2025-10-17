package com.spring.mbti.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.mbti.vo.MbtiVo;
import com.spring.mbti.vo.PageVo;

@Repository
public class MbtiDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<MbtiVo> selectList(PageVo pageVo) throws Exception {
		return sqlSession.selectList("mbti.mbtiList", pageVo);
	}
	
}
