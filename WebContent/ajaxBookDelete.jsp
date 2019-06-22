<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.BookInfoDAO"%>
<%
	request.setCharacterEncoding("utf-8");

	String isbn = request.getParameter("isbn");
	BookInfoDAO bookinfodao = new BookInfoDAO();
	if (bookinfodao.deleteBookInfo(isbn)) {
		out.print("true");
	}else {
		out.print("false");
	}
%>