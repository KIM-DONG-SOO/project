package com.example.dto;

import lombok.Data;

/**
 * 로그인 요청 DTO
 * - Vue Axios에서 POST 요청 시 JSON으로 전송
 * - Controller에서 @RequestBody로 자동 변환
 * 
 * 요청 예시:
 * {
 *   "userEmail": "hong@kt.com",
 *   "userPw": "1234"
 * }
 * 
 * Lombok @Data 자동 생성:
 * - getter/setter: getUserEmail(), setUserEmail()
 * - toString(): LoginRequestDTO(userEmail=hong@kt.com, userPw=****)
 * - equals/hashCode
 */
@Data
public class LoginRequestDTO {
	
    private String userEmail;  // 로그인 ID (이메일)
    private String userPw;     // 비밀번호 (평문, 서버에서 BCrypt 검증)
    
}
