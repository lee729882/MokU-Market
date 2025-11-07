<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>목유마켓 로그인</title>

<!-- ✅ 폰트: Jua (둥글고 귀여운 손글씨체) + Nanum Gothic -->
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Nanum Gothic', sans-serif;
    background-color: #f7f8f9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.login-container {
    background: #fff;
    width: 380px;
    border-radius: 22px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    text-align: center;
}

/* ✅ 상단 헤더 영역 */
.header {
    background-color: #007A5C;
    padding: 25px 0 10px; /* 상단/하단 여백 줄임 */
    border-bottom: 1px solid #eaeaea;
}
.header img {
    width: 75px;
    height: 75px;
    border-radius: 50%;        /* ✅ 완전 동그라미 */
    object-fit: cover;         /* 비율 유지 */
    background-color: #fff;    /* 테두리 대비 */
    padding: 5px;              /* 안쪽 여백으로 여유감 */
    box-shadow: 0 0 5px rgba(0,0,0,0.1); /* 은은한 그림자 효과 */
}


/* ✅ '목유마켓' 로고 텍스트 */
.header h1 {
    font-family: 'Jua', sans-serif;
    font-size: 28px;
    color: #007A5C; /* 본 글자색 */
    margin-top: 8px;
    margin-bottom: 2px; /* 아래 여백 줄임 */
    letter-spacing: 1px;
    text-shadow:
        -1.5px -1.5px 0 #ffffff,
         1.5px -1.5px 0 #ffffff,
        -1.5px  1.5px 0 #ffffff,
         1.5px  1.5px 0 #ffffff; /* 흰색 외곽선 효과 */
}

/* ✅ 로그인 폼 */
.form {
    padding: 18px 35px 30px;
}
.form h2 {
    font-size: 19px;
    color: #222;
    margin-bottom: 15px;
    font-weight: 700;
}

input[type="text"], input[type="password"] {
    width: 100%;
    box-sizing: border-box;
    padding: 13px 15px;
    margin-bottom: 10px;
    border: 1px solid #ddd;
    border-radius: 12px;
    font-size: 14px;
    transition: 0.2s;
}
input[type="text"]:focus, input[type="password"]:focus {
    border-color: #00A67E;
    outline: none;
}

/* ✅ 로그인 버튼 */
button.login-btn {
    width: 100%;
    background-color: #00A67E;
    color: #fff;
    border: none;
    border-radius: 12px;
    font-size: 15px;
    font-weight: 700;
    padding: 12px 0;
    margin-top: 6px;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}
button.login-btn:hover {
    background-color: #008a6b;
    transform: translateY(-1.5px);
}

/* ✅ 옵션 (Remember me / 비밀번호 찾기) */
.options {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 13px;
    margin-top: 8px;
    color: #555;
}
.options label {
    display: flex;
    align-items: center;
    gap: 5px;
}
.options a {
    text-decoration: none;
    color: #007A5C;
}
.options a:hover {
    text-decoration: underline;
}

/* ✅ 회원가입 링크 */
.signup-link {
    margin-top: 18px;
    font-size: 14px;
    color: #444;
}
.signup-link a {
    color: #00A67E;
    text-decoration: none;
    font-weight: 600;
}
.signup-link a:hover {
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
            <input type="text" name="email" placeholder="이메일 주소를 입력해주세요" required>
            <input type="password" name="password" placeholder="비밀번호를 입력해주세요" required>
            <button type="submit" class="login-btn">로그인</button>

            <div class="options">
                <label><input type="checkbox"> Remember Me</label>
                <a href="#">비밀번호 찾기</a>
            </div>

            <div class="signup-link">
                아직 회원이 아니신가요? 
                <a href="${pageContext.request.contextPath}/signup">회원가입</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
