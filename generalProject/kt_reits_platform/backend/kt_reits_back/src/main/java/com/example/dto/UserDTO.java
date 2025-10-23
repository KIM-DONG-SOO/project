package com.example.dto;

import java.util.Date;

import lombok.Data;

@Data
public class UserDTO {
	private Long userId;         // 회원 고유번호
    private String userName;     // 이름
    private String userEmail;    // 이메일(로그인 ID)
    private String userPw;       // 비밀번호 (암호화 저장)
    private String userRole;     // 권한 (ADMIN/MANAGER/STAFF)
    private String phoneNumber;  // 연락처
    private String deptName;     // 부서명
    private Date regDate;        // 가입일
    private String status;       // 상태 (ACTIVE/INACTIVE)

}
