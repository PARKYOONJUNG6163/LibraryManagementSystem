<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import = "java.text.*" %>
<%@page import="dao.ApplicationDAO"%>
<%@page import="obj.Application"%>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>도서 신청 pro</title>
</head>
<body>

<%
		String appRequest[] = request.getParameterValues("application");
		String id = (String)session.getAttribute("identifier");
		
		Calendar oCalendar = Calendar.getInstance();
		String year = String.valueOf(oCalendar.get(Calendar.YEAR));
		oCalendar.add(Calendar.MONTH, 1);// 한달이 적게 나와서 추가한 코드
		int monthInt = oCalendar.get(Calendar.MONTH);
		String month="";
		if(monthInt<=9){
			month="0"+String.valueOf(monthInt);
		}
		else{
			month=String.valueOf(monthInt);
		}
		int dayInt = oCalendar.get(Calendar.DAY_OF_MONTH);
		String day="";
		if(dayInt<=9){
			day="0"+String.valueOf(dayInt);
		}
		else{
			day=String.valueOf(dayInt);
		}
		String date = year+month+day; // 오늘날짜
		
		Application app = new Application();
		app.setId(id); //*********************본인아이디가 들어가게 수정
		app.setBookName(appRequest[0]);
		app.setAuthor(appRequest[1]);
		app.setPublisher(appRequest[2]);
		app.setApplicationDate(date);
		
		ApplicationDAO appdao = new ApplicationDAO();
		appdao.insertApplication(app);
%>
</body>

	<script type="text/javascript">
    	alert("신청이 완료되었습니다.");
    	location.href="Application.jsp";
    </script>
    
    
</html>