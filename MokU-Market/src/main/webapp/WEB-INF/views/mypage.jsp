<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 | 목유마켓</title>

<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,300..700,0..1,-50..200" />

<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>

<style>
html, body {
    height: 100%;              /* ⬅️ 추가 */
    margin: 0;
    padding: 0;
    font-family: 'Nanum Gothic', sans-serif;
    background-color: #fafafa;
}

/* body를 세로 flex 컨테이너로 */
body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

/* 페이지 내용 전체를 감싸는 래퍼 (footer 위쪽) */
.page-root {
    flex: 1;                   /* ⬅️ 이 부분이 footer를 아래로 미는 역할 */
    display: flex;
    flex-direction: column;
}



/* 공통 래퍼 */
.mypage-wrapper {
    width: 100%;
    max-width: 1150px;
    margin: 0 auto;              /* 아래 여백 X */
    padding: 0 20px 60px;
    flex: 1;                      /* 남은 높이를 채우는 영역 */
}

/* ============== 마이페이지 NAV ============== */
.mypage-nav {
    display: flex;
    justify-content: center;
    background-color: #f7f7f7;
    border-bottom: 1.5px solid #007A5C;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.mypage-nav a {
    flex: 1;
    text-align: center;
    padding: 16px 0;
    font-weight: 600;
    color: #444;
    text-decoration: none;
    border-bottom: 3px solid transparent;
    transition: 0.2s;
}
.mypage-nav a:hover {
    color: #007A5C;
    background-color: #f0fdf9;
}
.mypage-nav a.active {
    color: #007A5C;
    border-bottom: 3px solid #007A5C;
    background-color: #fff;
}

/* ================= 프로필 카드 ================= */
.profile-card {
    width: 100%;
    max-width: 680px;
    background: #fff;
    margin: 50px auto 20px;
    border-radius: 15px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    padding: 35px 45px;
    display: flex;
    align-items: center;
    gap: 25px;
}
.profile-img {
    position: relative;
    width: 120px;
    height: 120px;
    border-radius: 50%;
    border: 4px solid #00A67E;
    overflow: hidden;
}
.profile-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.camera-btn {
    position: absolute;
    bottom: 5px;
    right: 5px;
    background: #007A5C;
    border-radius: 50%;
    width: 32px;
    height: 32px;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-size: 14px;
    cursor: pointer;
    border: 2px solid #fff;
}
.camera-btn:hover { background: #005f45; }

/* ================= 프로필 정보 ================= */
.profile-info h2 { margin: 0; font-size: 19px; font-weight: bold; }
.profile-info .stats { font-size: 14px; color: #555; margin-top: 3px; }

.verified-badge {
    display: inline-block;
    background-color: #007A5C;
    color: white;
    font-size: 12.5px;
    font-weight: 700;
    padding: 5px 10px;
    border-radius: 20px;
    margin-bottom: 6px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.12);
}

/* ============== 탭 컨텐츠 공통 ============== */
.tab-content {
    display: none;
}
.tab-content.active {
    display: block;
}

/* ================= 정보 폼 ================= */
.info-box {
    width: 100%;
    max-width: 680px;
    background: #fff;
    margin: 0 auto;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    padding: 35px 40px;
}
.info-box label {
    display: block;
    font-weight: bold;
    color: #333;
    margin-bottom: 6px;
}
.info-box input {
    width: 100%;
    padding: 11px 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    background-color: #f6f6f6;
    color: #555;
    font-size: 14px;
    margin-bottom: 15px;
}
.info-box input[readonly] { cursor: not-allowed; }

.btn-save {
    width: 100%;
    padding: 10px 0;
    border-radius: 8px;
    border: none;
    font-weight: 700;
    background: #ccc;
    color: #fff;
    cursor: not-allowed;
}

.password-change {
    text-align: center;
    margin-top: 40px;
    margin-bottom: 40px;
}
.password-change a {
    color: #ff4d4d;
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;
    opacity: 0.85;
    transition: 0.2s;
}
.password-change a:hover {
    text-decoration: underline;
    opacity: 1;
}

/* ================= 상품 카드 (내 등록템 / 내 관심템 공통) ================= */
.section-title {
    font-family: 'Jua', sans-serif;
    font-size: 20px;
    margin: 30px 0 15px;
    color: #333;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
    gap: 24px 20px;
}
.product {
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.08);
    overflow: hidden;
    text-align: left;
    transition: 0.25s;
}
.product:hover {
    transform: translateY(-3px);
    box-shadow: 0 5px 12px rgba(0,0,0,0.15);
}
.product .thumb {
    position: relative;
    cursor: pointer;
}
.product img {
    width: 100%;
    height: 190px;
    object-fit: cover;
}

