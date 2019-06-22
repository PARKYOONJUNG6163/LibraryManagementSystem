<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.BookDAO"%>
<%@page import="java.util.ArrayList" %>
<%@page import="obj.Book" %>

<%
	request.setCharacterEncoding("utf-8");

	int bookNo = Integer.parseInt(request.getParameter("bookNo"));
	String isRev = request.getParameter("isRev");
	String identifier = (String)session.getAttribute("identifier");
	System.out.println(identifier);
	BookDAO bookinstancedao = new BookDAO();
	if(bookinstancedao.updateRev(bookNo, isRev,identifier)){
		out.print("true");
	}else{
		out.print("false");
	}
%>