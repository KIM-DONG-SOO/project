package com.spring.user.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.user.vo.UserVO;


@Repository
public class UserDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public UserVO selectOneUser(UserVO userVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.selectOneUser", userVO);
	}
	
	
	
	public int userInsert(UserVO userVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("user.userInsert", userVO);
	}
	
	
}
