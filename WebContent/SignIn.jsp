<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
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
					<h2>로그인</h2>
					<ul class="icons">
						<a href="SignUp.jsp" class="button primary">SignUp</a>
						<a href="SignIn.jsp" class="button">SignIn</a>
					</ul>
				</header>
				<!-- Banner -->
				<section id="banner">
					<div class="content">
						<!-- Text -->
						<form id="signInForm" action="MainChart.jsp" method="post">
							<label for="id">ID</label><input type="text" id="id" name="ids" /><br/>
							<label for="password">Password</label><input type="password" name="pwd" /><br/> 
							<button	type="button" class="btn" onclick="do_login();">로그인</button>
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
	<script src="assets/js/SignIn.js"></script>

</body>
</html>