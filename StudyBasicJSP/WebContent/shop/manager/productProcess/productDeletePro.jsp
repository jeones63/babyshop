<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.productshop.master.ShopProductDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품삭제처리</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>

<%
int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_kind = request.getParameter("product_kind");

ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
productProcess.deleteProduct(product_id);

response.sendRedirect("productList.jsp?product_kind=" + product_kind);
%>
</body>
</html>