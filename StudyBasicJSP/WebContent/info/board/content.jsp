<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="info.board.BoardDBBean" %>
<%@ page import="info.board.BoardDataBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {
	background: url("../images/prince2.jpg") no-repeat;
	background-size: cover;
}
</style>
</head>
<body bgcolor="<%=bodyback_c%>">
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

try {
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.getArticle(num);
	
	int ref = article.getRef();
	int re_step = article.getRe_step();
	int re_level = article.getRe_level();
%>

<div class="tittext">
	<p>글내용 보기</p>
</div>

<form>
<table class="contable">
	<tr height="30">
		<td align="center" width="125" bgcolor="<%=value_c%>" class="lavel">글번호</td>
		<td align="center" width="125">
			<%=article.getNum() %></td>
		<td align="center" width="125" bgcolor="<%=value_c%>" class="lavel">조회수</td>
		<td align="center" width="125">
			<%=article.getReadcount() %></td>
	</tr>
	<tr height="30">
		<td align="center" width="125" bgcolor="<%=value_c%>" class="lavel">작성자</td>
		<td align="center" width="125">
			<%=article.getWriter() %></td>
		<td align="center" width="125" bgcolor="<%=value_c%>" class="lavel">작성일</td>
		<td align="center" width="125">
			<%=sdf.format(article.getReg_date()) %></td>
	</tr>
	<tr height="30">
		<td align="center" width="125" bgcolor="<%=value_c%>" class="lavel">글제목</td>
		<td align="center" width="375" colspan="3">
			<%=article.getSubject() %></td>
	</tr>
	<tr>
		<td align="center" width="125" bgcolor="<%=value_c%>" class="lavel">글내용</td>
		<td align="left" width="375" colspan="3">
			<pre><%=article.getContent() %></pre></td>
	</tr>
	<tr height="30">
		<td colspan="4" bgcolor="<%=value_c %>" align="right"  class="lavel">
			<input type="button" value="글수정" 
			onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'" class="btn">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글삭제" 
			onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum%>'" class="btn">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="댓글쓰기" 
			onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref %>&re_step=<%=re_step %>&re_level=<%=re_level %>'" class="btn">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글목록" 
			onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'" class="btn">
		</td>
	</tr>
</table>
</form>
<%
} catch(Exception e) {}
%>
</body>
</html>