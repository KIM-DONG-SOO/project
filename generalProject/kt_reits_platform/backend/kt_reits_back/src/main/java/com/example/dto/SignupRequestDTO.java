package com.example.dto;

import lombok.Data;

/**
 * 회원가입 요청 DTO
 * - Vue Axios에서 POST 요청 시 JSON으로 전송
 * - Controller에서 @RequestBody로 자동 변환
 * 
 * 요청 예시:
 * {
 *   "userName": "홍길동",
 *   "userEmail": "hong@kt.com",
 *   "userPw": "1234",
 *   "phoneNumber": "010-1234-5678",
 *   "deptName": "개발팀",
 *   "userRole": "MANAGER"
 * }
 * 
 * 특징:
 * - userId, regDate 등은 서버에서 자동 생성 (포함 안 함)
 * - userPw는 평문으로 받아서 Service에서 BCrypt 암호화
 * - userRole 기본값: STAFF (null이면 DB에서 기본값 적용)
 */
@Data
public class SignupRequestDTO {
    private String userName;       // 이름 (필수)
    private String userEmail;      // 이메일 (필수, 로그인 ID)
    private String userPw;         // 비밀번호 평문 (필수, 서버에서 암호화)
    private String phoneNumber;    // 연락처 (선택)
    private String deptName;       // 부서명 (선택)
    private String userRole;       // 권한 (선택, 기본값: STAFF)
                                   // 가능한 값: ADMIN, MANAGER, STAFF
    
    // 자동 생성되는 필드 (클라이언트에서 보내지 않음):
    // - userId: SEQ_USER.NEXTVAL (Oracle 시퀀스)
    // - regDate: SYSDATE (DB 기본값)
    // - status: 'ACTIVE' (DB 기본값)
}
