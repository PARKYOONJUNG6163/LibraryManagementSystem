<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="dao.ApplicationDAO"%>
<%@page import="obj.Application"%>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>도서신청 처리</title>
</head>
<body>
	
<script type="text/javascript">
<%
	String appNo = request.getParameter("appNo");
	String getApp[] = request.getParameterValues(appNo);
	String select = "";
	String reason = null;
	if(getApp.length==2){
		select = request.getParameterValues(appNo)[0];
		reason = request.getParameterValues(appNo)[1];
	} else {
		select = request.getParameterValues(appNo)[0];
	}
	
	ApplicationDAO appdao = new ApplicationDAO();
	Application app = appdao.getApplication(Integer.valueOf(appNo));
	
	if(new String(select).equals("Y")){ //수락
		app.setAccept("Y");
	}
	if(new String(select).equals("N")){ //처리중
		app.setAccept("N");
	}
	else if(new String(select).equals("R")){ //거절
		app.setAccept("R");
	}
	app.setReason(reason);
	appdao.updateApplication(app);
%>

	alert("처리가 완료되었습니다.");
	location.href="ApplicationManager.jsp";
</script>


</body>
</html>