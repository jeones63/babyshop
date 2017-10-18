<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.productshop.master.ShopProductDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정처리</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>

<%
String realFolder = "";
String filename = "";
MultipartRequest imageUp = null;

String saveFolder = "/imageFile";
String encType = "utf-8";
int maxSize = 2*1024*1024;

ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);

try {
	imageUp = new MultipartRequest(
			request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> files = imageUp.getFileNames();
	
	while(files.hasMoreElements()) {
		String name = (String)files.nextElement();
		
		filename = imageUp.getFilesystemName(name);
	}
} catch(IOException ioe) {
	System.out.println(ioe);
} catch(Exception ex) {
	System.out.println(ex);
}
%>

<jsp:useBean id="product" scope="page"
	class="shop.productshop.master.ShopProductDataBean">
</jsp:useBean>

<%
int product_id = Integer.parseInt(imageUp.getParameter("product_id"));
String product_kind = imageUp.getParameter("product_kind");
String product_title = imageUp.getParameter("product_title");
String product_price = imageUp.getParameter("product_price");
String product_count = imageUp.getParameter("product_count");
String brand = imageUp.getParameter("brand");
String product_content = imageUp.getParameter("product_content");
String discount_rate = imageUp.getParameter("discount_rate");
		
product.setProduct_kind(product_kind);
product.setProduct_title(product_title);
product.setProduct_price(Integer.parseInt(product_price));
product.setProduct_count(Short.parseShort(product_count));
product.setBrand(brand);
product.setProduct_image(filename);
product.setProduct_content(product_content);
product.setDiscount_rate(Byte.parseByte(discount_rate));
product.setReg_date(new Timestamp(System.currentTimeMillis()));

ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
productProcess.updateProduct(product, product_id);

response.sendRedirect("productList.jsp?product_kind=" + product_kind);
%>
</body>
</html>