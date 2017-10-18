<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.productshop.master.ShopProductDBBean" %>
<%@ page import="shop.productshop.master.ShopProductDataBean" %>
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
String product_id = request.getParameter("product_id");
String id = "";
int buy_price = 0;
try {
	if(session.getAttribute("id")==null) {
		id = "not";
	} else {
		id = (String)session.getAttribute("id");
	}
} catch(Exception e) {
	
}

ShopProductDataBean productList = null;
String product_kindName="";

ShopProductDBBean productProcess = ShopProductDBBean.getInstance();

productList = productProcess.getProduct(Integer.parseInt(product_id));

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
}
%>
<form name="inform" method="post" action="cartInsert.jsp">
<table align="center">
<tr height="30">
	<td rowspan="6" width="150">
		<img src="../../imageFile/<%=productList.getProduct_image() %>"
		border="0" width="150" height="200"></td>
	<td width="500"><font size="+1">
	<b><%=productList.getProduct_title() %></b></font></td>
</tr>
<tr><td width="500">저자: <%=productList.getBrand() %></td></tr>
<tr><td width="500">정가: 
<%=NumberFormat.getInstance().format(productList.getProduct_price()) %>원<br>
	<%buy_price=(int)(productList.getProduct_price()*(
			(double)(100-productList.getDiscount_rate())/100)); %>
	판매가: <b><font color="red">
	<%=NumberFormat.getInstance().format((int)(buy_price)) %>원
	</font></b><td></tr>
	<tr><td width="500">수량: <input type="text" size="5" name="buy_count" value="1">개
	<%
	if(id.equals("not")) {
		if(productList.getProduct_count()==0) {
	%>
			<font color="red"><b>일시품절</b></font>
	<%	} else { %>
			<b><font color="red">로그인하시면 구매가능합니다.</font></b>
	<%
		}
	} else {
		if(productList.getProduct_count()==0) {
	%>
			<font color="red"><b>일시품절</b></font>
	<%	} else {%>
		<input type="hidden" name="product_id" value="<%=product_id %>">
		<input type="hidden" name="product_image" value="<%=productList.getProduct_image() %>">
		<input type="hidden" name="product_title" value="<%=productList.getProduct_title() %>">
		<input type="hidden" name="buy_price" value="<%=buy_price %>">
		<input type="hidden" name="product_kind" value="<%=product_kind %>">
		<input type="submit" value="장바구니에 담기">
	<%
		}
	}
	%>
		<input type="button" value="목록으로"
		onclick="javascript:window.location='list.jsp?product_kind=<%=product_kind %>'">
		<input type="button" value="메인으로"
		onclick="javascript:window.location='shopMain.jsp'">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="left" width="300">
			<br><%=productList.getProduct_content() %></td>
	</tr>
</table>
</form>
</body>
</html>