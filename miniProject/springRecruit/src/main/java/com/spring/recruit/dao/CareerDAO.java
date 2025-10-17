package com.spring.recruit.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recruit.vo.CareerVO;
import com.spring.recruit.vo.EducationVO;

@Repository
public class CareerDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void insertCareer(CareerVO careerVO) throws Exception {
		sqlSession.insert("career.insertCareer", careerVO);
	}
	
	public void updateCareer(CareerVO careerVO) throws Exception {
		sqlSession.update("career.updateCareer", careerVO);
	}
	
	public List<CareerVO> selectCarList(String seq) throws Exception {
		return sqlSession.selectList("career.selectCarList", seq);
	}
	
	
}
