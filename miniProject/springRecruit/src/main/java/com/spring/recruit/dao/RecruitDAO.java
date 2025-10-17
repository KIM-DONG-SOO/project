package com.spring.recruit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recruit.vo.RecruitVO;

@Repository
public class RecruitDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<RecruitVO> selectLocList() throws Exception {
		return sqlSession.selectList("recruit.selectLocList");
	}
	
	public void insertRecruit(RecruitVO recruitVO) throws Exception {
		sqlSession.insert("recruit.insertRecruit", recruitVO);
	}
	
	public void updateRecruit(RecruitVO recruitVO) throws Exception {
		sqlSession.update("recruit.updateRecruit", recruitVO);
	}
	
	public RecruitVO selectRecruit(String phone) throws Exception {
		return sqlSession.selectOne("recruit.selectRecruit", phone);
	}
	
}
