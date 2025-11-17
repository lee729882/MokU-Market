<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${product.title} - 목유마켓</title>

<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">

<style>

/* ===================== GLOBAL ===================== */
html, body {
  margin: 0;
  padding: 0;
  font-family: 'Nanum Gothic', sans-serif;
  background-color: #fafafa;
}

/* ===================== HEADER ===================== */
.header {
  background-color: #007A5C;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 25px 40px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
.header .logo { display:flex; align-items:center; gap:10px; }
.header .logo img { width:45px; height:45px; border-radius:50%; background:white; padding:4px; }
.header .logo h1 { font-family:'Jua'; font-size:25px; margin:0; }

.nav-links, .user-menu {
  display:flex;
  align-items:center;
  font-weight:600;
  font-size:15px;
  color:white;
}
.nav-links { gap:25px; margin-left:60px; }
.user-menu { gap:20px; }

.nav-links a, .user-menu a {
  color: white;
  text-decoration: none;
}
.nav-links a:hover, .user-menu a:hover { text-decoration: underline; }

/* 검색창 */
.search-box {
  flex:1;
  display:flex;
  justify-content:center;
  align-items:center;
}
.search-box input {
  width: 60%;
  padding: 9px 15px;
  border: none;
  border-radius: 20px;
  outline: none;
}
.search-box button {
  background: white;
  border: none;
  border-radius: 50%;
  width: 32px;
  height: 32px;
  margin-left: 8px;
  cursor: pointer;
  color: #007A5C;
  font-weight: bold;
}

/* HEADER PROFILE */
.profile-link {
  display:flex;
  align-items:center;
  gap:8px;
}
.profile-link img {
  width:36px; height:36px;
  border-radius:50%;
  object-fit:cover;
  border:2px solid white;
}

/* ===================== DETAIL LAYOUT ===================== */
.detail-container {
  width: 780px;
  margin: 40px auto 0;
  padding: 0 20px;
}

/* ===================== 이미지 슬라이더 ===================== */
.image-slider {
  width: 100%;
  height: 420px;
  position: relative;
  overflow: hidden;
  border-radius: 12px;
  background: #ddd;
  margin-bottom: 25px;
}

.slides {
  display: flex;
  transition: transform 0.4s ease;
  width: 100%;
  height: 100%;
}

.slide {
  min-width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.slide img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

/* arrows */
.arrow {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  font-size: 28px;
  padding: 8px 12px;
  background: rgba(255,255,255,0.8);
  border-radius: 50%;
  cursor: pointer;
  user-select: none;
}
.arrow.left { left: 10px; }
.arrow.right { right: 10px; }

/* dots */
.dots {
  position: absolute;
  bottom: 12px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 6px;
}
.dot {
  width: 10px; height: 10px;
  background: #bbb;
  border-radius: 50%;
  cursor: pointer;
}
.dot.active {
  background: #007A5C;
}

/* ===================== SELLER ===================== */
.seller-box {
  display:flex;
  align-items:center;
  gap:15px;
  margin-top:10px;
}
.seller-box img {
  width:48px; height:48px;
  border-radius:50%;
  object-fit:cover;
}

.title { font-size:23px; font-weight:700; margin-top:25px; }
.meta { margin-top:5px; color:#777; font-size:14px; }
.price { font-size:23px; font-weight:900; margin-top:10px; }
.description { margin-top:15px; line-height:1.6; }

/* like button */
.like-btn {
  cursor: pointer;
  display: flex;
  align-items: center;
}

.heart-icon {
  width: 32px;
  height: 32px;
  transition: 0.2s ease;
}

.like-btn.liked .heart-icon path {
  fill: #ff5959 !important;
  stroke: #ff5959 !important;
}

/* 지도 */
#map {
  width:100%;
  height:240px;
  border-radius:12px;
  margin-top:15px;
}

/* footer */
.footer {
  background-color: #f1f1f1;
  text-align: center;
  padding: 10px;
  font-size: 13px;
  color: #666;
  border-top: 1px solid #ddd;
  margin-top: 50px;
}
.chat-btn {
  background-color: #007A5C;
  color: white;
  border: none;
  padding: 12px 22px;
  font-size: 16px;
  font-weight: 700;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.chat-btn:hover {
  background-color: #009b75; /* 조금 밝은 그린 */
  transform: translateY(-2px);
}

.chat-btn:active {
  background-color: #006450;
  transform: translateY(0);
}

</style>
</head>

<body>

<!-- ===================== HEADER ===================== -->
<div class="header">

  <div class="logo">
    <a href="${pageContext.request.contextPath}/home"
       style="display:flex; align-items:center; gap:10px; text-decoration:none; color:white;">
      <img src="${pageContext.request.contextPath}/resources/images/mokyu_logo.png">
      <h1>목유마켓</h1>
    </a>
  </div>

  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/product/list?category=중고거래">중고거래</a>
    <a href="${pageContext.request.contextPath}/product/list?category=무료나눔">무료나눔</a>
  </div>

  <div class="search-box">
    <input type="text" placeholder="원하는 상품을 검색해보세요!">
    <button>🔍</button>
  </div>

  <div class="user-menu">

    <c:if test="${not empty user}">
      <a href="${pageContext.request.contextPath}/controller/myStore">내 상점</a>

      <a href="${pageContext.request.contextPath}/controller/mypage" class="profile-link">
        <img src="${pageContext.request.contextPath}${user.profileImagePath}"
             onerror="this.src='${pageContext.request.contextPath}/resources/images/default_profile.png';">
        <span>${user.name}</span>
      </a>

      <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </c:if>

    <c:if test="${empty user}">
      <a href="${pageContext.request.contextPath}/login">로그인</a>
    </c:if>

  </div>
</div>

<!-- ===================== DETAIL CONTENT ===================== -->
<div class="detail-container">

<!-- 이미지 슬라이더 -->
<div class="image-slider">

    <div class="slides">
        <c:forEach var="img" items="${images}">
            <div class="slide">
                <img src="${pageContext.request.contextPath}${img}">
            </div>
        </c:forEach>
    </div>

    <!-- 좌우 화살표 -->
    <c:if test="${fn:length(images) > 1}">
        <div class="arrow left" onclick="prevSlide()">&#10094;</div>
        <div class="arrow right" onclick="nextSlide()">&#10095;</div>
    </c:if>

    <!-- 하단 도트 -->
    <div class="dots">
        <c:forEach var="i" begin="0" end="${fn:length(images)-1}">
            <span class="dot" onclick="currentSlide(${i})"></span>
        </c:forEach>
    </div>

</div>


    <!-- 판매자 -->
    <div class="seller-box">
        <img src="${pageContext.request.contextPath}${seller.profileImagePath}">
        <div>
            <div style="font-weight:700; font-size:16px;">${seller.name}</div>
            <div style="font-size:13px; color:#777; margin-top:3px;">
매너온도 ${seller.mannerTemp}°C · 찜 <span id="likeCount">${likeCount}</span> · 채팅 ${seller.chatCount}
            </div>
        </div>
    </div>

    <!-- 제목 -->
    <div class="title">제목 : ${product.title}</div>

    <!-- 작성일 -->
    <div class="meta">
        <fmt:formatDate value="${product.createdAt}" pattern="yyyy-MM-dd"/> · 조회수 ${product.viewCount}
    </div>

    <!-- 가격 -->
    <div class="price"><fmt:formatNumber value="${product.price}" pattern="#,###"/> 원</div>

    <!-- 설명 -->
    <div class="description">${product.description}</div>

    <!-- 버튼 -->
    <div class="btn-row" style="display:flex; align-items:center; gap:15px; margin-top:20px;">
<button class="chat-btn">채팅하기</button>

        <div id="likeBtn" class="like-btn ${liked ? 'liked' : ''}">
            <svg class="heart-icon" viewBox="0 0 24 24">
                <path d="M12.1 8.64l-.1.1-.11-.1C9.14 5.92 5.6 6.28 4.07 8.36c-1.52 2.09-1 5.33 1.11 7.11L12 21l6.82-5.53c2.12-1.78 2.63-5.02 1.11-7.11-1.53-2.08-5.07-2.44-7.83.28z"
                      fill="none" stroke="#000" stroke-width="2"/>
            </svg>
        </div>

    </div>

    <!-- 거래 장소 -->
    <h3 style="margin-top:45px; margin-bottom:10px;">거래 장소</h3>
    <div id="map"></div>

    <!-- 관련 상품 -->
    <h3 style="margin-top:40px;">연관상품</h3>
    <div class="related-grid">
        <c:forEach var="r" items="${relatedProducts}">
            <div class="related-card"
                 onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${r.productId}'">
                <img src="${pageContext.request.contextPath}${r.imagePath}">
                <p>${r.title}</p>
            </div>
        </c:forEach>
    </div>

</div>

<!-- FOOTER -->
<div class="footer">
  <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<!-- ===================== JS: 슬라이더 ===================== -->
<script>
document.addEventListener("DOMContentLoaded", () => {

    let currentIndex = 0;
    const slides = document.querySelector(".slides");
    const slideList = document.querySelectorAll(".slide");
    const dots = document.querySelectorAll(".dot");
    const slideCount = slideList.length;

    if (!slides || slideCount === 0) return;

    function showSlide(index) {
        if (index < 0) index = slideCount - 1;
        if (index >= slideCount) index = 0;

        currentIndex = index;

        // 🔥 여기 부분만 템플릿 문자열 → 문자열 더하기로 변경
        slides.style.transform = 'translateX(-' + (index * 100) + '%)';

        dots.forEach(dot => dot.classList.remove("active"));
        if (dots[index]) dots[index].classList.add("active");
    }

    window.nextSlide = function() { showSlide(currentIndex + 1); };
    window.prevSlide = function() { showSlide(currentIndex - 1); };
    window.currentSlide = function(i) { showSlide(i); };

    // 초기 슬라이드 표시
    showSlide(0);
});
</script>



<!-- ===================== KAKAO MAP ===================== -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=85969b990129ae28ec3aa8ad0beeca55&libraries=services"></script>
<script>
var map = new kakao.maps.Map(document.getElementById('map'), {
    center: new kakao.maps.LatLng(${product.latitude}, ${product.longitude}),
    level: 3
});
new kakao.maps.Marker({
    map: map,
    position: new kakao.maps.LatLng(${product.latitude}, ${product.longitude})
});
</script>

<!-- ===================== LIKE BUTTON AJAX ===================== -->
<script>
document.addEventListener("DOMContentLoaded", () => {

    const btn = document.getElementById("likeBtn");
    const countArea = document.getElementById("likeCount");

    if (!btn) return;

    btn.addEventListener("click", () => {

    	fetch("${pageContext.request.contextPath}/product/toggleLike", {
    	    method: "POST",
    	    headers: { "Content-Type": "application/json" },
    	    body: JSON.stringify({ productId: ${product.productId} })
    	})

        .then(res => res.json())
        .then(data => {

            if (data.status === "login_required") {
                alert("로그인이 필요합니다.");
                return;
            }

            if (data.liked) btn.classList.add("liked");
            else btn.classList.remove("liked");

            countArea.innerText = data.likeCount;
        })
        .catch(err => console.error("LIKE ERROR:", err));
    });

});
</script>

</body>
</html>
