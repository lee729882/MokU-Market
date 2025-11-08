<%@ page contentType="text/html; charset=UTF-8"%>
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
  background-color: #fafafa;
  display: flex;
  flex-direction: column;
}

/* ✅ 헤더 전체 */
.header {
  background-color: #007A5C;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 25px 40px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

/* ✅ 로고 */
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

/* ✅ 네비게이션 */
.nav-links {
  display: flex;
  gap: 25px;
  align-items: center;
  margin-left: 60px;
  font-family: 'Nanum Gothic', sans-serif;
  font-weight: 600;
  font-size: 15px;
  line-height: 1;
}
.nav-links a {
  color: white;
  text-decoration: none;
}
.nav-links a:hover { text-decoration: underline; }

/* ✅ 검색창 (home.jsp 동일 정렬) */
.search-box {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px;
}
.search-box input {
  width: 700px;
  padding: 12px 22px;
  border: none;
  border-radius: 25px;
  outline: none;
  font-size: 15px;
  color: #333;
  background-color: white;
  box-sizing: border-box;
  line-height: normal;
}
.search-box button {
  background-color: white;
  border: none;
  border-radius: 50%;
  width: 38px;
  height: 38px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: 0.2s;
  position: relative;
  top: 0;
}
.search-box button:hover {
  transform: scale(1.05);
  background-color: #f1f1f1;
}

/* ✅ 사용자 메뉴 */
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
.profile-link:hover img { transform: scale(1.07); }

/* ✅ 본문 컨테이너 */
.container {
  flex: 1;
  width: 100%;
  max-width: 1100px;
  margin: 50px auto;
  padding: 0 20px;
}
.container h2 {
  text-align: center;
  color: #007A5C;
  font-size: 24px;
  margin-bottom: 25px;
}

/* ✅ 상품 목록 */
.empty-msg {
  text-align: center;
  color: #777;
  margin-top: 40px;
  font-size: 15px;
}
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 25px;
}
.product {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 3px 8px rgba(0,0,0,0.08);
  padding: 12px;
  cursor: pointer;
  transition: 0.25s;
  text-align: center;
}
.product:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 12px rgba(0,0,0,0.15);
}
.product img {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 10px;
  margin-bottom: 10px;
}
.product p { margin: 6px 0; font-size: 15px; color: #333; }
.product .price { font-weight: bold; color: #007A5C; }

/* ✅ 상품 등록 버튼 */
.add-btn {
  display: block;
  width: 200px;
  margin: 50px auto 80px;
  padding: 13px 0;
  text-align: center;
  background-color: #007A5C;
  color: white;
  border-radius: 10px;
  text-decoration: none;
  font-weight: 600;
  transition: 0.2s;
}
.add-btn:hover { background-color: #005f45; }

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
  .floating-container { bottom: 25px; right: 25px; }
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
    <a href="${pageContext.request.contextPath}/product/list?category=중고거래">중고거래</a>
    <a href="${pageContext.request.contextPath}/product/list?category=무료나눔">무료나눔</a>
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
        <c:otherwise>
          <img src="${pageContext.request.contextPath}/resources/images/default_profile.png" alt="기본 프로필">
        </c:otherwise>
      </c:choose>
      <span>${user.name}</span>
    </a>
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
                <c:when test="${p.price == 0}">무료나눔</c:when>
                <c:otherwise>${p.price}원</c:otherwise>
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
