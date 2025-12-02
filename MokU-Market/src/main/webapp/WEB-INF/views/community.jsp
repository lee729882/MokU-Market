<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>목포대학교 커뮤니티</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: "Noto Sans KR", -apple-system, BlinkMacSystemFont, sans-serif;
    background: #fafafa;
    min-height: 100vh;
}

/* Header */
.header {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    height: 60px;
    background: #fff;
    border-bottom: 1px solid #dbdbdb;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

.header-content {
    width: 100%;
    max-width: 935px;
    padding: 0 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.logo {
    font-size: 24px;
    font-weight: 700;
    background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

.header-icons {
    display: flex;
    gap: 16px;
}

.header-icon {
    width: 24px;
    height: 24px;
    cursor: pointer;
    fill: #262626;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 14px;
    font-weight: 500;
    color: #262626;
}

.user-avatar {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-weight: 600;
    font-size: 14px;
}

/* Main Container */
.container {
    max-width: 600px;
    margin: 0 auto;
    padding: 80px 20px 60px;
}

/* Write Button */
.write-btn {
    position: fixed;
    bottom: 80px;
    right: calc(50% - 300px + 20px);
    width: 56px;
    height: 56px;
    border-radius: 50%;
    background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);
    border: none;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.2s, box-shadow 0.2s;
    z-index: 100;
}

.write-btn:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 20px rgba(0,0,0,0.2);
}

.write-btn svg {
    width: 24px;
    height: 24px;
    fill: #fff;
}

@media (max-width: 640px) {
    .write-btn {
        right: 20px;
    }
    .container {
        padding: 80px 12px 60px;
    }
}

/* Write Form Modal */
.modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.65);
    z-index: 2000;
    align-items: center;
    justify-content: center;
}

.modal-overlay.active {
    display: flex;
}

#writeForm {
    background: #fff;
    width: 100%;
    max-width: 500px;
    border-radius: 12px;
    overflow: hidden;
    animation: modalSlide 0.3s ease;
}

@keyframes modalSlide {
    from {
        opacity: 0;
        transform: scale(0.95);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}

.form-header {
    padding: 12px 16px;
    border-bottom: 1px solid #dbdbdb;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.form-header h3 {
    font-size: 16px;
    font-weight: 600;
    color: #262626;
}

.close-btn {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    color: #262626;
    line-height: 1;
}

.form-body {
    padding: 16px;
}

.form-body input[type="text"],
.form-body textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #dbdbdb;
    border-radius: 8px;
    font-family: inherit;
    font-size: 14px;
    margin-bottom: 12px;
    resize: none;
    transition: border-color 0.2s;
}

.form-body input[type="text"]:focus,
.form-body textarea:focus {
    outline: none;
    border-color: #a8a8a8;
}

.file-upload {
    position: relative;
    margin-bottom: 12px;
}

.file-upload input[type="file"] {
    display: none;
}

.file-upload-label {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    padding: 12px;
    border: 1px dashed #dbdbdb;
    border-radius: 8px;
    cursor: pointer;
    color: #8e8e8e;
    font-size: 14px;
    transition: all 0.2s;
}

.file-upload-label:hover {
    border-color: #a8a8a8;
    background: #fafafa;
}

.submit-btn {
    width: 100%;
    padding: 12px;
    background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);
    border: none;
    border-radius: 8px;
    color: #fff;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: opacity 0.2s;
}

.submit-btn:hover {
    opacity: 0.9;
}

/* Posts */
#posts {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.post {
    background: #fff;
    border: 1px solid #dbdbdb;
    border-radius: 8px;
    overflow: hidden;
}

.post-header {
    padding: 14px 16px;
    display: flex;
    align-items: center;
    gap: 12px;
}

.post-avatar {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);
    padding: 2px;
}

.post-avatar-inner {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
    font-size: 12px;
    color: #262626;
}

.post-user-info {
    flex: 1;
}

