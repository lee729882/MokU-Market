<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 | 목유마켓</title>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">

<!-- 🔥 이미지 캐시 차단 -->
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>

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

/* ================= HEADER ================= */
.header {
    background-color: #007A5C;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 22px 40px;
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
    color: white;
}
.nav-links, .user-menu {
    display: flex;
    align-items: center;
    font-weight: 600;
    font-size: 15px;
    color: white;
}
.nav-links { gap: 25px; margin-left: 60px; }
.user-menu { gap: 25px; }
.nav-links a, .user-menu a {
    color: inherit;
    text-decoration: none;
}
.nav-links a:hover, .user-menu a:hover {
    text-decoration: underline;
}
.profile-link {
    display: flex;
    align-items: center;
    gap: 8px;
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

/* ================= 검색창 ================= */
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

/* ============== 마이페이지 NAV ============== */
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

/* ================= 프로필 카드 ================= */
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

/* ================= 프로필 정보 ================= */
.profile-info h2 { margin: 0; font-size: 19px; font-weight: bold; }
.profile-info .stats { font-size: 14px; color: #555; margin-top: 3px; }

/* ================= 정보 폼 ================= */
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

.footer {
    background-color: #f1f1f1;
    text-align: center;
    padding: 10px;
    font-size: 13px;
    color: #666;
    border-top: 1px solid #ddd;
    margin-top: auto;
}

.password-change {
    text-align: center;
    margin-top: 40px;
    margin-bottom: 40px;
}
.password-change a {
    color: #ff4d4d;
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;
    opacity: 0.85;
    transition: 0.2s;
}
.password-change a:hover {
    text-decoration: underline;
    opacity: 1;
}

/* ================= 플로팅 버튼 ================= */
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
    box-shadow: 0 4px 10px rgba(0,0,0,0.25);
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
        line-height: 55px;
    }
}
</style>
</head>

<body>

<!-- ================= HEADER ================= -->
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

        <!-- 🔥 헤더 프로필 이미지 = ID 부여 -->
        <a href="${pageContext.request.contextPath}/controller/mypage" class="profile-link">
            <c:choose>
                <c:when test="${not empty user.profileImagePath}">
                    <img id="headerProfileImg" src="${pageContext.request.contextPath}${user.profileImagePath}">
                </c:when>
                <c:otherwise>
                    <img id="headerProfileImg" src="${pageContext.request.contextPath}/resources/images/default_profile.png">
                </c:otherwise>
            </c:choose>
            <span>${user.name}</span>
        </a>

        <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
    </div>
</div>

<!-- ================= 마이페이지 NAV ================= -->
<div class="mypage-nav">
    <a href="${pageContext.request.contextPath}/controller/myProducts">내 등록템</a>
    <a href="${pageContext.request.contextPath}/controller/mypage" class="active">개인정보 수정</a>
    <a href="${pageContext.request.contextPath}/controller/favorites">내 관심템</a>
    <a href="${pageContext.request.contextPath}/controller/reviews">내 후기</a>
</div>

<!-- ================= 프로필 카드 ================= -->
<div class="profile-card">
    <div class="profile-img">
        <c:choose>
            <c:when test="${not empty user.profileImagePath}">
                <img id="profilePreview" src="${pageContext.request.contextPath}${user.profileImagePath}">
            </c:when>
            <c:otherwise>
                <img id="profilePreview" src="${pageContext.request.contextPath}/resources/images/default_profile.png">
            </c:otherwise>
        </c:choose>
        <div class="camera-btn" onclick="document.getElementById('profileUpload').click()">📷</div>
        <input type="file" id="profileUpload" accept="image/*" style="display:none;" onchange="uploadProfileImage(this)">
    </div>

    <div class="profile-info">
        <h2>${user.name}</h2>

        <div class="stats"><span>매너온도: ${user.mannerTemp}℃ 🔥</span></div>

        <div class="stats">
            <span>내 등록템 ${user.productCount}개</span>
            <span>내 관심템 ${user.favoriteCount}개</span>
            <span>채팅 ${user.chatCount}건</span>
        </div>
    </div>
</div>

<!-- ================= 개인정보 BOX ================= -->
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

<!-- ================= FOOTER ================= -->
<div class="footer">
    <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<!-- ================= JS ================= -->
<script>
function uploadProfileImage(input) {
    const file = input.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("file", file);

    fetch(`${pageContext.request.contextPath}/controller/updateProfileImage`, {
        method: "POST",
        body: formData,
        credentials: "include"
    })
    .then(res => res.json())
    .then(data => {
        if (data.success && data.imagePath) {

            // 🔥 알림 후 새로고침
            alert("프로필 이미지가 정상적으로 변경되었습니다.");
            location.reload();   // ← 새로고침 추가됨

        } else {
            alert(data.message ?? "업로드 중 문제가 발생했습니다.");
        }
    })
    .catch(err => {
        console.error("업로드 오류:", err);
        alert("업로드 중 오류가 발생했습니다.");
    });
}






document.getElementById("topBtn")?.addEventListener("click", () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
});
</script>

<!-- ================= 플로팅 버튼 ================= -->
<div class="floating-container">
    <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
    <a href="${pageContext.request.contextPath}/product/add" class="floating-add">+</a>
</div>

</body>
</html>
