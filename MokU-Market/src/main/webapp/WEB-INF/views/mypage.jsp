<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 | 목유마켓</title>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Nanum Gothic', sans-serif;
    background-color: #fafafa;
    margin: 0;
}

/* ✅ 상단 헤더 */
.header {
    background-color: #007A5C;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 40px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
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
}
.header .search-box {
    flex: 1;
    display: flex;
    justify-content: center;
    margin: 0 40px;
}
.header input[type="text"] {
    width: 60%;
    padding: 10px 15px;
    border: none;
    border-radius: 20px;
    outline: none;
}
.header .user-menu {
    display: flex;
    gap: 20px;
}
.header .user-menu a {
    color: white;
    text-decoration: none;
    font-weight: 600;
}
.header .user-menu a:hover {
    text-decoration: underline;
}

/* ✅ 상단 탭 */
.mypage-nav {
    display: flex;
    justify-content: center;
    background-color: #f1f1f1;
    border-bottom: 2px solid #007A5C;
}
.mypage-nav a {
    padding: 15px 40px;
    text-decoration: none;
    color: #333;
    font-weight: bold;
    border-bottom: 3px solid transparent;
}
.mypage-nav a.active {
    color: #007A5C;
    border-bottom: 3px solid #007A5C;
}

/* ✅ 카드형 프로필 */
.profile-card {
    width: 680px;
    background: #fff;
    margin: 50px auto 20px;
    border-radius: 15px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    padding: 35px 45px;
    display: flex;
    align-items: center;
    gap: 25px;
}

.profile-img {
    position: relative;
    width: 120px;
    height: 120px;
    border-radius: 50%;
    border: 4px solid #00A67E;  /* ✅ 항상 원형 테두리 유지 */
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    background-color: #fff;
    box-sizing: border-box;
}

/* ✅ 프로필 이미지 */
.profile-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 50%;
    display: block;
}

/* ✅ 이미지가 없을 때 표시되는 기본 텍스트 */
.profile-img span {
    font-size: 14px;
    color: #555;
    font-weight: 600;
    text-align: center;
}

/* ✅ 카메라 버튼 */
.camera-btn {
    position: absolute;
    bottom: 5px;
    right: 5px;
    background: #007A5C;
    border-radius: 50%;
    width: 32px;
    height: 32px;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-size: 14px;
    cursor: pointer;
    border: 2px solid #fff;
    transition: 0.2s;
}
.camera-btn:hover {
    background: #005f45;
}



.profile-info h2 {
    margin: 0;
    font-size: 19px;
    font-weight: bold;
}
.profile-info .stats {
    font-size: 14px;
    color: #555;
    margin-top: 3px;
}
.profile-info .stats span {
    margin-right: 15px;
}
.profile-info .verify-badge {
    display: inline-block;
    margin-top: 8px;
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 13px;
    font-weight: 600;
}
.verify-badge.verified {
    background-color: #e8f9f1;
    color: #007a5c;
}
.verify-badge.unverified {
    background-color: #fce8e8;
    color: #cc2b2b;
}
.verify-btn {
    background-color: #007A5C;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 12px;
    cursor: pointer;
    margin-left: 5px;
}
.verify-btn:hover {
    background-color: #005f45;
}

/* ✅ 정보 폼 박스 */
.info-box {
    width: 680px;
    background: #fff;
    margin: 0 auto;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    padding: 35px 40px;
}
.info-box label {
    display: block;
    font-weight: bold;
    color: #333;
    margin-bottom: 6px;
}
.info-box input[type="text"],
.info-box input[type="email"] {
    width: 100%;
    padding: 11px 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    background-color: #f6f6f6;
    color: #555;
    font-size: 14px;
    margin-bottom: 15px;
}
.info-box input[readonly] {
    cursor: not-allowed;
}
.btn-save {
    width: 100%;
    background-color: #ccc;
    color: #fff;
    border: none;
    padding: 12px;
    border-radius: 8px;
    font-weight: bold;
    cursor: not-allowed;
}

