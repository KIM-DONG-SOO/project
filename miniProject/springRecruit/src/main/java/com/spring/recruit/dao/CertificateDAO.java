package com.spring.recruit.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recruit.vo.CareerVO;
import com.spring.recruit.vo.CertificateVO;

@Repository
public class CertificateDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void insertCertificate(CertificateVO certificateVO) throws Exception {
		sqlSession.insert("certificate.insertCertificate", certificateVO);
	}
	
	public void updateCertificate(CertificateVO certificateVO) throws Exception {
		sqlSession.update("certificate.updateCertificate", certificateVO);
	}
	
	public List<CertificateVO> selectCertList(String seq) throws Exception {
		return sqlSession.selectList("certificate.selectCertList", seq);
	}
	
}
