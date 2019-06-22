<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="java.io.*" %>
   <%
   request.setCharacterEncoding("UTF-8");

   //정규식표현.
   String id_validate = request.getParameter("id_validate");
   String idRegex = "^[a-zA-Z0-9_]{6,10}$";
   boolean check = Pattern.matches(idRegex, id_validate);
   //정규식표현에 맞는지 확인.

      if(id_validate==""){
        check = true;
      }
		
      out.print(check);
      //전달.

 	%>