package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

public class AuthService {
	
	@Autowired
    private UserDAO userDAO;
    
    @Autowired
    private LogDAO logDAO;

    /**
     * 로그인 처리
     * - 이메일로 회원 조회 → 비밀번호 검증
     * - 성공 시 UserDTO 반환 (비밀번호 제외)
     */
    @Transactional
    public UserDTO login(LoginRequestDTO request, String ipAddress) {
        // 1. 이메일로 회원 조회
        UserDTO user = userDAO.findByEmail(request.getUserEmail());
        
        if (user == null) {
            throw new RuntimeException("존재하지 않는 이메일입니다.");
        }
        
        // 2. 비밀번호 검증 (BCrypt)
        if (!BCrypt.checkpw(request.getUserPw(), user.getUserPw())) {
            throw new RuntimeException("비밀번호가 일치하지 않습니다.");
        }
        
        // 3. 로그인 성공 로그 기록
        logDAO.insertLog(user.getUserId(), "LOGIN", 
                        "로그인 성공: " + user.getUserEmail(), ipAddress);
        
        // 4. 비밀번호 제거 후 반환 (보안)
        user.setUserPw(null);
        return user;
    }

    /**
     * 회원가입 처리
     * - 이메일 중복 체크 → 비밀번호 암호화 → DB 저장
     */
    @Transactional
    public void signup(SignupRequestDTO request) {
        // 1. 이메일 중복 체크
        if (userDAO.checkEmailExists(request.getUserEmail()) > 0) {
            throw new RuntimeException("이미 존재하는 이메일입니다.");
        }
        
        // 2. 비밀번호 암호화 (BCrypt)
        String hashedPw = BCrypt.hashpw(request.getUserPw(), BCrypt.gensalt());
        
        // 3. UserDTO 생성
        UserDTO user = new UserDTO();
        user.setUserName(request.getUserName());
        user.setUserEmail(request.getUserEmail());
        user.setUserPw(hashedPw);  // 암호화된 비밀번호
        user.setPhoneNumber(request.getPhoneNumber());
        user.setDeptName(request.getDeptName());
        user.setUserRole(request.getUserRole() != null ? request.getUserRole() : "STAFF");
        
        // 4. DB 저장
        int result = userDAO.insertUser(user);
        if (result == 0) {
            throw new RuntimeException("회원가입에 실패했습니다.");
        }
    }
    
    /**
     * 이메일 중복 체크 (회원가입 전 검증용)
     */
    public boolean isEmailAvailable(String email) {
        return userDAO.checkEmailExists(email) == 0;
    }

}
