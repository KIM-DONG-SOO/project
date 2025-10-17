package com.spring.recruit.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recruit.vo.EducationVO;
import com.spring.recruit.vo.RecruitVO;

@Repository
public class EducationDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void insertEducation(EducationVO educationVO) throws Exception {
		sqlSession.insert("education.insertEducation", educationVO);
	}
	
	public void updateEducation(EducationVO educationVO) throws Exception {
		sqlSession.update("education.updateEducation", educationVO);
	}
	
	public List<EducationVO> selectEduList(String seq) throws Exception {
		return sqlSession.selectList("education.selectEduList", seq);
	}
	
}
