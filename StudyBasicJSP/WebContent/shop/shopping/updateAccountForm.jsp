<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제계좌 수정</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c %>">
<%
String buyer = (String)session.getAttribute("id");
String accountList = request.getParameter("accountList");

if(buyer == null) {
	response.sendRedirect("shopMain.jsp");
} else {
%>
<h3><%=buyer %>님의 계좌 수정</h3>
<form method="post" action="updateAccountPro.jsp">
<table align="center">
	<tr>
		<td width="80" align="center">결제계좌</td>
		<td width="250" align="center"><%=accountList %></td>
		<input type="hidden" name="accountList" value="<%=accountList %>">
	</tr>
	<tr>
		<td width="80" align="center">수정 계좌번호</td>
		<td width="250">
			<input type="text" name="update_account">
		</td>
	</tr>
	<tr>
		<td width="80" align="center">수정 계좌은행</td>
		<td width="250">
			<input type="text" name="update_bank">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" bgcolor="<%=value_c %>">
			<input type="submit" value="확인">&nbsp;&nbsp;
			<input type="button" value="취소" 
				onclick="javascript:window.location='buyForm.jsp'">
		</td>
	</tr>
</table>
</form>
<%} %>
</body>
</html>