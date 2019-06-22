<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.RentDAO"%>
<%
	request.setCharacterEncoding("utf-8");

	String rentNo = request.getParameter("rentNo");
	RentDAO rentdao = new RentDAO();
	if (rentdao.updateExt(Integer.parseInt(rentNo))) {
		out.print("true");
	}else {
		out.print("false");
	}
%>