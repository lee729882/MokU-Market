<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 / 렌탈 상품</title>

<style>
    body { font-family: 'Noto Sans KR'; background:#f5f6fa; margin:0; padding:0; }
    .container { width: 900px; margin: 30px auto; }

    .add-btn {
        display:inline-block; padding:10px 18px; background:#007bff;
        color:white; border-radius:8px; text-decoration:none;
        margin-bottom:20px; cursor:pointer;
    }

    .product-list { display:flex; flex-wrap:wrap; gap:20px; }
    .product-card {
        width: 200px; background:white; border-radius:10px;
        padding:15px; box-shadow:0 3px 8px rgba(0,0,0,0.1);
        text-align:center;
        position:relative;
    }

    .product-card img {
        width:100%; height:140px; object-fit:cover; border-radius:6px;
    }

    .delete-btn {
        background:#ff4444; color:white; border:none;
        padding:6px 10px; border-radius:6px;
        cursor:pointer; width:100%; margin-top:10px;
    }

    .rent-btn {
        background:#28a745; color:white; border:none;
        padding:6px 10px; border-radius:6px;
        cursor:pointer; width:100%; margin-top:10px;
    }

    .disabled-btn {
        background:gray; color:white; border:none;
        padding:6px 10px; border-radius:6px;
        width:100%; margin-top:10px; cursor:not-allowed;
    }

    /* 모달 스타일 */
    .modal {
        display:none;
        position:fixed;
        top:0; left:0;
        width:100%; height:100%;
        background:rgba(0,0,0,0.55);
        justify-content:center;
        align-items:center;
        z-index:9999;
    }

    .modal-content {
        background:white;
        padding:25px;
        width:350px;
        border-radius:12px;
        text-align:center;
    }
</style>
</head>

<body>
<div class="container">

    <h2>대여 / 렌탈 상품</h2>

    <!-- 🔥 로그인한 사용자 표시 -->
    <c:if test="${not empty loginUser}">
        <p style="font-size:16px; color:#333; margin-bottom:20px;">
            👤 로그인한 사용자: <strong>${loginUser.name}</strong>
        </p>
    </c:if>

    <!-- 상품 추가 버튼 -->
    <div class="add-btn" onclick="toggleAddForm()">
        + 상품 추가
    </div>

	<!-- 상품 등록 폼 박스 -->
	<div id="addFormBox" style="display:none; background:white; padding:20px; border-radius:10px; box-shadow:0 3px 10px rgba(0,0,0,0.1); margin-bottom:20px;">
	
	    <h3>렌탈 상품 등록</h3>
	
	    <form action="${pageContext.request.contextPath}/product/rent/add"
	          method="post" enctype="multipart/form-data">
	
	        <label>상품 이름</label>
	        <input type="text" name="title" required>
	
	        <label>상품 설명</label>
	        <textarea name="description" required></textarea>
	
	        <label>대여 가격</label>
	        <input type="number" name="price" required>
	
	        <label>대여 가능 기간</label>
	        <select name="durationType" required>
	            <option value="3MIN">3분</option>
	            <option value="1DAY">1일</option>
	            <option value="1MONTH">1달</option>
	            <option value="3MONTH">3달</option>
	        </select>
	
	        <label>상품 이미지</label>
	        <input type="file" name="file" accept="image/*" required>
	
	        <button type="submit" class="rent-btn">등록하기</button>
	    </form>
	</div>

    <!-- 상품 리스트 -->
    <div class="product-list">

        <c:forEach var="p" items="${products}">
            <div class="product-card">

                <c:choose>
                    <c:when test="${p.base64Image != null}">
                        <img src="data:image/png;base64,${p.base64Image}">
                    </c:when>
                    <c:otherwise>
                        <img src="/upload/product/no_image2.png">
                    </c:otherwise>
                </c:choose>

                <h3>${p.title}</h3>
                <p>${p.price}원</p>

                <!-- 🔥 판매자 이름 표시 -->
                <div style="font-size:12px; color:#666; margin-top:5px;">
                    판매자: <strong>${p.sellerName}</strong>
                </div>

                <!-- 상태 표시 -->
                <c:choose>
                    <c:when test="${p.status == 'RENTED'}">
                        <p style="color:red; font-weight:bold;">대여 중</p>
                    </c:when>
                    <c:otherwise>
                        <p style="color:green;">대여 가능</p>
                    </c:otherwise>
                </c:choose>

                <!-- 🔥 본인 상품 삭제 버튼 -->
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

                <!-- ⭐ 대여하기 버튼 (결제 모달 열기) -->
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
        </c:forEach>

    </div>
</div>


<!-- 📌 결제 모달 -->
<div id="paymentModal" class="modal">
    <div class="modal-content">
        <h3 id="payTitle">상품 결제</h3>
        <p>가격: <span id="payPrice"></span> 원</p>
        <p>대여 기간: <span id="payDurationText"></span></p>

        <input type="hidden" id="payProductId">
        <input type="hidden" id="payDuration">

        <button onclick="startPayment()" 
                style="margin-top:20px; width:100%; padding:12px;
                       background:#28a745; color:white; border:none; border-radius:6px;">
            결제하기
        </button>

        <button onclick="closePaymentModal()" 
                style="margin-top:10px; width:100%; padding:10px;
                       background:#777; color:white; border:none; border-radius:6px;">
            닫기
        </button>
    </div>
</div>


<script>
function toggleAddForm() {
    const box = document.getElementById("addFormBox");
    box.style.display = (box.style.display === "none") ? "block" : "none";
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
