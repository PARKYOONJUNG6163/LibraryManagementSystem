<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>회원 가입</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css?after" />
	</head>
	<body class="is-preload">

     <%
 		String identifier = (String)session.getAttribute("identifier");
 
    	if(identifier != null){
    		%>
    		<script>alert("잘못된 접근입니다.");
    				location.href = "InformationGet.jsp";
    		</script>
    		
    		<%
    		
    	}
    %>
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<header id="header">
									<h2>회원가입</h2>
									<ul class="icons">
										<a href ="SignUp.jsp" class="button primary">SignUp</a>
										<a href ="SignIn.jsp" class="button">SignIn</a>
									</ul>
								</header>

							<!-- Banner -->
								<section id="banner">
									<div class="content">
										<!-- Text -->
									<form onSubmit="return val();" method="post" name="check" action="SignIn.jsp">
										<label for="id">아이디</label> 
										<input type="text" placeholder="문자 or 숫자" id="id" name="ids" onblur="idChecking();" required>
										<input type="button" value="중복 체크" id = "overlapCheck" onclick="checkDup();"> 
										<br>
										<label for="pwd">Password</label> 
										<input type="password" id="pwd" name="pwds" placeholder="문자 or 숫자, 8자리 이상" onblur="pwdChecking();" required>
										<br> 
										<label for="cpwd">Password 확인</label> 
										<input type="password" id="cpwd" onblur="samePwd();" required> 
										<br> 
										<label for="name">이름</label> 
										<input type="text" id="nameInput" name="name" required>
										<br> 
										<label for="tel">연락처</label> 
										<input type="text" id="telInput" name="tel" onblur="telChecking();" required>
										<br> 
										<label for="email">이메일</label>
										<input type="email" id="emailInput" name="email" onblur="emailChecking();" required>
										<br> 
										<label for="birth">생년월일</label>
										<input type="date" id="birthInput" name="birth" required>
										<br> 
										<label for="address">주소</label>
										<input type="text" id="addInput" name="address">
										<br> 
										<br>
										<center><input type="submit" class="button big" value="가입하기"></center>
									</form>
									</div>
								</section>	
						</div>
					</div>

	</div>

		<!-- Scripts -->
		<jsp:include page="./assets/shared/scripts.jsp" flush="false">
			<jsp:param name="pageName" value="scripts"/>
		</jsp:include>
		<script src="assets/js/SignUp.js"></script>
	</body>
</html>