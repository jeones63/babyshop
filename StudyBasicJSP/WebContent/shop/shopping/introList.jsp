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
<h3>신상품 소개</h3>
<%
ShopProductDataBean[] productLists = null;
int number = 0;
String product_kindName = "";

ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
for(int i=1; i<=5; i++) {
	productLists = productProcess.getProducts(i+"00", 3);
	
	if(productLists[0].getProduct_kind().equals("100")) {
		product_kindName = "젖병/젖꼭지";
	} else if(productLists[0].getProduct_kind().equals("200")) {
		product_kindName = "노리개/치발기";
	} else if(productLists[0].getProduct_kind().equals("300")) {
		product_kindName = "빨대컵/유아컵";
	} else if(productLists[0].getProduct_kind().equals("400")) {
		product_kindName = "치약/칫솔";
	} else if(productLists[0].getProduct_kind().equals("500")) {
		product_kindName = "이유용품";
	}
%>
<hr>
<br><font size="+1"><b><%=product_kindName %>분류의 신상품 목록:
<a href="list.jsp?product_kind=<%=productLists[0].getProduct_kind() %>">더보기</a>
</b></font>
<br><br>
<%
	for(int j=0; j<productLists.length; j++) {
%>
<table align="center">
<tr height="30" bgcolor="<%=value_c%>">
	<td rowspan="4" width="100">
		<a href="productContent.jsp?product_id=<%=productLists[j].getProduct_id() %>&product_kind=<%=productLists[0].getProduct_kind() %>">
			<img src="../../imageFile/<%=productLists[j].getProduct_image() %>" border="0" width="60" height="90"></a></td>
	<td width="350"><font size="+1"><b>
		<a href="productContent.jsp?product_id=<%=productLists[j].getProduct_id() %>&product_kind=<%=productLists[0].getProduct_kind() %>"><%=productLists[j].getProduct_title() %></a></b></font></td>
	<td rowspan="4" width="100">
		<%if(productLists[j].getProduct_count()==0) { %>
			<font color="red"><b>일시품절</b></font>
		<%} else { %>
			<font color="blue"><b>구매가능</b></font>
		<%} %>
	</td>
</tr>
<tr height="30" bgcolor="<%=value_c %>">
	<td width="350">브랜드 : <%=productLists[j].getBrand() %></td>
</tr>
<tr height="30" bgcolor="<%=value_c %>">
	<td width="350">정가 :
	<%=NumberFormat.getInstance().format(productLists[j].getProduct_price()) %>원<br>
		판매가 : <b><font color="red" size="5">
	<%=NumberFormat.getInstance().format((int)(productLists[j].getProduct_price()*(
			(double)(100-productLists[j].getDiscount_rate())/100))) %>
	</font></b>원</td>
</tr>
</table>
<br>
<%
	}
}	// 23라인 for문 종료
%>
<hr>
</body>
</html>