<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인이 필요한 서비스 입니다.</title>
</head>
<body>
	<%	// 로그인 하지 않고 주요기능을 실행했을 경우, 로그인 페이지로 이동하기 위한 jsp파일
	
		response.sendRedirect("SignIn.jsp");
	%>
</body>
</html>