.post-username {
    font-size: 14px;
    font-weight: 600;
    color: #262626;
}

.post-time {
    font-size: 12px;
    color: #8e8e8e;
}

.post-menu {
    background: none;
    border: none;
    cursor: pointer;
    padding: 8px;
    font-size: 16px;
    color: #262626;
}

.post-image {
    width: 100%;
    max-height: 585px;
    object-fit: cover;
}

.post-actions {
    padding: 8px 16px;
    display: flex;
    align-items: center;
    gap: 16px;
}

.action-btn {
    background: none;
    border: none;
    cursor: pointer;
    padding: 8px 0;
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 14px;
    color: #262626;
    transition: transform 0.2s;
}

.action-btn:hover {
    transform: scale(1.1);
}

.action-btn svg {
    width: 24px;
    height: 24px;
}

.action-btn.liked svg {
    fill: #ed4956;
    stroke: #ed4956;
    animation: likeAnimation 0.3s ease;
}

.action-btn.liked {
    color: #ed4956;
}

@keyframes likeAnimation {
    0% { transform: scale(1); }
    25% { transform: scale(1.2); }
    50% { transform: scale(0.95); }
    100% { transform: scale(1); }
}

.like-count {
    padding: 0 16px 8px;
    font-size: 14px;
    font-weight: 600;
    color: #262626;
}

.post-content-area {
    padding: 0 16px 12px;
}

.post-title {
    font-size: 14px;
    font-weight: 600;
    color: #262626;
    margin-bottom: 4px;
}

.post-content {
    font-size: 14px;
    color: #262626;
    line-height: 1.5;
    white-space: pre-line;
}

.view-comments {
    padding: 0 16px 8px;
    font-size: 14px;
    color: #8e8e8e;
    cursor: pointer;
    background: none;
    border: none;
    text-align: left;
}

.view-comments:hover {
    color: #262626;
}

/* Comments */
.comments-section {
    display: none;
    border-top: 1px solid #efefef;
}

.comments-section.active {
    display: block;
}

.comment-list {
    max-height: 200px;
    overflow-y: auto;
}

.comment {
    padding: 12px 16px;
    display: flex;
    align-items: flex-start;
    gap: 12px;
}

.comment-avatar {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    background: #dbdbdb;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 10px;
    font-weight: 600;
    color: #262626;
    flex-shrink: 0;
}

.comment-content {
    flex: 1;
    font-size: 14px;
    color: #262626;
    line-height: 1.4;
}

.comment-username {
    font-weight: 600;
    margin-right: 6px;
}

.comment-delete {
    background: none;
    border: none;
    color: #8e8e8e;
    cursor: pointer;
    font-size: 12px;
    padding: 4px;
}

.comment-delete:hover {
    color: #ed4956;
}

.comment-input-area {
    padding: 12px 16px;
    border-top: 1px solid #efefef;
    display: flex;
    align-items: center;
    gap: 12px;
}

.comment-input {
    flex: 1;
    border: none;
    font-size: 14px;
    font-family: inherit;
    outline: none;
    background: transparent;
}

.comment-input::placeholder {
    color: #8e8e8e;
}

.comment-submit {
    background: none;
    border: none;
    color: #0095f6;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    opacity: 0.5;
    transition: opacity 0.2s;
}

.comment-submit:hover {
    opacity: 1;
}

.delete-post-btn {
    background: none;
    border: none;
    color: #ed4956;
    font-size: 12px;
    cursor: pointer;
    padding: 4px 8px;
}

/* Bottom Nav */
.bottom-nav {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    height: 50px;
    background: #fff;
    border-top: 1px solid #dbdbdb;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 60px;
    z-index: 100;
}

.nav-icon {
    width: 24px;
    height: 24px;
    fill: #262626;
    cursor: pointer;
}
</style>
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="header-content">
        <div class="logo">목포대 커뮤니티</div>
        <div class="header-right">
            <div class="user-info">
                <div class="user-avatar">${loginName.substring(0,1)}</div>
                <span>${loginName}</span>
            </div>
        </div>
    </div>
