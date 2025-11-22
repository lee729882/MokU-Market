<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<fmt:setTimeZone value="Asia/Seoul" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>채팅 | 목유마켓</title>

    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;600;700&display=swap" rel="stylesheet">
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
            display: flex;
            flex-direction: column;
        }

        .page-wrapper {
            margin-top: 80px; /* 헤더 높이만큼 */
            flex: 1;
        }

        .chat-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px;
            display: flex;
            gap: 24px;
        }

        /* ================== 왼쪽: 채팅방 리스트 ================== */
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

        /* ================== 오른쪽: 채팅 상세 ================== */
        .chat-detail {
            flex: 1;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* 상단 상품/방 정보 */
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

        .date-divider::before { left: 8px; }
        .date-divider::after  { right: 8px; }

        /* 메시지 리스트 */
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


        /* 플로팅 버튼 */
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

        /* ================== 후기 모달 ================== */
        .review-modal {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.55);
            display: none;          /* JS에서 show 클래스 추가 시 flex로 변경 */
            z-index: 3000;
            align-items: center;
            justify-content: center;
        }
        .review-modal.show {
            display: flex;
        }

        .review-modal-inner {
            width: 420px;
            max-width: 95%;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.25);
            padding: 24px 26px 20px;
            position: relative;
            font-size: 13px;
        }

        .review-modal-close {
            position: absolute;
            top: 10px;
            right: 12px;
            border: none;
            background: transparent;
            font-size: 18px;
            cursor: pointer;
            color: #aaa;
        }

        .review-item-box {
            display: flex;
            gap: 12px;
            padding: 10px;
            border-radius: 10px;
            background: #fafafa;
            margin-bottom: 18px;
        }

        .review-item-thumb {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            overflow: hidden;
            background: #ddd;
            flex-shrink: 0;
        }
        .review-item-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .review-item-info-title {
            font-weight: 700;
            margin-bottom: 4px;
        }
        .review-item-info-price {
            font-size: 12px;
            color: #777;
        }

        .review-question {
            margin: 10px 0 6px;
            font-weight: 600;
            font-size: 13px;
        }

        .review-score-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .review-score-btn {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: 1px solid #ddd;
            background: #fff;
            font-size: 18px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .review-score-btn.active {
            border-color: #ff6b6b;
            background: #ffebef;
        }

        .review-textarea {
            width: 100%;
            resize: vertical;
            min-height: 80px;
            max-height: 200px;
            border-radius: 10px;
            border: 1px solid #ddd;
            padding: 10px;
            font-family: inherit;
            font-size: 13px;
            box-sizing: border-box;
        }

        .review-modal-footer {
            margin-top: 14px;
            display: flex;
            justify-content: flex-end;
        }

        .btn-review-submit {
            border: none;
            border-radius: 999px;
            padding: 8px 18px;
            font-size: 13px;
            cursor: pointer;
            background: #ff6b6b;
            color: #fff;
            font-weight: 600;
        }
        .btn-review-submit:disabled {
            background: #ddd;
            cursor: default;
        }

        .chat-room-delete-btn {
            margin-top: 4px;
            padding: 2px 8px;
            font-size: 11px;
            border-radius: 999px;
            border: 1px solid #ddd;
            background-color: #fff;
            color: #999;
            cursor: pointer;
        }

        .chat-room-delete-btn:hover {
            border-color: #ff4b5b;
            color: #ff4b5b;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="page-wrapper">
    <div class="chat-container">

        <!-- ============== 왼쪽: 채팅방 리스트 ============== -->
        <div class="chat-list">
            <div class="chat-list-header">Chat</div>

            <c:if test="${empty rooms}">
                <div style="padding:16px 20px; font-size:13px; color:#888;">
                    아직 시작한 채팅이 없습니다.
                </div>
            </c:if>

            <c:forEach var="room" items="${rooms}">
                <a
                    href="${ctx}/chat/room?roomId=${room.roomId}"
                    class="chat-room-item ${not empty activeRoom and room.roomId == activeRoom.roomId ? 'active' : ''}"
                >
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
                                <fmt:formatDate value="${room.lastMessageAt}" pattern="HH:mm" timeZone="Asia/Seoul" />
                            </span>
                        </c:if>
                        <c:if test="${room.unreadCount gt 0}">
                            <span class="unread-badge">${room.unreadCount}</span>
                        </c:if>

                        <!-- 채팅방 삭제 버튼 -->
                        <button type="button"
                                class="chat-room-delete-btn"
                                data-room-id="${room.roomId}">
                            삭제
                        </button>
                    </div>
                </a>
            </c:forEach>

        </div>

        <!-- ============== 오른쪽: 채팅 상세 ============== -->
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
                            <!-- SOLD + CONFIRMED 인 경우에만 후기 버튼 노출 -->
                            <c:if test="${activeRoom.tradeStatus eq 'CONFIRMED' and product.status eq 'SOLD'}">
                                <c:choose>
                                    <c:when test="${hasReview}">
                                        <button type="button" class="btn-small btn-review-edit">후기 수정하기</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="btn-small btn-review">후기 남기기</button>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </div>
                    </div>

                    <!-- 거래 상태 배너 (판매자 요청 → 구매자 확정용) -->
                    <c:if test="${not empty activeRoom}">
                        <div id="tradeBanner"
                             data-room-id="${activeRoom.roomId}"
                             data-product-id="${activeRoom.productId}"
                             data-trade-status="${activeRoom.tradeStatus}"
                             data-is-buyer="${loginUser.userId == activeRoom.buyerId}"
                             style="padding:10px 16px; font-size:13px; border-bottom:1px solid #eee;
                                    background:#fff9e6; display:none;">
                            <!-- JS에서 내용 동적으로 채움 -->
                        </div>
                    </c:if>

                    <!-- 메시지 목록 -->
                    <div class="chat-messages" id="chatMessages">

                        <%-- 오늘 날짜 구분선 --%>
                        <jsp:useBean id="now" class="java.util.Date" />
                        <div class="date-divider">
                            <fmt:formatDate value="${now}" pattern="yyyy.MM.dd (E)" />
                        </div>

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
                                        <fmt:formatDate value="${msg.sentAt}" pattern="HH:mm" timeZone="Asia/Seoul" />
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

<!-- ================== 후기 모달 마크업 ================== -->
<c:if test="${not empty activeRoom}">
    <div id="reviewModal" class="review-modal">
        <div class="review-modal-inner">
            <button type="button" class="review-modal-close">&times;</button>

            <h3 style="margin:0 0 14px; font-size:15px;">
                <c:choose>
                    <c:when test="${hasReview}">후기 수정하기</c:when>
                    <c:otherwise>후기 남기기</c:otherwise>
                </c:choose>
            </h3>

            <div class="review-item-box">
                <div class="review-item-thumb">
                    <c:if test="${not empty activeRoom.productImageUrl}">
                        <img src="${ctx}${activeRoom.productImageUrl}" alt="상품 이미지">
                    </c:if>
                </div>
                <div>
                    <div class="review-item-info-title">
                        <c:out value="${activeRoom.productTitle}" />
                    </div>
                    <div class="review-item-info-price">
                        <fmt:formatNumber value="${activeRoom.price}" pattern="#,###" />원 ·
                        <c:out value="${activeRoom.opponentName}" default="거래상대" />님과의 거래
                    </div>
                </div>
            </div>

            <div class="review-question">거래는 전반적으로 만족스러우셨나요? (선택)</div>
            <div class="review-score-row">
                <button type="button" class="review-score-btn <c:if test='${myReview.rating == 1}'>active</c:if>" data-score="1">1</button>
                <button type="button" class="review-score-btn <c:if test='${myReview.rating == 2}'>active</c:if>" data-score="2">2</button>
                <button type="button" class="review-score-btn <c:if test='${myReview.rating == 3}'>active</c:if>" data-score="3">3</button>
                <button type="button" class="review-score-btn <c:if test='${myReview.rating == 4}'>active</c:if>" data-score="4">4</button>
                <button type="button" class="review-score-btn <c:if test='${myReview.rating == 5}'>active</c:if>" data-score="5">5</button>
            </div>
            <input type="hidden" id="reviewRating"
                   value="<c:out value='${myReview.rating}' default=''/>" />

            <div class="review-question">상대방과의 거래 후기를 남겨 주세요.</div>
            <textarea id="reviewContent"
                      class="review-textarea"
                      placeholder="예) 시간 약속을 잘 지켜 주셔서 편하게 거래할 수 있었습니다."><c:out value='${myReview.content}' /></textarea>

            <div class="review-modal-footer">
                <button type="button" id="btnReviewSubmit" class="btn-review-submit" disabled>
                    <c:choose>
                        <c:when test="${hasReview}">수정 완료</c:when>
                        <c:otherwise>등록하기</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </div>
    </div>
</c:if>

<!-- 플로팅 버튼 -->
<div class="floating-container">
    <button id="topBtn" class="floating-top">^<br><span>Top</span></button>
    <a href="${ctx}/product/add" class="floating-add">+</a>
</div>

<script>
    // Top 버튼
    document.getElementById("topBtn").addEventListener("click", function() {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });

    // ================== 채팅방 삭제 ==================
    (function() {
        const ctx = '${ctx}';
        const deleteButtons = document.querySelectorAll('.chat-room-delete-btn');

        deleteButtons.forEach(function(btn) {
            btn.addEventListener('click', function(e) {
                e.preventDefault();   // a 태그 이동 방지
                e.stopPropagation();  // 클릭 버블링 차단

                const roomId = this.dataset.roomId;
                if (!roomId) return;

                if (!confirm('이 채팅방을 삭제하시겠습니까?\n(대화 내용도 함께 삭제됩니다.)')) {
                    return;
                }

                fetch(ctx + '/chat/room/delete', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                    },
                    body: 'roomId=' + encodeURIComponent(roomId)
                })
                .then(res => res.json())
                .then(data => {
                    if (data.status === 'login_required') {
                        alert('로그인이 필요합니다.');
                        location.href = ctx + '/login';
                        return;
                    }
                    if (data.status !== 'success') {
                        alert(data.message || '채팅방 삭제 중 오류가 발생했습니다.');
                        return;
                    }

                    alert('채팅방이 삭제되었습니다.');
                    location.href = ctx + '/chat';
                })
                .catch(err => {
                    console.error(err);
                    alert('네트워크 오류가 발생했습니다.');
                });
            });
        });
    })();
