<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 - 목유마켓</title>
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
.container {
    background: #fff;
    width: 420px;
    border-radius: 22px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    text-align: center;
}

/* ✅ 상단 헤더 */
.header {
    background-color: #007A5C;
    padding: 25px 0 10px;
}
.header img {
    width: 85px;
    height: 85px;
    border-radius: 50%;
    background-color: #fff;
    padding: 6px;
    box-shadow: 0 0 5px rgba(0,0,0,0.1);
}
.header h1 {
    font-family: 'Jua', sans-serif;
    font-size: 28px;
    color: #007A5C;
    margin-top: 6px;
    margin-bottom: 2px;
    letter-spacing: 1px;
    text-shadow:
        -1.5px -1.5px 0 #ffffff,
         1.5px -1.5px 0 #ffffff,
        -1.5px  1.5px 0 #ffffff,
         1.5px  1.5px 0 #ffffff;
}

/* ✅ 폼 영역 */
.form {
    padding: 15px 35px 30px;
}
.form h2 {
    font-size: 21px;
    color: #222;
    margin-bottom: 20px;
    font-weight: 700;
}

/* ✅ 입력 필드 공통 스타일 */
.form input[type="email"],
.form input[type="text"],
.form input[type="password"] {
    width: 100%;
    box-sizing: border-box;
    padding: 13px 15px;
    margin-bottom: 14px;
    border: 1px solid #ddd;
    border-radius: 12px;
    font-size: 14px;
    transition: 0.2s;
}
.form input:focus {
    border-color: #00A67E;
    outline: none;
}

/* ✅ 인증코드 전송/확인 그룹 */
.auth-group {
    display: flex;
    align-items: stretch;
    gap: 10px;
    margin-bottom: 14px;
}
.auth-group input {
    flex: 1.3; /* ✅ 입력칸 살짝 늘림 */
    height: 46px;
    border-radius: 12px;
    padding: 13px 15px;
    border: 1px solid #ddd;
    font-size: 14px;
}
.auth-group button {
    width: 105px; /* ✅ 버튼 너비 살짝 줄임 */
    height: 46px;
    background-color: #00A67E;
    color: #fff;
    border: none;
    border-radius: 12px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.2s;
}
.auth-group button:hover {
    background-color: #008a6b;
    transform: translateY(-1px);
}

/* ✅ 비밀번호 변경 버튼 */
button.reset-btn {
    width: 100%;
    background-color: #00A67E;
    color: #fff;
    border: none;
    border-radius: 12px;
    padding: 13px 0;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
    transition: 0.2s;
}
button.reset-btn:hover {
    background-color: #008a6b;
    transform: translateY(-1.5px);
}
/* ✅ 로그인 이동 링크 */
.login-link {
    text-align: center;
    margin-top: 25px;
    font-size: 14px;
    color: #444;
}
.login-link a {
    color: #00A67E;
    font-weight: 600;
    text-decoration: none;
}
.login-link a:hover {
    text-decoration: underline;
}

</style>
</head>

<body>
<div class="container">
    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/images/mokyu_logo.png" alt="목유마켓 로고">
        <h1>목유마켓</h1>
    </div>

    <div class="form">
        <h2>비밀번호 재설정</h2>

        <div class="auth-group">
            <input type="email" id="email" placeholder="이메일 주소 입력 (@mokpo.ac.kr)">
            <button type="button" id="sendCodeBtn">인증코드 전송</button>
        </div>

        <div class="auth-group">
            <input type="text" id="authCode" placeholder="인증코드 입력">
            <button type="button" id="verifyBtn">인증 확인</button>
        </div>

        <input type="password" id="newPw" placeholder="새 비밀번호 입력" required>
		<!-- ✅ 비밀번호 변경 버튼 -->
		<button type="button" class="reset-btn" id="resetBtn">비밀번호 변경</button>
		
		<!-- ✅ 로그인 안내 문구 -->
		<div class="login-link">
		    비밀번호를 기억하고 계신가요? 
		    <a href="${pageContext.request.contextPath}/login">로그인하기</a>
		</div>
    </div>
</div>


<script>
let verified = false;

// ✅ 인증코드 전송
document.getElementById("sendCodeBtn").onclick = () => {
    const email = document.getElementById("email").value.trim();
    if (!email.endsWith("@mokpo.ac.kr")) {
        alert("mokpo.ac.kr 이메일만 사용 가능합니다.");
        return;
    }
    fetch("${pageContext.request.contextPath}/member/sendResetCode", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "email=" + encodeURIComponent(email)
    })
    .then(res => res.text())
    .then(msg => {
        if (msg === "success") alert("인증코드가 전송되었습니다.");
        else alert("전송 실패. 이메일 주소를 확인해주세요.");
    });
};

// ✅ 인증코드 확인
document.getElementById("verifyBtn").onclick = () => {
    const code = document.getElementById("authCode").value.trim();
    fetch("${pageContext.request.contextPath}/member/verifyResetCode", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "code=" + encodeURIComponent(code)
    })
    .then(res => res.text())
    .then(msg => {
        if (msg === "verified") {
            alert("인증 완료되었습니다!");
            verified = true;
        } else alert("인증코드가 올바르지 않습니다.");
    });
};

// ✅ 비밀번호 변경
document.getElementById("resetBtn").onclick = () => {
    if (!verified) {
        alert("먼저 이메일 인증을 완료해주세요.");
        return;
    }
    const newPw = document.getElementById("newPw").value.trim();
    if (newPw === "") {
        alert("새 비밀번호를 입력해주세요.");
        return;
    }

    fetch("${pageContext.request.contextPath}/member/resetPassword", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "newPw=" + encodeURIComponent(newPw)
    })
    .then(res => res.text())
    .then(msg => {
        if (msg === "success") {
            alert("비밀번호가 변경되었습니다. 로그인 페이지로 이동합니다.");
            location.href = "${pageContext.request.contextPath}/login";
        } else alert("비밀번호 변경에 실패했습니다.");
    });
};
</script>
</body>
</html>
