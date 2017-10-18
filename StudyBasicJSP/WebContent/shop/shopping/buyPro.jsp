<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.productshop.shopping.CartDataBean" %>
<%@ page import="shop.productshop.shopping.CartDBBean" %>
<%@ page import="shop.productshop.shopping.BankDBBean" %>
<%@ page import="shop.productshop.master.ShopProductDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shopping Mall</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%
String account = request.getParameter("account");
String deliveryName = request.getParameter("deliveryName");
String deliveryTel = request.getParameter("deliveryTel");
String deliveryAddress = request.getParameter("deliveryAddress");
String buyer = (String)session.getAttribute("id");

CartDBBean cartProcess = CartDBBean.getInstance();
List<CartDataBean> cartLists = cartProcess.getCart(buyer);

BankDBBean bankProcess = BankDBBean.getInstance();
bankProcess.insertBuy(cartLists, buyer, account, 
		deliveryName, deliveryTel, deliveryAddress);

response.sendRedirect("buyList.jsp");
%>


</body>
</html>