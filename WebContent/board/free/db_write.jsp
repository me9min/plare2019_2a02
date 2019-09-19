<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Bean.Board" %>
<%@ page import = "java.sql.Date" %>

<% 
	request.setCharacterEncoding("utf-8");
	String email = (String)session.getAttribute("email");
%>

<jsp:useBean id="article" scope="page" class="Bean.BoardBean">
   <jsp:setProperty name="article" property="*"/>
   <jsp:setProperty name="article" property="writer" value="<%=email %>"/>
</jsp:useBean>

<%
	String ip = null;
	if (null != request.getRemoteAddr()) {
		ip = request.getRemoteAddr();
		if (null != request.getRemoteHost()) {
			ip = request.getRemoteHost();
			if (null != request.getHeader("x-forwarded-for")) {
				ip = request.getHeader("x-forwarded-for");
			}
		}
	}
	article.setIp(ip);
						
	try {
	    Board board = Board.getInstance();
	    board.insertArticle(article, "free");
%>
		<script>alert('게시글이 등록되었습니다.')</script>
<%
	} catch(Exception e) {
%>
		<script>alert('게시글 등록에 실패했습니다.')</script>
<%		
	} finally {
		response.sendRedirect("index.jsp");
	}
%>