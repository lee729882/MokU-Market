<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>목유마켓 회원가입</title>

<!-- ✅ 폰트 통일 -->
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">

<style>
/* ✅ 전체 폰트 */
body {
    font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
    background-color: #f7f8f9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.signup-container {
    background-color: #fff;
    width: 420px;
    border-radius: 22px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    text-align: center;
}

/* ✅ 헤더 */
.header {
    background-color: #007A5C;
    padding: 25px 0 10px;
    text-align: center;
}
.header img {
    width: 85px;
    height: 85px;
    border-radius: 50%;
    object-fit: cover;
    background-color: #fff;
    padding: 6px;
    box-shadow: 0 0 5px rgba(0,0,0,0.1);
    margin-bottom: 8px;
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

/* ✅ 폼 전체 */
.form {
    padding: 10px 35px 30px; /* 상단 여백 줄임 (기존 18px → 10px) */
}
.form h2 {
    text-align: center;
    font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
    font-weight: 700;
    font-size: 21px;
    color: #222;
    margin-bottom: 18px; /* 회원가입 아래 간격 약간 줄임 */
    letter-spacing: -0.3px;
}

/* ✅ 입력 필드 통일 */
.form input[type="email"],
.form input[type="password"],
.form input[type="text"],
.form input[type="tel"] {
    width: 100%;
    box-sizing: border-box;
    padding: 13px 15px;
    margin-bottom: 14px; /* ✅ 모든 입력칸 간격 동일 */
    border: 1px solid #ddd;
    border-radius: 12px;
    font-size: 14px;
    transition: 0.2s;
}
.form input:focus {
    border-color: #00A67E;
    outline: none;
}

/* ✅ 인증 그룹 (버튼 포함 동일 간격) */
.auth-group {
    display: flex;
    align-items: stretch;
    gap: 3px;
    margin-bottom: 5px; /* ✅ 입력칸과 동일한 간격 */
}
.auth-group input {
    flex: 1;
    height: 46px;
    border-radius: 12px;
    padding: 13px 0px;
    font-size: 14px;
    border: 1px solid #ddd;
    transition: 0.2s;
}
.auth-group input:focus {
    border-color: #00A67E;
    outline: none;
}
.auth-group button {
    width: 120px;
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



/* ✅ 회원가입 버튼 */
.form button.signup-btn {
    width: 100%;
    background-color: #00A67E;
    border: none;
    color: #fff;
    font-size: 15px;
    font-weight: 700;
    border-radius: 12px;
    padding: 13px 0;
    margin-top: 10px;
    cursor: pointer;
    transition: 0.2s;
}
.form button.signup-btn:hover {
    background-color: #008a6b;
    transform: translateY(-1.5px);
}

/* ✅ 로그인 링크 */
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
<div class="signup-container">
    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/images/mokyu_logo.png" alt="목유마켓 로고">
        <h1>목유마켓</h1>
    </div>

    <div class="form">
        <h2>회원가입</h2>
        <form id="signupForm" action="${pageContext.request.contextPath}/signup" method="post">
            <!-- 이메일 인증 -->
            <div class="auth-group">
                <input type="email" id="email" name="email" placeholder="이메일 주소 (@mokpo.ac.kr)" required>
                <button type="button" id="sendCodeBtn">인증코드 전송</button>
            </div>

            <div class="auth-group">
                <input type="text" id="authCode" placeholder="인증코드 입력">
                <button type="button" id="verifyBtn">인증 확인</button>
            </div>

            <!-- 비밀번호 / 이름 / 전화번호 -->
            <input type="password" name="password" placeholder="비밀번호를 입력해주세요" required>
            <input type="text" name="name" placeholder="이름을 입력해주세요" required>
            <input type="tel" name="phone" placeholder="전화번호 (010-xxxx-xxxx)" maxlength="13" required>

            <button type="submit" class="signup-btn">회원가입</button>

            <div class="login-link">
                이미 계정이 있으신가요?
                <a href="${pageContext.request.contextPath}/login">로그인</a>
            </div>
        </form>
    </div>
</div>

<script>
let emailVerified = false;

// ✅ 전화번호 입력 시 자동 하이픈(-) 추가
document.querySelector("input[name='phone']").addEventListener("input", function(e) {
    let value = e.target.value.replace(/[^0-9]/g, ""); // 숫자만 남기기
    if (value.length > 3 && value.length <= 7)
        value = value.replace(/(\d{3})(\d+)/, "$1-$2");
    else if (value.length > 7)
        value = value.replace(/(\d{3})(\d{4})(\d+)/, "$1-$2-$3");
    e.target.value = value;
});

// ✅ 이메일 인증코드 전송 (중복체크 포함)
document.querySelector("#sendCodeBtn").onclick = function() {
    const email = document.querySelector("#email").value.trim();
    if (!email.endsWith("@mokpo.ac.kr")) {
        alert("mokpo.ac.kr 이메일만 사용 가능합니다.");
        return;
    }

    // 이메일 중복 체크
    fetch("${pageContext.request.contextPath}/member/checkEmail?email=" + encodeURIComponent(email))
        .then(res => res.text())
        .then(result => {
            if (result === "exists") {
                alert("이미 등록된 학교 이메일입니다.");
            } else {
                // 인증코드 전송
                fetch("${pageContext.request.contextPath}/email/send", {
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: "email=" + encodeURIComponent(email)
                })
                .then(res => res.text())
                .then(msg => {
                    if (msg === "success") alert("인증코드가 이메일로 전송되었습니다.");
                    else alert("메일 전송에 실패했습니다. 다시 시도해주세요.");
                });
            }
        });
};

// ✅ 인증코드 검증
document.querySelector("#verifyBtn").onclick = function() {
    const code = document.querySelector("#authCode").value.trim();
    if (code === "") {
        alert("인증코드를 입력해주세요.");
        return;
    }

    fetch("${pageContext.request.contextPath}/email/verify", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "code=" + encodeURIComponent(code)
    })
    .then(res => res.text())
    .then(msg => {
        if (msg === "verified") {
            alert("이메일 인증이 완료되었습니다.");
            emailVerified = true;
            document.querySelector("#email").readOnly = true;
            document.querySelector("#sendCodeBtn").disabled = true;
            document.querySelector("#verifyBtn").disabled = true;
        } else {
            alert("인증코드가 올바르지 않습니다.");
        }
    });
};

//✅ 회원가입 시 인증/중복 확인
document.querySelector("#signupForm").onsubmit = async function(e) {
    if (!emailVerified) {
        e.preventDefault();
        alert("이메일 인증을 완료해야 회원가입이 가능합니다.");
        return false;
    }

    const phone = document.querySelector("input[name='phone']").value.trim();
    if (phone.length < 13) {
        e.preventDefault();
        alert("전화번호 형식을 확인해주세요.");
        return false;
    }

    // ✅ 이메일 중복 재확인
    const email = document.querySelector("#email").value.trim();
    const emailRes = await fetch("${pageContext.request.contextPath}/member/checkEmail?email=" + encodeURIComponent(email));
    const emailResult = await emailRes.text();
    if (emailResult === "exists") {
        e.preventDefault();
        alert("이미 사용 중인 이메일입니다.");
        return false;
    }

    // ✅ 전화번호 중복 확인
    const phoneRes = await fetch("${pageContext.request.contextPath}/member/checkPhone?phone=" + encodeURIComponent(phone));
    const phoneResult = await phoneRes.text();
    if (phoneResult === "exists") {
        e.preventDefault();
        alert("이미 사용 중인 전화번호입니다.");
        return false;
    }

    return true; // 검증 통과 → submit 진행
};

</script>
</body>
</html>
