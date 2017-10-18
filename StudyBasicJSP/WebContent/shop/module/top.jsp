<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품분류 메뉴</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.submenu {
		margin-right: 65px;
	}
	nav ul li {
		display: inline;
		text-decoration: none;
		padding: 10px;
	}
	
	nav ul li a {
		text-decoration: none;
		color: black;
	}
	
	.menu ul {
		padding: 10px;
		border-top: 1px solid gray;
		border-bottom: 1px solid gray; 
	}
	
	.menu ul li {
		font-size: 1.3em;
		font-weight: bold;
		
	}
	.menu ul li:hover {
		background-color: cyan;
	}
</style>
</head>
<body bgcolor="<%=bodyback_c %>">
<%-- <%
try {
	if(session.getAttribute("id") == null) {%>
		<a href="../shopping/list.jsp?product_kind=all">전체목록보기</a>&nbsp;
		<br>
		
		<form method="post" action="../shopping/loginPro.jsp">
			아이디: <input type="text" name="id" size="15" maxlength="50">
			비밀번호: <input type="password" name="passwd" size="15" maxlength="16">
			<input type="submit" value="로그인">
		</form> 
		
		<font color="red">* 반드시 로그인을 하셔야 쇼핑을 하실 수 있습니다.</font>
	<%} else {%>
		<a href="../shopping/list.jsp?product_kind=all">전체목록보기</a>&nbsp;
		<a href="../shopping/cartList.jsp?product_kind=all">장바구니보기</a>&nbsp;
		<a href="../shopping/buyList.jsp">구매목록보기</a>&nbsp;
		
		<br><br>
		<b><%=session.getAttribute("id") %></b>님, 즐거운 쇼핑시간이 되세요.
		
		<input type="button" value="로그아웃"
			onclick="javascript:window.location='../shopping/logout.jsp'">
	<%}
} catch(Exception e) {
	e.printStackTrace();
}
%> --%>

<%
try {
	if(session.getAttribute("id") == null) {
%>
		<header>
			<nav align="right" class="submenu">
				<ul>
					<li><a href="loginForm.jsp">로그인</a></li>
				</ul>
				<font color="red">* 반드시 로그인을 하셔야 쇼핑을 하실 수 있습니다.</font>
			</nav>
<%
	} else {
%>
			<nav align="right" class="submenu">
				<ul>
					<li><a href="logout.jsp">로그아웃</a></li>
					<li><a href="cartList.jsp?product_kind=all">cart</a></li>
				</ul>
				<b><%=session.getAttribute("id") %></b>님, 즐거운 쇼핑시간이 되세요.
			</nav>
<%
	}
%>
	<nav class="menu">
		<ul>
			<li><a href="../shopping/list.jsp?product_kind=all">전체목록보기</a></li>
			<li><a href="../shopping/list.jsp?product_kind=100">젖병/젖꼭지</a></li>
			<li><a href="../shopping/list.jsp?product_kind=200">노리개/치발기</a></li>
			<li><a href="../shopping/list.jsp?product_kind=300">빨대컵/유아컵</a></li>
			<li><a href="../shopping/list.jsp?product_kind=400">치약/칫솔</a></li>
			<li><a href="../shopping/list.jsp?product_kind=500">이유용품</a></li>
		</ul>
	</nav>
</header>
<%
} catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>