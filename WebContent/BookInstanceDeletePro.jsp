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
<title>도서 객체 DB 삭제</title>
</head>
<%
	BookDAO bookdao = new BookDAO();
	String isbn = request.getParameter("isbn");
	String id = request.getParameter("id");
	int bookNo = Integer.parseInt(request.getParameter("bookNo"));
	System.out.println(isbn + id + bookNo);
	boolean result = bookdao.removeBook(isbn, bookNo, id);
	if(result){
		out.print("true");
	}else{
		out.print("false");
	}
%>
<body>
</body>
</html>