<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../etc/script.js"></script>
</head>
<body bgcolor="<%=bodyback_c%>">
<%
String managerId = "";
try {
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} else {
%>
<p>상품 등록</p>
<br>

<form method="post" name="writeform" action="productRegisterPro.jsp" enctype="multipart/form-data">
<table align="center">
	<tr>
		<td align="right" colspan="2" bgcolor="<%=value_c%>">
				<a href="../managerMain.jsp">관리자 메인으로</a>
			</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c%>">분류 선택</td>
		<td width="400" align="left">
			<select name="product_kind">
				<option value="100">젖병/젖꼭지</option>
				<option value="200">노리개/치발기</option>
				<option value="300">빨대컵/유아컵</option>
				<option value="400">치약/칫솔</option>
				<option value="500">이유용품</option>
			</select>
		</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">제목</td>
		<td width="400" align="left">
			<input type="text" size="50" maxlength="50" name="product_title">
		</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">가격</td>
		<td width="400" align="left">
		<input type="text" size="10" maxlength="9" name="product_price">원</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">수량</td>
		<td width="400" align="left">
			<input type="text" size="10" maxlength="5" name="product_count">EA</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">브랜드</td>
		<td width="300" align="left">
			<input type="text" size="20" maxlength="30" name="brand"></td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">이미지</td>
		<td width="400" align="left">
			<input type="file" name="product_image"></td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">내용</td>
		<td width="400" align="left">
			<textarea name="product_content" rows="13" cols="40"></textarea></td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">할인율</td>
		<td width="400" align="left">
			<input type="text" size="5" maxlength="2" name="discount_rate">%</td>
	</tr> 
	<tr>
		<td colspan="2" bgcolor="<%=value_c %>" align="center">
			<input type="button" value="상품등록" onclick="checkForm(this.form)">
			<input type="reset" value="다시 작성">
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