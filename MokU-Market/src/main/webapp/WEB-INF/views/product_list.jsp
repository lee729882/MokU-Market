<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${category} 목록 - 목유마켓</title>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">

<style>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: 'Nanum Gothic', sans-serif;
    background-color: #f7f8f9;
    display: flex;
    flex-direction: column;
}

/* ✅ 상단 헤더 */
.header {
    background-color: #007A5C;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 25px 40px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

/* 로고 */
.header .logo {
    display: flex;
    align-items: center;
    gap: 10px;
}
.header .logo img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    background: white;
    padding: 4px;
}
.header .logo h1 {
    font-family: 'Jua', sans-serif;
    font-size: 25px;
    margin: 0;
    color: white;
}

/* 네비게이션 + 사용자 메뉴 공통 */
.nav-links, .user-menu {
    display: flex;
    align-items: center;
    font-family: 'Nanum Gothic', sans-serif !important;
    font-weight: 600;
    font-size: 15px;
    line-height: 1.4;
    color: white;
}
.nav-links {
    gap: 25px;
    margin-left: 60px;
}
.user-menu {
    gap: 20px;
}

/* 링크 스타일 */
.nav-links a, .user-menu a {
    color: inherit;
    text-decoration: none;
    font-weight: inherit;
    font-size: inherit;
}
.nav-links a:hover, .user-menu a:hover {
    text-decoration: underline;
}

/* 검색창 */
.search-box {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
}
.search-box input {
    width: 60%;
    padding: 9px 15px;
    border: none;
    border-radius: 20px;
    outline: none;
    font-size: 14px;
}
.search-box button {
    background: white;
    border: none;
    border-radius: 50%;
    width: 32px;
    height: 32px;
    margin-left: 8px;
    cursor: pointer;
    font-size: 15px;
    color: #007A5C;
    font-weight: bold;
}

/* ✅ 본문 컨테이너 */
.container {
    flex: 1;
    max-width: 1000px;
    margin: 40px auto;
    background: white;
    border-radius: 18px;
    padding: 30px 40px;
    box-shadow: 0 6px 16px rgba(0,0,0,0.1);
}
.container h2 {
    font-family: 'Jua', sans-serif;
    color: #007A5C;
    text-align: center;
    margin-bottom: 25px;
}

/* ✅ 상품 리스트 */
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 25px;
}
.product {
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);
    overflow: hidden;
    text-align: center;
    transition: 0.3s;
    cursor: pointer;
}
.product:hover { transform: translateY(-5px); }
.product img {
    width: 100%;
    height: 160px;
    object-fit: cover;
}
.product p {
    margin: 10px 0;
    font-size: 14px;
    color: #333;
}
.product .price {
    font-weight: bold;
    color: #007A5C;
}

/* ✅ 등록 버튼 */
.add-btn {
    display: block;
    width: 160px;
    margin: 25px auto 0;
    background-color: #00A67E;
    color: white;
    text-align: center;
    padding: 12px 0;
    border-radius: 12px;
    text-decoration: none;
    font-weight: bold;
    transition: 0.2s;
}
.add-btn:hover {
    background-color: #008a6b;
    transform: translateY(-2px);
}

/* ✅ 빈 데이터 표시 */
.empty-msg {
    text-align: center;
    color: #777;
    margin-top: 40px;
    font-size: 15px;
}

/* ✅ 푸터 */
.footer {
    background-color: #f1f1f1;
    text-align: center;
    padding: 10px;
    font-size: 13px;
    color: #666;
    border-top: 1px solid #ddd;
    margin-top: auto;
}
</style>
</head>

<body>

<!-- ✅ 헤더 -->
<div class="header">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home" 
           style="display:flex; align-items:center; gap:10px; text-decoration:none; color:white;">
            <img src="${pageContext.request.contextPath}/resources/images/mokyu_logo.png" alt="로고">
            <h1>목유마켓</h1>
        </a>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/controller/products">중고거래</a>
        <a href="${pageContext.request.contextPath}/controller/free">무료나눔</a>
    </div>

    <div class="search-box">
        <input type="text" placeholder="원하는 상품을 검색해보세요!">
        <button>🔍</button>
    </div>

    <div class="user-menu">
        <a href="${pageContext.request.contextPath}/controller/myStore">내 상점</a>
        <a href="${pageContext.request.contextPath}/controller/mypage">마이페이지</a>
        <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </div>
</div>

<!-- ✅ 본문 -->
<div class="container">
    <h2>📦 ${category} 목록</h2>

    <c:choose>
        <c:when test="${empty products}">
            <p class="empty-msg">등록된 상품이 없습니다. 첫 번째로 등록해보세요!</p>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach var="p" items="${products}">
                    <div class="product" onclick="location.href='${pageContext.request.contextPath}/product/detail/${p.productId}'">
                        <img src="${pageContext.request.contextPath}${p.imagePath}" alt="${p.title}">
                        <p>${p.title}</p>
                        <p class="price">
                            <c:choose>
                                <c:when test="${p.price == 0}">
                                    무료나눔
                                </c:when>
                                <c:otherwise>
                                    ${p.price}원
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/product/add" class="add-btn">상품 등록하기</a>
</div>

<!-- ✅ 푸터 -->
<div class="footer">
    <p>© 2025 Mokpo National University | MokU Market</p>
</div>

</body>
</html>
