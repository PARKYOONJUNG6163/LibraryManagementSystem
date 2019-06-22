<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.RentDAO"%>
<%
	request.setCharacterEncoding("utf-8");

	int rentNo = Integer.parseInt(request.getParameter("rentNo"));
	String id = request.getParameter("id");
	RentDAO rentdao = new RentDAO();
	if (rentdao.deleteRent(rentNo, id)) {
		out.print("true");
	}else {
		out.print("false");
	}
%>