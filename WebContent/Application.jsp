<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>도서 신청</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
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
				<h2>도서 신청</h2>
				<ul class="icons">
					<p><%=identifier%>
						님 로그인 중
					</p>
					<a href="Logout.jsp" class="button big">Logout</a>
				</ul>
				</header>
				<br>

				<!-- Banner -->
				<form method="post" action="ApplicationPro.jsp">
					<table>
						<thead>
							<tr>
								<th width=100>도서명</th>
								<th width=100>저자명</th>
								<th width=100>출판사</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td width=100><input type="text" placeholder="도서명" name="application">
								</td>
								<td width=100><input type="text" placeholder="저자명" name="application">
								</td>
								<td width=100><input type="text" placeholder="출판사" name="application">
								</td>
							</tr>
						</tbody>
					</table>
					<br> <input type="submit" value="신청">
				</form>
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
</body>
</html>
