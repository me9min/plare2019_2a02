<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Bean.Board" %>
<%@ page import = "Bean.BoardBean" %>
<% 
	request.setCharacterEncoding("UTF-8");
	Board board = Board.getInstance();
	
	int num = Integer.parseInt(request.getParameter("num"));	
	int currentPage = Integer.parseInt(request.getParameter("pageNum"));
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));
	
	board.deleteComment(commentNum);
%>
<script>
	alert("댓글 삭제가 완료되었습니다.");
	window.location = 'content.jsp?num=<%=num%>&pageNum=<%=currentPage%>';
</script>
