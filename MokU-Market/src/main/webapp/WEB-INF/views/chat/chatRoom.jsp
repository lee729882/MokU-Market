<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // JSP 상단에서 contextPath 한 번만 꺼내서 쓰기
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>채팅 | 목유마켓</title>

    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- ✅ 머티리얼 아이콘 (chat_bubble, notifications 아이콘용) -->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,300..700,0..1,-50..200" />

    <style>
    html, body {
    height: 100%;
}
        body {
            margin: 0;
            font-family: 'Nanum Gothic', sans-serif;
            background-color: #f5f5f5;
            
                display: flex;          /* 추가 */
    flex-direction: column; /* 추가 */
        }

        .page-wrapper {
            margin-top: 80px; /* 기존 공통 헤더 높이만큼 */
            flex: 1;                /* 추가: 본문이 남은 높이를 차지하도록 */
            
        }

        .chat-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px;
            display: flex;
            gap: 24px;
        }

        /* ------------ 왼쪽: 채팅방 리스트 ------------ */
        .chat-list {
            width: 32%;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            padding: 16px 0;
            display: flex;
            flex-direction: column;
        }

        .chat-list-header {
            padding: 0 20px 12px;
            border-bottom: 1px solid #eee;
            font-size: 20px;
            font-weight: 700;
        }

        .chat-room-item {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            gap: 12px;
            cursor: pointer;
            text-decoration: none;
            color: #333;
        }

        .chat-room-item:hover {
            background-color: #f8f8f8;
        }

        .chat-room-item.active {
            background-color: #ffe8ea;
        }

        .chat-room-thumb {
            width: 44px;
            height: 44px;
            border-radius: 8px;
            background-color: #ddd;
            overflow: hidden;
            flex-shrink: 0;
        }

        .chat-room-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .chat-room-text {
            flex: 1;
            min-width: 0;
        }

        .chat-room-nickname {
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 2px;
        }

        .chat-room-last-message {
            font-size: 12px;
            color: #777;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }

        .chat-room-meta {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 6px;
            font-size: 11px;
            color: #999;
        }

        .unread-badge {
            min-width: 20px;
            height: 20px;
            border-radius: 999px;
            background-color: #ff4b5c;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 700;
        }

        /* ------------ 오른쪽: 채팅 상세 ------------ */
        .chat-detail {
            flex: 1;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* 상단 상품/방 정보 영역 */
        .chat-detail-header {
            padding: 12px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            gap: 12px;
            background-color: #f9f9f9;
        }

        .chat-detail-thumb {
            width: 52px;
            height: 52px;
            border-radius: 10px;
            background-color: #ddd;
            overflow: hidden;
            flex-shrink: 0;
        }

        .chat-detail-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .chat-detail-info {
            flex: 1;
        }

        .product-title {
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .product-meta {
            font-size: 12px;
            color: #777;
        }

        .status-badge {
            display: inline-block;
            margin-left: 8px;
            padding: 2px 8px;
            border-radius: 999px;
            font-size: 11px;
            background-color: #e5f5f0;
            color: #007a5c;
        }

        .chat-detail-buttons {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .btn-small {
            border: none;
            border-radius: 999px;
            padding: 6px 12px;
            font-size: 11px;
            cursor: pointer;
        }

        .btn-review {
            background-color: #ff6b6b;
            color: #fff;
        }

        .btn-review-edit {
            background-color: #7bd88a;
            color: #fff;
        }

        /* 날짜 구분선 */
        .date-divider {
            text-align: center;
            font-size: 11px;
            color: #999;
            margin: 16px 0;
            position: relative;
        }

        .date-divider::before,
        .date-divider::after {
            content: "";
            position: absolute;
            top: 50%;
            width: 35%;
            height: 1px;
            background-color: #eee;
        }

        .date-divider::before {
            left: 8px;
        }

        .date-divider::after {
            right: 8px;
        }

        /* 메시지 리스트 영역 */
        .chat-messages {
            flex: 1;
            padding: 12px 20px 8px;
            overflow-y: auto;
            background-color: #fafafa;
        }

        .message-row {
            display: flex;
            margin-bottom: 10px;
        }

        .message-row.me {
            justify-content: flex-end;
        }

        .message-row.other {
            justify-content: flex-start;
        }

        .message-bubble {
            max-width: 60%;
            padding: 10px 12px;
            border-radius: 16px;
            font-size: 13px;
            line-height: 1.4;
            position: relative;
        }

        .message-bubble.me {
            background-color: #ff5b6b;
            color: #fff;
            border-bottom-right-radius: 4px;
        }

        .message-bubble.other {
            background-color: #ffffff;
            border: 1px solid #eee;
            color: #333;
            border-bottom-left-radius: 4px;
        }

        .message-time {
            font-size: 10px;
            color: #aaa;
            margin-top: 2px;
        }

        .message-meta {
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            margin-left: 6px;
            margin-right: 6px;
        }

        .message-nickname {
            font-size: 11px;
            color: #888;
            margin-bottom: 2px;
        }

        /* 입력 영역 */
        .chat-input-wrapper {
            border-top: 1px solid #eee;
            padding: 10px 14px;
            background-color: #ffffff;
            display: flex;
            gap: 8px;
            align-items: flex-end;
        }

        .chat-input-wrapper textarea {
            flex: 1;
            resize: none;
            border-radius: 16px;
            border: 1px solid #ddd;
            padding: 10px 12px;
            font-size: 13px;
            font-family: inherit;
            min-height: 42px;
            max-height: 120px;
        }

        .btn-send {
            width: 44px;
            height: 44px;
            border-radius: 999px;
            border: none;
            background-color: #ff5b6b;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            flex-shrink: 0;
        }

        .btn-send:disabled {
            background-color: #ddd;
            cursor: default;
        }

        .empty-room {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #aaa;
            font-size: 14px;
        }
         /* 푸터 */
        .footer {
            background-color: #f1f1f1;
            text-align: center;
            padding: 10px;
            font-size: 13px;
            color: #666;
            border-top: 1px solid #ddd;
            margin-top: 40px;
        }
         /* 플로팅 버튼 세트 */
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

        /* Top 버튼 */
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

        /* + 등록 버튼 */
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
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="page-wrapper">
    <div class="chat-container">

        <!-- ======================= 왼쪽: 채팅방 리스트 ======================= -->
        <div class="chat-list">
            <div class="chat-list-header">Chat</div>

            <c:if test="${empty rooms}">
                <div style="padding:16px 20px; font-size:13px; color:#888;">
                    아직 시작한 채팅이 없습니다.
                </div>
            </c:if>

            <c:forEach var="room" items="${rooms}">
                <a class="chat-room-item
                          <c:if test='${not empty activeRoom and room.roomId == activeRoom.roomId}'>active</c:if>"
                   href="${ctx}/chat/room?roomId=${room.roomId}">

                    <div class="chat-room-thumb">
                        <c:if test="${not empty room.productImageUrl}">
                            <img src="${ctx}${room.productImageUrl}" alt="상품 이미지">
                        </c:if>
                    </div>

                    <div class="chat-room-text">
                        <div class="chat-room-nickname">
                            <c:out value="${room.opponentName}" default="닉네임" />
                        </div>
                        <div class="chat-room-last-message">
                            <c:out value="${room.lastMessage}" default="마지막 채팅 내용이 여기에 표시됩니다." />
                        </div>
                    </div>

                    <div class="chat-room-meta">
                        <c:if test="${not empty room.lastMessageAt}">
                            <span>
                                <fmt:formatDate value="${room.lastMessageAt}" pattern="HH:mm" />
                            </span>
                        </c:if>
                        <c:if test="${room.unreadCount gt 0}">
                            <span class="unread-badge">${room.unreadCount}</span>
                        </c:if>
                    </div>
                </a>
            </c:forEach>
        </div>

        <!-- ======================= 오른쪽: 채팅 상세 ======================= -->
        <div class="chat-detail">

            <c:choose>
                <c:when test="${empty activeRoom}">
                    <div class="empty-room">
                        왼쪽에서 채팅방을 선택하시거나 상품 상세에서 채팅을 시작해 주세요.
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- 상단 상품/방 정보 -->
                    <div class="chat-detail-header">

                        <!-- ✅ 상품 영역 클릭 시 상세 페이지로 이동 -->
                        <a href="${ctx}/product/detail?id=${activeRoom.productId}"
                           style="display:flex; align-items:center; gap:12px; text-decoration:none; color:inherit; flex:1;">

                            <div class="chat-detail-thumb">
                                <c:if test="${not empty activeRoom.productImageUrl}">
                                    <img src="${ctx}${activeRoom.productImageUrl}" alt="상품 이미지">
                                </c:if>
                            </div>

                            <div class="chat-detail-info">
                                <div class="product-title">
                                    <c:out value="${activeRoom.productTitle}" default="게시글 제목" />
                                </div>
                                <div class="product-meta">
                                    <span>
                                        <fmt:formatNumber value="${activeRoom.price}" pattern="#,###" />원
                                    </span>
                                    <c:if test="${not empty activeRoom.status}">
                                        <span class="status-badge">
                                            <c:out value="${activeRoom.status}" />
                                        </span>
                                    </c:if>
                                </div>
                            </div>
                        </a>

                        <div class="chat-detail-buttons">
                            <button type="button" class="btn-small btn-review">후기 남기기</button>
                            <button type="button" class="btn-small btn-review-edit">후기 수정하기</button>
                        </div>
                    </div>

                    <!-- 메시지 리스트 -->
						<div class="chat-messages" id="chatMessages">
						
						    <%-- ✅ 현재 날짜 객체 생성 --%>
						    <jsp:useBean id="now" class="java.util.Date" />
						
						    <%-- 오늘 날짜 한 줄만 표시 --%>
						    <div class="date-divider">
						        <fmt:formatDate value="${now}" pattern="yyyy.MM.dd (E)" />
						    </div>
						
						    <%-- 기존 prevDate / msgDate 로직은 제거하고 메시지만 그리기 --%>
						    <c:forEach var="msg" items="${messages}">
						        <c:set var="isMe" value="${msg.senderId == loginUser.userId}" />
						
						        <div class="message-row ${isMe ? 'me' : 'other'}">
						            <c:if test="${not isMe}">
						                <div class="message-meta">
						                    <div class="message-nickname">
						                        <c:out value="${activeRoom.opponentName}" default="프로필" />
						                    </div>
						                </div>
						            </c:if>
						
						            <div class="message-bubble ${isMe ? 'me' : 'other'}">
						                <c:out value="${msg.content}" />
						            </div>
						
						            <div class="message-meta">
						                <div class="message-time">
						                    <fmt:formatDate value="${msg.sentAt}" pattern="HH:mm" />
						                </div>
						            </div>
						        </div>
						    </c:forEach>
						</div>


                    <!-- 입력 영역 -->
                    <form class="chat-input-wrapper" id="chatForm">
                        <textarea name="content"
                                  id="messageText"
                                  placeholder="메세지를 입력하세요. Enter로 줄바꿈, Ctrl+Enter로 전송."></textarea>
                        <button type="submit" class="btn-send" id="btnSend" disabled>↑</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>
    <!-- 푸터 -->
    <div class="footer">
        <p>© 2025 Mokpo National University | MokU Market</p>
    </div>
  <!-- 플로팅 버튼 -->
        <div class="floating-container">
            <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
            <a href="${pageContext.request.contextPath}/product/add" class="floating-add">+</a>
        </div>

    </div> <!-- /page-wrapper -->

    <!-- Top 버튼 기능 -->
    <script>
        document.getElementById("topBtn").addEventListener("click", () => {
            window.scrollTo({ top: 0, behavior: "smooth" });
        });

        // 슬라이더 스크립트
        let currentSlide = 0;
        const AUTO_DELAY = 5000;
        let autoTimer = null;

        function updateCarousel() {
            const items = document.querySelectorAll(".carousel-item");
            const dots = document.querySelectorAll(".carousel-dots .dot");
            const totalSlides = items.length;
            if (totalSlides === 0) return;

            currentSlide = (currentSlide + totalSlides) % totalSlides;

            items.forEach((item, i) => {
                item.classList.toggle("active", i === currentSlide);
            });
            dots.forEach((dot, i) => {
                dot.classList.toggle("active", i === currentSlide);
            });
        }

        function goToSlide(index) {
            currentSlide = index;
            updateCarousel();
        }

        function moveSlide(delta) {
            currentSlide += delta;
            updateCarousel();
        }

        function startAuto() {
            stopAuto();
            autoTimer = setInterval(() => {
                currentSlide += 1;
                updateCarousel();
            }, AUTO_DELAY);
        }

        function stopAuto() {
            if (autoTimer) {
                clearInterval(autoTimer);
                autoTimer = null;
            }
        }

        window.addEventListener("load", () => {
            currentSlide = 0;
            updateCarousel();
            startAuto();

            const hero = document.querySelector(".hero-carousel");
            if (hero) {
                hero.addEventListener("mouseenter", stopAuto);
                hero.addEventListener("mouseleave", startAuto);
            }
        });
    </script>
<c:if test="${not empty activeRoom}">
<script>
    (function() {
        const textarea = document.getElementById('messageText');
        const btnSend  = document.getElementById('btnSend');
        const form     = document.getElementById('chatForm');
        const msgBox   = document.getElementById('chatMessages');

        const ctx    = '${ctx}';
        const roomId = '${activeRoom.roomId}';

        if (msgBox) {
            msgBox.scrollTop = msgBox.scrollHeight;
        }

        if (!textarea || !btnSend || !form) return;

        function updateButton() {
            const v = textarea.value.trim();
            btnSend.disabled = v.length === 0;
        }

        textarea.addEventListener('input', updateButton);

        // Ctrl+Enter 전송, Enter는 줄바꿈
        textarea.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && e.ctrlKey) {
                e.preventDefault();
                if (!btnSend.disabled) {
                    sendMessage();
                }
            }
        });

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            if (!btnSend.disabled) {
                sendMessage();
            }
        });

        function appendMessage(me, content) {
            if (!msgBox) return;

            const row = document.createElement('div');
            row.className = 'message-row ' + (me ? 'me' : 'other');

            const bubble = document.createElement('div');
            bubble.className = 'message-bubble ' + (me ? 'me' : 'other');
            bubble.textContent = content;

            const meta = document.createElement('div');
            meta.className = 'message-meta';
            const timeSpan = document.createElement('div');
            timeSpan.className = 'message-time';
            const now = new Date();
            const hh = String(now.getHours()).padStart(2, '0');
            const mm = String(now.getMinutes()).padStart(2, '0');
            timeSpan.textContent = hh + ':' + mm;
            meta.appendChild(timeSpan);

            row.appendChild(bubble);
            row.appendChild(meta);

            msgBox.appendChild(row);
            msgBox.scrollTop = msgBox.scrollHeight;
        }

        function sendMessage() {
            const text = textarea.value.trim();
            if (!text) return;

            const params = new URLSearchParams();
            params.append('roomId', roomId);
            params.append('content', text);

            fetch(ctx + '/chat/room/send', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                },
                body: params.toString()
            })
                .then(res => res.json())
                .then(data => {
                    if (data.status === 'success') {
                        appendMessage(true, text);
                        textarea.value = '';
                        updateButton();
                    } else if (data.status === 'login_required') {
                        alert('로그인이 필요합니다.');
                        location.href = ctx + '/login';
                    } else {
                        alert(data.message || '메시지 전송 중 오류가 발생했습니다.');
                    }
                })
                .catch(err => {
                    console.error(err);
                    alert('네트워크 오류가 발생했습니다.');
                });
        }

        updateButton();
    })();
</script>
</c:if>

</body>
</html>
