<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.productshop.shopping.CartDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 추가</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>

<%
String product_kind = request.getParameter("product_kind");
String buy_count = request.getParameter("buy_count");
String product_id = request.getParameter("product_id");
String product_title = request.getParameter("product_title");
String product_image = request.getParameter("product_image");
String buy_price = request.getParameter("buy_price");
String buyer = (String)session.getAttribute("id");
%>

<jsp:useBean id="cart" scope="page" class="shop.productshop.shopping.CartDataBean" />
 
<%
cart.setProduct_id(Integer.parseInt(product_id));
cart.setProduct_image(product_image);
cart.setProduct_title(product_title);
cart.setBuy_count(Byte.parseByte(buy_count));
cart.setBuy_price(Integer.parseInt(buy_price));
cart.setBuyer(buyer);

CartDBBean productProcess = CartDBBean.getInstance();
productProcess.insertCart(cart);
response.sendRedirect("cartList.jsp?product_kind=" + product_kind);
%>
</body>
</html>