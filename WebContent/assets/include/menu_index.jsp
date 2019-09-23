<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Nav -->
<nav id="menu">
	<ul class="links">
		<li><a href="/guide">게임소개/가이드</a></li>
		<li><a href="/rank">랭크</a></li>
		<li><a href="/shop">상점</a></li>
		<li><a href="/board/free">자유게시판</a></li>
		<li><a href="/board/motd">공지사항</a></li>
		<li><a href="/board/issue">문의게시판</a></li>
<%
	request.setCharacterEncoding("utf-8");
	
	String email = (String)session.getAttribute("email");
	if(email == null) {
%>
		<li><a href="/member/login">로그인/회원가입</a></li>
<%
	} else {
%>
		<li><a href="/member">내정보</a></li>
		<li><a href="/member/logout">로그아웃</a></li>
<%
	}
%>
	</ul>
</nav>