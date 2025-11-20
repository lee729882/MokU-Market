<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 | 목유마켓</title>

<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,300..700,0..1,-50..200" />

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

/* 공통 래퍼 */
.mypage-wrapper {
    width: 100%;
    max-width: 1150px;
    margin: 0 auto 80px;
    padding: 0 20px 60px;
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
    width: 100%;
    max-width: 680px;
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

.verified-badge {
    display: inline-block;
    background-color: #007A5C;
    color: white;
    font-size: 12.5px;
    font-weight: 700;
    padding: 5px 10px;
    border-radius: 20px;
    margin-bottom: 6px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.12);
}

/* ============== 탭 컨텐츠 공통 ============== */
.tab-content {
    display: none;
}
.tab-content.active {
    display: block;
}

/* ================= 정보 폼 ================= */
.info-box {
    width: 100%;
    max-width: 680px;
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

.btn-save {
    width: 100%;
    padding: 10px 0;
    border-radius: 8px;
    border: none;
    font-weight: 700;
    background: #ccc;
    color: #fff;
    cursor: not-allowed;
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

/* ================= 상품 카드 (내 등록템 / 내 관심템 공통) ================= */
.section-title {
    font-family: 'Jua', sans-serif;
    font-size: 20px;
    margin: 30px 0 15px;
    color: #333;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
    gap: 24px 20px;
}
.product {
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.08);
    overflow: hidden;
    text-align: left;
    transition: 0.25s;
}
.product:hover {
    transform: translateY(-3px);
    box-shadow: 0 5px 12px rgba(0,0,0,0.15);
}
.product .thumb {
    position: relative;
    cursor: pointer;
}
.product img {
    width: 100%;
    height: 190px;
    object-fit: cover;
}

/* ✅ 판매완료 비주얼 */
.product.sold .thumb img {
    filter: grayscale(0.5) brightness(0.7);
}
.product.sold .thumb::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.35);
}
.sold-badge {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0,0,0,0.7);
    color: #fff;
    font-size: 14px;
    font-weight: 700;
    padding: 6px 14px;
    border-radius: 999px;
    letter-spacing: 1px;
}

/* 상품 정보 */
.product-info {
    padding: 12px 14px 8px;
}
.product-info h3 {
    font-size: 15px;
    color: #333;
    font-weight: 600;
    margin: 6px 0;
    line-height: 1.4;
}
.price {
    font-weight: bold;
    font-size: 15px;
    color: #111;
    margin: 3px 0 8px;
}

