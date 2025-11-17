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
  object-fit: contain;
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

/* ✅ 지도 높이를 zone-box에 맞게 자동 조정 */
.map-wrapper {
  display: flex;
  align-items: stretch; /* 높이를 자동으로 동일하게 맞춤 */
  gap: 25px;
}

#map {
  flex: 1; /* 남은 공간 꽉 채우기 */
  min-height: 400px; /* 너무 작아지지 않도록 최소 높이 설정 */
  border-radius: 10px;
  border: 1px solid #ccc;
}

.zone-box {
  width:30%;
  background:#fff;
  border:1px solid #ddd;
  border-radius:10px;
  padding:15px;
  font-size:14px;
}
.zone-tabs {
  display:flex;
  justify-content:space-around;
  margin-bottom:10px;
}
.zone-tab {
  flex:1;
  padding:8px 0;
  text-align:center;
  background:#e0e0e0;
  border-radius:8px;
  margin:0 3px;
  cursor:pointer;
  font-weight:600;
  transition:0.2s;
}
.zone-tab.active {
  background:#007A5C;
  color:white;
}
.zone-list { display:none; }
.zone-list.active { display:block; }

.zone-list ul { list-style:none; padding-left:10px; margin:5px 0 10px 0; }
.zone-list a { color:#333; text-decoration:none; display:block; padding:3px 0; }
.zone-list a:hover { color:#007A5C; font-weight:600; }

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
.price-wrap {
  position: relative;
  width: 100%;
}

.price-wrap input {
  width: 100%;
  height: 46px;
  padding: 0 50px 0 12px;
  border: 1px solid #ddd;
  border-radius: 10px;
  font-size: 14px;
  line-height: 46px;
  text-align: right;
  box-sizing: border-box;
}

.won-label {
  position: absolute;
  right: 15px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 14px;
  font-weight: 600;
  color: #555;
  pointer-events: none;
  user-select: none;
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
    <div id="fileInputsContainer"></div>
    
    <input type="file" id="fileInput" name="files" accept="image/*" multiple style="display:none;">

    <label>제목</label>
    <input type="text" name="title" maxlength="20" placeholder="최대 20자까지 입력 가능합니다" required>

    <label>가격</label>
    <div class="price-wrap">
      <input type="text" name="price" id="priceInput" placeholder="희망 가격을 입력해주세요 !" required>
      <span class="won-label">원</span>
    </div>

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
    <input type="text" id="placeName" name="placeName" placeholder="지도를 클릭하거나 오른쪽 목록에서 선택하세요." required>
    <input type="hidden" id="latitude" name="latitude">
    <input type="hidden" id="longitude" name="longitude">

    <!-- ✅ 지도 + 캠퍼스 구역 목록 -->
<div class="map-wrapper">
  <div id="map"></div>
	<div class="zone-box">
	  <div class="zone-tabs">
	    <div class="zone-tab active" data-target="A">A구역</div>
	    <div class="zone-tab" data-target="B">B구역</div>
	    <div class="zone-tab" data-target="C">C구역</div>
	  </div>
	
<!-- A구역 -->
<div id="zoneA" class="zone-list active">
  <ul>
    <li><a href="#" onclick="return setTradePlace('대학본부',34.9085069834,126.4343014031)">대학본부[A01]</a></li>
    <li><a href="#" onclick="return setTradePlace('종합운동장',34.9068153672,126.4319616942)">종합운동장[A02]</a></li>
    <li><a href="#" onclick="return setTradePlace('학군단',34.9057880643,126.4330331442)">학군단[A03]</a></li>
    <li><a href="#" onclick="return setTradePlace('체육관',34.9069577184,126.4338666200)">체육관[A04]</a></li>
    <li><a href="#" onclick="return setTradePlace('박물관',34.9073756474,126.4347571134)">박물관[A05]</a></li>
    <li><a href="#" onclick="return setTradePlace('고시생활관',34.9073983769,126.4359354971)">고시생활관[A06]</a></li>
    <li><a href="#" onclick="return setTradePlace('학생군사교육단',34.9061202417,126.4330212335)">학생군사교육단[A07]</a></li>
    <li><a href="#" onclick="return setTradePlace('사회과학대학',34.9082378944,126.4364469051)">사회과학대학[A08]</a></li>
    <li><a href="#" onclick="return setTradePlace('중앙도서관',34.9089021418,126.4355079613)">중앙도서관[A09]</a></li>
    <li><a href="#" onclick="return setTradePlace('정보종합센터',34.9090832404,126.4348302564)">정보종합센터[A10]</a></li>
    <li><a href="#" onclick="return setTradePlace('음악관',34.9083209877,126.4349875635)">음악관[A11]</a></li>
    <li><a href="#" onclick="return setTradePlace('생활편의관',34.9102658703,126.4342580516)">생활편의관[A13]</a></li>
    <li><a href="#" onclick="return setTradePlace('학생회관',34.9097776630,126.4358209673)">학생회관[A14]</a></li>
    <li><a href="#" onclick="return setTradePlace('창조관',34.9056272145,126.4326029093)">창조관[A38]</a></li>
    <li><a href="#" onclick="return setTradePlace('플라자60',34.9098761781,126.4344044625)">플라자60[A60]</a></li>
    <li><a href="#" onclick="return setTradePlace('기념관',34.9075885768,126.4335966205)">60주년기념관[A70]</a></li>
    <li><a href="#" onclick="return setTradePlace('차고지',34.9084907794,126.4342782994)">차고지</a></li>
    <li><a href="#" onclick="return setTradePlace('수위실',34.9084907794,126.4342782994)">수위실</a></li>
  </ul>
</div>

<!-- B구역 -->
<div id="zoneB" class="zone-list">
  <ul>
    <li><a href="#" onclick="return setTradePlace('인문대학',34.9109037640,126.4353686571)">인문대학[B15]</a></li>
    <li><a href="#" onclick="return setTradePlace('공동실험실습관',34.9116655299,126.4352488516)">공동실험실습관[B16]</a></li>
    <li><a href="#" onclick="return setTradePlace('교수회관',34.9120431109,126.4358407258)">교수회관[B17]</a></li>
    <li><a href="#" onclick="return setTradePlace('공과대학1호관',34.9123525904,126.4373741579)">공과대학 1호관[B18]</a></li>
    <li><a href="#" onclick="return setTradePlace('공과대학2호관',34.9127536294,126.4365569781)">공과대학 2호관[B19]</a></li>
    <li><a href="#" onclick="return setTradePlace('공과대학3호관',34.9133570171,126.4373169373)">공과대학 3호관[B20]</a></li>
    <li><a href="#" onclick="return setTradePlace('공과대학4호관',34.9128518727,126.4379910657)">공과대학 4호관[B21]</a></li>
    <li><a href="#" onclick="return setTradePlace('교수아파트',34.9137599429,126.4360305499)">교수아파트[B22]</a></li>
    <li><a href="#" onclick="return setTradePlace('생활과학관',34.9134859677,126.4385336637)">생활과학관[B23]</a></li>
    <li><a href="#" onclick="return setTradePlace('대외협력관',34.9141687283,126.4383714325)">대외협력관[B24]</a></li>
    <li><a href="#" onclick="return setTradePlace('스포츠센터',34.9148584177,126.4383888244)">스포츠센터[B25]</a></li>
    <li><a href="#" onclick="return setTradePlace('공과대학5호관',34.9144735182,126.4391183853)">공과대학 5호관[B26]</a></li>
    <li><a href="#" onclick="return setTradePlace('법학관',34.9138625320,126.4390568518)">법학관[B27]</a></li>
    <li><a href="#" onclick="return setTradePlace('전자정보통신관',34.9130622190,126.4390656599)">전자정보통신관[B28]</a></li>
    <li><a href="#" onclick="return setTradePlace('국제협력관',34.9124075446,126.4396676885)">국제협력관[B29]</a></li>
    <li><a href="#" onclick="return setTradePlace('창업보육센터',34.9135455565,126.4408750129)">창업보육센터</a></li>
    <li><a href="#" onclick="return setTradePlace('산학융합센터',34.9084907794,126.4342782994)">산학융합센터</a></li>
    <li><a href="#" onclick="return setTradePlace('부속공장',34.9136838633,126.4400872881)">부속공장</a></li>
    <li><a href="#" onclick="return setTradePlace('부속농장',34.9142321982,126.4395520978)">부속농장</a></li>
    <li><a href="#" onclick="return setTradePlace('위험물옥내저장소',34.9084907794,126.4342782994)">위험물옥내저장소</a></li>
  </ul>
</div>

<!-- C구역 -->
<div id="zoneC" class="zone-list">
  <ul>
    <li><a href="#" onclick="return setTradePlace('자연과학대학1호관',34.9101801166,126.4371442794)">자연과학대학 1호관[C30]</a></li>
    <li><a href="#" onclick="return setTradePlace('자연과학대학2호관',34.9099887558,126.4383405447)">자연과학대학 2호관[C31]</a></li>
    <li><a href="#" onclick="return setTradePlace('학생생활관관리동',34.9099553391,126.4393967935)">학생생활관 관리동[C32]</a></li>
    <li><a href="#" onclick="return setTradePlace('가람관',34.9094446748,126.4398223706)">가람관[C33]</a></li>
    <li><a href="#" onclick="return setTradePlace('다래관',34.9096202733,126.4404866644)">다래관[C34]</a></li>
    <li><a href="#" onclick="return setTradePlace('햇귀관',34.9103023441,126.4401558585)">햇귀관[C35]</a></li>
    <li><a href="#" onclick="return setTradePlace('한울관',34.9103171890,126.4408992921)">한울관[C36]</a></li>
    <li><a href="#" onclick="return setTradePlace('마루·다솜관',34.9091802501,126.4405777545)">마루·다솜관[C37]</a></li>
    <li><a href="#" onclick="return setTradePlace('약학관',34.9094600461,126.4375553767)">약학관[C38]</a></li>
    <li><a href="#" onclick="return setTradePlace('국제관',34.9104301731,126.4403371810)">국제관[C39]</a></li>
    <li><a href="#" onclick="return setTradePlace('국제교육교류원',34.9108981379,126.4408111572)">국제교육교류원[C40]</a></li>
    <li><a href="#" onclick="return setTradePlace('장비지원센터',34.9084907794,126.4342782994)">장비지원센터</a></li>
  </ul>
</div>

	</div>
</div>

    <label>본문</label>
    <textarea name="description" placeholder="상품 상태, 사용기간 등을 적어주세요." required></textarea>

    <button type="submit">등록하기</button>
  </form>
</div>

<div class="footer">
  <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<!-- ✅ Kakao Map Script -->
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=85969b990129ae28ec3aa8ad0beeca55&libraries=services"></script>
<script>
//✅ 무료나눔 선택 시 가격 자동 0원 설정 및 비활성화
const categorySelect = document.querySelector("select[name='category']");
const priceField = document.getElementById("priceInput");

categorySelect.addEventListener("change", () => {
  if (categorySelect.value === "무료나눔") {
    priceField.value = "0";
    priceField.setAttribute("readonly", true);
    priceField.style.backgroundColor = "#f3f3f3";
  } else {
    priceField.removeAttribute("readonly");
    priceField.style.backgroundColor = "white";
    priceField.value = "";
  }
});

let map, marker, geocoder;

kakao.maps.load(() => {
  const mapContainer = document.getElementById("map");
  const mapOption = { center: new kakao.maps.LatLng(34.90857525955331, 126.43440540737004), level: 4 };  map = new kakao.maps.Map(mapContainer, mapOption);
  marker = new kakao.maps.Marker({ map: map });
  geocoder = new kakao.maps.services.Geocoder();

  // 지도 클릭 시 거래장소 자동 입력
  kakao.maps.event.addListener(map, "click", function(mouseEvent) {
    const latlng = mouseEvent.latLng;
    const lat = latlng.getLat();
    const lng = latlng.getLng();
    marker.setPosition(latlng);
    document.getElementById("latitude").value = lat;
    document.getElementById("longitude").value = lng;
    geocoder.coord2Address(lng, lat, (result, status) => {
      if (status === kakao.maps.services.Status.OK) {
        document.getElementById("placeName").value = result[0].address.address_name;
      }
    });
  });
});

// ✅ 건물 클릭 시 거래장소 자동입력 + 스크롤 방지
function setTradePlace(name, lat, lng) {
  const latlng = new kakao.maps.LatLng(lat, lng);
  map.panTo(latlng);
  marker.setPosition(latlng);
  document.getElementById("placeName").value = name;
  document.getElementById("latitude").value = lat;
  document.getElementById("longitude").value = lng;
  return false; // 🚫 클릭 시 페이지 상단 이동 방지
}

// ✅ 구역 탭 전환
document.querySelectorAll('.zone-tab').forEach(tab => {
  tab.addEventListener('click', () => {
    document.querySelectorAll('.zone-tab').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.zone-list').forEach(l => l.classList.remove('active'));
    tab.classList.add('active');
    document.getElementById('zone' + tab.dataset.target).classList.add('active');
  });
});
// ✅ 가격 콤마 표시
const priceInput = document.getElementById("priceInput");
priceInput.addEventListener("input", (e) => {
  let value = e.target.value.replace(/[^0-9]/g, "");
  e.target.value = value ? Number(value).toLocaleString() : "";
});
const form = document.querySelector("form");
form.addEventListener("submit", () => {
  const raw = priceInput.value.replace(/[^0-9]/g, "");
  priceInput.value = raw || 0;
});

//============================
//여러 장 이미지 업로드 완전 구현
//============================

let clickedSlot = null;
let fileCount = 0;

document.querySelectorAll(".main-slot, .sub-slot").forEach(slot => {
slot.addEventListener("click", e => {
    clickedSlot = e.currentTarget;

    fileCount++;

    // ★ slot마다 별도 file input 만들어서 저장
    const input = document.createElement("input");
    input.type = "file";
    input.accept = "image/*";
    input.name = "files"; // 서버로 multiple 전달됨
    input.style.display = "none";
    input.dataset.slot = fileCount; // 어떤 slot인지 tracking

    document.getElementById("fileInputsContainer").appendChild(input);

    input.click();

    input.addEventListener("change", function () {
        const file = this.files[0];
        if (!file) return;

        const reader = new FileReader();

        reader.onload = ev => {
            clickedSlot.innerHTML = "";
            const img = document.createElement("img");
            img.src = ev.target.result;

            clickedSlot.appendChild(img);

            // 삭제 버튼 추가
            const btn = document.createElement("button");
            btn.className = "delete-btn";
            btn.innerText = "×";

            btn.addEventListener("click", e2 => {
                e2.stopPropagation();
                clickedSlot.innerHTML = clickedSlot.classList.contains("main-slot") ? "대표 +" : "+";
                clickedSlot.classList.remove("loaded");

                // file input도 제거
                input.remove();
            });

            clickedSlot.appendChild(btn);
            clickedSlot.classList.add("loaded");
        };

        reader.readAsDataURL(file);
    });
});
});

</script>

</body>
</html>
