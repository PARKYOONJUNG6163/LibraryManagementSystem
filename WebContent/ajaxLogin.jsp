<%@page import="java.io.PrintWriter"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String rank = request.getParameter("rank");
	
	String response_string;
	PrintWriter outResponse = response.getWriter();				// script쪽으로 response할때 쓰이는 writer
	
	MemberDAO memberdao = new MemberDAO();
		
	if(memberdao.checkExistMember(id, pwd)){							
		response_string = id;						
		session.setAttribute("identifier", id);		
	}else{
		response_string = "no exist user";				
	}						
	
	outResponse.write(response_string);					// output
	outResponse.flush();
	outResponse.close();
	%>
