<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.MemberDAO"%>
<%@page import="obj.Member"%>
<!DOCTYPE html>
<html>
<head>
<title>내 정보 조회</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css?after" />
</head>
<body class="is-preload">
	<%
		String identifier = (String) session.getAttribute("identifier");

		if (identifier == null) {
	%>
	<script>
		alert("로그인이 필요한 서비스입니다.");
		location.href = "Redirect.jsp";
	</script>
	<%} %>
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<header id="header">
					<h2>내 정보 조회</h2>
					<ul class="icons">
						<p><%=identifier%>
							님 로그인 중
						</p>
						<a href="Logout.jsp" class="button big">Logout</a>
					</ul>
				</header>

				<!-- Banner -->
				<section id="banner">
					<div class="content">
						<!-- Text -->
						<%
							MemberDAO memberdao = new MemberDAO();
								Member m = memberdao.getMemberInformation(identifier);
						%>
						<div class="mypage-wrapper">
							<div class="mypage-container">
								<div class="mypage-content">
									<div class="mypage-column">아이디</div>
									<div class="mypage-row"><%=m.getId()%></div>
								</div>
								<div class="mypage-content">
									<div class="mypage-column">이메일</div>
									<div class="mypage-row"><%=m.getEmail()%></div>
								</div>
								<div class="mypage-content">
									<div class="mypage-column">전화번호</div>
									<div class="mypage-row"><%=m.getTel()%></div>
								</div>
								<div class="mypage-content">
									<div class="mypage-column">생년월일</div>
									<div class="mypage-row"><%=m.getBirth()%></div>
								</div>
								<div class="mypage-content">
									<div class="mypage-column">주소</div>
									<div class="mypage-row"><%=m.getAddress()%></div>
								</div>
								<div class="mypage-delete">
									<button type="button" onclick="outMember('<%=m.getId()%>');">삭제</button>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
		<!-- Sidebar -->
		<jsp:include page="./assets/shared/sidebar.jsp" flush="false">
			<jsp:param name="pageName" value="sidebar"/>
		</jsp:include>
	</div>

	<!-- Scripts -->
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts"/>
	</jsp:include>
	<script src="assets/js/MemberManagement.js"></script>
</body>
</html>