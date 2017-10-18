<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="shop.productshop.master.ShopProductDBBean" %>
<%@ page import="shop.productshop.master.ShopProductDataBean" %>
<%@ include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
<link href="../../etc/style.css" rel="stylesheet"  type="text/css">
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
		int product_id = Integer.parseInt(request.getParameter("product_id"));
		String product_kind = request.getParameter("product_kind");
		try {
			ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
			ShopProductDataBean product = productProcess.getProduct(product_id);
%>
<p>책 수정</p>
<br>

<form method="post" action="productUpdatePro.jsp" name="writeform"
	enctype="multipart/form-data">
<table align="center">
	<tr>
		<td align="right" colspan="2" bgcolor="<%=value_c%>">
			<a href="../managerMain.jsp">관리자 메인으로</a> &nbsp;
			<a href="productList.jsp?product_kind=<%=product_kind%>">목록으로</a>
		</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">분류선택</td>
		<td width="400" align="left">
			<select name="product_kind">
				<option value="100"
				<%if(product.getProduct_kind().equals("100")) {%>selected<%} %>
				>젖병/젖꼭지</option>
				<option value="200"
				<%if(product.getProduct_kind().equals("200")) {%>selected<%} %>
				>노리개/치발기</option>
				<option value="300"
				<%if(product.getProduct_kind().equals("300")) {%>selected<%} %>
				>빨대컵/유아컵</option>
				<option value="400"
				<%if(product.getProduct_kind().equals("400")) {%>selected<%} %>
				>치약/칫솔</option>
				<option value="500"
				<%if(product.getProduct_kind().equals("500")) {%>selected<%} %>
				>이유용품</option>
			</select>
		</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">제목</td>
		<td width="400" align="left">
			<input type="text" size="50" maxlength="50" name="product_title"
			value="<%=product.getProduct_title()%>">
			<input type="hidden" name="product_id" value="<%=product_id %>"></td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">가격</td>
		<td width="400" align="left">
			<input type="text" size="10" maxlength="9" name="product_price"
			value="<%=product.getProduct_price()%>">원</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">수량</td>
		<td width="400" align="left">
			<input type="text" size="10" maxlength="5" name="product_count"
			value="<%=product.getProduct_count()%>">권</td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">브랜드</td>
		<td width="400" align="left">
			<input type="text" size="10" maxlength="5" name="brand"
			value="<%=product.getBrand()%>"></td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">이미지</td>
		<td width="400" align="left">
			<input type="file" name="product_image"><%=product.getProduct_image() %></td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">내용</td>
		<td width="400" align="left">
			<textarea name="product_content" rows="13"
			cols="40"><%=product.getProduct_content() %></textarea></td>
	</tr>
	<tr>
		<td width="100" bgcolor="<%=value_c %>">할인율</td>
		<td width="400" align="left">
			<input type="text" size="5" maxlength="2" name="discount_rate"
			value="<%=product.getDiscount_rate() %>">%</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="<%=value_c %>" align="center">
			<input type="button" value="상품수정" onclick="updateCheckForm(this.form)">
			<input type="reset" value="다시작성">
		</td>
	</tr>
</table>
</form>
<%
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
} catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>