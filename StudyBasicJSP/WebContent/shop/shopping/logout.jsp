<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 </title>
</head>
<body>
<%session.invalidate(); %> <!-- 세션을 무효화 시킨다. -->

<script>
 	alert("로그아웃 되었습니다.");
 	location.href="shopMain.jsp";
</script>
</body>
</html>