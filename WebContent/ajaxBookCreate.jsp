<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.BookInfoDAO"%>
<%
	request.setCharacterEncoding("utf-8");

	String isbn = request.getParameter("isbn");
	int category = Integer.parseInt(request.getParameter("category"));
	String name = request.getParameter("name");
	String author = request.getParameter("author");
	String publisher = request.getParameter("publisher");
	String publishedDate = request.getParameter("publishedDate");

	BookInfoDAO bookinfodao = new BookInfoDAO();
	int result = bookinfodao.registerBookInfo(isbn, category, name, author, publisher, publishedDate);
	if (result == 0) {
		out.print("0");
	} else if(result == 1){
		out.print("1");
	}else {
		out.print("2");
	}
%>