<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 | 목유마켓</title>
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

/* ✅ 상단 헤더 */
.header {
    background-color: #007A5C;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 22px 40px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

/* 로고 */
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

/* 네비게이션 & 사용자 메뉴 */
.nav-links, .user-menu {
    display: flex;
    align-items: center;
    font-weight: 600;
    font-size: 15px;
    color: white;
}
.nav-links { gap: 25px; margin-left: 60px; }
.user-menu { gap: 25px; }

/* 링크 스타일 */
.nav-links a, .user-menu a {
    color: inherit;
    text-decoration: none;
}
.nav-links a:hover, .user-menu a:hover {
    text-decoration: underline;
}

/* 프로필 링크 */
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

/* ✅ 마이페이지 탭 */
.mypage-nav {
    display: flex;
    justify-content: center;
    background-color: #f7f7f7;
    border-bottom: 1.5px solid #007A5C;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.mypage-nav a {
    flex: 1;
    text-align: center;
    padding: 16px 0;
    font-weight: 600;
    color: #444;
    text-decoration: none;
    border-bottom: 3px solid transparent;
    transition: 0.2s;
}
.mypage-nav a:hover {
    color: #007A5C;
    background-color: #f0fdf9;
}
.mypage-nav a.active {
    color: #007A5C;
    border-bottom: 3px solid #007A5C;
    background-color: #fff;
}

/* ✅ 프로필 카드 */
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
    border: 4px solid #00A67E;
    overflow: hidden;
}
.profile-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
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
}
.camera-btn:hover { background: #005f45; }

/* ✅ 프로필 정보 */
.profile-info h2 { margin: 0; font-size: 19px; font-weight: bold; }
.profile-info .stats { font-size: 14px; color: #555; margin-top: 3px; }
.profile-info .verify-badge {
    display: inline-block;
    margin-top: 8px;
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 13px;
    font-weight: 600;
}
.verify-badge.verified { background-color: #e8f9f1; color: #007a5c; }
.verify-badge.unverified { background-color: #fce8e8; color: #cc2b2b; }
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
.verify-btn:hover { background-color: #005f45; }

/* ✅ 정보 폼 */
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
.info-box input {
    width: 100%;
    padding: 11px 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    background-color: #f6f6f6;
    color: #555;
    font-size: 14px;
    margin-bottom: 15px;
}
.info-box input[readonly] { cursor: not-allowed; }

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
/* ✅ 비밀번호 변경 링크 */
.password-change {
    text-align: center;
    margin-top: 40px;
    margin-bottom: 40px;
}
.password-change a {
    color: #ff4d4d;               /* 빨강 강조 */
    text-decoration: none;        /* 밑줄 제거 */
    font-weight: 600;
    font-size: 14px;
    opacity: 0.85;
    transition: 0.2s;
}
.password-change a:hover {
    text-decoration: underline;   /* 마우스 오버 시 밑줄 */
    opacity: 1;
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
        <a href="${pageContext.request.contextPath}/controller/products">중고거래</a>
        <a href="${pageContext.request.contextPath}/controller/free">무료나눔</a>
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

<!-- ✅ 마이페이지 네비게이션 -->
<div class="mypage-nav">
    <a href="${pageContext.request.contextPath}/controller/myProducts">내 등록템</a>
    <a href="${pageContext.request.contextPath}/controller/mypage" class="active">개인정보 수정</a>
    <a href="${pageContext.request.contextPath}/controller/favorites">내 관심템</a>
    <a href="${pageContext.request.contextPath}/controller/reviews">내 후기</a>
</div>

<!-- ✅ 프로필 카드 -->
<div class="profile-card">
    <div class="profile-img">
        <c:choose>
            <c:when test="${not empty user.profileImagePath}">
                <img id="profilePreview" src="${pageContext.request.contextPath}${user.profileImagePath}" alt="프로필 이미지">
            </c:when>
            <c:otherwise>
                <img id="profilePreview" src="${pageContext.request.contextPath}/resources/images/default_profile.png" alt="기본 프로필">
            </c:otherwise>
        </c:choose>
        <div class="camera-btn" onclick="document.getElementById('profileUpload').click()">📷</div>
        <input type="file" id="profileUpload" accept="image/*" style="display:none;" onchange="uploadProfileImage(this)">
    </div>

    <div class="profile-info">
        <h2>${user.name}</h2>
        <div class="stats"><span>매너온도: ${user.mannerTemp}℃ 🔥</span></div>
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

<!-- ✅ 개인정보 박스 -->
<div class="info-box">
    <label>아이디</label>
    <input type="email" value="${user.email}" readonly>

    <label>이름</label>
    <input type="text" value="${user.name}" readonly>

    <label>전화번호</label>
    <input type="text" value="${user.phone}" readonly>

    <button class="btn-save" disabled>저장하기</button>
</div>

<div class="password-change"> <a href="${pageContext.request.contextPath}/member/forgot-password">비밀번호 변경하기</a> </div>

<!-- ✅ 푸터 -->
<div class="footer">
    <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<script>
function verifyWifi() {
  fetch("${pageContext.request.contextPath}/controller/verifyWifi")
    .then(res => res.text())
    .then(msg => {
        alert(msg);
        if (msg.includes("📡 캠퍼스 Wi-Fi 인증 완료")) {
            const badge = document.querySelector(".verify-badge.unverified");
            if (badge) {
                badge.classList.remove("unverified");
                badge.classList.add("verified");
                badge.textContent = "🎓 캠퍼스 인증 완료";
            }
            const btn = document.querySelector(".verify-btn");
            if (btn) btn.style.display = "none";

            const place = document.createElement("span");
            place.textContent = "(목포대학교 Wi-Fi 인증)";
            place.style.fontSize = "13px";
            place.style.color = "#777";
            place.style.marginLeft = "8px";
            badge.parentNode.appendChild(place);
        }
    })
    .catch(() => alert("Wi-Fi 인증 중 오류가 발생했습니다."));
}

function uploadProfileImage(input) {
    const file = input.files[0];
    if (!file) return;
    const formData = new FormData();
    formData.append("file", file);

    fetch("${pageContext.request.contextPath}/controller/updateProfileImage", {
        method: "POST",
        body: formData,
        credentials: "include"   // ✅ 세션 유지
    })
    .then(res => res.json())
    .then(data => {
        alert(data.message);
        if (data.success) {
            // ✅ 업로드 성공 시: 미리보기 즉시 갱신
            document.getElementById("profilePreview").src =
                "${pageContext.request.contextPath}" + data.imagePath;

            // ✅ 헤더 프로필 사진도 즉시 갱신
            const headerProfile = document.querySelector(".profile-link img");
            if (headerProfile) {
                headerProfile.src = "${pageContext.request.contextPath}" + data.imagePath;
            }
        }
    })
    .catch(() => alert("업로드 중 오류가 발생했습니다."));
}

</script>
</body>
</html>
