<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   <!-- ✅ 추가 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>목유마켓 홈</title>

    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

    <style>
        body {
            font-family: 'Nanum Gothic', sans-serif;
            margin: 0;
            background-color: #f8f9fa;
        }

        /* 페이지 전체 래퍼 (헤더 아래 내용) */
        .page-wrapper {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* 배너(필요 없으면 제거 가능) */
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

        /* 카테고리 영역 */
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

        /* 섹션 공통 */
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

        /* 상품 그리드 */
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


        /* 플로팅 버튼 세트 */
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

        /* Top 버튼 */
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
            font-family: 'Nanum Gothic', sans-serif;
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

        /* + 등록 버튼 */
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

        /* 메인 배너(슬라이더) 영역 */
        .hero-carousel {
            position: relative;
            max-width: 1200px;
            margin: 0 auto 35px;
            overflow: hidden;
            border-radius: 18px;
            background: transparent;
        }
        .carousel-track {
            display: flex;
            transition: transform 0.4s ease;
        }
        .carousel-item {
            flex: 0 0 100%;
            display: none;
            justify-content: center;
            align-items: center;
        }
        .carousel-item img {
            width: 100%;
            height: auto;
            border-radius: 0;
            display: block;
        }
        .carousel-item.active {
            display: flex;
        }

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
            background: #007A5C;
            transform: scale(1.2);
        }
        /* ✅ 판매완료 비주얼 */
.product {
    position: relative;  /* 오버레이 기준점 */
}

/* 이미지 톤 다운 */
.product.sold img {
    filter: grayscale(0.5) brightness(0.7);
}

/* 어두운 오버레이 */
.product.sold::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.35);
    pointer-events: none;
}

/* 중앙 "판매 완료" 뱃지 */
.sold-badge {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0,0,0,0.7);
    color: #fff;
    font-size: 13px;
    font-weight: 700;
    padding: 6px 14px;
    border-radius: 999px;
    letter-spacing: 1px;
    z-index: 2;
}
        
    </style>
</head>

<body>

    <!-- ✅ 공통 헤더 + GNB -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- ✅ 헤더 아래 실제 메인 콘텐츠 -->
    <div class="page-wrapper">

        <!-- 메인 배너 슬라이더 -->
        <div class="hero-carousel">

            <!-- 왼쪽 버튼 -->
            <button class="carousel-btn left" onclick="moveSlide(-1)">&#10094;</button>
            
            <div class="category"
			     onclick="location.href='${pageContext.request.contextPath}/community'">
			    <img src="https://cdn-icons-png.flaticon.com/512/1827/1827513.png" alt="커뮤니티">
			    <span>커뮤니티</span>
			</div>

            

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

            <!-- 하단 점(인디케이터) -->
            <div class="carousel-dots">
                <span class="dot active" onclick="goToSlide(0)"></span>
                <span class="dot" onclick="goToSlide(1)"></span>
                <span class="dot" onclick="goToSlide(2)"></span>
            </div>

            <!-- 오른쪽 버튼 -->
            <button class="carousel-btn right" onclick="moveSlide(1)">&#10095;</button>

        </div>

        <!-- 카테고리 -->
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

<!-- 인기상품: 찜 많은 순 -->
<div class="section">
    <h3>🔥 인기 상품 (찜 많은 순)</h3>

    <c:choose>
        <c:when test="${empty topFavoriteProducts}">
            <p style="color:#777; font-size:14px;">
                아직 인기 상품이 없습니다.
            </p>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
<c:forEach var="p" items="${topFavoriteProducts}">
    <div class="product<c:if test='${p.status eq "SOLD"}'> sold</c:if>"
         onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${p.productId}'">

        <!-- 🔥 판매완료 뱃지 -->
        <c:if test="${p.status == 'SOLD'}">
            <div class="sold-badge">판매 완료</div>
        </c:if>

        <img src="${pageContext.request.contextPath}${p.imagePath}"
             alt="${p.title}"
             onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />

        <p>${p.title}</p>
        <p class="price">
            <c:choose>
                <c:when test="${p.price == 0}">무료나눔</c:when>
                <c:otherwise>
                    <fmt:formatNumber value="${p.price}" type="number" pattern="#,###" /> 원
                </c:otherwise>
            </c:choose>
        </p>
    </div>
</c:forEach>

            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- 많이 본 상품: 조회수 많은 순 -->
<div class="section">
    <h3>👀 많이 본 상품 (조회수 순)</h3>

    <c:choose>
        <c:when test="${empty topViewProducts}">
            <p style="color:#777; font-size:14px;">
                아직 조회수가 많은 상품이 없습니다.
            </p>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
              <c:forEach var="p" items="${topViewProducts}">
    <div class="product<c:if test='${p.status eq "SOLD"}'> sold</c:if>"
         onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${p.productId}'">

        <!-- 🔥 판매완료 뱃지 -->
        <c:if test="${p.status == 'SOLD'}">
            <div class="sold-badge">판매 완료</div>
        </c:if>

        <img src="${pageContext.request.contextPath}${p.imagePath}"
             alt="${p.title}"
             onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />

        <p>${p.title}</p>
        <p class="price">
            <c:choose>
                <c:when test="${p.price == 0}">무료나눔</c:when>
                <c:otherwise>
                    <fmt:formatNumber value="${p.price}" type="number" pattern="#,###" /> 원
                </c:otherwise>
            </c:choose>
        </p>
    </div>
</c:forEach>

            </div>
        </c:otherwise>
    </c:choose>
</div>


        <!-- 플로팅 버튼 -->
        <div class="floating-container">
            <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
            <a href="${pageContext.request.contextPath}/product/add" class="floating-add">+</a>
        </div>

    </div> <!-- /page-wrapper -->

    <!-- Top 버튼 기능 -->
    <script>
        document.getElementById("topBtn").addEventListener("click", () => {
            window.scrollTo({ top: 0, behavior: "smooth" });
        });

        // 슬라이더 스크립트
        let currentSlide = 0;
        const AUTO_DELAY = 5000;
        let autoTimer = null;

        function updateCarousel() {
            const items = document.querySelectorAll(".carousel-item");
            const dots = document.querySelectorAll(".carousel-dots .dot");
            const totalSlides = items.length;
            if (totalSlides === 0) return;

            currentSlide = (currentSlide + totalSlides) % totalSlides;

            items.forEach((item, i) => {
                item.classList.toggle("active", i === currentSlide);
            });
            dots.forEach((dot, i) => {
                dot.classList.toggle("active", i === currentSlide);
            });
        }

        function goToSlide(index) {
            currentSlide = index;
            updateCarousel();
        }

        function moveSlide(delta) {
            currentSlide += delta;
            updateCarousel();
        }

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

        window.addEventListener("load", () => {
            currentSlide = 0;
            updateCarousel();
            startAuto();

            const hero = document.querySelector(".hero-carousel");
            if (hero) {
                hero.addEventListener("mouseenter", stopAuto);
                hero.addEventListener("mouseleave", startAuto);
            }
        });
    </script>

    <!-- 삭제 후 한 번만 뜨는 알림 -->
    <c:if test="${not empty requestScope.msg}">
        <script>
            alert("${requestScope.msg}");
        </script>
    </c:if>
    <jsp:include page="/WEB-INF/views/common/recentProducts.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
