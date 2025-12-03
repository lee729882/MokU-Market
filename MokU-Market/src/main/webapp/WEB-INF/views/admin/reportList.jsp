<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,300..700,0..1,-50..200" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 관리 - 관리자</title>

    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap"
          rel="stylesheet">

    <style>
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Nanum Gothic', sans-serif;
            background-color: #f5f5f5;
        }

        .admin-container {
            max-width: 1100px;
            margin: 40px auto 60px;
            padding: 0 20px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 18px;
        }

        .sub-text {
            font-size: 13px;
            color: #777;
            margin-bottom: 18px;
        }

        .filter-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .filter-left {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 13px;
        }

        .filter-left select {
            padding: 5px 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 13px;
        }

        .filter-right {
            font-size: 13px;
            color: #555;
        }

        .card {
            background-color: #fff;
            border-radius: 12px;
            padding: 16px 18px;
            box-shadow: 0 2px 7px rgba(0,0,0,0.08);
        }

        table.report-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        .report-table thead tr {
            background-color: #f0f0f0;
        }

        .report-table th,
        .report-table td {
            padding: 8px 6px;
            border-bottom: 1px solid #e5e5e5;
            text-align: center;
        }

        .report-table th {
            font-weight: 700;
        }

        .report-table tbody tr:hover {
            background-color: #fafafa;
        }

        .text-left {
            text-align: left;
        }

        .ellipsis {
            max-width: 320px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .badge-status {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 700;
            color: #fff;
        }
        .badge-new { background-color: #ff4d4d; }
        .badge-progress { background-color: #f39c12; }
        .badge-done { background-color: #2ecc71; }

        .btn-small {
            padding: 4px 10px;
            border-radius: 999px;
            border: 1px solid transparent;
            font-size: 12px;
            cursor: pointer;
            background-color: #fff;
        }

        .btn-small-primary {
            border-color: #007a5c;
            color: #007a5c;
        }
        .btn-small-primary:hover {
            background-color: #e6fff7;
        }

        .btn-small-muted {
            border-color: #ccc;
            color: #aaa;
            cursor: default;
        }

        .empty-row {
            text-align: center;
            padding: 30px 0;
            color: #999;
            font-size: 13px;
        }
                /* 페이지 전체 래퍼 (헤더 아래 내용) */
        .page-wrapper {
            max-width: 1200px;
            margin: 0 auto;
        }
        
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />


    
<div class="admin-container">
    <!-- ✅ 헤더 아래 실제 메인 콘텐츠 -->
    <div class="page-wrapper">
    <!-- 제목/설명 -->
    <div class="page-title">신고 관리</div>
    <div class="sub-text">
        이용자가 접수한 신고 목록입니다. 상태를 확인하시고 필요 시 조치 후 <b>처리완료</b>로 변경해 주십시오.
    </div>

    <!-- 필터 박스 -->
    <div class="filter-box">
        <form method="get" action="${ctx}/admin/report/list" class="filter-left">
            <span>상태 필터</span>
            <select name="status" onchange="this.form.submit()">
                <option value="">전체</option>
                <option value="NEW" <c:if test="${status eq 'NEW'}">selected</c:if>>NEW (신규)</option>
                <option value="IN_PROGRESS" <c:if test="${status eq 'IN_PROGRESS'}">selected</c:if>>
                    IN_PROGRESS (처리중)
                </option>
                <option value="DONE" <c:if test="${status eq 'DONE'}">selected</c:if>>DONE (처리완료)</option>
            </select>
        </form>

        <div class="filter-right">
        </div>
    </div>

    <!-- 신고 목록 카드 -->
    <div class="card">
        <table class="report-table">
            <thead>
            <tr>
                <th style="width:60px;">ID</th>
                <th style="width:90px;">신고자ID</th>
                <th style="width:90px;">대상유저ID</th>
                <th style="width:70px;">상품ID</th>
                <th style="width:70px;">게시글ID</th>
                <th style="width:80px;">채팅방ID</th>
                <th style="width:85px;">유형</th>
                <th>내용</th>
                <th style="width:90px;">상태</th>
                <th style="width:110px;">처리자/시각</th>
                <th style="width:70px;">조치</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty reports}">
                <tr>
                    <td colspan="11" class="empty-row">
                        등록된 신고가 없습니다.
                    </td>
                </tr>
            </c:if>

            <c:forEach var="r" items="${reports}">
                <tr>
                    <td>${r.reportId}</td>
                    <td>${r.reporterId}</td>
                    <td>${r.targetUserId}</td>
                    <td>${r.productId}</td>
                    <td>${r.postId}</td>
                    <td>${r.chatRoomId}</td>
                    <td>${r.reasonType}</td>
                    <td class="text-left">
                        <div class="ellipsis" title="${r.description}">
                            <c:out value="${r.description}" />
                        </div>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${r.status eq 'NEW'}">
                                <span class="badge-status badge-new">NEW</span>
                            </c:when>
                            <c:when test="${r.status eq 'IN_PROGRESS'}">
                                <span class="badge-status badge-progress">IN_PROGRESS</span>
                            </c:when>
                            <c:when test="${r.status eq 'DONE'}">
                                <span class="badge-status badge-done">DONE</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge-status badge-progress">${r.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${r.processedBy != null}">
                            관리자 ${r.processedBy}<br/>
                            <fmt:formatDate value="${r.processedAt}" pattern="MM/dd HH:mm"/>
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${r.status eq 'DONE'}">
                                <button type="button"
                                        class="btn-small btn-small-muted"
                                        disabled>
                                    완료
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button"
                                        class="btn-small btn-small-primary"
                                        onclick="resolveReport(${r.reportId})">
                                    처리완료
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>

</div>

<script>
    const ctx = '${ctx}';

    function resolveReport(reportId) {
        if (!confirm('해당 신고를 처리완료(DONE) 상태로 변경하시겠습니까?')) {
            return;
        }

        fetch(ctx + '/admin/report/resolve', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            body: 'reportId=' + encodeURIComponent(reportId)
        })
            .then(function (res) {
                return res.json();
            })
            .then(function (data) {
                if (data.status === 'success') {
                    alert('처리완료로 변경되었습니다.');
                    location.reload();
                } else if (data.status === 'forbidden') {
                    alert('권한이 없습니다. 관리자 계정으로 로그인해 주십시오.');
                } else {
                    alert(data.message || '처리 중 오류가 발생했습니다.');
                }
            })
            .catch(function (err) {
                console.error(err);
                alert('서버 통신 중 오류가 발생했습니다.');
            });
    }
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/recentProducts.jsp" />

</body>
</html>
