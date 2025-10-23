package com.example.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LogDAO {
	
	/**
     * 로그 기록 삽입
     * 
     * @param userId 사용자 ID (FK: USER_TB)
     * @param action 수행 동작
     *               - LOGIN: 로그인
     *               - LOGIN_FAIL: 로그인 실패
     *               - INSERT_PROPERTY: 매물 등록
     *               - UPDATE_PROPERTY: 매물 수정
     *               - DELETE_PROPERTY: 매물 삭제
     * @param detail 상세 내용 (최대 4000자)
     * @param ipAddress 접속 IP (최대 50자)
     * @return 삽입된 행 개수 (1이면 성공)
     * 
     * 사용 예시:
     * logDAO.insertLog(123L, "LOGIN", "로그인 성공: hong@kt.com", "192.168.0.1");
     */
    int insertLog(@Param("userId") Long userId, 
                  @Param("action") String action, 
                  @Param("detail") String detail, 
                  @Param("ipAddress") String ipAddress);

}
