<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품분류 메뉴</title>
<style type="text/css">
	a {
		color: black;
		text-decoration: none;
	}
	a:hover {
		color: blue;
	}
</style>
</head>
<body>
<p>상품분류</p>
<a href="../shopping/list.jsp?product_kind=all">전체목록보기</a><br>
<a href="../shopping/list.jsp?product_kind=100">젖병/젖꼭지</a><br>
<a href="../shopping/list.jsp?product_kind=200">노리개/치발기</a><br>
<a href="../shopping/list.jsp?product_kind=300">빨대컵/유아컵</a><br>
<a href="../shopping/list.jsp?product_kind=400">치약/칫솔</a><br>
<a href="../shopping/list.jsp?product_kind=500">이유용품</a>
<br><br><br>
<%
String buyer = (String)session.getAttribute("id");
if(buyer == null) {
	
} else {
%>
	<a href="../../info/board/list.jsp" target="balnk">어린이 행사보기</a>
<%
}
%>
</body>
</html>