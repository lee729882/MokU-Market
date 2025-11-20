<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
  ※ head 쪽에 아래 폰트 링크 한 번만 추가해 두시면 아이콘이 정상 노출됩니다.
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,300..700,0..1,-50..200" />
--%>

<style>
/* =========================
   공통 헤더 / GNB 스타일
   ========================= */

/* 상단 초록 헤더 전체 */
.header {
    background-color: #007A5C;
    color: white;
    position: sticky;
    top: 0;
    z-index: 1000;
    box-shadow: 0 1px 4px rgba(0,0,0,0.12);
}

/* 가운데 정렬 컨테이너 */
.header-inner {
    max-width: 1200px;
    margin: 0 auto;
    padding: 10px 24px;
    display: flex;
    flex-direction: row;
    align-items: center;
    flex-wrap: nowrap;
    column-gap: 32px;
}

/* 로고 영역 */
.header .logo {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-shrink: 0;
}
.header .logo img {
    width: 52px;
    height: 56px;
    border-radius: 50%;
    background: #ffffff;
    padding: 4px;
}
.header .logo h1 {
    font-family: 'Jua', sans-serif;
    font-size: 30px;
    margin: 0;
    color: #ffffff;
    white-space: nowrap;
}

/* 가운데 검색 영역 */
.search-box {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
}
.search-box-inner {
    position: relative;
    display: flex;
    align-items: center;
    background: #ffffff;
    border-radius: 999px;
    padding: 9px 42px 9px 18px;
    width: 100%;
    max-width: 720px;
}
.search-box-inner input {
    width: 100%;
    padding: 9px 15px;
    border: none;
    border-radius: 24px;
    outline: none;
    font-size: 14px;
}
.search-box-inner input::placeholder {
    color: #9ca3af;
}
/* 검색 아이콘 버튼 */
.search-box-inner button {
    position: absolute;
    right: 14px;
    top: 50%;
    transform: translateY(-50%);
    width: 26px;
    height: 26px;
    border-radius: 50%;
    border: none;
    background: #f3f4f6;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0;
    cursor: pointer;
    color: #007A5C;
}
.search-box-inner button:hover {
    background: #e5e7eb;
}

/* 우측 유저 메뉴 */
.user-menu {
    display: flex;
    gap: 20px;
    align-items: center;
    flex-shrink: 0;
    white-space: nowrap;
}
.user-menu a {
    color: #ffffff;
    text-decoration: none;
    font-weight: 600;
}
.user-menu a:hover {
    text-decoration: underline;
}

/* 프로필 링크 */
.profile-link {
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    color: #ffffff;
}
.profile-link img {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #ffffff;
    transition: 0.2s ease;
}
.profile-link:hover img {
    transform: scale(1.07);
}

/* 메시지 / 알림 아이콘 묶음 */
.user-icons {
    display: flex;
    gap: 10px;
    align-items: center;
}

/* 아이콘 버튼 자체 */
.icon-circle {
    position: relative;              /* 🔥 배지 위치 기준이 되도록 */
    border: none;
    background: transparent;
    padding: 0 4px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    outline: none;
}

/* 머티리얼 아이콘 크기/색 */
.icon-circle .material-symbols-rounded {
    font-size: 30px;                 /* ← 여기서 크기 조절 */
    line-height: 1;
    color: #ffffff;
}

/* hover 시 살짝 강조만 */
.icon-circle:hover {
    background: rgba(255,255,255,0.12);
    border-radius: 999px;
}

/* 빨간 동그라미 배지 */
.icon-badge {
    position: absolute;
    top: -3px;                       /* 아이콘 기준 위치 조정 */
    right: -1px;
    min-width: 14px;
    height: 14px;
    padding: 0 3px;
    border-radius: 999px;
    background: #FF4D4D;
    color: #ffffff;
    font-size: 10px;
    line-height: 14px;
    font-weight: 700;
    text-align: center;
}

