<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.productshop.master.ShopProductDBBean" %>
<%@ page import="shop.productshop.master.ShopProductDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shopping Mall</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c %>">
<%
String product_kind = request.getParameter("product_kind");
%>
<table align="center">
<tr>
	<td width="150" valign="top">
		<jsp:include page="../module/left.jsp" flush="false"/>
	</td>
	<td width="700">
	<%
	List<ShopProductDataBean> productLists = null;
	ShopProductDataBean productList = null;
	String product_kindName="";
	
	ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
	productLists = productProcess.getProducts(product_kind);
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
	
	<h3><b><%=product_kindName %>분류의 목록</b></h3>
	<a href="shopMain.jsp">메인으로</a>
	<%
	for(int i=0; i<productLists.size(); i++) {
		productList = (ShopProductDataBean)productLists.get(i);
	%>
	<table align="center">
	<tr height="30" bgcolor="<%=value_c %>">
		<td rowspan="4" width="100">
			<a href="productContent.jsp?product_id=<%=productList.getProduct_id() %>&product_kind=<%=product_kind %>">
				<img src="../../imageFile/<%=productList.getProduct_image() %>" border="0" width="60" height="90"></a></td>
		<td width="350"><font size="+1"><b>
			<a href="productContent.jsp?product_id=<%=productList.getProduct_id() %>&product_kind=<%=product_kind %>">
			<%=productList.getProduct_title() %></a></b></font></td>
		<td rowspan="4" width="100" align="center" valign="middle">
		<%if(productList.getProduct_count()==0) {%>
			<font color="red"><b>일시품절</b></font>
		<%} else {%>
			<font color="blue"><b>구매 가능</b></font>
		<%} %>
		</td>
	</tr>
	<tr height="30" bgcolor="<%=value_c %>">
		<td width="350">브랜드: <%=productList.getBrand() %></td>
	</tr>
	<tr height="30" bgcolor="<%=value_c %>">
		<td width="350">정가:
		<%=NumberFormat.getInstance().format(productList.getProduct_price()) %><br>
			판매가: <b><font color="red">
		
		<%=NumberFormat.getInstance().format(
				(int)(productList.getProduct_price()*(
						(double)(100-productList.getDiscount_rate())/100))) %>
		</font></b></td>
	</tr>
	</table>
	<br>
	<%}	%>
	</td>
</tr>
</table>
</body>
</html>