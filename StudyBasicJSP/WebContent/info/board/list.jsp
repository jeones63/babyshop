<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="info.board.BoardDBBean" %>
<%@ page import="info.board.BoardDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {
	background-image: url("../images/prince1.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}
a {
	text-decoration: none;
}
</style>
</head>
<body bgcolor="<%=bodyback_c%>">

<%!
int pageSize = 10;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
String pageNum = request.getParameter("pageNum");

if(pageNum == null) {
	pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);	// 현재 페이지 번호
int startRow = (currentPage - 1)*pageSize + 1;	// 현재 페이지의시작 번호
int endRow = currentPage*pageSize;				// 현재 페이지의 끝 번호
int count = 0;									// 전체 글 수
int number = 0;
List<BoardDataBean> articleList = null;

BoardDBBean dbPro = BoardDBBean.getInstance();
count = dbPro.getArticleCount();

if(count>0) {
	articleList = dbPro.getArticles(startRow, pageSize);
}

number = count-(currentPage-1)*pageSize;
%>

<div class="tittext">
	<h1>어린이 체험학습 정보공유 게시판</h1>
	<p>글목록(전체 글:<%=count %>)</p>
</div>

<% if(count==0) { %>

<table>
	<tr>
		<td align="center">
			게시판에 저장된 글이 없습니다.
		</td>
	</tr>
</table>

<%} else { %>

<table class="tb1">
	<tr height="30">
		<td colspan="6" align="left" bgcolor="<%=value_c %>">
			<a href="writeForm.jsp" id="write">글쓰기</a>
		</td>
	</tr>
	<tr height="30" bgcolor="<%=value_c%>">
		<td align="center" width="50" class="lavel">번호</td>
		<td align="center" width="250" class="lavel">제 목</td>
		<td align="center" width="100" class="lavel">작성자</td>
		<td align="center" width="200" class="lavel">작성일</td>
		<td align="center" width="50" class="lavel">조회</td>
		<td align="center" width="100" class="lavel">IP</td>
	</tr>
	<%
	for(int i=0; i < articleList.size(); i++) {
		BoardDataBean article = articleList.get(i);
	%>
		<tr height="30">
			<td width="50"><%=number-- %></td>
			<td width="250" align="left" class="content">
	<%
		int wid = 0;
		if(article.getRe_level() > 0) {
			wid = 5*(article.getRe_level());
	%>
			<%-- <img src="../images/level.png" width="<%=wid %>" height="16"> --%> <!-- 생략가능 -->
			<img src="../images/re.png">
	<%	} else {%>
		<img src="../images/level.png" width="<%=wid %>" height="16">
	<%	} %>
	
	<a href="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
		<%=article.getSubject() %></a>
	<% if(article.getReadcount()>=10) { %>
		<img src="../images/hot.png" border="0" height="16">
	<% } %></td>
	<td width="100" align="center">
		<a href="mailto:<%=article.getEmail() %>">
			<%=article.getWriter() %></a></td>
	<td width="150"><%=sdf.format(article.getReg_date()) %></td>
	<td width="50"><%=article.getReadcount() %></td>
	<td width="100"><%=article.getIp() %></td>
	</tr>
<%}%>
</table>
<%}%>

<%
if(count>0) {
	int pageCount = count/pageSize + (count%pageSize == 0?0:1);
	int startPage = 1;
	
	if(currentPage%10 != 0)
		startPage = (int)(currentPage/10)*10+1;
	else
		startPage = ((int)(currentPage/10)-1)*10+1;
	
	int pageBlock = 10;
	int endPage = startPage + pageBlock -1;
	if(endPage > pageCount) endPage = pageCount;
	
	if(startPage > 10) {%>
		<a href="list.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<%	}
	
	for(int i=startPage; i<=endPage; i++) {%>
		<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
<%	} 
	
	if(endPage < pageCount) { %>
		<a href="list.jsp?pageNum=<%=startPage + 10 %>">[다음]</a>
<%

	}
}
%>
	
</body>
</html>