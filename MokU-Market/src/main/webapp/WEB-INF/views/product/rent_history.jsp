<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>대여 내역 | MokU Market</title>

<style>
body {
    background:#eef2f3;
    font-family: 'Noto Sans KR', sans-serif;
    margin:0;
    padding:0;
}

.wrap {
    width: 950px;
    margin: 50px auto;
}

/* 박스 섹션 */
.section-box {
    background:white;
    padding:25px;
    border-radius:14px;
    margin-bottom:40px;
    box-shadow:0 4px 15px rgba(0,0,0,0.08);
}

.section-title {
    font-size:22px;
    font-weight:bold;
    margin-bottom:20px;
    color:#333;
}

/* 카드 스타일 */
.card {
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:#fafafa;
    padding:18px;
    border-radius:12px;
    margin-bottom:18px;
    border:1px solid #e2e2e2;
    transition:0.2s;
}

.card:hover {
    background:#f2f2f2;
    box-shadow:0 3px 12px rgba(0,0,0,0.08);
}

/* 카드 내부 왼쪽 정보 */
.card-info {
    width:70%;
}

.card-title {
    font-size:19px;
    font-weight:bold;
    color:#222;
}

.small {
    font-size:14px;
    color:#555;
    margin-top:5px;
}

/* 오른쪽 이미지 */
.card-img-box {
    width:120px;
    height:120px;
    border-radius:10px;
    overflow:hidden;
    border:1px solid #ccc;
    background:#ddd;
    display:flex;
    align-items:center;
    justify-content:center;
}

.card-img-box img {
    width:100%;
    height:100%;
    object-fit:cover;
}

/* 이미지 없을 경우 */
.no-img {
    font-size:12px;
    color:#666;
}

.empty-msg {
    padding:10px 0;
    font-size:14px;
    color:#999;
}

.back-btn {
    display:inline-block;
    margin-bottom:20px;
    padding:10px 18px;
    background:#007A5C;
    color:white;
    border-radius:8px;
    text-decoration:none;
    font-size:14px;
    font-weight:bold;
}

.back-btn:hover { background:#005f44; }

.main-title {
    font-size:32px;
    font-weight:bold;
    margin-bottom:35px;
}
</style>

</head>
<body>

<div class="wrap">

    <a href="${pageContext.request.contextPath}/product/rent" class="back-btn">
        ← 대여 목록으로 돌아가기
    </a>

    <h1 class="main-title">📦 나의 대여 기록</h1>


    <!-- ============================
         🟢 내가 빌려준 상품
    ============================== -->
    <div class="section-box">
        <div class="section-title">🟢 내가 빌려준 상품</div>

        <c:if test="${empty gaveList}">
            <div class="empty-msg">빌려준 상품이 없습니다.</div>
        </c:if>

        <c:forEach var="p" items="${gaveList}">
            <div class="card">

                <!-- 왼쪽 정보 -->
                <div class="card-info">
                    <div class="card-title">${p.title} — ${p.price}원</div>

                    <div class="small">대여자: ${p.renterName}</div>

                    <div class="small">
                        대여 종료일: 
                        <c:choose>
                            <c:when test="${empty p.endAt}">미설정</c:when>
                            <c:otherwise>${p.endAt}</c:otherwise>
                        </c:choose>
                    </div>

                    <div class="small">상태: ${p.status}</div>
                </div>

                <!-- 오른쪽 이미지 -->
                <div class="card-img-box">
                    <c:choose>
                        <c:when test="${not empty p.base64Image}">
                            <img src="data:image/png;base64,${p.base64Image}" alt="상품 이미지">
                        </c:when>
                        <c:otherwise>
                            <span class="no-img">이미지 없음</span>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </c:forEach>
    </div>



    <!-- ============================
         🔵 내가 빌린 상품
    ============================== -->
    <div class="section-box">
        <div class="section-title">🔵 내가 빌린 상품</div>

        <c:if test="${empty rentedList}">
            <div class="empty-msg">빌린 상품이 없습니다.</div>
        </c:if>

        <c:forEach var="p" items="${rentedList}">
            <div class="card">

                <!-- 왼쪽 -->
                <div class="card-info">
                    <div class="card-title">${p.title} — ${p.price}원</div>

                    <div class="small">판매자: ${p.sellerName}</div>

                    <div class="small">
                        반납 예정일: 
                        <c:choose>
                            <c:when test="${empty p.endAt}">미설정</c:when>
                            <c:otherwise>${p.endAt}</c:otherwise>
                        </c:choose>
                    </div>

                    <div class="small">상태: ${p.status}</div>
                </div>

                <!-- 오른쪽 이미지 -->
                <div class="card-img-box">
                    <c:choose>
                        <c:when test="${not empty p.base64Image}">
                            <img src="data:image/png;base64,${p.base64Image}" alt="상품 이미지">
                        </c:when>
                        <c:otherwise>
                            <span class="no-img">이미지 없음</span>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </c:forEach>
    </div>

</div>

</body>
</html>
