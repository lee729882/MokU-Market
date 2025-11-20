<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  <!-- ✅ 가격 천단위 표시용 추가 -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${category} 목록 - 목유마켓</title>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,300..700,0..1,-50..200" />

<style>
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
  font-family: 'Nanum Gothic', sans-serif;
  background-color: #fafafa;
  display: flex;
  flex-direction: column;
}

/* ✅ 본문 */
.container {
  flex: 1;
  width: 100%;
  max-width: 1150px;
  margin: 60px auto;
  padding: 0 20px;
}
.container h2 {
  font-family: 'Jua', sans-serif;
  text-align: center;
  color: #007A5C;
  margin-bottom: 25px;
}

/* ✅ 상품 카드 */
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 30px 25px;
}
.product {
  position: relative;   /* 판매완료 오버레이/배지용 */
  background: #fff;
  border-radius: 15px;
  box-shadow: 0 3px 8px rgba(0,0,0,0.08);
  overflow: hidden;
  cursor: pointer;
  text-align: left;
  transition: 0.25s;
}
.product:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 12px rgba(0,0,0,0.15);
}

/* 이미지 래퍼 */
.product .thumb {
  position: relative;
}
.product img {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

/* ✅ 판매완료 비주얼 (마이페이지와 동일 스타일) */

/* 이미지에 그레이 + 어둡게 */
.product.sold-out .thumb img {
  filter: grayscale(0.5) brightness(0.7);
}

/* 전체 반투명 오버레이 */
.product.sold-out .thumb::before {
  content: "";
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.35);
}

/* 중앙 동그란 "판매 완료" 배지 */
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

.product.sold-out .sold-badge {
  background: rgba(0,0,0,0.85);
}

/* 가격 옆 텍스트 */
.product-info {
  padding: 15px;
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
  margin: 5px 0;
}
.price .sold-text {
  font-size: 12px;
  color: #ff4d4d;
  margin-left: 4px;
  font-weight: 600;
}

/* ✅ 카테고리 뱃지 */
.badge {
  display: inline-block;
  font-size: 12px;
  font-weight: bold;
  padding: 4px 10px;
  border-radius: 20px;
  color: white;
  margin-bottom: 5px;
}
.badge.무료나눔 { background-color: #4CAF50; }
.badge.전자기기 { background-color: #3F51B5; }
.badge.의류 { background-color: #FF7043; }
.badge.생활용품 { background-color: #009688; }
.badge.전공서적 { background-color: #9C27B0; }
.badge.음식 { background-color: #795548; }
.badge.default { background-color: #607D8B; }

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

/* ✅ 플로팅 버튼 */
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
.floating-top:hover { opacity: 1; transform: translateY(-2px); }
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
  box-shadow: 0 4px 10px rgba(0,0,0,0.25);
  transition: 0.25s;
}
.floating-add:hover { background-color: #E03B3B; transform: scale(1.07); }

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
</style>
</head>

<body>

<!-- ✅ 공통 헤더 JSP 사용 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- ✅ 본문 -->
<div class="container">
  <h2>📦 ${category} 목록</h2>

  <c:choose>
    <c:when test="${empty products}">
      <p style="text-align:center; color:#777; margin-top:40px;">
        등록된 상품이 없습니다. 첫 번째로 등록해보세요!
      </p>
    </c:when>
    <c:otherwise>
      <div class="product-grid">
        <c:forEach var="p" items="${products}">
          <%-- 🔴 STATUS = 'SOLD_OUT' 이면 sold-out 클래스 추가 --%>
          <div class="product<c:if test='${p.status eq "SOLD"}'> sold-out</c:if>"
               onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${p.productId}'">

            <!-- ✅ 이미지 + 판매완료 배지 -->
            <div class="thumb">
              <img src="${pageContext.request.contextPath}${p.imagePath}"
                   alt="${p.title}"
                   onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />
              <c:if test="${p.status eq 'SOLD'}">
                <div class="sold-badge">판매완료</div>
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

                <%-- 🔴 가격 옆 텍스트로도 표시 (STATUS = SOLD_OUT 기준) --%>
                <c:if test="${p.status eq 'SOLD'}">
                  <span class="sold-text">· 판매완료</span>
                </c:if>
              </p>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<!-- ✅ 푸터 -->
<div class="footer">
  <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<!-- ✅ 플로팅 버튼 -->
<div class="floating-container">
  <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
  <a href="${pageContext.request.contextPath}/product/add" class="floating-add">+</a>
</div>

<script>
document.getElementById("topBtn").addEventListener("click", () => {
  window.scrollTo({ top: 0, behavior: "smooth" });
});
</script>

</body>
</html>
