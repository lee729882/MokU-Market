<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${member.name} 프로필 - 목유마켓</title>

<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,300..700,0..1,-50..200" />
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

/* 메인 컨테이너 */
.profile-container {
    width: 900px;
    margin: 40px auto 60px;
    padding: 0 20px;
}

/* 상단 프로필 영역 */
.profile-top {
    display: flex;
    align-items: center;
    padding: 20px;
    background: #ffffff;
    border-radius: 16px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.08);
}
.profile-avatar {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 18px;
}
.profile-main {
    flex: 1;
}
.profile-name {
    font-size: 22px;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 8px;
}
.profile-meta {
    margin-top: 6px;
    font-size: 14px;
    color: #777;
}
.profile-meta span + span::before {
    content: "·";
    margin: 0 4px;
}
.profile-right {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 8px;
}

/* 캠퍼스 인증 뱃지 */
.seller-verified-badge {
    display: inline-flex;
    align-items: center;
    padding: 2px 8px;
    border-radius: 999px;
    background: #007A5C;
    color: #fff;
    font-size: 11px;
    font-weight: 600;
}

/* 숫자 정보 (판매글, 찜, 후기 등) */
.profile-stats {
    margin-top: 8px;
    display: flex;
    gap: 18px;
    font-size: 13px;
    color: #555;
}
.profile-stats span strong {
    font-weight: 700;
    margin-right: 4px;
}

/* 버튼 */
.btn-chip {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 8px 16px;
    border-radius: 999px;
    border: 1px solid #ccc;
    background: #fff;
    font-size: 13px;
    cursor: pointer;
    text-decoration: none;
    color: #333;
    transition: 0.15s ease;
}
.btn-chip:hover {
    background: #f5f5f5;
}
.btn-primary {
    border-color: #00A67E;
    color: #00A67E;
}
.btn-primary:hover {
    background: #e6fff7;
}

/* 섹션 타이틀 */
.section-title {
    margin-top: 32px;
    margin-bottom: 10px;
    font-size: 17px;
    font-weight: 700;
}

/* 게시글 그리드 */
.post-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
}
.post-card {
    width: 180px;
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    cursor: pointer;
}
.post-card img {
    width: 100%;
    height: 140px;
    object-fit: cover;
}
.post-card-body {
    padding: 8px 10px 10px;
}
.post-title {
    font-size: 13px;
    font-weight: 600;
    margin-bottom: 4px;
}
.post-price {
    font-size: 13px;
    color: #333;
}
.post-meta {
    font-size: 11px;
    color: #999;
    margin-top: 4px;
}

/* 거래 상태 뱃지 */
.post-status-badge {
    position: absolute;
    left: 8px;
    bottom: 8px;
    padding: 2px 8px;
    border-radius: 999px;
    font-size: 11px;
    font-weight: 700;
    color: #fff;
}
.post-status-sold {
    background-color: rgba(0,0,0,0.55);
}
.post-image-wrap {
    position: relative;
}
/* ================= 후기 카드 리스트 (마이페이지 디자인 공통 사용) ================= */
.review-section {
    margin-top: 12px;
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

/* 비어 있을 때 공통 */
.empty-text {
    font-size: 13px;
    color: #999;
    margin-top: 8px;
}


/* 반응형 */
@media (max-width: 768px) {
    .profile-container {
        width: 100%;
        margin-top: 20px;
    }
    .profile-top {
        flex-direction: column;
        align-items: flex-start;
    }
    .profile-right {
        align-items: flex-start;
        margin-top: 12px;
    }
    .post-card {
        width: calc(50% - 8px);
    }
}
/* 페이지 내용 전체를 감싸는 래퍼 (footer 위쪽) */
.page-root {
    flex: 1;                   /* ⬅️ 이 부분이 footer를 아래로 미는 역할 */
    display: flex;
    flex-direction: column;
}
/* ✅ 판매완료 비주얼 (category 목록과 동일 컨셉) */

/* 판매완료일 때 이미지 그레이 + 어둡게 */
.post-card.sold-out .post-image-wrap img {
    filter: grayscale(0.5) brightness(0.7);
}

/* 전체 반투명 오버레이 */
.post-card.sold-out .post-image-wrap::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0, 0, 0, 0.35);
}

/* 중앙 동그란 "판매완료" 배지 */
.sold-badge {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0, 0, 0, 0.7);
    color: #fff;
    font-size: 14px;
    font-weight: 700;
    padding: 6px 14px;
    border-radius: 999px;
    letter-spacing: 1px;
}

.post-card.sold-out .sold-badge {
    background: rgba(0, 0, 0, 0.85);
}

/* 가격 옆 판매완료 텍스트 */
.post-price .sold-text {
    font-size: 12px;
    color: #ff4d4d;
    margin-left: 4px;
    font-weight: 600;
}

</style>
</head>

<body>



  <div class="page-root">
  
  <jsp:include page="/WEB-INF/views/common/header.jsp" />
  <div class="profile-container">
  
    <!-- 상단 프로필 -->
    <div class="profile-top">
        <img class="profile-avatar"
             src="${ctx}${member.profileImagePath}"
             onerror="this.src='${ctx}/resources/images/default_profile.png';">

        <div class="profile-main">
            <div class="profile-name">
                <span>${member.name}</span>
                <c:if test="${member.isLocationVerified == 'Y'}">
                    <span class="seller-verified-badge">📡 캠퍼스 인증</span>
                </c:if>
            </div>

            <div class="profile-meta">
                <span>매너온도 ${member.mannerTemp}°C</span>

            </div>

            <div class="profile-stats">
                <span><strong>${fn:length(products)}</strong>게시글</span>
                <span><strong>${fn:length(receivedReviews)}</strong>받은 후기</span>
                <span><strong>${fn:length(writtenReviews)}</strong>작성한 후기</span>
            </div>
        </div>


    </div>

    <!-- 게시글 섹션 -->
