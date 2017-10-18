<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 로그인</title>
<link href="../etc/style.css" rel="stylesheet" type="text.css">
<style type="text/css">
	.container {
		width: 300px;
		margin: 0 auto;
	}
	fieldset {	
		width: 300px;
		margin-top: 50px;
	}
	label {
		width: 80px;
		float: left;
		margin-right: 10px;
		text-align: right;
	}
</style>
</head>
<body bgcolor="<%=bodyback_c %>">
<div class="container">
	<fieldset>
		<h2>로그인</h2>
		<form method="post" action="../shopping/loginPro.jsp">
			<label>아이디 : </label>
			<input type="text" name="id" size="15" maxlength="50"><br>
			<label>비밀번호 : </label>
			<input type="password" name="passwd" size="15" maxlength="16"><br>
			<input type="submit" value="로그인">
			<input type="button" value="취소" 
			onclick="javascript:window.location='shopMain.jsp'">
		</form>
	</fieldset>
</div>
</body>
</html>