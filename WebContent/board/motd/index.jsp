<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import = "Bean.Board" %>
<%@ page import = "Bean.BoardBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%!
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<%
	String category = "motd";
    String pageNum = request.getParameter("pageNum");
	String admin = "admin@plare.cf";

    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    List<BoardBean> articleList = null; 
    
    Board board = Board.getInstance();
    count = board.getArticleCount(category);
    
    if (count > 0) {
        articleList = board.getArticles(category, startRow, pageSize);
    }
%>

<!DOCTYPE HTML>
<html>
	<head>
		<title>공지사항</title>
		<style>
			td {color: black; background-color: #ffffff;}
			a:visited {color: black; text-decoration: none;}
		</style>
		<script language="JavaScript" src="login.js"></script>
<%@ include file="/assets/include/menu.jsp" %>
<%
	if(email == null) {
		email = "";
	}
%>

		<!-- One -->
			<section id="One" class="wrapper style3">
				<div class="inner">
					<header class="align-center">
						<p>안내사항이나 이벤트를 확인할 수 있습니다</p>
						<h2>공지사항</h2>
					</header>
				</div>
			</section>
			
		<!-- main -->
			<section id="two" class="wrapper style2">
				<div class="inner">
					<div class="box">
						<div class="content">
							<header class="align-center">
								<h2>공지사항</h2>
							</header>

	<div class="table-wrapper">
<%
	if(email.equals(admin)) {
%>
		<a href="write.jsp" class="button alt pull-right">글쓰기</a>
<% 
	}
	if(count == 0) { %>
		<table>
			<tr>
				<td><center>게시글이 존재하지 않습니다.</center></td>
			</tr>
		</table>
<% } else { %>
		<table class="table table-hover">
			<thead>
				<tr>
					<th width="10%">번호</th>
					<th width="50%">제목</th>
					<th>작성자</th>
					<th>작성일자</th>
					<th>조회수</th>
				</tr>
			</thead>
<%  
		for (int i = 0 ; i < articleList.size() ; i++) {
		  BoardBean article = articleList.get(i);
		  String nickname = board.getNickname(article.getWriter());
%>
			<tbody>
				<tr>
					<td width="10%">
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
							<%=article.getNum() %>
						</a>
					</td>
					<td width="50%">
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
							<%=article.getTitle() %>
						</a>
					</td>
					<td>
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
							<%=nickname %>
						</a>
					</td>						
					<td>
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
							<%=article.getReg_date() %>
						</a>		
					</td>
					<td>
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
							<%=article.getRead_count() %>
						</a>		
					</td>
				</tr>
			</tbody>
<% 		}
	}
%>
			<tfoot>
				<tr>
					<td colspan="6">
					<center>
<%
    if (count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1;
		
		if(currentPage % 5 != 0)
           startPage = (int)(currentPage/5)*5 + 1;
		else
           startPage = ((int)(currentPage/5)-1)*5 + 1;

		int pageBlock = 5;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 5) { %>
        	<a href="index.jsp?pageNum=<%= startPage - 5 %>">&lt;</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
        	<a href="index.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
   	     	<a href="index.jsp?pageNum=<%= startPage + 5 %>">&gt;</a>
<%
        }
    }
%>
					</center>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

						</div>
					</div>
				</div>
			</section>

<%@ include file="/assets/include/foot.jsp" %>

</html>