<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${month}월 대여 통계</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background: linear-gradient(160deg, #0f172a 0%, #1e293b 50%, #334155 100%);
    font-family: 'Inter', 'Noto Sans KR', sans-serif;
    min-height: 100vh;
    padding: 40px 20px;
    position: relative;
    overflow-x: hidden;
}

/* 배경 장식 */
body::before {
    content: '';
    position: fixed;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle at 20% 80%, rgba(59, 130, 246, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(139, 92, 246, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(16, 185, 129, 0.05) 0%, transparent 40%);
    pointer-events: none;
    z-index: 0;
}

.container {
    max-width: 1100px;
    margin: 0 auto;
    position: relative;
    z-index: 1;
}

/* 헤더 */
.page-header {
    text-align: center;
    margin-bottom: 40px;
}

.page-header h1 {
    font-size: 42px;
    font-weight: 900;
    background: linear-gradient(135deg, #fff 0%, #94a3b8 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 12px;
    letter-spacing: -1px;
}

.page-header p {
    color: #64748b;
    font-size: 16px;
    font-weight: 500;
}

/* 요약 카드 */
.summary-container {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 24px;
    margin-bottom: 40px;
}

.summary-card {
    background: rgba(255, 255, 255, 0.03);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    padding: 32px;
    border-radius: 24px;
    border: 1px solid rgba(255, 255, 255, 0.08);
    display: flex;
    align-items: center;
    gap: 24px;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
}

.summary-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 3px;
    border-radius: 24px 24px 0 0;
}

.summary-card.income-card::before {
    background: linear-gradient(90deg, #3b82f6, #06b6d4);
}

.summary-card.expense-card::before {
    background: linear-gradient(90deg, #f43f5e, #f97316);
}

.summary-card:hover {
    transform: translateY(-6px) scale(1.02);
    border-color: rgba(255, 255, 255, 0.15);
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
}

.summary-icon {
    width: 72px;
    height: 72px;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32px;
    flex-shrink: 0;
    position: relative;
}

.summary-icon.income {
    background: linear-gradient(135deg, #3b82f6 0%, #06b6d4 100%);
    box-shadow: 0 8px 24px rgba(59, 130, 246, 0.4);
}

.summary-icon.expense {
    background: linear-gradient(135deg, #f43f5e 0%, #f97316 100%);
    box-shadow: 0 8px 24px rgba(244, 63, 94, 0.4);
}

.summary-content {
    flex: 1;
}

.summary-label {
    font-size: 13px;
    color: #64748b;
    font-weight: 600;
    margin-bottom: 8px;
    text-transform: uppercase;
    letter-spacing: 1.5px;
}

.summary-value {
    font-size: 32px;
    font-weight: 800;
    letter-spacing: -1px;
}

.summary-value.income {
    background: linear-gradient(135deg, #3b82f6, #06b6d4);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.summary-value.expense {
    background: linear-gradient(135deg, #f43f5e, #f97316);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* 캘린더 */
.calendar-wrapper {
    background: rgba(255, 255, 255, 0.03);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    padding: 40px;
    border-radius: 32px;
    border: 1px solid rgba(255, 255, 255, 0.08);
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
}

.calendar-header {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 20px;
    margin-bottom: 36px;
    padding-bottom: 24px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.calendar-title {
    font-size: 28px;
    font-weight: 800;
    color: #fff;
    letter-spacing: -0.5px;
}

.calendar-badge {
    background: linear-gradient(135deg, #8b5cf6 0%, #6366f1 100%);
    color: white;
    padding: 8px 18px;
    border-radius: 30px;
    font-size: 13px;
    font-weight: 700;
    box-shadow: 0 4px 15px rgba(139, 92, 246, 0.4);
}

/* 요일 헤더 */
.week-header {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    text-align: center;
    font-weight: 700;
    padding: 16px 0 20px 0;
    font-size: 12px;
    color: #64748b;
    text-transform: uppercase;
    letter-spacing: 2px;
}

.week-header div:first-child {
    color: #f87171;
}

.week-header div:last-child {
    color: #60a5fa;
}

/* 날짜 그리드 */
.calendar-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 12px;
}

.day-box {
    background: rgba(255, 255, 255, 0.02);
    border-radius: 16px;
    padding: 14px 12px;
    min-height: 110px;
    border: 1px solid rgba(255, 255, 255, 0.05);
    position: relative;
    font-size: 13px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    cursor: pointer;
}

.day-box:hover {
    background: rgba(255, 255, 255, 0.06);
    transform: translateY(-4px) scale(1.02);
    border-color: rgba(139, 92, 246, 0.3);
    box-shadow: 0 12px 30px rgba(139, 92, 246, 0.15);
}

.date-num {
    font-weight: 700;
    font-size: 18px;
    color: #e2e8f0;
    margin-bottom: 10px;
}

/* 오늘 날짜 */
.today {
    background: linear-gradient(135deg, rgba(139, 92, 246, 0.15) 0%, rgba(99, 102, 241, 0.1) 100%) !important;
    border: 2px solid rgba(139, 92, 246, 0.5) !important;
    box-shadow: 0 8px 30px rgba(139, 92, 246, 0.25);
}

.today .date-num {
    background: linear-gradient(135deg, #a78bfa, #818cf8);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.today::before {
    content: 'TODAY';
    position: absolute;
    top: 8px;
    right: 8px;
    background: linear-gradient(135deg, #8b5cf6 0%, #6366f1 100%);
    color: white;
    font-size: 8px;
    font-weight: 800;
    padding: 3px 8px;
    border-radius: 8px;
    letter-spacing: 1px;
    box-shadow: 0 2px 8px rgba(139, 92, 246, 0.4);
}

/* 금액 표시 */
.amount-income {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-weight: 700;
    color: #22d3ee;
    background: rgba(34, 211, 238, 0.15);
    padding: 5px 10px;
    border-radius: 10px;
    font-size: 11px;
    margin-top: 6px;
    border: 1px solid rgba(34, 211, 238, 0.2);
}

.amount-income::before {
    content: '▲';
    font-size: 8px;
}

.amount-expense {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-weight: 700;
    color: #fb7185;
    background: rgba(251, 113, 133, 0.15);
    padding: 5px 10px;
    border-radius: 10px;
    font-size: 11px;
    margin-top: 6px;
    border: 1px solid rgba(251, 113, 133, 0.2);
}

.amount-expense::before {
    content: '▼';
    font-size: 8px;
}

/* 빈 날짜 */
.empty-day {
    background: transparent;
    border: none;
}

/* 애니메이션 */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.summary-card, .calendar-wrapper {
    animation: fadeInUp 0.6s ease-out forwards;
}

.summary-card:nth-child(2) {
    animation-delay: 0.1s;
}

.calendar-wrapper {
    animation-delay: 0.2s;
}

/* 반응형 */
@media (max-width: 768px) {
    body {
        padding: 24px 16px;
    }
    
    .page-header h1 {
        font-size: 28px;
    }
    
    .summary-container {
        grid-template-columns: 1fr;
        gap: 16px;
    }
    
    .summary-card {
        padding: 24px;
    }
    
    .summary-value {
        font-size: 26px;
    }
    
    .calendar-wrapper {
        padding: 24px 16px;
        border-radius: 24px;
    }
    
    .calendar-title {
        font-size: 22px;
    }
    
    .calendar-grid {
        gap: 8px;
    }
    
    .day-box {
        min-height: 90px;
        padding: 10px 8px;
        border-radius: 12px;
    }
    
    .date-num {
        font-size: 15px;
    }
    
    .amount-income,
    .amount-expense {
        font-size: 9px;
        padding: 3px 6px;
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
        <div class="summary-card income-card">
            <div class="summary-icon income">
                <span>📈</span>
            </div>
            <div class="summary-content">
                <div class="summary-label">이번 달 수입</div>
                <div class="summary-value income">+${earned}원</div>
            </div>
        </div>

        <div class="summary-card expense-card">
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
