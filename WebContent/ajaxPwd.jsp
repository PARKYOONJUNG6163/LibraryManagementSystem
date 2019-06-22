<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="java.io.*" %>
   <%
   String pwd_validate = request.getParameter("pwd_validate");
   if(pwd_validate == null){
	   out.print(false);
	   //전달.
   }
   String pwdRegex="^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$"; //pwd 위한 정규표현식 
   boolean check = Pattern.matches(pwdRegex, pwd_validate);
   if(pwd_validate==""){
  	 check = true;
    }

   out.print(check);
   //전달.
%>