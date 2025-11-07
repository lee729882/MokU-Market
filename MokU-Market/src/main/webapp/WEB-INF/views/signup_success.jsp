<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입 완료 - 목유마켓</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f8f8;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* ✅ 수직 중앙 정렬 */
        margin: 0;
    }

    .container {
        background: #fff;
        width: 400px;
        text-align: center;
        padding: 40px 30px;
        border-radius: 18px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        animation: fadeIn 0.6s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(15px); }
        to { opacity: 1; transform: translateY(0); }
    }

    h2 {
        color: #007A5C;
        font-size: 24px;
        margin-bottom: 18px;
    }

    p {
        font-size: 16px;
        color: #333;
        margin: 10px 0;
    }

    strong {
        color: #007A5C;
    }

    button {
        margin-top: 25px;
        background-color: #00A67E;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    button:hover {
        background-color: #007A5C;
        transform: translateY(-2px);
    }
</style>
</head>

<body>
<div class="container">
    <h2>🎉 회원가입 완료!</h2>
    <p><strong>${name}</strong> 님, 환영합니다 🎈</p>
    <p>가입하신 이메일: <strong>${email}</strong></p>
    <button onclick="location.href='${pageContext.request.contextPath}/login'">
        로그인 페이지로 이동
    </button>
</div>
</body>
</html>
