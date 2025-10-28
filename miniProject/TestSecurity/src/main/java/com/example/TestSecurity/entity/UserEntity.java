package com.example.TestSecurity.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_user_generator")
    @SequenceGenerator(name = "seq_user_generator", sequenceName = "SEQ_USER", allocationSize = 1)
    private Long seq;

    private String username;
    private String userid;
    private String password;
    private String email;
    private String imei;
    private String role;

}