</script>

<c:if test="${not empty activeRoom}">
<script>
(function() {
    const textarea = document.getElementById('messageText');
    const btnSend  = document.getElementById('btnSend');
    const form     = document.getElementById('chatForm');
    const msgBox   = document.getElementById('chatMessages');

    const ctx       = '${ctx}';
    const roomId    = '${activeRoom.roomId}';
    const productId = '${activeRoom.productId}';
    const productStatus = '${activeRoom.status}';

    // 거래 상태 / 역할 정보
    const bannerEl = document.getElementById('tradeBanner');
    let tradeStatus = 'NONE';
    let isBuyer     = false;

    if (bannerEl) {
        tradeStatus = bannerEl.dataset.tradeStatus || 'NONE';
        isBuyer     = (bannerEl.dataset.isBuyer === 'true');
    }

    if (msgBox) {
        msgBox.scrollTop = msgBox.scrollHeight;
    }

    if (!textarea || !btnSend || !form) return;

    // 거래 상태별 UI 제어
    if (tradeStatus === 'CONFIRMED' && productStatus === 'SOLD') {
        // 거래 완료: 채팅 차단
        textarea.disabled   = true;
        btnSend.disabled    = true;
        textarea.placeholder = '거래가 완료된 채팅방입니다. 추가 메세지는 보낼 수 없습니다.';
    } else if (tradeStatus === 'REQUESTED' && isBuyer && bannerEl) {
        // 판매자가 거래 확정을 요청했고, 내가 그 구매자일 때
        bannerEl.style.display        = 'flex';
        bannerEl.style.justifyContent = 'space-between';
        bannerEl.style.alignItems     = 'center';

        bannerEl.innerHTML =
            '<span>판매자가 거래 확정을 요청했습니다. 실제로 거래를 완료하셨다면 확정 버튼을 눌러 주세요.</span>' +
            '<button type="button" id="btnConfirmTrade" ' +
            ' style="margin-left:8px; padding:5px 10px; border-radius:999px; border:none;' +
            ' background:#ff8a00; color:#fff; font-size:12px; cursor:pointer;">' +
            '거래 확정하기</button>';

        const btnConfirmTrade = document.getElementById('btnConfirmTrade');
        btnConfirmTrade.addEventListener('click', function() {
            if (!confirm('이 채팅 상대와의 거래를 최종 확정하시겠습니까?\n' +
                         '확정 후에는 게시글이 판매완료로 변경됩니다.')) {
                return;
            }

            fetch(ctx + '/chat/confirmTradeByBuyer', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({
                    roomId: parseInt(roomId, 10),
                    productId: parseInt(productId, 10)
                })
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'login_required') {
                    alert('로그인이 필요합니다.');
                    location.href = ctx + '/login';
                    return;
                }
                if (data.status !== 'success') {
                    alert(data.message || '거래 확정 처리 중 오류가 발생했습니다.');
                    return;
                }

                alert('거래가 확정되었으며, 상품이 판매완료로 변경되었습니다.');
                location.reload();
            })
            .catch(err => {
                console.error(err);
                alert('서버 통신 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.');
            });
        });
    }

    function updateButton() {
        if (textarea.disabled) {
            btnSend.disabled = true;
            return;
        }
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
                location.reload();
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

    // ================== 후기 모달 JS ==================
    const hasReview = <c:out value="${hasReview}" default="false" />;

    const reviewModal        = document.getElementById('reviewModal');
    const btnOpenReview      = document.querySelector('.btn-review');
    const btnOpenReviewEdit  = document.querySelector('.btn-review-edit');
    const reviewCloseBtn     = reviewModal ? reviewModal.querySelector('.review-modal-close') : null;
    const reviewRatingInput  = reviewModal ? document.getElementById('reviewRating') : null;
    const reviewContentArea  = reviewModal ? document.getElementById('reviewContent') : null;
    const reviewScoreButtons = reviewModal ? reviewModal.querySelectorAll('.review-score-btn') : [];
    const btnReviewSubmit    = reviewModal ? document.getElementById('btnReviewSubmit') : null;

    function openReviewModal() {
        if (!reviewModal) return;
        reviewModal.classList.add('show');
    }
    function closeReviewModal() {
        if (!reviewModal) return;
        reviewModal.classList.remove('show');
    }

    if (btnOpenReview) {
        btnOpenReview.addEventListener('click', function() {
            // 새 작성: 값 초기화
            if (reviewRatingInput) reviewRatingInput.value = '';
            if (reviewContentArea) reviewContentArea.value = '';
            reviewScoreButtons.forEach(function(b){ b.classList.remove('active'); });
            openReviewModal();
            updateReviewSubmitButton();
        });
    }

    if (btnOpenReviewEdit) {
        btnOpenReviewEdit.addEventListener('click', function() {
            // 서버에서 이미 값이 채워진 상태이므로 그대로 오픈
            openReviewModal();
            updateReviewSubmitButton();
        });
    }

    if (reviewCloseBtn) {
        reviewCloseBtn.addEventListener('click', closeReviewModal);
    }
    if (reviewModal) {
        reviewModal.addEventListener('click', function(e) {
            if (e.target === reviewModal) {
                closeReviewModal();
            }
        });
    }

    reviewScoreButtons.forEach(function(btn) {
        btn.addEventListener('click', function() {
            const score = this.dataset.score;
            if (reviewRatingInput) {
                reviewRatingInput.value = score;
            }
            reviewScoreButtons.forEach(function(b){ b.classList.remove('active'); });
            this.classList.add('active');
            updateReviewSubmitButton();
        });
    });

    if (reviewContentArea) {
        reviewContentArea.addEventListener('input', updateReviewSubmitButton);
    }

    function updateReviewSubmitButton() {
        if (!btnReviewSubmit) return;
        const ratingVal  = reviewRatingInput ? reviewRatingInput.value.trim() : '';
        const contentVal = reviewContentArea ? reviewContentArea.value.trim() : '';

        // 별점은 선택 사항, 내용은 필수
        btnReviewSubmit.disabled = !(contentVal.length > 0);
    }

    if (btnReviewSubmit) {
        btnReviewSubmit.addEventListener('click', function() {
            if (!reviewContentArea) return;

            const content = reviewContentArea.value.trim();
            if (!content) {
                alert('후기 내용을 입력해 주세요.');
                return;
            }
            const ratingVal = reviewRatingInput ? reviewRatingInput.value.trim() : '';

            const payload = {
                dealId: parseInt(roomId, 10),
                content: content
            };
            if (ratingVal) {
                payload.rating = parseInt(ratingVal, 10);
            }

            fetch(ctx + '/chat/review/save', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'login_required') {
                    alert('로그인이 필요합니다.');
                    location.href = ctx + '/login';
                    return;
                }
                if (data.status !== 'success') {
                    alert(data.message || '후기 저장 중 오류가 발생했습니다.');
                    return;
                }

                alert('후기가 저장되었습니다.');
                closeReviewModal();
                location.reload();
            })
            .catch(err => {
                console.error(err);
                alert('서버 통신 중 오류가 발생했습니다.');
            });
        });
    }

    updateButton();
})();
</script>
</c:if>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
