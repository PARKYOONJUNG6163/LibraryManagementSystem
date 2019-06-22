<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="dao.RentDAO"%>
<%
	request.setCharacterEncoding("utf-8");

	String bookNo = request.getParameter("bookNo");
	String identifier = (String)session.getAttribute("identifier");
	RentDAO rentdao= new RentDAO();
	boolean result = rentdao.rentBookInstance(bookNo,identifier);
	if(result){
		out.print("true");
	}else{
		out.print("false");
	}
%>