.password-change {
    text-align: center;
    margin-top: 40px;   /* ✅ 간격 넓힘 */
        margin-bottom: 40px; /* ✅ 하단 푸터와의 간격 추가 */
    
}

.password-change a {
    color: #ff4d4d;     /* ✅ 연한 빨강 */
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;    /* ✅ 글씨 약간 작게 */
    opacity: 0.85;      /* ✅ 색 살짝 투명하게 */
    transition: 0.2s;
}

.password-change a:hover {
    text-decoration: underline;
    opacity: 1;
}

/* ✅ 푸터 */
.footer {
    background-color: #f1f1f1;
    text-align: center;
    padding: 10px;
    font-size: 13px;
    color: #666;
    border-top: 1px solid #ddd;
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

    <div class="search-box">
        <input type="text" placeholder="원하는 상품을 검색해보세요!">
    </div>
    <div class="user-menu">
        <a href="#">내 상점</a>
        <a href="${pageContext.request.contextPath}/controller/mypage">마이페이지</a>
        <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </div>
</div>

<!-- ✅ 마이페이지 네비게이션 -->
<div class="mypage-nav">
    <a href="${pageContext.request.contextPath}/controller/mypage" class="active">개인정보 수정</a>
    <a href="${pageContext.request.contextPath}/controller/myProducts">내 등록템</a>
    <a href="${pageContext.request.contextPath}/controller/favorites">내 관심템</a>
    <a href="${pageContext.request.contextPath}/controller/reviews">내 후기</a>
</div>

<!-- ✅ 카드형 프로필 -->
<div class="profile-card">
    <div class="profile-img">
        <img id="profilePreview" src="${pageContext.request.contextPath}/resources/images/sample_profile.jpg" alt="프로필 이미지">
        <div class="camera-btn" onclick="document.getElementById('profileUpload').click()">📷</div>
        <input type="file" id="profileUpload" accept="image/*" style="display:none;">
    </div>

    <div class="profile-info">
        <h2>${user.name}</h2>
        <div class="stats">
            <span>매너온도: ${user.mannerTemp}℃ 🔥</span>
        </div>

        <div class="stats">
            <c:choose>
                <c:when test="${user.isLocationVerified eq 'Y'}">
                    <span class="verify-badge verified">🎓 캠퍼스 인증 완료</span>
                    <span style="font-size:13px; color:#777;">(${user.verifiedPlace})</span>
                </c:when>
                <c:otherwise>
                    <span class="verify-badge unverified">❌ 캠퍼스 인증 미완료</span>
                    <button type="button" class="verify-btn" onclick="verifyWifi()">📶 Wi-Fi 인증하기</button>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="stats">
            <span>내 등록템 ${user.productCount}개</span>
            <span>내 관심템 ${user.favoriteCount}개</span>
            <span>채팅 ${user.chatCount}건</span>
        </div>
    </div>
</div>

<!-- ✅ 정보 폼 -->
<div class="info-box">
    <label>아이디</label>
    <input type="email" value="${user.email}" readonly>

    <label>이름</label>
    <input type="text" value="${user.name}" readonly>

    <label>전화번호</label>
    <input type="text" value="${user.phone}" readonly>

    <button class="btn-save" disabled>저장하기</button>
</div>

<div class="password-change">
    <a href="${pageContext.request.contextPath}/member/forgot-password">비밀번호 변경하기</a>
</div>


<!-- ✅ 푸터 -->
<div class="footer">
    <p>© 2025 Mokpo National University | MokU Market</p>
</div>
<script>
function verifyWifi() {
  fetch("${pageContext.request.contextPath}/controller/verifyWifi")
    .then(res => res.text())
    .then(msg => alert(msg))
    .catch(() => alert("Wi-Fi 인증 중 오류가 발생했습니다."));
}

// ✅ 프로필 사진 미리보기 기능
document.getElementById("profileUpload").addEventListener("change", function(e) {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = function(event) {
        document.getElementById("profilePreview").src = event.target.result;
    };
    reader.readAsDataURL(file);
});
</script>

</body>
</html>
