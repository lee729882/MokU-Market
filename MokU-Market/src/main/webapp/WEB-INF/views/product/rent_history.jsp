<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>대여 내역 | MokU Market</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
    font-family: 'Inter', 'Noto Sans KR', sans-serif;
    min-height: 100vh;
    padding: 40px 20px;
}

.wrap {
    max-width: 1000px;
    margin: 0 auto;
}

/* 뒤로가기 버튼 */
.back-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 30px;
    padding: 12px 24px;
    background: rgba(255,255,255,0.1);
    backdrop-filter: blur(10px);
    color: #e2e8f0;
    border-radius: 50px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    border: 1px solid rgba(255,255,255,0.15);
    transition: all 0.3s ease;
}

.back-btn:hover { 
    background: rgba(255,255,255,0.2);
    transform: translateX(-5px);
    color: #fff;
}

/* 메인 타이틀 */
.main-title {
    font-size: 42px;
    font-weight: 800;
    margin-bottom: 50px;
    background: linear-gradient(135deg, #fff 0%, #94a3b8 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    display: flex;
    align-items: center;
    gap: 16px;
}

.title-icon {
    font-size: 48px;
    -webkit-text-fill-color: initial;
}

/* 섹션 박스 */
.section-box {
    background: rgba(255,255,255,0.05);
    backdrop-filter: blur(20px);
    padding: 32px;
    border-radius: 24px;
    margin-bottom: 40px;
    border: 1px solid rgba(255,255,255,0.1);
    box-shadow: 0 25px 50px rgba(0,0,0,0.3);
}

.section-title {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 28px;
    color: #f1f5f9;
    display: flex;
    align-items: center;
    gap: 12px;
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(255,255,255,0.1);
}

.section-title.gave {
    color: #4ade80;
}

.section-title.rented {
    color: #60a5fa;
}

.section-icon {
    width: 40px;
    height: 40px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
}

.section-icon.gave {
    background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
    box-shadow: 0 8px 20px rgba(34, 197, 94, 0.3);
}

.section-icon.rented {
    background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
    box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
}

/* 카드 스타일 */
.card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: rgba(255,255,255,0.03);
    padding: 24px;
    border-radius: 16px;
    margin-bottom: 16px;
    border: 1px solid rgba(255,255,255,0.08);
    transition: all 0.3s ease;
}

.card:hover {
    background: rgba(255,255,255,0.08);
    transform: translateY(-4px);
    box-shadow: 0 20px 40px rgba(0,0,0,0.2);
    border-color: rgba(255,255,255,0.15);
}

.card:last-child {
    margin-bottom: 0;
}

/* 카드 내부 왼쪽 정보 */
.card-info {
    flex: 1;
    padding-right: 24px;
}

.card-title {
    font-size: 20px;
    font-weight: 700;
    color: #f8fafc;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    gap: 12px;
}

.price-tag {
    background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
    color: #fff;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
}

