<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="info.board.BoardDBBean" %>
<%@ page import="info.board.BoardDataBean" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 게시판</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
<style type="text/css">
body {
	background: url("../images/prince4.JPG") no-repeat;
	background-size: cover;
}
</style>
</head>
<body bgcolor="<%=bodyback_c%>">
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
try {
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.updateGetArticle(num);
%>

<div class="tittext">
	<p>글수정</p>
</div>

<br>
<form method="post" action="updatePro.jsp?pageNum=<%=pageNum%>" 
name="writeform" onclick="return writeSave()">
<table>
	<tr>
		<td width="70" bgcolor="<%=value_c%>" align="center" class="lavel">이름</td>
		<td align="left" width="330">
			<input type="text" size="10" maxlength="10" name="writer"
			value="<%=article.getWriter() %>" style="ime-mode:active;">
			<input type="hidden" name="num" value="<%=article.getNum() %>"></td>
	</tr>
	<tr>
		<td width="70" bgcolor="<%=value_c%>" align="center" class="lavel">제목</td>
		<td align="left" width="330">
			<input type="text" size="40" maxlength="50" name="subject"
			value="<%=article.getSubject()%>" style="ime-mode:active;"></td>
	</tr>
	<tr>
		<td width="70" bgcolor="<%=value_c %>" align="center" class="lavel">Email</td>
		<td align="left" width="330">
			<input type="text" size="40" maxlength="30" name="email"
			value="<%=article.getEmail() %>" style="ime-mode:inactive;"></td>
	</tr>
	<tr>
		<td width="70" bgcolor="<%=value_c %>" align="center" class="lavel">내용</td>
		<td align="left" width="330">
			<textarea name="content" rows="13" cols="40"
			style="ime-mode:active;"><%=article.getContent() %></textarea></td>
	</tr>
	<tr>
		<td width="70" bgcolor="<%=value_c %>" align="center" class="lavel">비밀번호</td>
		<td align="left" width="330">
			<input type="password" size="8" maxlength="12"
			name="passwd" style="ime-mode:inactive;">
		</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="<%=value_c %>" align="center" class="lavel">
			<input type="submit" value="글수정" class="btn">
			<input type="reset" value="다시작성" class="btn">
			<input type="button" value="목록보기"
			onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'" class="btn">
		</td>
	</tr>
</table>

</form>
<%
} catch(Exception e) {}%>
</body>
</html>