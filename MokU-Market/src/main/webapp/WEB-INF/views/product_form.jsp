<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>
  <c:choose>
    <c:when test="${mode eq 'edit'}">상품 수정 | 목유마켓</c:when>
    <c:otherwise>상품 등록 | 목유마켓</c:otherwise>
  </c:choose>
</title>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,300..700,0..1,-50..200" />

<style>
body {
  font-family: 'Nanum Gothic', sans-serif;
  margin: 0;
  background-color: #f8f9fa;
}

/* 상품 등록 폼 */
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

/* 이미지 업로드 */
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

/* ✅ 입력 스타일을 .container 내부로만 한정 */
.container label {
  font-weight: 600;
  display: block;
  margin-top: 12px;
  color: #333;
}
.container input,
.container textarea,
.container select {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 10px;
  font-size: 14px;
  margin-bottom: 10px;
}
.container textarea {
  resize: vertical;
  height: 120px;
}

/* 버튼 */
/* 상품등록 폼 내부 submit 버튼만 스타일 적용 */
.container button[type="submit"] {
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
.container button[type="submit"]:hover {
  background-color: #008a6b;
  transform: translateY(-2px);
}


/* 지도 + 거래장소 */
.map-wrapper {
  display: flex;
  align-items: stretch;
  gap: 25px;
}

#map {
  flex: 1;
  min-height: 400px;
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

/* 가격 입력 */
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

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 상품 등록/수정 -->
<div class="container">
  <h2>
    <c:choose>
      <c:when test="${mode eq 'edit'}">✏️ 상품 수정</c:when>
      <c:otherwise>📦 상품 등록</c:otherwise>
    </c:choose>
  </h2>

  <form action="${pageContext.request.contextPath}/product/${mode eq 'edit' ? 'edit' : 'add'}"
        method="post"
        enctype="multipart/form-data">

    <c:if test="${mode eq 'edit'}">
        <input type="hidden" name="productId" value="${product.productId}" />

        <div class="current-images-wrap" style="margin-bottom:10px;">
            <p style="margin-bottom:5px;">현재 등록된 이미지</p>
            <div class="thumb-list">
              <c:forEach var="img" items="${images}" varStatus="st">
                <c:if test="${st.index <= 4}">
                  <img src="${pageContext.request.contextPath}${img}"
                       class="thumb-img"
                       style="width:80px;height:80px;object-fit:cover;margin-right:8px;border-radius:6px;border:1px solid #ddd;">
                </c:if>
              </c:forEach>
            </div>
        </div>
    </c:if>

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

    <label>제목</label>
    <input type="text"
           name="title"
           maxlength="20"
           placeholder="최대 20자까지 입력 가능합니다"
           value="${product.title}"
           required>

    <label>가격</label>
    <div class="price-wrap">
      <input type="text"
             name="price"
             id="priceInput"
             placeholder="희망 가격을 입력해주세요 !"
             value="${product.price}"
             required>
      <span class="won-label">원</span>
    </div>

    <label>카테고리</label>
    <select name="category" required>
      <option value="" disabled
        <c:if test="${empty product.category}">selected</c:if>>
        카테고리를 선택하세요
      </option>
      <option value="전공서적"
        <c:if test="${product.category == '전공서적'}">selected</c:if>>
        전공서적
      </option>
      <option value="전자기기"
        <c:if test="${product.category == '전자기기'}">selected</c:if>>
        전자기기
      </option>
      <option value="생활용품"
        <c:if test="${product.category == '생활용품'}">selected</c:if>>
        생활용품
      </option>
      <option value="의류"
        <c:if test="${product.category == '의류'}">selected</c:if>>
        의류
      </option>
      <option value="음식"
        <c:if test="${product.category == '음식'}">selected</c:if>>
        음식
      </option>
      <option value="무료나눔"
        <c:if test="${product.category == '무료나눔'}">selected</c:if>>
        무료나눔
      </option>
    </select>

    <label>거래장소</label>
    <input type="text"
           id="placeName"
           name="placeName"
           placeholder="지도를 클릭하거나 오른쪽 목록에서 선택하세요."
           value="${product.placeName}"
           required>
    <input type="hidden" id="latitude" name="latitude" value="${product.latitude}">
    <input type="hidden" id="longitude" name="longitude" value="${product.longitude}">

    <div class="map-wrapper">
      <div id="map"></div>
      <div class="zone-box">
        <div class="zone-tabs">
          <div class="zone-tab active" data-target="A">A구역</div>
          <div class="zone-tab" data-target="B">B구역</div>
          <div class="zone-tab" data-target="C">C구역</div>
        </div>

        <!-- A/B/C 구역 리스트는 생략 없이 그대로 사용 -->
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
    <textarea name="description"
              placeholder="상품 상태, 사용기간 등을 적어주세요."
              required>${product.description}</textarea>

    <button type="submit">
      <c:choose>
        <c:when test="${mode eq 'edit'}">수정 완료</c:when>
        <c:otherwise>등록하기</c:otherwise>
      </c:choose>
    </button>
  </form>
</div>

<!-- Kakao Map Script -->
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=85969b990129ae28ec3aa8ad0beeca55&libraries=services"></script>
<script>
const categorySelect = document.querySelector("select[name='category']");
const priceField = document.getElementById("priceInput");

if (categorySelect.value === "무료나눔") {
  priceField.value = "0";
  priceField.setAttribute("readonly", true);
  priceField.style.backgroundColor = "#f3f3f3";
}

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

  const defaultLat = ${empty product.latitude ? 34.90857525955331 : product.latitude};
  const defaultLng = ${empty product.longitude ? 126.43440540737004 : product.longitude};

  const mapOption = {
    center: new kakao.maps.LatLng(defaultLat, defaultLng),
    level: 4
  };
  map = new kakao.maps.Map(mapContainer, mapOption);
  marker = new kakao.maps.Marker({
    map: map,
    position: new kakao.maps.LatLng(defaultLat, defaultLng)
  });
  geocoder = new kakao.maps.services.Geocoder();

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

function setTradePlace(name, lat, lng) {
  const latlng = new kakao.maps.LatLng(lat, lng);
  map.panTo(latlng);
  marker.setPosition(latlng);
  document.getElementById("placeName").value = name;
  document.getElementById("latitude").value = lat;
  document.getElementById("longitude").value = lng;
  return false;
}

document.querySelectorAll('.zone-tab').forEach(tab => {
  tab.addEventListener('click', () => {
    document.querySelectorAll('.zone-tab').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.zone-list').forEach(l => l.classList.remove('active'));
    tab.classList.add('active');
    document.getElementById('zone' + tab.dataset.target).classList.add('active');
  });
});

// 가격 콤마 표시
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

// 여러 장 이미지 업로드
let clickedSlot = null;
let fileCount = 0;

document.querySelectorAll(".main-slot, .sub-slot").forEach(slot => {
  slot.addEventListener("click", e => {
    clickedSlot = e.currentTarget;

    fileCount++;

    const input = document.createElement("input");
    input.type = "file";
    input.accept = "image/*";
    input.name = "files";
    input.style.display = "none";
    input.dataset.slot = fileCount;

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

        const btn = document.createElement("button");
        btn.className = "delete-btn";
        btn.innerText = "×";

        btn.addEventListener("click", e2 => {
          e2.stopPropagation();
          clickedSlot.innerHTML = clickedSlot.classList.contains("main-slot") ? "대표 +" : "+";
          clickedSlot.classList.remove("loaded");
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

<!-- Top + 등록 플로팅 버튼 -->
<div class="floating-container">
    <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
    <a href="${pageContext.request.contextPath}/product/add" class="floating-add">+</a>
</div>

<style>
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
    .floating-container {
        bottom: 25px;
        right: 25px;
    }
    .floating-add {
        width: 55px;
        height: 55px;
        font-size: 34px;
    }
}
</style>

<script>
document.getElementById("topBtn").addEventListener("click", () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
});
</script>
    <jsp:include page="/WEB-INF/views/common/recentProducts.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
