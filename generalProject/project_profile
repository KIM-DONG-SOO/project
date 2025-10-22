▶ 프로젝트명 : KTOP REITs 부동산 통합 플랫폼 개발
  -> 부동산 관련 데이터를 한 곳에서 관리하고, 경영진과 현장직원이 실시간으로 정보를 공유할 수 있는 통합 웹 플랫폼 구축 프로젝트

▶ 프로젝트 기간 : 2025.05 ~ 2025.10 (6개월)

▶ 참여 인원 : 총 5명 (백엔드 3명 / 프론트엔드 2명)

▶ 역할: 매물 관리 주요 담당 + 회원/계약 관리 보조 참여

▶ 개발 환경 및 기술 스택
    Frontend : Vue.js 3, Pinia, Axios, Chart.js, Leaflet.js
    Backend : Spring Framework (Spring MVC), MyBatis
    Database : Oracle 11g
    Build Tool : Maven (백엔드) / Vite (프론트엔드)
    Server : Apache Tomcat 9
    Version Control : Git, GitHub
    IDE / Editor : Eclipse (Spring), VS Code (Vue)
    Others : Lombok, Log4j, JSTL, JSP

▶ 시스템 아키텍처 구조
    KTOP REITs 부동산 통합 플랫폼
    │
    ├── Frontend (Vue.js)
    │     ├─ 로그인 / 회원가입 / 권한 UI
    │     ├─ 매물 관리 페이지
    │     ├─ 지도 / 통계 / 리포트 시각화
    │     └─ Axios → REST API 연동
    │
    ├── Backend (Spring MVC)
    │     ├─ Controller : REST API 제공
    │     ├─ Service : 비즈니스 로직 처리
    │     ├─ DAO : MyBatis Mapper 연동
    │     ├─ DTO : 데이터 전달용 객체
    │     └─ JSP : 관리자용 내부 화면
    │
    └── Database (Oracle)
          ├─ 회원 테이블 (USER_TB)
          ├─ 매물 테이블 (PROPERTY_TB)
          ├─ 계약 테이블 (CONTRACT_TB)
          └─ 로그 / 통계 테이블 등

▶ 주요 기능 요약
    로그인 / 권한관리 : 로그인, 회원가입, 권한별 접근제어
    메인 대시보드 : 매물현황 지도, 실시간 통계, 알림
    매물 관리 : 매물 CRUD, 지도 좌표, 상태관리, 검색 필터
    회원 및 계약 관리 : 중복 회원 검증, 계약 등록/수정/자동이력
    데이터 분석 리포트 : KPI, 공실률 추이, 지역별 트렌드
    시스템 관리 : DB 관리, 로그, 백업

▶ 배포 구조
server/
│   ├─ Spring Project (Eclipse)
│   ├─ target/
│   └─ deployed to Tomcat (8080)
│
client/
│   ├─ Vue Project (VS Code)
│   ├─ dist/
│   └─ build 후 → Spring /resources/static 에 배포

▶ 기술 포인트 / 배운 점
    Vue ↔ Spring REST API 통신 구조를 설계하며 프론트-백 분리 아키텍처 이해
    Axios 비동기 통신, Map·Chart 시각화 등 데이터 시각화 중심 기능 구현 경험
    Oracle DB 연동 시 MyBatis 사용으로 SQL 관리 효율화
    MVC 계층 설계 및 Controller-Service-DAO 구조 표준화 경험
