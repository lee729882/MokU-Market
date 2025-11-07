<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>목유마켓 로그인</title>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f8f8;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.login-container {
    background-color: #fff;
    width: 420px;
    border-radius: 22px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
    overflow: hidden;
    animation: fadeIn 0.6s ease-in-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* ✅ 헤더: 학교 색상 적용 */
.header {
    background-color: #007A5C; /* 목포대 청록 */
    padding: 45px 20px 25px;
    text-align: center;
}

.header img {
    width: 85px;
    height: 85px;
    object-fit: contain;
    margin-bottom: 12px;
    border-radius: 10px;
}

.header h1 {
    color: #fff;
    font-size: 27px;
    font-weight: 700;
    margin: 0;
}

/* ✅ 폼 */
.form {
    padding: 30px 35px 40px;
}

.form h2 {
    text-align: center;
    font-size: 20px;
    color: #222;
    margin-bottom: 25px;
    font-weight: 600;
}

/* ✅ 입력창 디자인 통일 */
.form input[type="email"],
.form input[type="password"] {
    width: 100%;
    box-sizing: border-box;
    padding: 13px 15px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 10px;
    font-size: 14px;
    transition: 0.2s;
}

.form input:focus {
    outline: none;
    border-color: #00A67E; /* 민트색 포커스 */
    box-shadow: 0 0 6px rgba(0, 166, 126, 0.3);
}

/* ✅ 로그인 버튼 */
.form button.login-btn {
    width: 100%;
    background-color: #00A67E;
    border: none;
    color: #fff;
    font-size: 16px;
    font-weight: 700;
    border-radius: 12px;
    padding: 13px 0;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 10px;
    box-shadow: 0 3px 0 #007A5C;
}

.form button.login-btn:hover {
    background-color: #007A5C;
    box-shadow: 0 2px 0 #005E48;
    transform: translateY(-2px);
}

/* ✅ 옵션 (체크박스, 비밀번호 찾기) */
.options {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 12px;
    font-size: 13px;
    color: #666;
}

.options input[type="checkbox"] {
    accent-color: #00A67E;
}

/* ✅ 하단 회원가입 링크 */
.signup {
    text-align: center;
    margin-top: 25px;
    font-size: 14px;
    color: #333;
}

.signup a {
    color: #00A67E;
    font-weight: 600;
    text-decoration: none;
}

.signup a:hover {
    text-decoration: underline;
}
</style>
</head>

<body>
<div class="login-container">
    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/images/mokyu_logo.png" alt="목유마켓 로고">
        <h1>목유마켓</h1>
    </div>

    <div class="form">
        <h2>로그인</h2>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <input type="email" name="email" placeholder="이메일 주소를 입력해주세요" required>
            <input type="password" name="password" placeholder="비밀번호를 입력해주세요" required>
            <button type="submit" class="login-btn">로그인</button>

            <div class="options">
                <label><input type="checkbox" name="remember"> Remember Me</label>
                <a href="#">비밀번호 찾기</a>
            </div>
        </form>

        <div class="signup">
            아직 회원이 아니신가요?
            <a href="${pageContext.request.contextPath}/signup">회원가입</a>
        </div>
    </div>
</div>
</body>
</html>
