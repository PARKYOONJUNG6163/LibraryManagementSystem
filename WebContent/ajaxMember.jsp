<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.MemberDAO"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	String birth = request.getParameter("birth");
	String address = request.getParameter("address");
	
	MemberDAO memberdao = new MemberDAO();
	if(memberdao.registerMemberInformation(id, pw, name, email, tel, birth, address)){
		out.print("true");
	}else{
		out.print("false");
	}
%>