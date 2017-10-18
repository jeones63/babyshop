<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품삭제</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c %>">
<%
String managerId = "";
try {
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} else {
		int product_id = Integer.parseInt(request.getParameter("product_id"));
		String product_kind = request.getParameter("product_kind");
%>
<p>상품삭제<P>
<br>
<form method="post" name="delForm" 
action="productDeletePro.jsp?product_id=<%=product_id %>&product_kind=<%=product_kind %>" 
onsubmit="return deleteSave()">
<table align="center">
<tr>
	<td align="right" bgcolor="<%=value_c %>">
		<a href="../managerMain.jsp">관리자 메인으로</a> &nbsp;
		<a href="productList.jsp?product_kind=<%=product_kind%>">목록으로</a>
	</td>
</tr>

<tr height="30">
	<td align="center" bgcolor="<%=value_c %>">
		<input type="submit" value="삭제">
	</td>
</tr>
</table>
</form>
<%
	}
} catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>