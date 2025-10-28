package com.example.TestSecurity.service;

import com.example.TestSecurity.entity.UserEntity;
import com.example.TestSecurity.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class MemberService {

    private final UserRepository userRepository;

    public List<UserEntity> findAllMembers() {
        System.out.println("mservice 메서드 실행");
        // 실제 비즈니스 로직 (예: 권한 체크, 데이터 가공)이 들어갈 수 있음

        return userRepository.findAll();
    }
}
