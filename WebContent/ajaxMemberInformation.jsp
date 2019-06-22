<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*"%>
 <%@page import="dao.MemberDAO"%>
<% 
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	String birth = request.getParameter("birth");
	String address = request.getParameter("address");
	String id = (String)session.getAttribute("identifier");
	 
	MemberDAO memberdao = new MemberDAO();
	try {	// 수강신청한 과목 하나씩 디비에 저장	
		if(memberdao.modifyMemberInformation(id,name, tel, email, birth, address)){
			out.print("true");
		}else{
			out.print("false");
		}
	} catch (Exception e) {
		e.printStackTrace();
	} 
%>