/* ✅ 판매완료 비주얼 */
.product.sold .thumb img {
    filter: grayscale(0.5) brightness(0.7);
}
.product.sold .thumb::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.35);
}
.sold-badge {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0,0,0,0.7);
    color: #fff;
    font-size: 14px;
    font-weight: 700;
    padding: 6px 14px;
    border-radius: 999px;
    letter-spacing: 1px;
}

/* 상품 정보 */
.product-info {
    padding: 12px 14px 8px;
}
.product-info h3 {
    font-size: 15px;
    color: #333;
    font-weight: 600;
    margin: 6px 0;
    line-height: 1.4;
}
.price {
    font-weight: bold;
    font-size: 15px;
    color: #111;
    margin: 3px 0 8px;
}

/* 카테고리 뱃지 */
.badge {
    display: inline-block;
    font-size: 11px;
    font-weight: bold;
    padding: 3px 8px;
    border-radius: 20px;
    color: white;
    margin-bottom: 3px;
}
.badge.무료나눔 { background-color: #4CAF50; }
.badge.전자기기 { background-color: #3F51B5; }
.badge.의류 { background-color: #FF7043; }
.badge.생활용품 { background-color: #009688; }
.badge.전공서적 { background-color: #9C27B0; }
.badge.음식 { background-color: #795548; }
.badge.default { background-color: #607D8B; }

/* 관리 버튼 (내 등록템) */
.product-actions {
    display: flex;
    justify-content: flex-start;
    gap: 6px;
    padding: 0 10px 10px;
}
.product-actions button {
    border-radius: 4px;
    padding: 3px 8px;
    font-size: 11px;
    cursor: pointer;
    border: 1px solid #ddd;
    background: #f9f9f9;
    font-weight: 600;
}
.product-actions button:hover {
    background: #fff;
}
.btn-edit   { border-color:#4caf50; color:#4caf50; }
.btn-delete { border-color:#9e9e9e; color:#555;   }
.btn-sold   { border-color:#f44336; color:#f44336; }

/* ================= 플로팅 버튼 ================= */
.floating-container {
    position: fixed;
    bottom: 35px;
    right: 35px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
    z-index: 999;
}
.floating-top {
    background: transparent;
    border: none;
    color: #333;
    font-size: 18px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
    opacity: 0.85;
    transition: 0.25s;
    line-height: 1.1;
}
.floating-top span {
    display: block;
    font-size: 13px;
    font-weight: 700;
    margin-top: -2px;
}
.floating-top:hover {
    opacity: 1;
    transform: translateY(-2px);
}
.floating-add {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background-color: #FF4D4D;
    color: white;
    font-size: 38px;
    font-weight: bold;
    text-decoration: none;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.25);
    transition: 0.25s;
}
.floating-add:hover {
    background-color: #E03B3B;
    transform: scale(1.07);
}

@media (max-width: 768px) {
    .mypage-wrapper { padding: 0 15px 50px; }
    .profile-card   { padding: 25px 20px; margin-top: 30px; }
    .floating-container { bottom: 25px; right: 25px; }
    .floating-add { width: 55px; height: 55px; font-size: 34px; line-height: 55px; }
}

/* ===================== 구매자 선택 모달 ===================== */
.buyer-modal {
    position: fixed;
    inset: 0;
    z-index: 2000;
    display: none; /* JS에서 block으로 변경 */
}
.buyer-modal-backdrop {
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.45);
}
.buyer-modal-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 360px;
    max-height: 80vh;
    background: #fff;
    border-radius: 16px;
    padding: 16px 18px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.25);
    display: flex;
    flex-direction: column;
}
.buyer-modal-content h3 {
    margin-top: 0;
    margin-bottom: 12px;
    font-size: 16px;
}
#buyerList {
    overflow-y: auto;
    max-height: 55vh;
    padding-right: 4px;
}
.buyer-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 8px 4px;
    cursor: pointer;
    border-radius: 10px;
}
.buyer-item:hover {
    background: #f5f5f5;
}
.buyer-avatar {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
    flex-shrink: 0;
}
.buyer-radio {
    width: 18px;
    height: 18px;
}
.buyer-info-main {
    flex: 1;
}
.buyer-name {
    font-size: 13px;
    font-weight: 700;
}
.buyer-last-message {
    font-size: 12px;
    color: #777;
    margin-top: 2px;
}
.buyer-time {
    display: none;
}

.buyer-modal-footer {
    margin-top: 16px;
    display: flex;
    justify-content: flex-end;
    gap: 8px;
}
.buyer-modal-footer button {
    padding: 7px 16px;
    border-radius: 999px;
    border: 1px solid #ddd;
    background: #fff;
    font-size: 13px;
    cursor: pointer;
}
#btnConfirmBuyer {
    background: #007A5C;
    color: #fff;
    border-color: #007A5C;
}
#btnConfirmBuyer:disabled {
    background: #ccc;
    border-color: #ccc;
    cursor: default;
}
/* ================= 후기 리스트 ================= */
.review-section {
    width: 100%;
    max-width: 800px;
    margin: 0 auto 40px;
}

.review-subtitle {
    font-size: 15px;
    font-weight: 700;
    margin: 18px 0 10px;
    color: #333;
}

.review-card {
    display: flex;
    gap: 14px;
    padding: 14px 16px;
    margin-bottom: 10px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.06);
    font-size: 13px;
}

.review-thumb {
    width: 70px;
    height: 70px;
    border-radius: 10px;
    overflow: hidden;
    flex-shrink: 0;
    background: #eee;
    cursor: pointer;
}
.review-thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.review-main {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 4px;
}
.review-counterpart {
    font-weight: 700;
    color: #333;
}
.review-role {
    font-size: 11px;
    color: #777;
    margin-left: 6px;
}
.review-date {
    font-size: 11px;
    color: #999;
}

.review-score-row {
    margin: 4px 0 6px;
}
.score-badge {
    display: inline-block;
    padding: 3px 9px;
    border-radius: 999px;
    font-size: 11px;
    font-weight: 700;
}
.score-badge.good {
    background: #e0f7ec;
    color: #007a5c;
}
.score-badge.normal {
    background: #f5f5f5;
    color: #555;
}
.score-badge.bad {
    background: #ffe7e7;
    color: #f44336;
}

.review-text {
    white-space: pre-line;
    line-height: 1.4;
    color: #444;
    margin-bottom: 4px;
}

.review-product-link {
    margin-top: 2px;
    font-size: 12px;
}
.review-product-link a {
    color: #007a5c;
    text-decoration: none;
}
.review-product-link a:hover {
    text-decoration: underline;
}
/* ✅ 페이지 전체 래퍼 – footer를 하단으로 밀어주는 역할 */
.page-root {
    min-height: 100vh;        /* 화면 높이 최소 채우기 */
    display: flex;
    flex-direction: column;   /* 위에서 아래로 쌓기 */
}

</style>
</head>

<body>

  <!-- ✅ 페이지 전체(footer 위쪽)를 감싸는 래퍼 -->
  <div class="page-root">
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<c:set var="activeTab" value="${empty param.tab ? 'info' : param.tab}" />

<!-- ================= 마이페이지 NAV ================= -->
<div class="mypage-nav">
    <a href="javascript:void(0);"
       class="tab-link ${activeTab eq 'myProducts' ? 'active' : ''}"
       data-tab="myProducts">내 등록템</a>

    <a href="javascript:void(0);"
       class="tab-link ${activeTab eq 'info' ? 'active' : ''}"
       data-tab="info">개인정보 수정</a>

    <a href="javascript:void(0);"
       class="tab-link ${activeTab eq 'favorites' ? 'active' : ''}"
       data-tab="favorites">내 관심템</a>

    <a href="javascript:void(0);"
       class="tab-link ${activeTab eq 'reviews' ? 'active' : ''}"
       data-tab="reviews">내 후기</a>
</div>

<div class="mypage-wrapper">

    <!-- ================= 프로필 카드 ================= -->
    <div class="profile-card">
        <div class="profile-img">
            <c:choose>
                <c:when test="${not empty user.profileImagePath}">
                    <img id="profilePreview" src="${pageContext.request.contextPath}${user.profileImagePath}">
                </c:when>
                <c:otherwise>
                    <img id="profilePreview" src="${pageContext.request.contextPath}/resources/images/default_profile.png">
                </c:otherwise>
            </c:choose>
            <div class="camera-btn" onclick="document.getElementById('profileUpload').click()">📷</div>
            <input type="file" id="profileUpload" accept="image/*"
                   style="display:none;" onchange="uploadProfileImage(this)">
        </div>

        <div class="profile-info">
            <c:if test="${user.isLocationVerified == 'Y'}">
                <div class="verified-badge">📡 캠퍼스 인증 완료</div>
            </c:if>

            <h2>${user.name}</h2>

            <div class="stats"><span>매너온도: ${user.mannerTemp}℃ 🔥</span></div>

            <div class="stats">
                    <span>내 등록템 ${myProductCount}개</span>
                    <span>내 관심템 ${myFavoriteCount}개</span>
			        <span>받은 후기 ${receivedReviewCount}개</span>
                    </div>

            <c:if test="${user.isLocationVerified != 'Y'}">
                <button onclick="verifyWifi()"
                        style="margin-top:12px; padding:8px 14px;
                               background:#007A5C; color:white;
                               border:none; border-radius:6px;
                               font-weight:600; cursor:pointer;">
                    📡 캠퍼스 Wi-Fi 인증하기
                </button>
            </c:if>
        </div>
    </div>

    <!-- ============== 개인정보 수정 탭 ============== -->
    <div class="tab-content ${activeTab eq 'info' ? 'active' : ''}" id="tab-info">
        <div class="info-box">
            <label>아이디</label>
            <input type="email" value="${user.email}" readonly>

            <label>이름</label>
            <input type="text" value="${user.name}" readonly>

            <label>전화번호</label>
            <input type="text" value="${user.phone}" readonly>

            <button class="btn-save" disabled>저장하기</button>
        </div>

        <div class="password-change">
            <a href="${pageContext.request.contextPath}/member/forgot-password">비밀번호 변경하기</a>
        </div>
    </div>

    <!-- ============== 내 등록템 탭 ============== -->
    <div class="tab-content ${activeTab eq 'myProducts' ? 'active' : ''}" id="tab-myProducts">
        <h3 class="section-title">내 등록템</h3>

        <c:choose>
            <c:when test="${empty myProducts}">
                <p style="text-align:center; color:#777; margin-top:30px;">
                    등록한 상품이 없습니다. 첫 번째로 등록해 보세요!
                </p>
            </c:when>
            <c:otherwise>
                <div class="product-grid">
                    <c:forEach var="p" items="${myProducts}">
                        <%-- SOLD 인 경우 product sold 클래스 부여 --%>
                        <div class="product<c:if test='${p.status eq "SOLD"}'> sold</c:if>">
                            <!-- 썸네일 -->
                            <div class="thumb"
                                 onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${p.productId}'">
                                <img src="${pageContext.request.contextPath}${p.imagePath}"
                                     alt="${p.title}"
                                     onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />

                                <c:if test="${p.status == 'SOLD'}">
                                    <div class="sold-badge">판매 완료</div>
                                </c:if>
                            </div>

                            <div class="product-info">
                                <span class="badge ${p.category != null ? p.category : 'default'}">
                                    ${p.category}
                                </span>
                                <h3>${p.title}</h3>
                                <p class="price">
                                    <c:choose>
                                        <c:when test="${p.price == 0}">무료나눔</c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${p.price}" type="number" pattern="#,###" /> 원
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <div class="product-actions">
                                <button class="btn-edit"
                                        onclick="location.href='${pageContext.request.contextPath}/product/edit?id=${p.productId}'">
                                    수정
                                </button>
                                <button class="btn-delete"
                                        onclick="deleteProduct(${p.productId});">
                                    삭제
                                </button>
                                <button class="btn-sold"
                                        onclick="toggleSold(${p.productId}, '${p.status}');">
                                    <c:choose>
                                        <c:when test="${p.status == 'SOLD'}">판매 완료 해제</c:when>
                                        <c:otherwise>구매자 확정 요청</c:otherwise>
                                    </c:choose>
                                </button>

                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ============== 내 관심템 탭 ============== -->
    <div class="tab-content ${activeTab eq 'favorites' ? 'active' : ''}" id="tab-favorites">
        <h3 class="section-title">내 관심템</h3>

        <c:choose>
            <c:when test="${empty favoriteProducts}">
                <p style="text-align:center; color:#777; margin-top:30px;">
                    관심 등록한 상품이 없습니다.
                </p>
            </c:when>
            <c:otherwise>
                <div class="product-grid">
                    <c:forEach var="p" items="${favoriteProducts}">
                        <div class="product<c:if test='${p.status eq "SOLD"}'> sold</c:if>"
                             onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${p.productId}'">
                            <div class="thumb">
                                <img src="${pageContext.request.contextPath}${p.imagePath}"
                                     alt="${p.title}"
                                     onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />
                                <c:if test="${p.status == 'SOLD'}">
                                    <div class="sold-badge">판매 완료</div>
                                </c:if>
                            </div>
                            <div class="product-info">
                                <span class="badge ${p.category != null ? p.category : 'default'}">
                                    ${p.category}
                                </span>
                                <h3>${p.title}</h3>
                                <p class="price">
                                    <c:choose>
                                        <c:when test="${p.price == 0}">무료나눔</c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${p.price}" type="number" pattern="#,###" /> 원
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

<!-- ============== 내 후기 탭 ============== -->
<div class="tab-content ${activeTab eq 'reviews' ? 'active' : ''}" id="tab-reviews">
    <h3 class="section-title">내 후기</h3>

    <!-- 내가 받은 후기 -->
    <div class="review-section">
        <h4 class="review-subtitle">내가 받은 후기</h4>

        <c:choose>
            <c:when test="${empty receivedReviews}">
                <p style="text-align:center; color:#777; margin-top:10px;">
                    아직 받은 후기가 없습니다.
                </p>
            </c:when>
            <c:otherwise>
                <c:forEach var="rv" items="${receivedReviews}">
                    <div class="review-card">
                        <!-- 거래 상품 썸네일 -->
                        <div class="review-thumb"
                             onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${rv.productId}'">
                            <img src="${pageContext.request.contextPath}${rv.productImagePath}"
                                 alt="${rv.productTitle}"
                                 onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />
                        </div>

                        <div class="review-main">
                            <div class="review-header">
                                <div>
                                    <span class="review-counterpart">${rv.writerName} 님</span>
                                    <span class="review-role">
                                        <c:choose>
                                            <c:when test="${rv.writerRole eq 'BUYER'}">(구매자)</c:when>
                                            <c:when test="${rv.writerRole eq 'SELLER'}">(판매자)</c:when>
                                            <c:otherwise></c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <span class="review-date">
                                    <fmt:formatDate value="${rv.createdAt}" pattern="yyyy.MM.dd HH:mm" />
                                </span>
                            </div>

<div class="review-score-row">
    <c:set var="scoreClass" value="normal" />
    <!-- 평점(1~5점) 기준으로 색 나누기 예시 -->
    <c:if test="${rv.rating ge 4}"><c:set var="scoreClass" value="good" /></c:if>
    <c:if test="${rv.rating le 2}"><c:set var="scoreClass" value="bad" /></c:if>

    <span class="score-badge ${scoreClass}">
        거래 만족도 ${rv.rating}점
    </span>
</div>

<div class="review-text">
    <c:out value="${rv.content}" />
</div>

                            <div class="review-product-link">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${rv.productId}">
                                    거래 상품: <c:out value="${rv.productTitle}" />
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

  <!-- 내가 작성한 후기 -->
<div class="review-section">
    <h4 class="review-subtitle">내가 남긴 후기</h4>

    <c:choose>
        <c:when test="${empty writtenReviews}">
            <p style="text-align:center; color:#777; margin-top:10px;">
                아직 작성한 후기가 없습니다.
            </p>
        </c:when>
        <c:otherwise>
            <c:forEach var="rv" items="${writtenReviews}">
                <div class="review-card">
                    <div class="review-thumb"
                         onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${rv.productId}'">
                        <img src="${pageContext.request.contextPath}${rv.productImagePath}"
                             alt="${rv.productTitle}"
                             onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />
                    </div>

                    <div class="review-main">
                        <div class="review-header">
                            <div>
                                <span class="review-counterpart">${rv.targetName} 님</span>
                                <span class="review-role">
                                    <c:choose>
                                        <c:when test="${rv.writerRole eq 'BUYER'}">(내가 구매자)</c:when>
                                        <c:when test="${rv.writerRole eq 'SELLER'}">(내가 판매자)</c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <span class="review-date">
                                <fmt:formatDate value="${rv.createdAt}" pattern="yyyy.MM.dd HH:mm" />
                            </span>
                        </div>

                        <!-- ✅ 평점 필드 수정 -->
                        <div class="review-score-row">
                            <c:set var="scoreClass" value="normal" />
                            <c:if test="${rv.rating ge 4}"><c:set var="scoreClass" value="good" /></c:if>
                            <c:if test="${rv.rating le 2}"><c:set var="scoreClass" value="bad" /></c:if>

                            <span class="score-badge ${scoreClass}">
                                거래 만족도 ${rv.rating}점
                            </span>
                        </div>

                        <!-- ✅ 후기 내용 필드 수정 -->
                        <div class="review-text">
                            <c:out value="${rv.content}" />
                        </div>

                        <div class="review-product-link">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${rv.productId}">
                                거래 상품: <c:out value="${rv.productTitle}" />
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>



</div> <!-- /mypage-wrapper -->

<!-- ✅ 구매자 확정 모달 -->
<div id="buyerModal" class="buyer-modal">
    <div class="buyer-modal-backdrop" onclick="closeBuyerModal()"></div>
    <div class="buyer-modal-content">
        <h3>구매자 선택</h3>

        <div id="buyerList">
            <!-- AJAX로 채워질 영역 -->
        </div>

        <div class="buyer-modal-footer">
            <button type="button" onclick="closeBuyerModal()">취소</button>
            <button type="button" id="btnConfirmBuyer" disabled>구매자 확정 요청</button>
        </div>
    </div>
</div>


<!-- ================= JS ================= -->
<script>
const ctx = '${pageContext.request.contextPath}';
let selectedRoomId = null;
let currentProductIdForModal = null;

// ✅ 공통: 탭 활성화 함수
function activateTab(tabName) {
    // 상단 탭 버튼 active 처리
    document.querySelectorAll('.mypage-nav .tab-link')
        .forEach(t => {
            if (t.dataset.tab === tabName) t.classList.add('active');
            else t.classList.remove('active');
        });

    // 콘텐츠 영역 active 처리
    document.querySelectorAll('.tab-content')
        .forEach(c => c.classList.remove('active'));

    const content = document.getElementById('tab-' + tabName);
    if (content) content.classList.add('active');
}

// ✅ 페이지 로드 시: 마지막으로 열었던 탭 복원
document.addEventListener('DOMContentLoaded', function() {
    // 서버에서 넘어온 기본 탭(info / myProducts / favorites / reviews)
    var serverTab = '${activeTab}';
    // 브라우저에 저장된 마지막 탭
    var savedTab = localStorage.getItem('mypageActiveTab');

    var finalTab = savedTab || serverTab || 'info';
    activateTab(finalTab);
});

// ✅ 탭 클릭 시: 화면 전환 + localStorage에 기억
document.querySelectorAll('.mypage-nav .tab-link').forEach(tab => {
    tab.addEventListener('click', function(e) {
        e.preventDefault();
        const target = this.dataset.tab;
        activateTab(target);
        // 마지막으로 선택한 탭 저장
        localStorage.setItem('mypageActiveTab', target);
    });
});

function verifyWifi() {
    fetch(ctx + '/controller/verifyWifi')
        .then(res => res.text())
        .then(msg => {
            alert(msg);
            location.reload();
        });
}

function uploadProfileImage(input) {
    const file = input.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("file", file);

    fetch(ctx + '/controller/updateProfileImage', {
        method: "POST",
        body: formData,
        credentials: "include"
    })
    .then(res => res.json())
    .then(data => {
        if (data.success && data.imagePath) {
            alert("프로필 이미지가 정상적으로 변경되었습니다.");
            location.reload();
        } else {
            alert(data.message ?? "업로드 중 문제가 발생했습니다.");
        }
    })
    .catch(err => {
        console.error("업로드 오류:", err);
        alert("업로드 중 오류가 발생했습니다.");
    });
}

// ✅ 삭제
function deleteProduct(id) {
    if (!confirm("정말 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.")) return;

    // 현재 선택된 탭 기억
    const currentTab = document.querySelector('.mypage-nav .tab-link.active')?.dataset.tab || 'info';
    localStorage.setItem('mypageActiveTab', currentTab);

    // from=mypage는 선택 사항
    location.href = ctx + '/product/delete?id=' + id + '&from=mypage';
}

// ✅ 판매완료 토글 / 구매자 확정 요청
function toggleSold(id, status) {
    const isSold = (status === 'SOLD');

    if (isSold) {
        // 이미 판매완료 → 판매완료 해제
        const confirmMsg = '판매 완료를 해제하시겠습니까?';
        if (!confirm(confirmMsg)) return;

        const url = ctx + '/product/markUnsold?id=' + id;

        const currentTab = document.querySelector('.mypage-nav .tab-link.active')?.dataset.tab || 'info';
        localStorage.setItem('mypageActiveTab', currentTab);

        fetch(url, {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(res => res.text())
        .then(text => {
            const msg = text && text.trim().length > 0
                ? text.trim()
                : '판매 상태가 변경되었습니다.';

            alert(msg);

            if (msg.indexOf('로그인이 필요') !== -1) {
                location.href = ctx + '/login';
            } else {
                location.reload();
            }
        })
        .catch(err => {
            console.error('판매 상태 변경 중 오류:', err);
            alert('판매 상태 변경 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.');
        });

    } else {
        // 판매중 → 구매자 선택 모달 열기 (거래 확정 요청 흐름)
        const currentTab = document.querySelector('.mypage-nav .tab-link.active')?.dataset.tab || 'info';
        localStorage.setItem('mypageActiveTab', currentTab);

        openBuyerModal(id);
    }
}

// ✅ 구매자 선택 모달 열기
function openBuyerModal(productId) {
    const modal      = document.getElementById('buyerModal');
    const buyerList  = document.getElementById('buyerList');
    const btnConfirm = document.getElementById('btnConfirmBuyer');

    currentProductIdForModal = productId;
    selectedRoomId = null;
    btnConfirm.disabled = true;
    buyerList.innerHTML = '로딩 중...';

    modal.style.display = 'block';

    fetch(ctx + '/chat/rooms/by-product?productId=' + productId)
        .then(res => res.json())
        .then(data => {
            if (data.status === 'login_required') {
                alert('로그인이 필요합니다.');
                location.href = ctx + '/login';
                return;
            }
            if (data.status !== 'success') {
                buyerList.innerHTML =
                    '<p style="font-size:13px; color:#777;">채팅 목록을 불러오지 못했습니다.</p>';
                return;
            }

            const rooms = data.rooms;
            if (!rooms || rooms.length === 0) {
                buyerList.innerHTML =
                    '<p style="font-size:13px; color:#777;">이 상품으로 진행된 채팅이 없습니다.</p>';
                return;
            }

            buyerList.innerHTML = '';
            rooms.forEach(room => {
                const item = document.createElement('div');
                item.className = 'buyer-item';
                item.dataset.roomId = room.roomId;

                // 🔹 lastMessageAt 기준 시간 문자열
                let timeText = '';
                if (room.lastMessageAt) {
                    const d = new Date(room.lastMessageAt);
                    const month = String(d.getMonth() + 1).padStart(2, '0');
                    const day   = String(d.getDate()).padStart(2, '0');
                    const hour  = String(d.getHours()).padStart(2, '0');
                    const min   = String(d.getMinutes()).padStart(2, '0');
                    timeText = `${month}/${day} ${hour}:${min}`;
                }

                const displayName =
                    (!room.opponentName || room.opponentName === 'false')
                        ? '구매자'
                        : room.opponentName;

                const lastMessageText =
                    room.lastMessage && room.lastMessage !== 'null'
                        ? room.lastMessage
                        : '마지막 채팅 내용...';

                // 🔹 프로필 이미지
                const profileSrc = room.opponentProfileImagePath
                    ? ctx + room.opponentProfileImagePath
                    : ctx + '/resources/images/default_profile.png';

                item.innerHTML =
                    '<input type="radio" name="roomRadio" class="buyer-radio">' +
                    '<img src="' + profileSrc + '" ' +
                    '     class="buyer-avatar" ' +
                    '     onerror="this.src=\'' + ctx + '/resources/images/default_profile.png\';">' +
                    '<div class="buyer-info-main">' +
                    '  <div class="buyer-name">' + displayName + '</div>' +
                    '  <div class="buyer-last-message">' + lastMessageText + '</div>' +
                    '</div>' +
                    '<div class="buyer-time">' + timeText + '</div>';

                item.addEventListener('click', () => {
                    selectedRoomId = room.roomId;
                    btnConfirm.disabled = false;
                    document.querySelectorAll('input[name="roomRadio"]').forEach(r => r.checked = false);
                    item.querySelector('input[name="roomRadio"]').checked = true;
                });

                buyerList.appendChild(item);
            });

        })
        .catch(err => {
            console.error(err);
            buyerList.innerHTML =
                '<p style="font-size:13px; color:#777;">네트워크 오류로 목록을 불러오지 못했습니다.</p>';
        });

    // 🔥 거래 확정 요청 API 호출 (chatRoom.jsp 흐름과 동일 컨셉)
    btnConfirm.onclick = function() {
        if (!selectedRoomId || !currentProductIdForModal) return;

        if (!confirm(
            '선택한 채팅방의 사용자를 구매자로 지정하고, 거래 확정을 요청하시겠습니까?\n' +
            '상대방이 채팅방에서 거래를 확정하면 게시글이 판매완료로 변경됩니다.'
        )) {
            return;
        }

        fetch(ctx + '/chat/confirmBuyer', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({
                roomId: selectedRoomId,
                productId: currentProductIdForModal
            })
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'login_required') {
                alert('로그인이 필요합니다.');
                location.href = ctx + '/login';
                return;
            }
            if (data.status !== 'success') {
                alert(data.message || '거래 확정 요청 처리 중 오류가 발생했습니다.');
                return;
            }

            alert(
                '해당 구매자에게 거래 확정을 요청했습니다.\n' +
                '구매자가 채팅방에서 거래를 확정하면 상품이 판매완료로 변경됩니다.'
            );
            closeBuyerModal();
            location.reload();
        })
        .catch(err => {
            console.error('confirmBuyer error:', err);
            alert('거래 확정 요청 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.');
        });
    };
}

function closeBuyerModal() {
    const modal = document.getElementById('buyerModal');
    modal.style.display = 'none';
}

// Top 버튼
document.getElementById("topBtn")?.addEventListener("click", () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
});
</script>
  </div> <!-- ✅ /page-root 끝 -->

<!-- 플로팅 버튼 -->
<div class="floating-container">
    <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
    <a href="${pageContext.request.contextPath}/product/add" class="floating-add">+</a>
</div>

    <jsp:include page="/WEB-INF/views/common/recentProducts.jsp" />
<!-- ================= FOOTER ================= -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
