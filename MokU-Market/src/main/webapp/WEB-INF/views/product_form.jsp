<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 등록 | 목유마켓</title>
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

/* ✅ 검색창 (정렬 완벽히 일치하도록 수정) */
.search-box {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center; /* ✅ 수직 정렬 */
  gap: 10px;
}

.search-box input {
  width: 700px;
  padding: 11px 20px;
  border: none;
  border-radius: 25px;
  outline: none;
  font-size: 15px;
  color: #333;
  background-color: white;
  box-sizing: border-box;
}

.search-box button {
  background-color: white;
  border: none;
  border-radius: 50%;
  width: 35px;
  height: 35px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: 0.2s;
  position: relative;
  top: -5px; /* ✅ 돋보기 아이콘을 약간 위로 올림 (1~2px 조정 가능) */
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
.user-menu a:hover { text-decoration: underline; }

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

/* ✅ 상품등록 폼 */
.container {
  background: #fff;
  width: 720px;
  border-radius: 20px;
  box-shadow: 0 8px 20px rgba(0,0,0,0.1);
  padding: 40px 50px;
  margin: 60px auto;
}
h2 {
  font-family: 'Jua', sans-serif;
  text-align: center;
  color: #007A5C;
  margin-bottom: 25px;
}

/* ✅ 이미지 업로드 */
.image-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
  margin-bottom: 15px;
}
.image-slot {
  aspect-ratio: 1 / 1;
  border: 2px dashed #ccc;
  border-radius: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  overflow: hidden;
  transition: 0.2s;
}
.image-slot:hover { border-color: #00A67E; }
.image-slot img { width: 100%; height: 100%; object-fit: cover; }

label {
  font-weight: 600;
  margin-top: 12px;
  display: block;
  color: #333;
}
input, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 10px;
  font-size: 14px;
  margin-bottom: 10px;
}
textarea { resize: vertical; height: 120px; }

button[type="submit"] {
  width: 100%;
  background-color: #00A67E;
  color: #fff;
  border: none;
  padding: 14px 0;
  font-weight: bold;
  border-radius: 12px;
  cursor: pointer;
  font-size: 15px;
  margin-top: 10px;
  transition: 0.2s;
}
button[type="submit"]:hover {
  background-color: #008a6b;
  transform: translateY(-2px);
}

#map {
  width: 100%;
  height: 300px;
  border-radius: 10px;
  margin-top: 5px;
  margin-bottom: 15px;
}

/* ✅ 푸터 */
.footer {
  background-color: #f1f1f1;
  text-align: center;
  padding: 10px;
  font-size: 13px;
  color: #666;
  border-top: 1px solid #ddd;
  margin-top: 50px;
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

  <!-- ✅ 중앙 검색창 -->
  <div class="search-box">
    <input type="text" placeholder="원하는 상품을 검색해보세요!">
    <button type="button">🔍</button>
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

<!-- ✅ 상품 등록 폼 -->
<div class="container">
  <h2>📦 상품 등록</h2>

  <form action="${pageContext.request.contextPath}/product/add" method="post" enctype="multipart/form-data">
    <label>상품 이미지 (최대 4장)</label>
    <div class="image-grid" id="imageGrid">
      <div class="image-slot" onclick="selectImage(0)">+</div>
      <div class="image-slot" onclick="selectImage(1)">+</div>
      <div class="image-slot" onclick="selectImage(2)">+</div>
      <div class="image-slot" onclick="selectImage(3)">+</div>
    </div>
    <input type="file" name="files" id="fileInput" multiple accept="image/*" style="display:none;">

    <label>제목</label>
    <input type="text" name="title" placeholder="최대 20자까지 입력 가능합니다" maxlength="20" required>

    <label>가격</label>
    <input type="number" name="price" placeholder="무료나눔은 0으로 입력하세요" required>

    <label>태그</label>
    <input type="text" name="tags" placeholder="#전공책 #기숙사용품 등 해시태그 입력">

    <label>거래장소</label>
    <input type="text" id="placeName" name="placeName" placeholder="예: GS25 학생회관점" required>
    <div id="map"></div>
    <input type="hidden" id="latitude" name="latitude">
    <input type="hidden" id="longitude" name="longitude">

    <label>본문</label>
    <textarea name="description" placeholder="상품 상태, 사용기간, 주의사항 등을 적어주세요." required></textarea>

    <button type="submit">등록하기</button>
  </form>
</div>

<!-- ✅ 푸터 -->
<div class="footer">
  <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<!-- ✅ Kakao 지도 -->
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=85969b990129ae28ec3aa8ad0beeca55&autoload=false"></script>
<script>
let map, marker;

function selectImage(index) {
  document.getElementById('fileInput').click();
}

document.getElementById('fileInput').addEventListener('change', (e) => {
  const files = e.target.files;
  const grid = document.getElementById('imageGrid').children;
  
  for (let i = 0; i < files.length && i < 4; i++) {
    const reader = new FileReader();
    reader.onload = function(event) {
      grid[i].innerHTML = `<img src="${event.target.result}" alt="preview">`;
    };
    reader.readAsDataURL(files[i]);
  }
});

document.addEventListener("DOMContentLoaded", function() {
  kakao.maps.load(function() {
    const mapContainer = document.getElementById('map');
    const mapOption = {
      center: new kakao.maps.LatLng(34.90858195604962, 126.43439168397106),
      level: 4
    };
    map = new kakao.maps.Map(mapContainer, mapOption);
    marker = new kakao.maps.Marker({ position: map.getCenter() });
    marker.setMap(map);

    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
      const latlng = mouseEvent.latLng;
      document.getElementById('latitude').value = latlng.getLat();
      document.getElementById('longitude').value = latlng.getLng();
      marker.setPosition(latlng);
    });
  });
});
</script>
</body>
</html>
