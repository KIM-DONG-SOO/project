package com.example.service;

import com.example.dto.LoginRequestDTO;
import com.example.dto.SignupRequestDTO;
import com.example.dto.UserDTO;

/**
 * 인증 관련 서비스 인터페이스
 * - 구현체: AuthServiceImpl
 */
public interface IAuthService {
    
    /**
     * 로그인 처리
     * @param request 로그인 요청 DTO
     * @param ipAddress 클라이언트 IP
     * @return 로그인된 사용자 정보 (비밀번호 제외)
     * @throws RuntimeException 로그인 실패 시
     */
    UserDTO login(LoginRequestDTO request, String ipAddress);
    
    /**
     * 회원가입 처리
     * @param request 회원가입 요청 DTO
     * @throws RuntimeException 이메일 중복 또는 저장 실패 시
     */
    void signup(SignupRequestDTO request);
    
    /**
     * 이메일 중복 체크
     * @param email 확인할 이메일
     * @return 사용 가능하면 true
     */
    boolean isEmailAvailable(String email);
}
