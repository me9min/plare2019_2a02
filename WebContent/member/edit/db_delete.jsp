<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Bean.*" %>
<jsp:useBean id="member" class="Bean.Member"/>
<%
	request.setCharacterEncoding("UTF-8");
	String email = (String)session.getAttribute("email");
	
	boolean del_check = passwordCheck(email, password);
	
	member.delete_member(email);
	session.invalidate();
	response.sendRedirect("../../");
%>