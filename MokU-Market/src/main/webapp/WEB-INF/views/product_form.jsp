<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 등록 - 목유마켓</title>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Nanum Gothic', sans-serif;
    background-color: #f7f8f9;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding-top: 40px;
    margin: 0;
}
.container {
    background: #fff;
    width: 520px;
    border-radius: 20px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    padding: 30px 40px;
}
h2 {
    text-align: center;
    font-family: 'Jua', sans-serif;
    color: #007A5C;
    margin-bottom: 25px;
}
input, select, textarea {
    width: 100%;
    margin-bottom: 15px;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 10px;
    font-size: 14px;
}
input:focus, textarea:focus, select:focus {
    outline: none;
    border-color: #00A67E;
}
button {
    width: 100%;
    background-color: #00A67E;
    color: #fff;
    border: none;
    padding: 13px 0;
    font-weight: bold;
    border-radius: 10px;
    cursor: pointer;
    transition: 0.2s;
}
button:hover {
    background-color: #008a6b;
    transform: translateY(-2px);
}
#map {
    width: 100%;
    height: 300px;
    margin-bottom: 15px;
    border-radius: 10px;
}
label {
    font-weight: 600;
    color: #333;
    display: block;
    margin-bottom: 5px;
}
</style>
</head>

<body>
<div class="container">
    <h2>📦 상품 등록</h2>

    <form action="${pageContext.request.contextPath}/product/add" method="post" enctype="multipart/form-data">
        <label>상품 제목</label>
        <input type="text" name="title" placeholder="예: 간호학개론 교재" required>

        <label>카테고리</label>
        <select name="category" required>
            <option value="">카테고리를 선택하세요</option>
            <option value="전공서적">전공서적</option>
            <option value="전자기기">전자기기</option>
            <option value="생활용품">생활용품</option>
            <option value="의류">의류</option>
            <option value="음식">음식</option>
            <option value="무료나눔">무료나눔</option>
        </select>

        <label>가격</label>
        <input type="number" name="price" placeholder="가격을 입력하세요 (무료나눔은 0)" required>

        <label>상품 설명</label>
        <textarea name="description" rows="4" placeholder="상품의 상태, 사용 기간 등을 입력해주세요." required></textarea>

        <label>📍 거래 위치 선택</label>
        <div id="map"></div>
        <input type="hidden" id="latitude" name="latitude">
        <input type="hidden" id="longitude" name="longitude">

        <label>상품 이미지</label>
        <input type="file" name="file" accept="image/*" required>

        <button type="submit">등록하기</button>
    </form>
</div>

<!-- ✅ SDK -->
<script 
  src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=85969b990129ae28ec3aa8ad0beeca55&autoload=false"
  onload="console.log('✅ SDK 파일 로드 성공')"
  onerror="console.error('❌ SDK 파일 로드 실패 (도메인 등록 안 됨)')">
</script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    console.log("✅ 현재 도메인:", window.location.origin);
    if (typeof kakao === "undefined") {
        console.error("❌ Kakao SDK가 로드되지 않음 (403 또는 등록되지 않은 도메인)");
        return;
    }

    kakao.maps.load(function() {
        console.log("✅ Kakao Maps 로드 성공");
        var mapContainer = document.getElementById("map");
        var mapOption = {
            center: new kakao.maps.LatLng(34.90858195604962, 126.43439168397106),
            level: 4
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);
        new kakao.maps.Marker({ position: map.getCenter() }).setMap(map);
    });
});
</script>


</body>
</html>
