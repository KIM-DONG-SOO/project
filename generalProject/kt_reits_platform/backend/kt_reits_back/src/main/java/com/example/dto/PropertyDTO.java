package com.example.dto;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 매물 정보 DTO
 * - DB 테이블 PROPERTY_TB와 매핑
 * - BigDecimal: Oracle의 NUMBER 타입과 정확히 매핑, 금융 데이터: 소수점 계산 정확도 필수
 * 
 * 사용 예시:
 * PropertyDTO property = new PropertyDTO();
 * property.setTitle("강남 오피스텔");
 * property.setPrice(new BigDecimal("500000000"));
 */
@Data
public class PropertyDTO {
    private Long propertyId;       // 매물 고유번호 (PK)
    private String title;          // 매물 제목
    private String location;       // 주소/위치
    private BigDecimal latitude;   // 위도 (지도 표시용)
    private BigDecimal longitude;  // 경도 (지도 표시용)
    private BigDecimal price;      // 금액 (정확한 숫자 계산용)
    private String status;         // 상태 (AVAILABLE/SOLD)
    private Long managerId;        // 담당자 ID (FK: USER_TB)
    
    // JOIN 결과용 (DB에는 없지만 SELECT 시 포함)
    private String managerName;    // 담당자 이름 (USER_TB.USER_NAME)
    
    private Date regDate;          // 등록일 (DB 자동 생성)
    
}
