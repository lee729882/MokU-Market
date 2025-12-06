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

    #addFormBox {
        display:none;
        background:white; padding:20px; border-radius:10px;
        box-shadow:0 3px 10px rgba(0,0,0,0.1);
        margin-bottom:20px;
    }

    input, textarea, select {
        width:100%; padding:12px; margin-top:8px; margin-bottom:12px;
        border-radius:6px; border:1px solid #ccc;
    }

    button {
        padding:12px 20px; background:#28a745; color:white;
        border:none; border-radius:6px; cursor:pointer;
        width:100%; font-size:16px;
    }

    /* 삭제 버튼 스타일 */
    .delete-btn {
        background:#ff4444;
        color:white;
        border:none;
        padding:6px 10px;
        border-radius:6px;
        cursor:pointer;
        margin-top:10px;
        width:100%;
        font-size:14px;
    }
    .delete-btn:hover {
        background:#cc0000;
    }
</style>

<script>
    function toggleAddForm() {
        const box = document.getElementById("addFormBox");
        box.style.display = (box.style.display === "none") ? "block" : "none";
    }
</script>

</head>
<body>

<div class="container">

    <h2>대여 / 렌탈 상품</h2>

    <!-- 상품 추가 버튼 -->
    <div class="add-btn" onclick="toggleAddForm()">
        + 상품 추가
    </div>

    <!-- 상품 등록 폼 -->
    <div id="addFormBox">

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

            <label>상품 이미지 (BLOB 저장)</label>
            <input type="file" name="file" accept="image/*" required>

            <button type="submit">상품 등록하기</button>
        </form>
    </div>

    <!-- 렌탈 상품 목록 -->
        <!-- 렌탈 상품 목록 -->
    <div class="product-list">

        <c:forEach var="p" items="${products}">
            <div class="product-card">

                <c:choose>
                    <c:when test="${p.base64Image != null}">
                        <img src="data:image/png;base64,${p.base64Image}" alt="상품 이미지">
                    </c:when>
                    <c:otherwise>
                        <img src="/upload/product/no_image2.png" alt="기본 이미지">
                    </c:otherwise>
                </c:choose>

                <h3>${p.title}</h3>
                <p>${p.price}원</p>

                <%-- 🔍 디버깅용: 판매자 / 로그인 사용자 이름 확인 --%>
                <div style="font-size:11px; color:#888; margin-top:4px;">
                    판매자: ${p.sellerName}
                    <br>
                    로그인: 
                    <c:choose>
                        <c:when test="${not empty sessionScope.loginUser}">
                            ${sessionScope.loginUser.name}
                        </c:when>
                        <c:otherwise>
                            (비로그인)
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- 🔥 본인 상품일 때만 삭제 버튼 표시 --%>
                <c:if test="${loginUser != null && p.sellerName == loginUser.name}">
				    <form action="${pageContext.request.contextPath}/product/rent/delete"
					      method="post"
					      onsubmit="return confirm('정말 삭제하시겠습니까?');">
					    <input type="hidden" name="productId" value="${p.rentProductId}">
					    <button type="submit" class="delete-btn">삭제하기</button>
					</form>
				</c:if>


            </div>
        </c:forEach>

    </div>


</div>

</body>
</html>
