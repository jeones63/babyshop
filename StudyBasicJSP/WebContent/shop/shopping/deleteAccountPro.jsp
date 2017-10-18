<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.productshop.shopping.BankDataBean" %>
<%@ page import="shop.productshop.shopping.BankDBBean" %>
<%@ page import="shop.productshop.shopping.CustomerDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 계좌 삭제 처리</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>

<%

String buyer = (String)session.getAttribute("id");
String accountList = request.getParameter("accountList");
String passwd = request.getParameter("passwd");
int index = accountList.indexOf(" ");
String account = accountList.substring(0, index);

CustomerDBBean memberProcess = CustomerDBBean.getInstance();
int check = memberProcess.userCheck(buyer, passwd);

if(check != 1) {
%>
<script type="text/javascript">
	alert('비밀번호를 잘못입력했습니다.');
	history.go(-1);
</script>
<%
} else {
	BankDBBean bankProcess = BankDBBean.getInstance();
	bankProcess.deleteAccount(buyer, account);
%>
<script type="text/javascript">
	alert('계좌를 삭제하였습니다.');
</script>
<%
response.sendRedirect("buyForm.jsp");
}
%>

</body>
</html>