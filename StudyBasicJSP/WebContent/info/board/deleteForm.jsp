<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제 게시판</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../etc/script.js"></script>
<style type="text/css">
body {
	background: url("../images/prince1.jpg") no-repeat;
	background-size: cover;
}
</style>
</head>
<body bgcolor="<%=bodyback_c%>">
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
%>

<div class="tittext">
	<p>글삭제</p>
</div>

<form method="post" action="deletePro.jsp?pageNum=<%=pageNum%>" name="deleteform"
	onsubmit="return deleteSave()">
<table class="contable">
	<tr height="30">
		<td align="center" bgcolor="<%=value_c%>" width="400" class="lavel">
			<b>비밀번호를 입력해 주세요.</b></td>
	</tr>
	<tr height="70">
		<td align="center">비밀번호:
			<input type="password" name="passwd" size="8" maxlength="12">
			<input type="hidden" name="num" value="<%=num %>"></td>
	</tr>
	<tr height="30">
		<td align="center" bgcolor="<%=value_c%>" class="lavel">
			<input type="submit" value="글삭제" class="btn">
			<input type="button" value="글목록"
			onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'" class="btn">
		</td>
	</tr>
</table>	
</form>



</body>
</html>