# 🛒 목유마켓 (Mok-U Market Database)

![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![ERD](https://img.shields.io/badge/ER_Modeling-000000?style=for-the-badge)

> **"신뢰할 수 있는 대학생 전용 중고거래 & 대여 플랫폼"**
> <br/>판매뿐만 아니라 '대여(Rental)'와 '통합 신고' 기능을 지원하는 관계형 데이터베이스(RDBMS) 모델링 및 구축
<img width="567" height="283" alt="2" src="https://github.com/user-attachments/assets/28e94f89-8092-4483-8c50-70a9ada0e358" />

<br/>

## 🛠 데이터베이스 구조 (ER Diagram)

**논리/물리적 모델링**을 통해 사용자, 상품(판매/대여), 커뮤니티, 신고 시스템 간의 유기적인 관계를 설계했습니다.
<img width="569" height="793" alt="그림" src="https://github.com/user-attachments/assets/01f22006-8009-488b-8b87-e20a55207c68" />

<br/>

## 📌 주요 기능 및 설계 포인트 (Key Features)

* **🔄 거래 유형의 분리 (Sales vs Rental)**
    * 영구적인 소유권 이전인 **판매(PRODUCT)**와 일시적 사용권 이전인 **대여(RENT_PRODUCT)**를 별도 테이블로 분리하여 비즈니스 로직 최적화
    * 대여 이력 테이블(`RENT_PAYMENT`)에서 `START_AT`, `END_AT` 타임스탬프를 통해 대여 기간 및 연체 여부를 관리
<img width="567" height="284" alt="3" src="https://github.com/user-attachments/assets/ec1fd24d-36cd-4180-8eaa-adceb31930c4" />
<img width="509" height="338" alt="4" src="https://github.com/user-attachments/assets/c1532616-f020-49ad-a4dc-c3e7244ff641" />

* **🚨 통합 신고 시스템 (Integrated Report System)**
    * 유저, 상품, 게시글, 채팅방 등 신고 대상이 다양함에 착안하여 **하나의 `REPORT` 테이블**로 통합 설계
    * 각 대상을 가리키는 외래키(FK)를 `NULL` 허용으로 설정하여 유연한 확장성 확보
<img width="567" height="391" alt="그림" src="https://github.com/user-attachments/assets/2be01bfd-1705-4b29-94c2-7fb89382945b" />

* **💬 실시간 소통 데이터 관리 (Chatting)**
    * `CHAT_ROOM`과 `MESSAGE`를 1:N 관계로 설계하여, 거래별 채팅 기록을 체계적으로 저장
<img width="567" height="310" alt="5" src="https://github.com/user-attachments/assets/de2de3cc-f20e-4313-b73a-939c0d5af386" />

<br/>

## ⚡ 기술적 도전 및 해결 (Troubleshooting)

### 1. 통합 신고 테이블 설계 (Polymorphic Design)
* **Issue:** 신고 대상(유저, 상품, 글)마다 테이블을 만들면 관리 포인트가 늘어나고 통계 쿼리가 복잡해짐
* **Solution:** 모든 신고 대상을 포함하는 단일 테이블을 설계하되, 신고 유형에 따라 해당 FK만 채우고 나머지는 `NULL`로 두는 방식 채택

```sql
-- 통합 신고 테이블 생성 DDL (발췌)
CREATE TABLE REPORT (
    REPORT_ID NUMBER(10) PRIMARY KEY,
    REPORTER_ID NUMBER(10) NOT NULL,
    TARGET_USER_ID NUMBER(10),       -- 유저 신고일 경우 값 존재
    PRODUCT_ID NUMBER(10),           -- 상품 신고일 경우 값 존재
    POST_ID NUMBER(10),              -- 게시글 신고일 경우 값 존재
    STATUS VARCHAR2(20) DEFAULT 'NEW',
    CREATED_AT TIMESTAMP DEFAULT SYSTIMESTAMP
);
```

### 2. 대여 상태 관리의 무결성 확보
* **Issue:** 대여 종료일(END_AT)이 지났는데 반납되지 않은 경우 등을 DB 차원에서 명확히 표현해야 함
* **Solution:** TIMESTAMP 타입 사용 및 상태 코드(STATUS) 컬럼을 도입하여 애플리케이션에서 날짜 비교 및 상태 업데이트가 용이하도록 설계
<br/>

## ⚙️ 기술 스택 (Tech Stack)

| Category | Technology |
|---|---|
| **Database** | Oracle Database 11g / 19c |
| **Language** | SQL (DDL, DML), PL/SQL |
| **Modeling Tool** | ER-Win, Excel |
| **Documentation** | Data Dictionary, Table Definition |
