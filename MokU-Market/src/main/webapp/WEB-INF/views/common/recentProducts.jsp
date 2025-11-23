<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
  /* ================= 최근 본 상품 패널 ================= */
.recent-products-panel {
  position: fixed;
  top: 50%;
  right: 20px;
  transform: translateY(-50%);
  width: 170px;
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  padding: 12px 10px 16px;
  font-family: 'Nanum Gothic', sans-serif;
  z-index: 1000;
}

  .recent-products-title {
    text-align: center;
    font-size: 14px;
    font-weight: 700;
    margin-bottom: 8px;
  }

  .recent-products-arrow {
    text-align: center;
    font-size: 12px;
    cursor: default;
    margin: 4px 0;
  }

  .recent-products-list {
    max-height: 260px;
    overflow-y: auto;
    margin: 8px 0;
  }

  .recent-product-item {
    display: block;
    margin-bottom: 8px;
    text-decoration: none;
    position: relative;     /* 🔥 오버레이 기준점 */
  }

  .recent-product-item img {
    display: block;
    width: 100%;
    height: auto;
    border-radius: 4px;
    object-fit: cover;
  }

  .recent-product-empty {
    font-size: 12px;
    color: #777;
    text-align: center;
    padding: 16px 4px;
  }

  /* ✅ 판매완료 비주얼 */
  .recent-product-item.sold img {
    filter: grayscale(0.5) brightness(0.7);
  }

  .recent-product-item.sold::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.35);
    border-radius: 4px;
    pointer-events: none;
  }

  .recent-sold-badge {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0,0,0,0.75);
    color: #fff;
    font-size: 11px;
    font-weight: 700;
    padding: 4px 10px;
    border-radius: 999px;
    letter-spacing: 1px;
    z-index: 2;
  }
</style>


<div class="recent-products-panel">
    <div class="recent-products-title">최근 본 상품</div>

    <!-- 위쪽 화살표 (스크롤 느낌만 주는 장식용) -->
    <div class="recent-products-arrow">▲</div>

    <div class="recent-products-list">
<c:choose>
    <c:when test="${not empty sessionScope.recentProducts}">
<c:forEach var="p" items="${sessionScope.recentProducts}">
    <a class="recent-product-item<c:if test='${p.status eq "SOLD"}'> sold</c:if>"
       href="${pageContext.request.contextPath}/product/detail?productId=${p.productId}">

        <!-- 🔥 판매완료 뱃지 -->
        <c:if test="${p.status eq 'SOLD'}">
            <div class="recent-sold-badge">판매 완료</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty p.imagePath}">
                <img src="${pageContext.request.contextPath}${p.imagePath}" alt="${p.title}">
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/resources/img/no-image.png" alt="${p.title}">
            </c:otherwise>
        </c:choose>
    </a>
</c:forEach>

    </c:when>
    <c:otherwise>
        <div class="recent-product-empty">
            최근 본 상품이 없습니다.
        </div>
    </c:otherwise>
</c:choose>


    </div>

    <!-- 아래쪽 화살표 (장식) -->
    <div class="recent-products-arrow">▼</div>
</div>
<script>
  window.addEventListener("pageshow", function (event) {
    // BFCache(뒤로/앞으로가기)로 돌아온 경우인지 체크
    var navEntries = performance.getEntriesByType("navigation");
    var isBackForward =
      (navEntries && navEntries.length > 0 && navEntries[0].type === "back_forward");

    if (event.persisted || isBackForward) {
      // 👉 뒤로가기/앞으로가기 로 돌아온 경우에만 강제 새로고침
      window.location.reload();
    }
  });
</script>

