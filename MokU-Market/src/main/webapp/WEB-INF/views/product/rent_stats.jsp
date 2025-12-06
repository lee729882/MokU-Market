<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${month}월 대여 통계</title>

<style>
body {
    background:#eef2f5;
    font-family: 'Noto Sans KR', sans-serif;
    margin:0;
    padding:25px;
}

/* 상단 요약 박스 */
.summary-box {
    width:700px;
    margin:0 auto 30px auto;
    background:white;
    padding:25px;
    border-radius:14px;
    text-align:center;
    box-shadow:0 3px 12px rgba(0,0,0,0.12);
}

.summary-title {
    font-size:28px;
    font-weight:700;
    margin-bottom:15px;
}

.stat {
    font-size:20px;
    margin:12px 0;
}

.earned { color:#007AFF; font-weight:bold; }
.spent  { color:#FF3B30; font-weight:bold; }

/* 캘린더 전체 */
.calendar-wrapper {
    width:900px;
    margin:0 auto;
    background:white;
    padding:25px;
    border-radius:14px;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
}

/* 요일 헤더 */
.week-header {
    display:grid;
    grid-template-columns:repeat(7, 1fr);
    text-align:center;
    font-weight:700;
    padding-bottom:10px;
    font-size:16px;
    color:#666;
}

/* 날짜 셀 */
.calendar-grid {
    display:grid;
    grid-template-columns:repeat(7, 1fr);
    gap:12px;
}

.day-box {
    background:#fafafa;
    border-radius:10px;
    padding:8px;
    height:110px;
    border:1px solid #e4e4e4;
    position:relative;
    font-size:13px;
    transition:0.15s ease-in-out;
}

.day-box:hover {
    background:#f0f8ff;
    transform:scale(1.02);
}

/* 날짜 숫자 */
.date-num {
    font-weight:700;
    font-size:15px;
    margin-bottom:6px;
}

/* 오늘 날짜 강조 */
.today {
    border:2px solid #007AFF !important;
    background:#eaf3ff !important;
}

/* 금액 스타일 */
.amount-income {
    font-weight:bold;
    color:#007AFF;
    margin-top:5px;
}
.amount-expense {
    font-weight:bold;
    color:#FF3B30;
    margin-top:3px;
}
</style>

</head>
<body>

<!-- 📌 요약 -->
<div class="summary-box">
    <div class="summary-title">📊 ${month}월 대여 통계</div>

    <div class="stat">
        🟦 이번 달 벌어들인 금액:
        <span class="earned">+${earned} 원</span>
    </div>

    <div class="stat">
        🟥 이번 달 사용한 금액:
        <span class="spent">-${spent} 원</span>
    </div>
</div>


<!-- 📅 달력 -->
<div class="calendar-wrapper">

    <div class="week-header">
        <div style="color:#FF3B30;">일</div>
        <div>월</div><div>화</div><div>수</div>
        <div>목</div><div>금</div>
        <div style="color:#007AFF;">토</div>
    </div>

    <div class="calendar-grid">

        <!-- 빈칸 (월 시작 요일 이전) -->
        <c:forEach var="i" begin="1" end="${startBlank}">
            <div></div>
        </c:forEach>

        <!-- 실제 날짜 렌더링 -->
        <c:forEach var="day" begin="1" end="${lastDay}">
            <c:set var="inc" value="${dailyEarned[day]}" />
            <c:set var="out" value="${dailySpent[day]}" />

            <!-- 오늘 날짜 체크 -->
            <c:set var="isToday"
                   value="${currentYear == year && currentMonth == month && currentDay == day}" />

            <div class="day-box ${isToday ? 'today' : ''}">
                <div class="date-num">${day}</div>

                <!-- 수입 -->
                <c:if test="${inc > 0}">
                    <div class="amount-income">+${inc}</div>
                </c:if>

                <!-- 지출 -->
                <c:if test="${out > 0}">
                    <div class="amount-expense">-${out}</div>
                </c:if>
            </div>
        </c:forEach>

    </div>
</div>

</body>
</html>
