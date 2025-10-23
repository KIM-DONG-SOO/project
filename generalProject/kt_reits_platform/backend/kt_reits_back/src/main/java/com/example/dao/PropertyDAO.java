package com.example.dao;

import org.apache.ibatis.annotations.Mapper;

/**
 * 매물 관련 DB 작업 인터페이스
 * - MyBatis가 PropertyMapper.xml과 자동 매핑
 * - namespace="com.example.dao.PropertyDAO"와 일치
 * 
 * 주요 기능:
 * - 매물 CRUD (등록/조회/수정/삭제)
 * - JOIN: PROPERTY_TB ↔ USER_TB (담당자 이름)
 */
@Mapper
public interface PropertyDAO {
    
    /**
     * 전체 매물 목록 조회
     * - LEFT JOIN으로 담당자 이름 포함
     * - 최신순 정렬 (REG_DATE DESC)
     * 
     * @return 매물 목록 (PropertyDTO의 managerName 포함)
     */
    List<PropertyDTO> selectAllProperties();
    
    /**
     * 매물 상세 조회
     * 
     * @param propertyId 매물 ID
     * @return 매물 정보 (없으면 null)
     */
    PropertyDTO selectPropertyById(@Param("propertyId") Long propertyId);
    
    /**
     * 매물 등록
     * - SEQ_PROPERTY.NEXTVAL로 자동 ID 생성
     * - STATUS 기본값: 'AVAILABLE'
     * 
     * @param property 등록할 매물 정보
     * @return 삽입된 행 개수 (1이면 성공)
     */
    int insertProperty(PropertyDTO property);
    
    /**
     * 매물 수정
     * 
     * @param property 수정할 매물 정보 (propertyId 필수)
     * @return 수정된 행 개수 (1이면 성공)
     */
    int updateProperty(PropertyDTO property);
    
    /**
     * 매물 삭제
     * 
     * @param propertyId 삭제할 매물 ID
     * @return 삭제된 행 개수 (1이면 성공)
     */
    int deleteProperty(@Param("propertyId") Long propertyId);
    
    /**
     * 담당자별 매물 목록 조회
     * 
     * @param managerId 담당자 ID (USER_TB의 USER_ID)
     * @return 담당자가 관리하는 매물 목록
     */
    List<PropertyDTO> selectPropertiesByManager(@Param("managerId") Long managerId);
    
    /**
     * 상태별 매물 개수 조회 (통계용)
     * 
     * @param status 매물 상태 (AVAILABLE, SOLD)
     * @return 해당 상태의 매물 개수
     * 
     * 사용 예시:
     * int availableCount = propertyDAO.countByStatus("AVAILABLE");
     */
    int countByStatus(@Param("status") String status);
}
