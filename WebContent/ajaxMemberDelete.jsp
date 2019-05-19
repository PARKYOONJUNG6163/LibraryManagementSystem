<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.MemberDAO"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	MemberDAO memberdao = new MemberDAO();
	if (memberdao.deleteMember(id)) {
		out.print("true");
	}else {
		out.print("false");
	}
%>