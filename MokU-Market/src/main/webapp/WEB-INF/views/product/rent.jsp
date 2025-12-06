<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 / 렌탈 상품</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body { 
        font-family: 'Noto Sans KR', sans-serif; 
        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        min-height: 100vh;
        color: #1e293b;
    }

    .container { 
        max-width: 1200px; 
        margin: 0 auto; 
        padding: 40px 20px;
    }

    /* 헤더 섹션 */
    .page-header {
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
        padding: 50px 40px;
        border-radius: 24px;
        margin-bottom: 32px;
        position: relative;
        overflow: hidden;
    }

    .page-header::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -20%;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(59, 130, 246, 0.3) 0%, transparent 70%);
        border-radius: 50%;
    }

    .page-header h2 {
        color: white;
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 8px;
        position: relative;
        z-index: 1;
    }

    /* 유저 정보 배지 */
    .user-badge {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        background: rgba(255,255,255,0.1);
        backdrop-filter: blur(10px);
        padding: 12px 20px;
        border-radius: 50px;
        margin-top: 16px;
        border: 1px solid rgba(255,255,255,0.1);
        position: relative;
        z-index: 1;
        color: white;
        font-size: 14px;
    }

    .user-badge strong {
        color: #60a5fa;
    }

    /* 액션 버튼 영역 */
    .action-bar {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        margin-bottom: 32px;
        align-items: center;
    }

    .add-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 14px 24px;
        background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
        color: white;
        border-radius: 12px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 14px rgba(59, 130, 246, 0.4);
    }

    .add-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(59, 130, 246, 0.5);
    }

    .action-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 14px 24px;
        background: white;
        color: #1e293b;
        border-radius: 12px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        border: 1px solid #e2e8f0;
    }

    .action-link:hover {
        background: #f8fafc;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .action-link.green {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        border: none;
        box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
    }

    .action-link.green:hover {
        box-shadow: 0 8px 25px rgba(16, 185, 129, 0.5);
    }

    /* 상품 등록 폼 박스 */
    #addFormBox {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(15, 23, 42, 0.7);
        backdrop-filter: blur(8px);
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    #addFormBox.show {
        display: flex;
    }

    #addFormBox .form-container {
        background: white;
        padding: 36px;
        width: 500px;
        max-width: 90%;
        max-height: 90vh;
        overflow-y: auto;
        border-radius: 24px;
        box-shadow: 0 25px 80px rgba(0,0,0,0.3);
        animation: modalSlide 0.3s ease;
        position: relative;
    }

    #addFormBox .close-btn {
        position: absolute;
        top: 16px;
        right: 16px;
        width: 36px;
        height: 36px;
        border: none;
        background: #f1f5f9;
        border-radius: 50%;
        font-size: 20px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.2s ease;
        color: #64748b;
    }

    #addFormBox .close-btn:hover {
        background: #e2e8f0;
        color: #1e293b;
    }

    #addFormBox h3 {
        font-size: 22px;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 24px;
        padding-bottom: 16px;
        border-bottom: 2px solid #f1f5f9;
    }

    #addFormBox form {
        display: grid;
        gap: 20px;
    }

    #addFormBox label {
        font-size: 14px;
        font-weight: 600;
        color: #475569;
        margin-bottom: 6px;
        display: block;
    }

    #addFormBox input[type="text"],
    #addFormBox input[type="number"],
    #addFormBox textarea,
    #addFormBox select {
        width: 100%;
        padding: 14px 18px;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        font-size: 15px;
        font-family: inherit;
        transition: all 0.2s ease;
        background: #f8fafc;
    }

    #addFormBox input:focus,
    #addFormBox textarea:focus,
    #addFormBox select:focus {
        outline: none;
        border-color: #3b82f6;
        background: white;
        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
    }

    #addFormBox input[type="file"] {
        padding: 12px;
        background: white;
        cursor: pointer;
    }

    /* 상품 리스트 */
    .product-list { 
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
        gap: 24px;
    }

    .product-card {
        background: white;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        border: 1px solid #f1f5f9;
    }

    .product-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 50px rgba(0,0,0,0.12);
    }

    .product-card .image-wrapper {
        position: relative;
        overflow: hidden;
        height: 180px;
    }

    .product-card img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }

    .product-card:hover img {
        transform: scale(1.08);
    }

    .product-card .card-content {
        padding: 20px;
        text-align: center;
    }

    .product-card h3 {
        font-size: 17px;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 8px;
    }

    .product-card .price {
        font-size: 20px;
        font-weight: 800;
        background: linear-gradient(135deg, #3b82f6, #8b5cf6);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .product-card .seller-info {
        font-size: 12px;
        color: #64748b;
        margin-top: 10px;
        padding-top: 10px;
        border-top: 1px solid #f1f5f9;
    }

    /* 상태 배지 */
    .status-badge {
        position: absolute;
        top: 12px;
        right: 12px;
        padding: 6px 12px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: 700;
    }

    .status-available {
        background: rgba(16, 185, 129, 0.9);
        color: white;
    }

    .status-rented {
        background: rgba(239, 68, 68, 0.9);
        color: white;
    }

    /* 버튼 스타일 */
    .card-actions {
        padding: 0 20px 20px;
    }

    .rent-btn {
        width: 100%;
        padding: 12px 20px;
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        font-family: inherit;
    }

    .rent-btn:hover {
        box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
        transform: translateY(-2px);
    }

    .delete-btn {
        width: 100%;
        padding: 12px 20px;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        font-family: inherit;
    }

    .delete-btn:hover {
        box-shadow: 0 6px 20px rgba(239, 68, 68, 0.4);
        transform: translateY(-2px);
    }

    .disabled-btn {
        width: 100%;
        padding: 12px 20px;
        background: #e2e8f0;
        color: #94a3b8;
        border: none;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        cursor: not-allowed;
        font-family: inherit;
    }

    /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(15, 23, 42, 0.7);
        backdrop-filter: blur(8px);
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    .modal-content {
        background: white;
        padding: 36px;
        width: 400px;
        max-width: 90%;
        border-radius: 24px;
        text-align: center;
        box-shadow: 0 25px 80px rgba(0,0,0,0.3);
        animation: modalSlide 0.3s ease;
    }

    @keyframes modalSlide {
        from {
            opacity: 0;
            transform: scale(0.9) translateY(20px);
        }
        to {
            opacity: 1;
            transform: scale(1) translateY(0);
        }
    }

    .modal-content h3 {
        font-size: 22px;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 20px;
    }

    .modal-content p {
        font-size: 16px;
        color: #475569;
        margin-bottom: 8px;
    }

    .modal-content p span {
        font-weight: 700;
        color: #0f172a;
    }

    .modal-btn {
        width: 100%;
        padding: 14px 24px;
        border: none;
        border-radius: 12px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        font-family: inherit;
    }

    .modal-btn.confirm {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        margin-top: 20px;
    }

    .modal-btn.confirm:hover {
        box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
    }

    .modal-btn.cancel {
        background: #f1f5f9;
        color: #64748b;
        margin-top: 10px;
    }

    .modal-btn.cancel:hover {
        background: #e2e8f0;
    }

    /* 반응형 */
    @media (max-width: 768px) {
        .page-header {
            padding: 30px 24px;
        }

        .page-header h2 {
            font-size: 24px;
        }

        .action-bar {
            flex-direction: column;
        }

        .add-btn, .action-link {
            width: 100%;
            justify-content: center;
        }

        .product-list {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>

<body>
<div class="container">

    <!-- 헤더 섹션 -->
    <div class="page-header">
        <h2>대여 / 렌탈 상품</h2>

        <c:if test="${not empty loginUser}">
            <div class="user-badge">
                👤 로그인한 사용자: <strong>${loginUser.name}</strong>
            </div>
        </c:if>
    </div>

    <!-- 액션 버튼 영역 -->
    <div class="action-bar">
        <a href="${pageContext.request.contextPath}/product/rent/history" class="action-link">
            📘 대여 내역 보기
        </a>

        <a href="${pageContext.request.contextPath}/product/rent/stats" class="action-link green">
            📊 이번달 매출/소비 보기
        </a>

        <div class="add-btn" onclick="toggleAddForm()">
            + 상품 추가
        </div>
    </div>

    <!-- 상품 등록 폼 박스 (기능 그대로 유지) -->
    <div id="addFormBox" onclick="closeAddForm(event)">
        <div class="form-container" onclick="event.stopPropagation()">
            <button type="button" class="close-btn" onclick="toggleAddForm()">✕</button>
            <h3>렌탈 상품 등록</h3>

            <form action="${pageContext.request.contextPath}/product/rent/add"
                  method="post" enctype="multipart/form-data">

                <div>
                    <label>상품 이름</label>
                    <input type="text" name="title" required>
                </div>

                <div>
                    <label>상품 설명</label>
                    <textarea name="description" required></textarea>
                </div>

                <div>
                    <label>대여 가격</label>
                    <input type="number" name="price" required>
                </div>

                <div>
                    <label>대여 가능 기간</label>
                    <select name="durationType" required>
                        <option value="3MIN">3분</option>
                        <option value="1DAY">1일</option>
                        <option value="1MONTH">1달</option>
                        <option value="3MONTH">3달</option>
                    </select>
                </div>

                <div>
                    <label>상품 이미지</label>
                    <input type="file" name="file" accept="image/*" required>
                </div>

                <button type="submit" class="rent-btn">등록하기</button>
            </form>
        </div>
    </div>

    <!-- 상품 리스트 -->
    <div class="product-list">

        <c:forEach var="p" items="${products}">
            <div class="product-card">

                <div class="image-wrapper">
                    <c:choose>
                        <c:when test="${p.base64Image != null}">
                            <img src="data:image/png;base64,${p.base64Image}">
                        </c:when>
                        <c:otherwise>
                            <img src="/upload/product/no_image2.png">
                        </c:otherwise>
                    </c:choose>

                    <!-- 상태 배지 -->
                    <c:choose>
                        <c:when test="${p.status == 'RENTED'}">
                            <div class="status-badge status-rented">대여 중</div>
                        </c:when>
                        <c:otherwise>
                            <div class="status-badge status-available">대여 가능</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="card-content">
                    <h3>${p.title}</h3>
                    <p class="price">${p.price}원</p>

                    <div class="seller-info">
                        판매자: <strong>${p.sellerName}</strong>
                    </div>
                </div>

                <div class="card-actions">
                    <!-- 본인 상품 삭제 버튼 -->
                    <c:if test="${loginUser != null 
                                 && p.sellerName == loginUser.name 
                                 && p.status != 'RENTED'}">

                        <form action="${pageContext.request.contextPath}/product/rent/delete"
                              method="post"
                              onsubmit="return confirm('정말 삭제하시겠습니까?');">

                            <input type="hidden" name="productId" value="${p.rentProductId}">
                            <button type="submit" class="delete-btn">삭제하기</button>
                        </form>
                    </c:if>

                    <!-- 삭제 불가 -->
                    <c:if test="${loginUser != null 
                                 && p.sellerName == loginUser.name 
                                 && p.status == 'RENTED'}">
                        <button class="disabled-btn">대여 중 삭제 불가</button>
                    </c:if>

                    <!-- 대여하기 버튼 -->
                    <c:if test="${loginUser != null 
                                 && p.sellerName != loginUser.name 
                                 && p.status != 'RENTED'}">

                        <button class="rent-btn"
                                onclick="openPaymentModal('${p.rentProductId}',
                                                         '${p.title}',
                                                         '${p.price}',
                                                         '${p.durationType}')">
                            대여하기
                        </button>
                    </c:if>

                    <c:if test="${p.status == 'RENTED'}">
                        <button class="disabled-btn">대여 중</button>
                    </c:if>
                </div>

            </div>
        </c:forEach>

    </div>