/* 하단 GNB 영역 */
.gnb {
    background-color: #ffffff;
    border-bottom: 1px solid #e5e7eb;
    box-shadow: 0 1px 3px rgba(0,0,0,0.04);
}
.gnb-inner {
    max-width: 1200px;
    margin: 0 auto;
    padding: 10px 32px 8px;
    display: flex;
    gap: 40px;
    align-items: center;
    font-size: 16px;
    font-weight: 700;
}
.gnb-inner a {
    position: relative;
    color: #374151;
    text-decoration: none;
    padding-bottom: 6px;
}
/* 밑줄 대신 바 효과 */
.gnb-inner a::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: 0;
    width: 0;
    height: 2px;
    background: #007A5C;
    transition: width .2s ease;
}
.gnb-inner a:hover {
    color: #007A5C;
}
.gnb-inner a:hover::after {
    width: 100%;
}
/* 현재 메뉴 표시용 */
.gnb-inner a.active {
    color: #007A5C;
}
.gnb-inner a.active::after {
    width: 100%;
}

/* 반응형(옵션) */
@media (max-width: 1200px) {
    .header-inner {
        padding: 10px 16px;
    }
    .search-box-inner {
        max-width: 560px;
    }
    .gnb-inner {
        padding: 10px 20px 8px;
        gap: 28px;
    }
}
</style>

<!-- =========================
     상단 헤더
     ========================= -->
<div class="header">
    <div class="header-inner">

        <!-- 로고 -->
        <div class="logo">
            <a href="${pageContext.request.contextPath}/home"
               style="display:flex; align-items:center; gap:10px; text-decoration:none; color:#ffffff;">
                <img src="${pageContext.request.contextPath}/resources/images/mokyu_logo.png" alt="로고">
                <h1>목유마켓</h1>
            </a>
        </div>

        <!-- 검색창 -->
        <div class="search-box">
            <div class="search-box-inner">
                <input type="text" placeholder="상품명·글 제목·학과/동아리 검색">
                <button type="submit">
                    <span class="material-symbols-rounded">search</span>
                </button>
            </div>
        </div>

<!-- 우측 유저 메뉴 -->
        <div class="user-menu">

<div class="user-icons">
    <!-- ✅ 메시지 아이콘 : 클릭 시 /chat 으로 이동 -->
    <button type="button" class="icon-circle" title="메시지" aria-label="메시지함"
            onclick="location.href='${pageContext.request.contextPath}/chat'">
        <span class="material-symbols-rounded">chat_bubble</span>

        <!-- 🔴 읽지 않은 메시지가 있을 때만 배지 표시 -->
        <c:if test="${unreadCount gt 0}">
            <span class="icon-badge">${unreadCount}</span>
        </c:if>
    </button>

    <!-- ✅ 알림 아이콘(예시는 숫자 고정 / 추후 로직 연결 가능) -->
    <button type="button" class="icon-circle" title="알림" aria-label="알림">
        <span class="material-symbols-rounded">notifications</span>
        <span class="icon-badge">5</span>
    </button>
</div>


            <!-- 프로필 -->
            <a href="${pageContext.request.contextPath}/controller/mypage" class="profile-link">
                <c:choose>
                    <c:when test="${not empty user.profileImagePath}">
                        <img src="${pageContext.request.contextPath}${user.profileImagePath}" alt="프로필 이미지">
                    </c:when>
                    <c:otherwise>
                        <%-- 기본 프로필 아이콘 등 필요 시 추가 --%>
                    </c:otherwise>
                </c:choose>
                <span>${user.name}</span>
            </a>

            <!-- 로그아웃 -->
            <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
        </div>
    </div>
</div>

<!-- =========================
     하단 GNB
     ========================= -->
<div class="gnb">
    <div class="gnb-inner">
        <a href="${pageContext.request.contextPath}/product/list"
           class="<c:out value='${menu eq "used" ? "active" : ""}'/>">중고거래</a>
        <a href="#" class="<c:out value='${menu eq "rent" ? "active" : ""}'/>">대여/렌탈</a>
        <a href="#" class="<c:out value='${menu eq "grad" ? "active" : ""}'/>">졸업생 마켓</a>
        <a href="#" class="<c:out value='${menu eq "community" ? "active" : ""}'/>">커뮤니티</a>
    </div>
</div>
