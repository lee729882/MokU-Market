<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

/* ✅ 프로필 링크 */
.profile-link {
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    color: white;
}
.profile-link img {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid white;
    transition: 0.2s ease;
}
.profile-link:hover img {
    transform: scale(1.07);
}

/* ✅ 공통 영역 */
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

/* ✅ Top 버튼 (강조 & 살짝 확대) */
.floating-top {
    background: transparent;
    border: none;
    color: #333;
    font-size: 18px;             /* ↑ 화살표 크기 확대 */
    font-weight: 700;            /* 굵게 */
    text-align: center;
    cursor: pointer;
    opacity: 0.85;
    transition: 0.25s;
    line-height: 1.1;
    font-family: 'Nanum Gothic', sans-serif;
}
.floating-top span {
    display: block;
    font-size: 13px;             /* “Top” 텍스트 크기 */
    font-weight: 700;            /* 굵게 */
    margin-top: -2px;
}
.floating-top:hover {
    opacity: 1;
    transform: translateY(-2px);
}

/* ✅ 등록 버튼 (+) */
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

/* ✅ 모바일 대응 */
@media (max-width: 768px) {
    .floating-container {
        bottom: 25px;
        right: 25px;
    }
    .floating-add {
        width: 55px;
        height: 55px;
        font-size: 34px;
        line-height: 55px;
    }
    
}
.hero-carousel {
    position: relative;
    width: 80%;
    max-width: 1200px;
    margin: 0 auto 35px;
    overflow: hidden;
    border-radius: 18px;
    background: transparent;   /* 🔥 이 한 줄만 변경 */
}



.carousel-track {
    display: flex;
    transition: transform 0.4s ease;
}

.carousel-item {
    flex: 0 0 100%;            /* 🔥 각 슬라이드가 hero-carousel 폭의 100%를 차지하도록 */
    /* min-width: 100%;  ← 있어도 무방하지만 flex가 더 중요합니다 */
    display: none;               /* 기본은 안 보이게 */
    justify-content: center;
    align-items: center;
}

/* 🔥 줍줍마켓처럼 배너를 고정 높이에 꽉 채우는 방식 */
/* 🔥 원본 비율 유지 */
.carousel-item img {
    width: 100%;     /* 가로는 배너 폭에 맞게 */
    height: auto;    /* 세로는 비율대로 자동 */
    border-radius: 0;
    display: block;
    /* object-fit: cover;  ← 있었다면 꼭 지워주세요 (잘림·변형 원인) */
}
.carousel-item.active {
    display: flex;              /* 활성 슬라이드만 보이게 */
}
/* 버튼 클릭 문제 해결 */
.carousel-btn {
    z-index: 9999 !important;
    pointer-events: auto !important;
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 45px;
    height: 45px;
    background: rgba(0,0,0,0.4);
    border: none;
    border-radius: 50%;
    color: white;
    font-size: 20px;
    cursor: pointer;
}

.carousel-btn.left { left: 20px; }
.carousel-btn.right { right: 20px; }

.carousel-btn:hover {
    background: rgba(0,0,0,0.65);
}
/* ▽▽ 슬라이드 하단 점(인디케이터) ▽▽ */
.carousel-dots {
    position: absolute;
    left: 50%;
    bottom: 12px;
    transform: translateX(-50%);
    display: flex;
    gap: 8px;
    z-index: 10000;
}

.carousel-dots .dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: rgba(255,255,255,0.6);
    border: 1px solid rgba(0,0,0,0.2);
    cursor: pointer;
    transition: background 0.2s ease, transform 0.2s ease;
}