<div class="section-title">게시글</div>

<c:choose>
    <c:when test="${empty products}">
        <div class="empty-text">등록된 게시글이 없습니다.</div>
    </c:when>
    <c:otherwise>
        <div class="post-grid">
            <c:forEach var="p" items="${products}">
                <%-- 🔴 판매완료이면 sold-out 클래스 추가 --%>
                <div class="post-card<c:if test='${p.status eq "SOLD"}'> sold-out</c:if>"
                     onclick="location.href='${ctx}/product/detail?productId=${p.productId}'">

                    <div class="post-image-wrap">
                        <img src="${ctx}${p.imagePath}"
                             onerror="this.src='${ctx}/resources/images/no_image.png';">

                        <%-- 🔴 중앙 "판매완료" 배지 --%>
                        <c:if test="${p.status eq 'SOLD'}">
                            <div class="sold-badge">판매완료</div>
                        </c:if>
                    </div>

                    <div class="post-card-body">
                        <div class="post-title">
                            ${p.title}
                        </div>
                        <div class="post-price">
                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> 원

                            <%-- 🔴 가격 옆 텍스트로도 표시 --%>
                            <c:if test="${p.status eq 'SOLD'}">
                                <span class="sold-text">· 판매완료</span>
                            </c:if>
                        </div>
                        <div class="post-meta">
                            <fmt:formatDate value="${p.createdAt}" pattern="yyyy-MM-dd"/>
                            &nbsp;·&nbsp; 조회수 ${p.viewCount}
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>



<!-- ================= 받은 후기 섹션 ================= -->
<div class="section-title" style="margin-top:40px;">받은 후기</div>

<div class="review-section">
    <c:choose>
        <c:when test="${empty receivedReviews}">
            <p class="empty-text">
                아직 받은 후기가 없습니다.
            </p>
        </c:when>
        <c:otherwise>
            <c:forEach var="rv" items="${receivedReviews}">
                <div class="review-card">
                    <!-- 거래 상품 썸네일 -->
                    <div class="review-thumb"
                         onclick="location.href='${ctx}/product/detail?productId=${rv.productId}'">
                        <img src="${ctx}${rv.productImagePath}"
                             alt="${rv.productTitle}"
                             onerror="this.src='${ctx}/resources/images/no_image.png';" />
                    </div>

                    <div class="review-main">
                        <div class="review-header">
                            <div>
                                <!-- 상대방 이름 + 역할 -->
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

                        <!-- 평점 뱃지 -->
                        <div class="review-score-row">
                            <c:set var="scoreClass" value="normal" />
                            <c:if test="${rv.rating ge 4}">
                                <c:set var="scoreClass" value="good" />
                            </c:if>
                            <c:if test="${rv.rating le 2}">
                                <c:set var="scoreClass" value="bad" />
                            </c:if>

                            <span class="score-badge ${scoreClass}">
                                거래 만족도 ${rv.rating}점
                            </span>
                        </div>

                        <!-- 후기 내용 -->
                        <div class="review-text">
                            <c:out value="${rv.content}" />
                        </div>

                        <!-- 거래 상품 링크 -->
                        <div class="review-product-link">
                            <a href="${ctx}/product/detail?productId=${rv.productId}">
                                거래 상품: <c:out value="${rv.productTitle}" />
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!-- ================= 내가 쓴 후기 섹션 ================= -->
<div class="section-title" style="margin-top:40px;">내가 쓴 후기</div>

<div class="review-section">
    <c:choose>
        <c:when test="${empty writtenReviews}">
            <p class="empty-text">
                아직 작성한 후기가 없습니다.
            </p>
        </c:when>
        <c:otherwise>
            <c:forEach var="rv" items="${writtenReviews}">
                <div class="review-card">
                    <!-- 거래 상품 썸네일 -->
                    <div class="review-thumb"
                         onclick="location.href='${ctx}/product/detail?productId=${rv.productId}'">
                        <img src="${ctx}${rv.productImagePath}"
                             alt="${rv.productTitle}"
                             onerror="this.src='${ctx}/resources/images/no_image.png';" />
                    </div>

                    <div class="review-main">
                        <div class="review-header">
                            <div>
                                <!-- 내가 후기 남긴 상대방 -->
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

                        <div class="review-score-row">
                            <c:set var="scoreClass" value="normal" />
                            <c:if test="${rv.rating ge 4}">
                                <c:set var="scoreClass" value="good" />
                            </c:if>
                            <c:if test="${rv.rating le 2}">
                                <c:set var="scoreClass" value="bad" />
                            </c:if>

                            <span class="score-badge ${scoreClass}">
                                거래 만족도 ${rv.rating}점
                            </span>
                        </div>

                        <div class="review-text">
                            <c:out value="${rv.content}" />
                        </div>

                        <div class="review-product-link">
                            <a href="${ctx}/product/detail?productId=${rv.productId}">
                                거래 상품: <c:out value="${rv.productTitle}" />
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>



</div>
<jsp:include page="/WEB-INF/views/common/recentProducts.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
