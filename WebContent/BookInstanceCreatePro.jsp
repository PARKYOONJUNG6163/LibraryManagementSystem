<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.BookDAO"%>
<%@page import="obj.Book"%>
<%@page import="java.util.*"%>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도서 객체 DB 등록</title>
</head>
<%
	BookDAO bookdao = new BookDAO();
	String isbn = request.getParameter("isbn");
	if(isbn != null){		
%>
	<script type="text/javascript">
    	alert("도서 등록이 완료되었습니다.");
    	location.href="BookInstanceCreate.jsp";
	</script>
<%
		bookdao.registerBook(isbn);
	} else {
%>
	<script type="text/javascript">
    	alert("도서를 선택해주세요!");
    	location.href="BookInstanceCreate.jsp";
	</script>
<% } %>
<body>

</body>
</html>