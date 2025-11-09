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

/* ✅ 헤더 */
.header {
  background-color: #007A5C;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 25px 40px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
.header .logo { display: flex; align-items: center; gap: 10px; }
.header .logo img { width: 45px; height: 45px; border-radius: 50%; background: white; padding: 4px; }
.header .logo h1 { font-family: 'Jua', sans-serif; font-size: 25px; margin: 0; color: white; }
.nav-links { display: flex; gap: 25px; align-items: center; margin-left: 60px; font-weight: 600; }
.nav-links a { color: white; text-decoration: none; }
.nav-links a:hover { text-decoration: underline; }
.search-box { flex: 1; display: flex; justify-content: center; align-items: center; gap: 10px; }
.search-box input { width: 700px; padding: 11px 20px; border: none; border-radius: 25px; outline: none; font-size: 15px; color: #333; background-color: white; }
.search-box button { background-color: white; border: none; border-radius: 50%; width: 35px; height: 35px; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: 0.2s; }
.search-box button:hover { transform: scale(1.05); background-color: #f1f1f1; }

/* ✅ 사용자 메뉴 */
.user-menu { display: flex; gap: 20px; align-items: center; }
.user-menu a { color: white; text-decoration: none; font-weight: 600; }
.user-menu a:hover { text-decoration: underline; }
.profile-link { display: flex; align-items: center; gap: 8px; text-decoration: none; color: white; }
.profile-link img { width: 36px; height: 36px; border-radius: 50%; object-fit: cover; border: 2px solid white; }

/* ✅ 상품 등록 폼 */
.container {
  background: #fff;
  width: 740px;
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
.image-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  width: 100%;
  max-width: 740px;
  margin: 0 auto 15px;
  gap: 20px;
}

.main-slot {
  width: 360px;
  height: 360px;
  border: 2px dashed #ccc;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #fafafa;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.main-slot.loaded { border-color:#00a67e; background:#e6fff7; }

.sub-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 15px;
}

.sub-slot {
  width: 170px;
  height: 170px;
  border: 2px dashed #ccc;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #fafafa;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.sub-slot.loaded { border-color:#00a67e; background:#e6fff7; }

.main-slot img, .sub-slot img {
  width: 100%;
  height: 100%;
  object-fit: contain;     /* ✅ 원본 비율 유지 */
  background-color: #fff;
  display: block;
}

.delete-btn {
  position: absolute;
  top: 5px;
  right: 5px;
  background: #ff5252;
  color: white;
  border: none;
  border-radius: 50%;
  width: 22px;
  height: 22px;
  cursor: pointer;
  font-size: 13px;
  font-weight: bold;
  z-index: 10;
}

/* ✅ 입력 */
label { font-weight: 600; display: block; margin-top: 12px; color: #333; }
input, textarea, select {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 10px;
  font-size: 14px;
  margin-bottom: 10px;
}
textarea { resize: vertical; height: 120px; }

/* ✅ 버튼 */
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
button[type="submit"]:hover { background-color: #008a6b; transform: translateY(-2px); }

/* ✅ 지도 */
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
    <a href="${pageContext.request.contextPath}/home" style="display:flex; align-items:center; gap:10px; text-decoration:none; color:white;">
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

<!-- ✅ 상품 등록 -->
<div class="container">
  <h2>📦 상품 등록</h2>

  <form action="${pageContext.request.contextPath}/product/add" method="post" enctype="multipart/form-data">
    <label>상품 이미지 (대표 1장 + 추가 4장)</label>
    <div class="image-wrapper">
      <div class="main-slot" id="mainSlot">대표 +</div>
      <div class="sub-grid" id="subGrid">
        <div class="sub-slot">+</div>
        <div class="sub-slot">+</div>
        <div class="sub-slot">+</div>
        <div class="sub-slot">+</div>
      </div>
    </div>
    <input type="file" id="fileInput" name="files" accept="image/*" multiple style="display:none;">

    <label>제목</label>
    <input type="text" name="title" maxlength="20" placeholder="최대 20자까지 입력 가능합니다" required>

    <label>가격</label>
    <input type="number" name="price" placeholder="무료나눔은 0으로 입력하세요" required>

    <label>카테고리</label>
    <select name="category" required>
      <option value="" disabled selected>카테고리를 선택하세요</option>
      <option value="전공서적">전공서적</option>
      <option value="전자기기">전자기기</option>
      <option value="생활용품">생활용품</option>
      <option value="의류">의류</option>
      <option value="음식">음식</option>
      <option value="무료나눔">무료나눔</option>
    </select>

    <label>거래장소</label>
    <input type="text" id="placeName" name="placeName" placeholder="지도를 클릭하면 자동 입력됩니다." required>
    <div id="map"></div>
    <input type="hidden" id="latitude" name="latitude">
    <input type="hidden" id="longitude" name="longitude">

    <label>본문</label>
    <textarea name="description" placeholder="상품 상태, 사용기간 등을 적어주세요." required></textarea>

    <button type="submit">등록하기</button>
  </form>
</div>

<div class="footer">
  <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<!-- ✅ Kakao Map & Image Preview -->
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=85969b990129ae28ec3aa8ad0beeca55&libraries=services&autoload=false"></script>
<script>
let mainSet = false;
const mainSlot = document.getElementById("mainSlot");
const subGrid = document.getElementById("subGrid");
const fileInput = document.getElementById("fileInput");
let clickedSlot = null; // ✅ 클릭한 슬롯 저장용

// ✅ 슬롯 클릭 → 어떤 칸인지 저장 후 파일 선택
document.querySelectorAll(".main-slot, .sub-slot").forEach(slot => {
  slot.addEventListener("click", e => {
    clickedSlot = e.currentTarget; // ✅ 클릭한 위치 기억
    fileInput.click();
  });
});

// ✅ 이미지 선택 후 미리보기 표시
fileInput.addEventListener("change", e => {
  const file = e.target.files[0];
  if (!file || !clickedSlot) return; // 아무것도 선택 안 한 경우

  const reader = new FileReader();
  reader.onload = ev => {
    const img = new Image();
    img.src = ev.target.result;

    img.onload = () => {
      // 클릭한 슬롯에 이미지 삽입
      clickedSlot.innerHTML = "";
      clickedSlot.appendChild(img);

      // ✅ 삭제 버튼 추가
      const btn = document.createElement("button");
      btn.textContent = "×";
      btn.className = "delete-btn";

      // ✅ 삭제 로직 (정확히 클릭한 슬롯 기준)
      btn.addEventListener("click", ev2 => {
        ev2.stopPropagation(); // 클릭 전파 방지
        const slot = ev2.target.closest(".main-slot, .sub-slot"); // 실제 눌린 슬롯 찾기

        if (slot.classList.contains("main-slot")) {
          slot.innerHTML = "대표 +";
          slot.classList.remove("loaded");
          mainSet = false;
        } else {
          slot.innerHTML = "+";
          slot.classList.remove("loaded");

          // ✅ 제목 입력칸으로 포커스 이동
          const titleInput = document.querySelector("input[name='title']");
          if (titleInput) {
            setTimeout(() => titleInput.focus(), 150); // 부드럽게 이동
          }
        }
      });

      clickedSlot.appendChild(btn);
      clickedSlot.classList.add("loaded");

      if (clickedSlot.classList.contains("main-slot")) {
        mainSet = true;
      }
    };
  };
  reader.readAsDataURL(file);

  // ⚠️ input 초기화, 슬롯 참조 안전하게 null 처리
  e.target.value = "";
  setTimeout(() => { clickedSlot = null; }, 300);
});

// ✅ 지도 클릭 → 주소 자동 입력
kakao.maps.load(() => {
  const mapContainer = document.getElementById("map");
  const mapOption = { center: new kakao.maps.LatLng(34.8085, 126.3897), level: 4 };
  const map = new kakao.maps.Map(mapContainer, mapOption);
  const marker = new kakao.maps.Marker({ position: map.getCenter() });
  const geocoder = new kakao.maps.services.Geocoder();
  marker.setMap(map);

  kakao.maps.event.addListener(map, "click", mouseEvent => {
    const latlng = mouseEvent.latLng;
    document.getElementById("latitude").value = latlng.getLat();
    document.getElementById("longitude").value = latlng.getLng();
    marker.setPosition(latlng);
    geocoder.coord2Address(latlng.getLng(), latlng.getLat(), (result, status) => {
      if (status === kakao.maps.services.Status.OK) {
        document.getElementById("placeName").value = result[0].address.address_name;
      }
    });
  });
});

// ✅ 지도 클릭 → 주소 자동 입력
kakao.maps.load(() => {
  const mapContainer = document.getElementById("map");
  const mapOption = { center: new kakao.maps.LatLng(34.8085, 126.3897), level: 4 };
  const map = new kakao.maps.Map(mapContainer, mapOption);
  const marker = new kakao.maps.Marker({ position: map.getCenter() });
  const geocoder = new kakao.maps.services.Geocoder();
  marker.setMap(map);

  kakao.maps.event.addListener(map, "click", mouseEvent => {
    const latlng = mouseEvent.latLng;
    document.getElementById("latitude").value = latlng.getLat();
    document.getElementById("longitude").value = latlng.getLng();
    marker.setPosition(latlng);
    geocoder.coord2Address(latlng.getLng(), latlng.getLat(), (result, status) => {
      if (status === kakao.maps.services.Status.OK) {
        document.getElementById("placeName").value = result[0].address.address_name;
      }
    });
  });
});
</script>
</body>
</html>