.carousel-dots .dot.active {
    background: #007A5C;     /* 활성 점 색상 */
    transform: scale(1.2);   /* 살짝 커지게 */
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
		<a href="${pageContext.request.contextPath}/product/list">중고거래</a>
        <a href="${pageContext.request.contextPath}/controller/free">무료나눔</a>
    </div>

    <div class="search-box">
        <input type="text" placeholder="원하는 상품을 검색해보세요!">
        <button>🔍</button>
    </div>

    <div class="user-menu">
        <a href="${pageContext.request.contextPath}/controller/myStore">내 상점</a>

        <a href="${pageContext.request.contextPath}/controller/mypage" class="profile-link">
            <c:choose>
                <c:when test="${not empty user.profileImagePath}">
                    <img src="${pageContext.request.contextPath}${user.profileImagePath}" alt="프로필 이미지">
                </c:when>
            </c:choose>
            <span>${user.name}</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </div>
</div>
<!-- 🎯 좌우 버튼으로 넘기는 이미지 슬라이더 -->
<div class="hero-carousel">

    <!-- 왼쪽 버튼 -->
    <button class="carousel-btn left" onclick="moveSlide(-1)">&#10094;</button>

    <!-- 이미지 리스트 -->
    <div class="carousel-track">
    <div class="carousel-item active">
            <img src="${pageContext.request.contextPath}/resources/images/banner1.png" alt="배너1">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/resources/images/banner2.png" alt="배너2">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/resources/images/banner3.png" alt="배너3">
        </div>
    </div>

    <!-- 🔽 여기 추가 🔽 -->
    <div class="carousel-dots">
        <span class="dot active" onclick="goToSlide(0)"></span>
        <span class="dot" onclick="goToSlide(1)"></span>
        <span class="dot" onclick="goToSlide(2)"></span>
    </div>
    <!-- 🔼 여기 추가 🔼 -->

    <!-- 오른쪽 버튼 -->
    <button class="carousel-btn right" onclick="moveSlide(1)">&#10095;</button>

</div>
<script>
let currentSlide = 0;
const AUTO_DELAY = 5000;   // 5초마다 자동 이동
let autoTimer = null;

// 슬라이드 / 점 상태 갱신 공통 함수
function updateCarousel() {
    const items = document.querySelectorAll(".carousel-item");
    const dots = document.querySelectorAll(".carousel-dots .dot");
    const totalSlides = items.length;
    if (totalSlides === 0) return;

    // 인덱스 보정 (0 ~ totalSlides-1)
    currentSlide = (currentSlide + totalSlides) % totalSlides;

    // 슬라이드 active 처리
    items.forEach((item, i) => {
        item.classList.toggle("active", i === currentSlide);
    });

    // 점 active 처리
    dots.forEach((dot, i) => {
        dot.classList.toggle("active", i === currentSlide);
    });
}

// 특정 인덱스로 이동
function goToSlide(index) {
    currentSlide = index;
    updateCarousel();
}

// 좌우 버튼
function moveSlide(delta) {
    currentSlide += delta;
    updateCarousel();
}

// 자동 슬라이드
function startAuto() {
    stopAuto();
    autoTimer = setInterval(() => {
        currentSlide += 1;
        updateCarousel();
    }, AUTO_DELAY);
}

function stopAuto() {
    if (autoTimer) {
        clearInterval(autoTimer);
        autoTimer = null;
    }
}

// 페이지 로드 후 초기화
window.addEventListener("load", () => {
    currentSlide = 0;
    updateCarousel();   // 첫 장 표시

    startAuto();        // 자동 넘김 시작

    const hero = document.querySelector(".hero-carousel");
    if (hero) {
        hero.addEventListener("mouseenter", stopAuto);
        hero.addEventListener("mouseleave", startAuto);
    }
});
</script>




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

<!-- ✅ Top + 등록 플로팅 버튼 세트 -->
<div class="floating-container">
    <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
    <a href="${pageContext.request.contextPath}/product/add" class="floating-add">+</a>
</div>

<script>
// ✅ Top 버튼 기능
document.getElementById("topBtn").addEventListener("click", () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
});
</script>

<!-- ✅ 푸터 -->
<div class="footer">
    <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<!-- ✅ 삭제 후 한 번만 뜨는 알림 -->
<c:if test="${not empty requestScope.msg}">
    <script>
        alert("${requestScope.msg}");
    </script>
</c:if>


</body>
</html>