.small {
    font-size: 14px;
    color: #94a3b8;
    margin-top: 8px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.small-icon {
    width: 16px;
    height: 16px;
    opacity: 0.7;
}

.status-badge {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    background: rgba(139, 92, 246, 0.2);
    color: #a78bfa;
    border: 1px solid rgba(139, 92, 246, 0.3);
}

/* 오른쪽 이미지 */
.card-img-box {
    width: 130px;
    height: 130px;
    border-radius: 16px;
    overflow: hidden;
    border: 2px solid rgba(255,255,255,0.1);
    background: rgba(0,0,0,0.3);
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    transition: all 0.3s ease;
}

.card:hover .card-img-box {
    border-color: rgba(255,255,255,0.25);
    transform: scale(1.05);
}

.card-img-box img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.card:hover .card-img-box img {
    transform: scale(1.1);
}

/* 이미지 없을 경우 */
.no-img {
    font-size: 12px;
    color: #64748b;
    text-align: center;
}

.no-img-icon {
    font-size: 32px;
    margin-bottom: 8px;
    opacity: 0.5;
}

.empty-msg {
    padding: 40px 20px;
    font-size: 15px;
    color: #64748b;
    text-align: center;
    background: rgba(0,0,0,0.2);
    border-radius: 12px;
    border: 1px dashed rgba(255,255,255,0.1);
}

/* 반응형 */
@media (max-width: 768px) {
    .wrap {
        padding: 0 10px;
    }
    
    .main-title {
        font-size: 28px;
    }
    
    .card {
        flex-direction: column-reverse;
        gap: 20px;
        text-align: center;
    }
    
    .card-info {
        padding-right: 0;
        width: 100%;
    }
    
    .card-title {
        justify-content: center;
        flex-wrap: wrap;
    }
    
    .small {
        justify-content: center;
    }
}
</style>

</head>
<body>

<div class="wrap">

    <a href="${pageContext.request.contextPath}/product/rent" class="back-btn">
        <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path d="M19 12H5M12 19l-7-7 7-7"/>
        </svg>
        대여 목록으로 돌아가기
    </a>

    <h1 class="main-title">
        <span class="title-icon">📦</span>
        나의 대여 기록
    </h1>


    <!-- ============================
         내가 빌려준 상품
    ============================== -->
    <div class="section-box">
        <div class="section-title gave">
            <span class="section-icon gave">↑</span>
            내가 빌려준 상품
        </div>

        <c:if test="${empty gaveList}">
            <div class="empty-msg">빌려준 상품이 없습니다.</div>
        </c:if>

        <c:forEach var="p" items="${gaveList}">
            <div class="card">

                <!-- 왼쪽 정보 -->
                <div class="card-info">
                    <div class="card-title">
                        ${p.title}
                        <span class="price-tag">${p.price}원</span>
                    </div>

                    <div class="small">
                        <svg class="small-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                        대여자: ${p.renterName}
                    </div>

                    <div class="small">
                        <svg class="small-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        대여 종료일: 
                        <c:choose>
                            <c:when test="${empty p.endAt}">미설정</c:when>
                            <c:otherwise>${p.endAt}</c:otherwise>
                        </c:choose>
                    </div>

                    <div class="small">
                        <svg class="small-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        상태: <span class="status-badge">${p.status}</span>
                    </div>
                </div>

                <!-- 오른쪽 이미지 -->
                <div class="card-img-box">
                    <c:choose>
                        <c:when test="${not empty p.base64Image}">
                            <img src="data:image/png;base64,${p.base64Image}" alt="상품 이미지">
                        </c:when>
                        <c:otherwise>
                            <span class="no-img">
                                <div class="no-img-icon">🖼️</div>
                                이미지 없음
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </c:forEach>
    </div>



    <!-- ============================
         내가 빌린 상품
    ============================== -->
    <div class="section-box">
    <div class="section-title rented">
        <span class="section-icon rented">↓</span>
        내가 빌린 상품
    </div>

    <c:if test="${empty rentedList}">
        <div class="empty-msg">빌린 상품이 없습니다.</div>
    </c:if>

    <c:forEach var="p" items="${rentedList}">
        <div class="card">

            <!-- 왼쪽 -->
            <div class="card-info">
                <div class="card-title">
                    ${p.title}
                    <span class="price-tag">${p.price}원</span>
                </div>

                <div class="small">
                    <svg class="small-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                    판매자: ${p.sellerName}
                </div>

                <!-- 🔥 endAt 없으면 이 줄 자체가 표시되지 않음 -->
                <c:if test="${not empty p.endAt}">
                    <div class="small">
                        <svg class="small-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        반납 예정일: ${p.endAt}
                    </div>
                </c:if>

                <div class="small">
                    <svg class="small-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    상태: <span class="status-badge">${p.status}</span>
                </div>
            </div>

            <!-- 오른쪽 이미지 -->
            <div class="card-img-box">
                <c:choose>
                    <c:when test="${not empty p.base64Image}">
                        <img src="data:image/png;base64,${p.base64Image}" alt="상품 이미지">
                    </c:when>
                    <c:otherwise>
                        <span class="no-img">
                            <div class="no-img-icon">🖼️</div>
                            이미지 없음
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </c:forEach>
</div>


</div>

</body>
</html>
