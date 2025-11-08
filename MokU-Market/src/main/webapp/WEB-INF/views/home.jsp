<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>목유마켓 홈</title>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Nanum Gothic', sans-serif;
    margin: 0;
    background-color: #f8f9fa;
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

.nav-links {
    display: flex;
    gap: 25px;
    align-items: center;
    margin-left: 60px;
    font-family: 'Nanum Gothic', sans-serif; /* ✅ 폰트 완전 동일화 */
    font-weight: 600; /* ✅ 두께 통일 */
    font-size: 15px;  /* ✅ 크기 통일 */
    line-height: 1;   /* ✅ 렌더링 차이 제거 */
}

.nav-links a {
    color: white;
    text-decoration: none;
    font-weight: inherit; /* ✅ 부모에서 상속 */
    font-size: inherit;
}

.nav-links a:hover {
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

/* 사용자 메뉴 */
.user-menu {
    display: flex;
    gap: 20px;
    align-items: center;
}
.user-menu a {
    color: white;
    text-decoration: none;
    font-weight: 600;
}
.user-menu a:hover {
    text-decoration: underline;
}

/* ✅ 이하 기존 유지 */
.banner {
    background: linear-gradient(135deg, #00A67E, #007A5C);
    color: white;
    text-align: center;
    padding: 60px 20px;
}
.banner h2 {
    font-family: 'Jua', sans-serif;
    font-size: 28px;
    margin-bottom: 12px;
}
.banner p { font-size: 16px; }

.categories {
    display: flex;
    justify-content: center;
    flex-wrap: nowrap;
    gap: 30px;
    margin: 40px auto;
}
.category {
    width: 120px;
    height: 120px;
    background-color: white;
    border-radius: 20px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: 0.3s;
}
.category:hover { transform: translateY(-5px); }
.category img { width: 40px; height: 40px; margin-bottom: 10px; }
.category span { font-weight: 600; color: #333; }

.section {
    max-width: 1000px;
    margin: 0 auto 50px;
    padding: 0 20px;
}
.section h3 {
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 20px;
    color: #333;
}
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 20px;
}
.product {
    background: white;
    border-radius: 15px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.05);
    overflow: hidden;
    text-align: center;
    transition: 0.3s;
}
.product:hover { transform: translateY(-5px); }
.product img {
    width: 100%;
    height: 150px;
    object-fit: cover;
}
.product p { margin: 10px; font-size: 14px; color: #333; }
.product .price { font-weight: bold; color: #007A5C; }

.footer {
    background-color: #f1f1f1;
    text-align: center;
    padding: 10px;
    font-size: 13px;
    color: #666;
    border-top: 1px solid #ddd;
}
</style>
</head>

<body>

<!-- ✅ 헤더 -->
<div class="header">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home" style="display:flex; align-items:center; gap:10px; text-decoration:none; color:white;">
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

<!-- ✅ 메인 배너 -->
<div class="banner">
    <h2>📚 대학생을 위한 캠퍼스 중고거래</h2>
    <p>전공책부터 자취용품까지, 목포대 학생 간 안전하게 거래하세요!</p>
</div>

<!-- ✅ 카테고리 -->
<div class="categories">
    <div class="category" 
         onclick="location.href='${pageContext.request.contextPath}/product/list?category=전공서적'">
        <img src="https://cdn-icons-png.flaticon.com/512/2232/2232688.png" alt="전공서적">
        <span>전공서적</span>
    </div>

    <div class="category" 
         onclick="location.href='${pageContext.request.contextPath}/product/list?category=전자기기'">
        <img src="https://cdn-icons-png.flaticon.com/512/2920/2920343.png" alt="전자기기">
        <span>전자기기</span>
    </div>

    <div class="category" 
         onclick="location.href='${pageContext.request.contextPath}/product/list?category=생활용품'">
        <img src="https://cdn-icons-png.flaticon.com/512/3081/3081559.png" alt="생활용품">
        <span>생활용품</span>
    </div>

    <div class="category" 
         onclick="location.href='${pageContext.request.contextPath}/product/list?category=의류'">
        <img src="https://cdn-icons-png.flaticon.com/512/892/892458.png" alt="의류">
        <span>의류</span>
    </div>
    
    <div class="category" 
         onclick="location.href='${pageContext.request.contextPath}/product/list?category=음식'">
        <img src="https://cdn-icons-png.flaticon.com/512/706/706164.png" alt="음식">
        <span>음식</span>
    </div>
    
    <div class="category" 
         onclick="location.href='${pageContext.request.contextPath}/product/list?category=무료나눔'">
        <img src="https://cdn-icons-png.flaticon.com/512/3081/3081559.png" alt="무료나눔" class="gift-icon">
        <span>무료나눔</span>
    </div>
    
    
</div>

<!-- ✅ 인기상품 -->
<div class="section">
    <h3>🔥 인기 상품</h3>
    <div class="product-grid">
        <div class="product">
            <img src="${pageContext.request.contextPath}/resources/images/sample1.jpg">
            <p>간호학개론 교재</p>
            <p class="price">10,000원</p>
        </div>
        <div class="product">
            <img src="${pageContext.request.contextPath}/resources/images/sample2.jpg">
            <p>자취용 전자레인지</p>
            <p class="price">30,000원</p>
        </div>
        <div class="product">
            <img src="${pageContext.request.contextPath}/resources/images/sample3.jpg">
            <p>노트북 거치대</p>
            <p class="price">7,000원</p>
        </div>
    </div>
</div>

<!-- ✅ 최신상품 -->
<div class="section">
    <h3>🆕 최신 등록 상품</h3>
    <div class="product-grid">
        <div class="product">
            <img src="${pageContext.request.contextPath}/resources/images/sample4.jpg">
            <p>공학용 계산기</p>
            <p class="price">5,000원</p>
        </div>
        <div class="product">
            <img src="${pageContext.request.contextPath}/resources/images/sample5.jpg">
            <p>전기포트</p>
            <p class="price">8,000원</p>
        </div>
        <div class="product">
            <img src="${pageContext.request.contextPath}/resources/images/sample6.jpg">
            <p>심리학 교재</p>
            <p class="price">12,000원</p>
        </div>
    </div>
</div>

<!-- ✅ 푸터 -->
<div class="footer">
    <p>© 2025 Mokpo National University | MokU Market</p>
</div>

</body>
</html>