</header>

<!-- Main Container -->
<div class="container">
    <div id="posts"></div>
</div>

<!-- Write Button -->
<button class="write-btn" onclick="toggleWriteForm()">
    <svg viewBox="0 0 24 24"><path d="M12 4v16m8-8H4" stroke="#fff" stroke-width="2" stroke-linecap="round" fill="none"/></svg>
</button>

<!-- Write Form Modal -->
<div class="modal-overlay" id="modalOverlay">
    <div id="writeForm">
        <div class="form-header">
            <button class="close-btn" onclick="toggleWriteForm()">×</button>
            <h3>새 게시물</h3>
            <div style="width: 24px;"></div>
        </div>
        <div class="form-body">
            <input type="text" id="title" placeholder="제목을 입력하세요">
            <textarea id="content" rows="6" placeholder="내용을 입력하세요..."></textarea>
            <div class="file-upload">
                <input type="file" id="image" accept="image/*">
                <label for="image" class="file-upload-label">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                        <circle cx="8.5" cy="8.5" r="1.5"/>
                        <polyline points="21,15 16,10 5,21"/>
                    </svg>
                    사진 추가하기
                </label>
            </div>
            <button class="submit-btn" onclick="submitPost()">공유하기</button>
        </div>
    </div>
</div>

<!-- Bottom Navigation -->
<nav class="bottom-nav">
    <svg class="nav-icon" viewBox="0 0 24 24"><path d="M9.005 16.545a2.997 2.997 0 012.997-2.997h0A2.997 2.997 0 0115 16.545V22h7V11.543L12 2 2 11.543V22h7.005z" fill="none" stroke="currentColor" stroke-width="2"/></svg>
    <svg class="nav-icon" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8" fill="none" stroke="currentColor" stroke-width="2"/><line x1="21" y1="21" x2="16.65" y2="16.65" stroke="currentColor" stroke-width="2"/></svg>
    <svg class="nav-icon" viewBox="0 0 24 24"><path d="M16.792 3.904A4.989 4.989 0 0121.5 9.122c0 3.072-2.652 4.959-5.197 7.222-2.512 2.243-3.865 3.469-4.303 3.752-.477-.309-2.143-1.823-4.303-3.752C5.141 14.072 2.5 12.167 2.5 9.122a4.989 4.989 0 014.708-5.218 4.21 4.21 0 013.675 1.941c.84 1.175.98 1.763 1.12 1.763s.278-.588 1.11-1.766a4.17 4.17 0 013.679-1.938z" fill="none" stroke="currentColor" stroke-width="2"/></svg>
    <svg class="nav-icon" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10" fill="none" stroke="currentColor" stroke-width="2"/><circle cx="12" cy="10" r="3" fill="none" stroke="currentColor" stroke-width="2"/><path d="M6.168 18.849A4 4 0 0110 16h4a4 4 0 013.834 2.855" fill="none" stroke="currentColor" stroke-width="2"/></svg>
</nav>

<script>
const ctx = "${ctx}";
const writerName = "${loginName}";
const currentSchool = "목포대학교";
const currentCategory = "free";
let editingPostId = null;
let likedPosts = new Set();


async function toggleLike(postId) {
    // 좋아요 상태 토글1
    if (likedPosts.has(postId)) {
        likedPosts.delete(postId);
    } else {
        likedPosts.add(postId);
    }
    
    await fetch(ctx + "/api/board/" + postId + "/like?writerName=" + writerName, {
        method: "POST"
    });
    loadPosts();
}

