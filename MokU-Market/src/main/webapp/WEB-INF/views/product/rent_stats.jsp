<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${month}월 대여 통계</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    font-family: 'Inter', 'Noto Sans KR', sans-serif;
    min-height: 100vh;
    padding: 40px 20px;
}

/* 컨테이너 */
.container {
    max-width: 1000px;
    margin: 0 auto;
}

/* 헤더 */
.page-header {
    text-align: center;
    margin-bottom: 32px;
}

.page-header h1 {
    font-size: 32px;
    font-weight: 800;
    background: linear-gradient(135deg, #1e293b 0%, #475569 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 8px;
}

.page-header p {
    color: #64748b;
    font-size: 14px;
}

/* 상단 요약 카드 */
.summary-container {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
    margin-bottom: 32px;
}

.summary-card {
    background: white;
    padding: 28px;
    border-radius: 20px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.06);
    display: flex;
    align-items: center;
    gap: 20px;
    transition: all 0.3s ease;
    border: 1px solid #f1f5f9;
}

.summary-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 32px rgba(0,0,0,0.1);
}

.summary-icon {
    width: 64px;
    height: 64px;
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    flex-shrink: 0;
}

.summary-icon.income {
    background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
}

.summary-icon.expense {
    background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
}

.summary-content {
    flex: 1;
}

.summary-label {
    font-size: 13px;
    color: #64748b;
    font-weight: 500;
    margin-bottom: 6px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.summary-value {
    font-size: 28px;
    font-weight: 700;
}

.summary-value.income {
    color: #2563eb;
}

.summary-value.expense {
    color: #dc2626;
}

/* 캘린더 전체 */
.calendar-wrapper {
    background: white;
    padding: 32px;
    border-radius: 24px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    border: 1px solid #f1f5f9;
}

.calendar-header {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 16px;
    margin-bottom: 28px;
    padding-bottom: 20px;
    border-bottom: 2px solid #f1f5f9;
}

.calendar-title {
    font-size: 24px;
    font-weight: 700;
    color: #1e293b;
}

.calendar-badge {
    background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
    color: white;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}

/* 요일 헤더 */
.week-header {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    text-align: center;
    font-weight: 600;
    padding: 12px 0 16px 0;
    font-size: 13px;
    color: #94a3b8;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.week-header div:first-child {
    color: #f87171;
}

.week-header div:last-child {
    color: #60a5fa;
}

/* 날짜 셀 */
.calendar-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 10px;
}

.day-box {
    background: linear-gradient(135deg, #fafafa 0%, #f5f5f5 100%);
    border-radius: 14px;
    padding: 12px 10px;
    min-height: 100px;
    border: 1px solid #e5e7eb;
    position: relative;
    font-size: 13px;
    transition: all 0.25s ease;
    cursor: pointer;
}

.day-box:hover {
    background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(59, 130, 246, 0.12);
    border-color: #93c5fd;
}

/* 날짜 숫자 */
.date-num {
    font-weight: 700;
    font-size: 16px;
    color: #334155;
    margin-bottom: 8px;
}

/* 오늘 날짜 강조 */
.today {
    background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%) !important;
    border: 2px solid #3b82f6 !important;
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.2);
}

.today .date-num {
    color: #2563eb;
}

.today::before {
    content: '오늘';
    position: absolute;
    top: 6px;
    right: 6px;
    background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
    color: white;
    font-size: 9px;
    font-weight: 600;
    padding: 2px 6px;
    border-radius: 6px;
}

/* 금액 스타일 */
.amount-income {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-weight: 600;
    color: #2563eb;
    background: #dbeafe;
    padding: 4px 8px;
    border-radius: 8px;
    font-size: 11px;
    margin-top: 4px;
}

.amount-income::before {
    content: '↑';
    font-size: 10px;
}

.amount-expense {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-weight: 600;
    color: #dc2626;
    background: #fee2e2;
    padding: 4px 8px;
    border-radius: 8px;
    font-size: 11px;
    margin-top: 4px;
}

.amount-expense::before {
    content: '↓';
    font-size: 10px;
}

/* 빈 날짜 */
.empty-day {
    background: transparent;
    border: none;
}

/* 반응형 */
@media (max-width: 768px) {
    .summary-container {
        grid-template-columns: 1fr;
    }
    
    .calendar-wrapper {
        padding: 20px 16px;
    }
    
    .calendar-grid {
        gap: 6px;
    }
    
    .day-box {
        min-height: 80px;
        padding: 8px 6px;
    }
    
    .date-num {
        font-size: 14px;
    }
    
    .amount-income,
    .amount-expense {
        font-size: 9px;
        padding: 3px 5px;
    }
}
</style>

</head>
<body>

<div class="container">
    <!-- 헤더 -->
    <div class="page-header">
        <h1>대여 통계</h1>
        <p>월별 수입과 지출을 한눈에 확인하세요</p>
    </div>

    <!-- 요약 카드 -->
    <div class="summary-container">
        <div class="summary-card">
            <div class="summary-icon income">
                <span>📈</span>
            </div>
            <div class="summary-content">
                <div class="summary-label">이번 달 수입</div>
                <div class="summary-value income">+${earned}원</div>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon expense">
                <span>📉</span>
            </div>
            <div class="summary-content">
                <div class="summary-label">이번 달 지출</div>
                <div class="summary-value expense">-${spent}원</div>
            </div>
        </div>
    </div>

    <!-- 캘린더 -->
    <div class="calendar-wrapper">
        <div class="calendar-header">
            <div class="calendar-title">${month}월 캘린더</div>
            <div class="calendar-badge">${year}년</div>
        </div>

        <div class="week-header">
            <div>일</div>
            <div>월</div>
            <div>화</div>
            <div>수</div>
            <div>목</div>
            <div>금</div>
            <div>토</div>
        </div>

        <div class="calendar-grid">
            <!-- 빈칸 (월 시작 요일 이전) -->
            <c:forEach var="i" begin="1" end="${startBlank}">
                <div class="empty-day"></div>
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
</div>

</body>
</html>
