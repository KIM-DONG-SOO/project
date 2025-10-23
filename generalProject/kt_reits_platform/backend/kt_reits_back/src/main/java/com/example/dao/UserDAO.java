package com.example.dao;

import com.example.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface UserDAO {
	
	// 이메일로 회원 조회 (로그인 시 사용)
    UserDTO findByEmail(@Param("userEmail") String userEmail);
    
    // 이메일 중복 체크 (회원가입 시 사용)
    int checkEmailExists(@Param("userEmail") String userEmail);
    
    // 회원가입
    int insertUser(UserDTO user);
    
    // 회원 정보 수정
    int updateUser(UserDTO user);
    
    // 회원 비활성화 (탈퇴)
    int deactivateUser(@Param("userId") Long userId);

}