async function loadPosts() {
    const res = await fetch(ctx + "/api/board?school=" + currentSchool + "&category=" + currentCategory);
    const posts = await res.json();
    let html = "";

    for (const p of posts) {
        const cRes = await fetch(ctx + "/api/comments/" + p.id);
        const comments = await cRes.json();
        const initial = p.writerName ? p.writerName.substring(0, 1) : "?";
        const isLiked = p.likedByMe || likedPosts.has(p.id);
        const likedClass = isLiked ? 'liked' : '';
        
        html += '<article class="post">';
        html += '  <div class="post-header">';
        html += '    <div class="post-avatar"><div class="post-avatar-inner">' + initial + '</div></div>';
        html += '    <div class="post-user-info">';
        html += '      <div class="post-username">' + p.writerName + '</div>';
        html += '      <div class="post-time">' + p.createdAt + '</div>';
        html += '    </div>';
        if (p.writerName === writerName) {
            html += '    <button class="delete-post-btn" onclick="deletePost(' + p.id + ')">삭제</button>';
        }
        html += '  </div>';
        
        if (p.imageBase64) {
            html += '  <img class="post-image" src="' + p.imageBase64 + '" alt="게시물 이미지">';
        }
        
        html += '  <div class="post-actions">';
        html += '    <button class="action-btn ' + likedClass + '" onclick="toggleLike(' + p.id + ')">';
        html += '      <svg viewBox="0 0 24 24"><path d="M16.792 3.904A4.989 4.989 0 0121.5 9.122c0 3.072-2.652 4.959-5.197 7.222-2.512 2.243-3.865 3.469-4.303 3.752-.477-.309-2.143-1.823-4.303-3.752C5.141 14.072 2.5 12.167 2.5 9.122a4.989 4.989 0 014.708-5.218 4.21 4.21 0 013.675 1.941c.84 1.175.98 1.763 1.12 1.763s.278-.588 1.11-1.766a4.17 4.17 0 013.679-1.938z" fill="none" stroke="currentColor" stroke-width="2"/></svg>';
        html += '      ' + (p.likeCount || 0);
        html += '    </button>';
        html += '    <button class="action-btn" onclick="showComments(' + p.id + ')">';
        html += '      <svg viewBox="0 0 24 24"><path d="M20.656 17.008a9.993 9.993 0 10-3.59 3.615L22 22z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/></svg>';
        html += '      ' + comments.length;
        html += '    </button>';
        html += '  </div>';
        
        html += '  <div class="like-count">좋아요 ' + (p.likeCount || 0) + '개</div>';
        
        html += '  <div class="post-content-area">';
        html += '    <div class="post-title">' + p.title + '</div>';
        html += '    <div class="post-content">' + p.content + '</div>';
        html += '  </div>';
        
        if (comments.length > 0) {
            html += '  <button class="view-comments" onclick="showComments(' + p.id + ')">댓글 ' + comments.length + '개 모두 보기</button>';
        }
        
        html += '  <div class="comments-section" id="cmt-box-' + p.id + '">';
        html += '    <div class="comment-list">';
        comments.forEach(function(c) {
            const cInitial = c.writer ? c.writer.substring(0, 1) : "?";
            html += '      <div class="comment">';
            html += '        <div class="comment-avatar">' + cInitial + '</div>';
            html += '        <div class="comment-content">';
            html += '          <span class="comment-username">' + c.writer + '</span>';
            html += '          ' + c.content;
            html += '        </div>';
            if (c.writer === writerName) {
                html += '        <button class="comment-delete" onclick="deleteComment(' + c.id + ')">×</button>';
            }
            html += '      </div>';
        });
        html += '    </div>';
        html += '    <div class="comment-input-area">';
        html += '      <input class="comment-input" id="cmt-input-' + p.id + '" placeholder="댓글 달기...">';
        html += '      <button class="comment-submit" onclick="submitComment(' + p.id + ')">게시</button>';
        html += '    </div>';
        html += '  </div>';
        
        html += '</article>';
    }

    document.getElementById("posts").innerHTML = html;
}

function showComments(postId) {
    const box = document.getElementById("cmt-box-" + postId);
    box.classList.toggle("active");
}

loadPosts();
</script>
</body>
</html>
