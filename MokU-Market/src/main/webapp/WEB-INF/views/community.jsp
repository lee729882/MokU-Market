<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>목포대학교 커뮤니티</title>

<style>
    body { font-family: "Noto Sans KR", sans-serif; max-width: 700px; margin: 0 auto; padding: 20px; background: #f5f6fa; }
    h2 { margin-bottom: 20px; }
    .post { background: #fff; padding: 16px; margin-bottom: 18px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,.1); }
    .post-title { font-weight: bold; font-size: 18px; margin-bottom: 8px; }
    .post-content { white-space: pre-line; margin-bottom: 10px; }
    .small { color: #777; font-size: 13px; margin-bottom: 10px; }
    button { padding: 6px 12px; background: #007bff; color: #fff; border: none; border-radius: 6px; cursor: pointer; }
    button:hover { background: #0056b3; }
    .delete-btn { background: #dc3545; }
    #writeForm { background: #fff; padding: 16px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,.1); margin-bottom: 30px; display: none; }
    input, textarea { width: 100%; padding: 10px; margin-bottom: 12px; border: 1px solid #ccc; border-radius: 6px; font-family: "Noto Sans KR"; }
    .comment-box { background: #f1f2f6; padding: 8px; margin-top: 8px; border-radius: 8px; }
</style>
</head>

<body>

<h2>📌 목포대학교 커뮤니티</h2>
<p><b>${loginName}</b>님 환영합니다!</p>

<button onclick="toggleWriteForm()">✏ 글쓰기</button>

<div id="writeForm">
    <h3>새 글 작성</h3>
    <input id="title" placeholder="제목">
    <textarea id="content" rows="5" placeholder="내용"></textarea>
    <input type="file" id="image" accept="image/*">
    <button onclick="submitPost()">등록</button>
</div>

<div id="posts"></div>

<script>
const ctx = "${ctx}";
const writerName = "${loginName}";   // 🔥 서버 세션의 로그인한 유저 이름

const currentSchool = "목포대학교";
const currentCategory = "free";
let editingPostId = null;

// -------------------
function toggleWriteForm() {
    const form = document.getElementById("writeForm");
    form.style.display = (form.style.display === "block") ? "none" : "block";
}

// -------------------
// 🔥 글 작성 (writerName = 로그인 사용자)
async function submitPost() {
    const title = document.getElementById("title").value.trim();
    const content = document.getElementById("content").value.trim();
    const file = document.getElementById("image").files[0];

    if (!title || !content) {
        alert("제목/내용을 입력해주세요.");
        return;
    }

    const fd = new FormData();
    fd.append("title", title);
    fd.append("content", content);
    fd.append("writerName", writerName); // 서버 세션 값
    fd.append("school", currentSchool);
    fd.append("category", currentCategory);
    if (file) fd.append("image", file);

    const url = editingPostId 
        ? ctx + "/api/board/" + editingPostId + "?writerName=" + writerName
        : ctx + "/api/board";

    const method = editingPostId ? "PUT" : "POST";

    let res = await fetch(url, { method, body: fd });
    let text = await res.text();

    if (text !== "OK") {
        alert("등록 실패: " + text);
        return;
    }

    editingPostId = null;
    toggleWriteForm();
    loadPosts();
}

// -------------------
async function deletePost(id) {
    if (!confirm("정말 삭제할까요?")) return;

    await fetch(ctx + "/api/board/" + id + "?writerName=" + writerName, {
        method: "DELETE"
    });

    loadPosts();
}

// -------------------
async function submitComment(postId) {
    const input = document.getElementById("cmt-input-" + postId);
    const text = input.value.trim();
    if (!text) return;

    await fetch(ctx + "/api/comments/" + postId, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ writer: writerName, content: text })
    });

    input.value = "";
    loadPosts();
}

// -------------------
async function deleteComment(id) {
    if (!confirm("댓글 삭제?")) return;

    await fetch(ctx + "/api/comments/" + id + "?username=" + writerName, {
        method: "DELETE"
    });

    loadPosts();
}

// -------------------
async function toggleLike(postId) {
    await fetch(ctx + "/api/board/" + postId + "/like?writerName=" + writerName, {
        method: "POST"
    });
    loadPosts();
}

// -------------------
async function loadPosts() {
    const res = await fetch(ctx + "/api/board?school=" + currentSchool + "&category=" + currentCategory);
    const posts = await res.json();

    let html = "";

    for (const p of posts) {

        const cRes = await fetch(ctx + "/api/comments/" + p.id);
        const comments = await cRes.json();

        html += '<div class="post">';
        html += '    <div class="post-title">' + p.title + '</div>';
        html += '    <div class="small">' + p.writerName + ' · ' + p.createdAt + '</div>';
        html += '    <div class="post-content">' + p.content + '</div>';

        if (p.imageBase64) {
            html += '<img src="' + p.imageBase64 + '" style="max-width:100%; border-radius:6px;">';
        }

        html += '    <button onclick="toggleLike(' + p.id + ')">❤️ ' + (p.likeCount || 0) + '</button>';
        html += '    <button onclick="showComments(' + p.id + ')">💬 댓글 (' + comments.length + ')</button>';

        if (p.writerName === writerName) {
            html += '    <button class="delete-btn" onclick="deletePost(' + p.id + ')">삭제</button>';
        }

        html += '<div id="cmt-box-' + p.id + '" style="display:none; margin-top:12px;">';

        comments.forEach(function(c) {
            html += '<div class="comment-box">';
            html += '    <b>' + c.writer + '</b>: ' + c.content;
            if (c.writer === writerName) {
                html += '    <button class="delete-btn" onclick="deleteComment(' + c.id + ')">X</button>';
            }
            html += '</div>';
        });

        html += '<input id="cmt-input-' + p.id + '" placeholder="댓글 입력...">';
        html += '<button onclick="submitComment(' + p.id + ')">등록</button>';
        html += '</div>';

        html += '</div>';
    }

    document.getElementById("posts").innerHTML = html;
}

// -------------------
function showComments(postId) {
    const box = document.getElementById("cmt-box-" + postId);
    box.style.display = (box.style.display === "block") ? "none" : "block";
}

loadPosts();
</script>

</body>
</html>