/* 카테고리 뱃지 */
.badge {
    display: inline-block;
    font-size: 11px;
    font-weight: bold;
    padding: 3px 8px;
    border-radius: 20px;
    color: white;
    margin-bottom: 3px;
}
.badge.무료나눔 { background-color: #4CAF50; }
.badge.전자기기 { background-color: #3F51B5; }
.badge.의류 { background-color: #FF7043; }
.badge.생활용품 { background-color: #009688; }
.badge.전공서적 { background-color: #9C27B0; }
.badge.음식 { background-color: #795548; }
.badge.default { background-color: #607D8B; }

/* 관리 버튼 (내 등록템) */
.product-actions {
    display: flex;
    justify-content: flex-start;
    gap: 6px;
    padding: 0 10px 10px;
}
.product-actions button {
    border-radius: 4px;
    padding: 3px 8px;
    font-size: 11px;
    cursor: pointer;
    border: 1px solid #ddd;
    background: #f9f9f9;
    font-weight: 600;
}
.product-actions button:hover {
    background: #fff;
}
.btn-edit   { border-color:#4caf50; color:#4caf50; }
.btn-delete { border-color:#9e9e9e; color:#555;   }
.btn-sold   { border-color:#f44336; color:#f44336; }

/* ================= FOOTER ================= */
.footer {
    background-color: #f1f1f1;
    text-align: center;
    padding: 10px;
    font-size: 13px;
    color: #666;
    border-top: 1px solid #ddd;
    margin-top: auto;
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
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.25);
    transition: 0.25s;
}
.floating-add:hover {
    background-color: #E03B3B;
    transform: scale(1.07);
}

@media (max-width: 768px) {
    .mypage-wrapper { padding: 0 15px 50px; }
    .profile-card   { padding: 25px 20px; margin-top: 30px; }
    .floating-container { bottom: 25px; right: 25px; }
    .floating-add { width: 55px; height: 55px; font-size: 34px; line-height: 55px; }
}
</style>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<c:set var="activeTab" value="${empty param.tab ? 'info' : param.tab}" />

<!-- ================= 마이페이지 NAV ================= -->
<div class="mypage-nav">
    <a href="javascript:void(0);"
       class="tab-link ${activeTab eq 'myProducts' ? 'active' : ''}"
       data-tab="myProducts">내 등록템</a>

    <a href="javascript:void(0);"
       class="tab-link ${activeTab eq 'info' ? 'active' : ''}"
       data-tab="info">개인정보 수정</a>

    <a href="javascript:void(0);"
       class="tab-link ${activeTab eq 'favorites' ? 'active' : ''}"
       data-tab="favorites">내 관심템</a>

    <a href="javascript:void(0);"
       class="tab-link ${activeTab eq 'reviews' ? 'active' : ''}"
       data-tab="reviews">내 후기</a>
</div>

<div class="mypage-wrapper">

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
            <input type="file" id="profileUpload" accept="image/*"
                   style="display:none;" onchange="uploadProfileImage(this)">
        </div>

        <div class="profile-info">
            <c:if test="${user.isLocationVerified == 'Y'}">
                <div class="verified-badge">📡 캠퍼스 인증 완료</div>
            </c:if>

            <h2>${user.name}</h2>

            <div class="stats"><span>매너온도: ${user.mannerTemp}℃ 🔥</span></div>

            <div class="stats">
                <span>내 등록템 ${user.productCount}개</span>
                <span>내 관심템 ${user.favoriteCount}개</span>
                <span>채팅 ${user.chatCount}건</span>
            </div>

            <c:if test="${user.isLocationVerified != 'Y'}">
                <button onclick="verifyWifi()"
                        style="margin-top:12px; padding:8px 14px;
                               background:#007A5C; color:white;
                               border:none; border-radius:6px;
                               font-weight:600; cursor:pointer;">
                    📡 캠퍼스 Wi-Fi 인증하기
                </button>
            </c:if>
        </div>
    </div>

    <!-- ============== 개인정보 수정 탭 ============== -->
    <div class="tab-content ${activeTab eq 'info' ? 'active' : ''}" id="tab-info">
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
    </div>

    <!-- ============== 내 등록템 탭 ============== -->
    <div class="tab-content ${activeTab eq 'myProducts' ? 'active' : ''}" id="tab-myProducts">
        <h3 class="section-title">내 등록템</h3>

        <c:choose>
            <c:when test="${empty myProducts}">
                <p style="text-align:center; color:#777; margin-top:30px;">
                    등록한 상품이 없습니다. 첫 번째로 등록해 보세요!
                </p>
            </c:when>
            <c:otherwise>
                <div class="product-grid">
                    <c:forEach var="p" items="${myProducts}">
                        <%-- SOLD 인 경우 product sold 클래스 부여 --%>
                        <div class="product<c:if test='${p.status eq "SOLD"}'> sold</c:if>">
                            <!-- 썸네일 -->
                            <div class="thumb"
                                 onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${p.productId}'">
                                <img src="${pageContext.request.contextPath}${p.imagePath}"
                                     alt="${p.title}"
                                     onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />

                                <c:if test="${p.status == 'SOLD'}">
                                    <div class="sold-badge">판매 완료</div>
                                </c:if>
                            </div>

                            <div class="product-info">
                                <span class="badge ${p.category != null ? p.category : 'default'}">
                                    ${p.category}
                                </span>
                                <h3>${p.title}</h3>
                                <p class="price">
                                    <c:choose>
                                        <c:when test="${p.price == 0}">무료나눔</c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${p.price}" type="number" pattern="#,###" /> 원
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <div class="product-actions">
                                <button class="btn-edit"
                                        onclick="location.href='${pageContext.request.contextPath}/product/edit?id=${p.productId}'">
                                    수정
                                </button>
                                <button class="btn-delete"
                                        onclick="deleteProduct(${p.productId});">
                                    삭제
                                </button>
                                <button class="btn-sold"
                                        onclick="toggleSold(${p.productId}, '${p.status}');">
                                    <c:choose>
                                        <c:when test="${p.status == 'SOLD'}">판매 완료 해제</c:when>
                                        <c:otherwise>판매 완료 변경</c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ============== 내 관심템 탭 ============== -->
    <div class="tab-content ${activeTab eq 'favorites' ? 'active' : ''}" id="tab-favorites">
        <h3 class="section-title">내 관심템</h3>

        <c:choose>
            <c:when test="${empty favoriteProducts}">
                <p style="text-align:center; color:#777; margin-top:30px;">
                    관심 등록한 상품이 없습니다.
                </p>
            </c:when>
            <c:otherwise>
                <div class="product-grid">
                    <c:forEach var="p" items="${favoriteProducts}">
                        <div class="product<c:if test='${p.status eq "SOLD"}'> sold</c:if>"
                             onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${p.productId}'">
                            <div class="thumb">
                                <img src="${pageContext.request.contextPath}${p.imagePath}"
                                     alt="${p.title}"
                                     onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.png';" />
                                <c:if test="${p.status == 'SOLD'}">
                                    <div class="sold-badge">판매 완료</div>
                                </c:if>
                            </div>
                            <div class="product-info">
                                <span class="badge ${p.category != null ? p.category : 'default'}">
                                    ${p.category}
                                </span>
                                <h3>${p.title}</h3>
                                <p class="price">
                                    <c:choose>
                                        <c:when test="${p.price == 0}">무료나눔</c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${p.price}" type="number" pattern="#,###" /> 원
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ============== 내 후기 탭 (임시) ============== -->
    <div class="tab-content ${activeTab eq 'reviews' ? 'active' : ''}" id="tab-reviews">
        <h3 class="section-title">내 후기</h3>
        <p style="text-align:center; color:#777; margin-top:30px;">
            아직 작성된 후기가 없습니다.
        </p>
    </div>

</div> <!-- /mypage-wrapper -->

<!-- ================= FOOTER ================= -->
<div class="footer">
    <p>© 2025 Mokpo National University | MokU Market</p>
</div>

<!-- ================= JS ================= -->
<script>
// ✅ 공통: 탭 활성화 함수
function activateTab(tabName) {
    // 상단 탭 버튼 active 처리
    document.querySelectorAll('.mypage-nav .tab-link')
        .forEach(t => {
            if (t.dataset.tab === tabName) t.classList.add('active');
            else t.classList.remove('active');
        });

    // 콘텐츠 영역 active 처리
    document.querySelectorAll('.tab-content')
        .forEach(c => c.classList.remove('active'));

    const content = document.getElementById('tab-' + tabName);
    if (content) content.classList.add('active');
}

// ✅ 페이지 로드 시: 마지막으로 열었던 탭 복원
document.addEventListener('DOMContentLoaded', function() {
    // 서버에서 넘어온 기본 탭(info / myProducts / favorites / reviews)
    var serverTab = '${activeTab}';
    // 브라우저에 저장된 마지막 탭
    var savedTab = localStorage.getItem('mypageActiveTab');

    var finalTab = savedTab || serverTab || 'info';
    activateTab(finalTab);
});

// ✅ 탭 클릭 시: 화면 전환 + localStorage에 기억
document.querySelectorAll('.mypage-nav .tab-link').forEach(tab => {
    tab.addEventListener('click', function(e) {
        e.preventDefault();
        const target = this.dataset.tab;
        activateTab(target);
        // 마지막으로 선택한 탭 저장
        localStorage.setItem('mypageActiveTab', target);
    });
});

function verifyWifi() {
    fetch('${pageContext.request.contextPath}/controller/verifyWifi')
        .then(res => res.text())
        .then(msg => {
            alert(msg);
            location.reload();
        });
}

function uploadProfileImage(input) {
    const file = input.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("file", file);

    fetch('${pageContext.request.contextPath}/controller/updateProfileImage', {
        method: "POST",
        body: formData,
        credentials: "include"
    })
    .then(res => res.json())
    .then(data => {
        if (data.success && data.imagePath) {
            alert("프로필 이미지가 정상적으로 변경되었습니다.");
            location.reload();
        } else {
            alert(data.message ?? "업로드 중 문제가 발생했습니다.");
        }
    })
    .catch(err => {
        console.error("업로드 오류:", err);
        alert("업로드 중 오류가 발생했습니다.");
    });
}

// ✅ 삭제
function deleteProduct(id) {
    if (!confirm("정말 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.")) return;

    // 현재 선택된 탭 기억
    const currentTab = document.querySelector('.mypage-nav .tab-link.active')?.dataset.tab || 'info';
    localStorage.setItem('mypageActiveTab', currentTab);

    // from=mypage는 선택 사항 (컨트롤러에서 쓰면 유지)
    location.href = '${pageContext.request.contextPath}/product/delete?id=' + id + '&from=mypage';
}

// ✅ 판매완료 토글 (중요: 별도 페이지로 안 가고, alert만 띄운 뒤 내 등록템 탭 유지)
function toggleSold(id, status) {
    const isSold = (status === 'SOLD');
    const confirmMsg = isSold
        ? '판매 완료를 해제하시겠습니까?'
        : '판매 완료로 변경하시겠습니까?';

    if (!confirm(confirmMsg)) return;

    const baseUrl = isSold
        ? '${pageContext.request.contextPath}/product/markUnsold'
        : '${pageContext.request.contextPath}/product/markSold';

    const url = baseUrl + '?id=' + id;

    // 현재 탭 저장 (대부분 myProducts일 것)
    const currentTab = document.querySelector('.mypage-nav .tab-link.active')?.dataset.tab || 'info';
    localStorage.setItem('mypageActiveTab', currentTab);

    fetch(url, {
        method: 'GET',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(res => res.text())
    .then(text => {
        const msg = text && text.trim().length > 0
            ? text.trim()
            : '판매 상태가 변경되었습니다.';

        alert(msg);   // ✅ 별도 페이지 안 열리고, 그냥 알림만

        if (msg.indexOf('로그인이 필요') !== -1) {
            location.href = '${pageContext.request.contextPath}/login';
        } else {
            // ✅ 같은 URL로 새로고침 (localStorage에 저장해둔 탭으로 다시 열림)
            location.reload();
        }
    })
    .catch(err => {
        console.error('판매 상태 변경 중 오류:', err);
        alert('판매 상태 변경 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.');
    });
}

// Top 버튼
document.getElementById("topBtn")?.addEventListener("click", () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
});
</script>


<!-- 플로팅 버튼 -->
<div class="floating-container">
    <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
    <a href="${pageContext.request.contextPath}/product/add" class="floating-add">+</a>
</div>

</body>
</html>
