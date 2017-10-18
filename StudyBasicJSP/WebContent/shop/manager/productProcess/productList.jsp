<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.productshop.master.ShopProductDBBean" %>
<%@ page import="shop.productshop.master.ShopProductDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록된 상품목록</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c %>">
<%!
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
String managerId = "";
try {
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} else {
		
		List<ShopProductDataBean> productList = null;
		int number = 0;
		String product_kind = "";
		
		product_kind = request.getParameter("product_kind");
		
		ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
		int count = productProcess.getProductCount();
		
		if(count > 0) {
			productList = productProcess.getProducts(product_kind);
		}
		
		String product_kindName = "";
		if(product_kind.equals("100")) {
			product_kindName="젖병/젖꼭지";
		} else if(product_kind.equals("200")) {
			product_kindName="노리개/치발기";
		} else if(product_kind.equals("300")) {
			product_kindName="빨대컵/유아컵";
		} else if(product_kind.equals("400")) {
			product_kindName="치약/칫솔";
		} else if(product_kind.equals("500")) {
			product_kindName="이유용품";
		} else if(product_kind.equals("all")) {
			product_kindName="전체";
		}
%>
		<a href="../managerMain.jsp">관리자 메인으로</a> &nbsp;
		<p><%=product_kindName %>분류의 목록:
		<%if(product_kind.equals("all")) {%>
			<%=count %>개
		<%} else { %>
			<%=productList.size() %>개
		<%} %>
		</p>
		<hr>
		<table align="center">
		<tr>
			<td align="right" bgcolor="<%=value_c %>">
				<a href="productRegisterForm.jsp">상품 등록</a>
			</td>
		</tr>
		</table>
		<br>
		
		<%
		if(count == 0) {
		%>
		<table align="center">
		<tr>
			<td align="center">
				등록된 책이 없습니다.
			</td>
		</tr>
		</table>
		
		<%} else { %>
		<table align="center">
		<tr height="30" bgcolor="<%=value_c %>">
			<td align="center" width="30">번호</td>
			<td align="center" width="50">상품분류</td>
			<td align="center" width="200">제목</td>
			<td align="center" width="50">가격</td>
			<td align="center" width="50">수량</td>
			<td align="center" width="70">브랜드</td>
			<td align="center" width="60">상품이미지</td>
			<td align="center" width="30">할인율</td>
			<td align="center" width="70">등록일</td>
			<td align="center" width="50">수정</td>
			<td align="center" width="50">삭제</td>
		</tr>
	<%
		for(int i=0; i<productList.size(); i++) {
			ShopProductDataBean product = 
					(ShopProductDataBean)productList.get(i);
	%>
		<tr height="30">
			<td width="30"><%=++number %></td>
			<td width="30"><%=product.getProduct_kind() %></td>
			<td width="100"><%=product.getProduct_title() %></td>
			<td width="50"><%=product.getProduct_price() %></td>
			<td width="50">
			<%if(product.getProduct_count()==0) { %>
				<font color="red"><%="일시품절" %></font>
			<%} else { %>
				<%=product.getProduct_count() %>
			<%} %>
			</td>
			<td width="70"><%=product.getBrand() %></td>
			<td width="50"><%=product.getProduct_image() %></td>
			<td width="50"><%=product.getDiscount_rate() %></td>
			<td width="50"><%=sdf.format(product.getReg_date()) %></td>
			<td width="50">
				<a href="productUpdateForm.jsp?product_id=<%=product.getProduct_id() %>&product_kind=<%=product.getProduct_kind() %>">수정</a></td>
			<td width="50">
				<a href="productDeleteForm.jsp?product_id=<%=product.getProduct_id() %>&product_kind=<%=product.getProduct_kind() %>">삭제</a></td>
				
		</tr>
		<%} %>
		</table>
		<%} %>
		<br>
		<a href="../managerMain.jsp">관리자 메인으로</a>
		
<%
	}
} catch(Exception e) {
	e.printStackTrace();
}

%>
</body>
</html>