</div>


<!-- 결제 모달 -->
<div id="paymentModal" class="modal">
    <div class="modal-content">
        <h3 id="payTitle">상품 결제</h3>
        <p>가격: <span id="payPrice"></span> 원</p>
        <p>대여 기간: <span id="payDurationText"></span></p>

        <input type="hidden" id="payProductId">
        <input type="hidden" id="payDuration">

        <button onclick="startPayment()" class="modal-btn confirm">
            결제하기
        </button>

        <button onclick="closePaymentModal()" class="modal-btn cancel">
            닫기
        </button>
    </div>
</div>


<script>
/* 기존 기능 100% 유지 */
function toggleAddForm() {
    const box = document.getElementById("addFormBox");
    box.classList.toggle("show");
}

function closeAddForm(event) {
    if (event.target === event.currentTarget) {
        document.getElementById("addFormBox").classList.remove("show");
    }
}

/* 결제 모달 열기 */
function openPaymentModal(productId, title, price, durationType) {

    document.getElementById("payProductId").value = productId;
    document.getElementById("payTitle").innerText = title + " 결제";
    document.getElementById("payPrice").innerText = price;

    let text;
    if (durationType === '3MIN') text = '3분';
    else if (durationType === '1DAY') text = '1일';
    else if (durationType === '1MONTH') text = '1달';
    else if (durationType === '3MONTH') text = '3달';
    else text = durationType;

    document.getElementById("payDurationText").innerText = text;
    document.getElementById("payDuration").value = durationType;

    document.getElementById("paymentModal").style.display = "flex";
}

function closePaymentModal() {
    document.getElementById("paymentModal").style.display = "none";
}

/* AJAX 결제 요청 */
function startPayment() {

    const productId = document.getElementById("payProductId").value;
    const duration = document.getElementById("payDuration").value;

    fetch("<c:url value='/product/rent/start'/>", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "productId=" + encodeURIComponent(productId)
             + "&durationType=" + encodeURIComponent(duration)
    })
    .then(() => {
        alert("결제가 완료되었습니다!\n대여가 시작됩니다.");
        closePaymentModal();
        location.reload();
    })
    .catch(err => {
        alert("대여 처리 중 오류 발생");
        console.error(err);
    });
}
</script>

</body>
</html>
