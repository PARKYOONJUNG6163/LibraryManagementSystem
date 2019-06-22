<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.RentDAO"%>
<%@page import="obj.Rent"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<title>대여 목록 조회</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="is-preload">
	<%
		if (session.getAttribute("identifier") == null) {
	%>			
			<script type="text/javascript">
				alert("접근 권한이 없습니다.")
				location.href="MainChart.jsp"
			</script>
	<%			
			if(!(session.getAttribute("identifier").equals("root"))){
	%>
		<script type="text/javascript">
			alert("접근 권한이 없습니다.")
			location.href="MainChart.jsp"
		</script>
	<%
			}
		}
	%>
	<% String identifier = (String)session.getAttribute("identifier"); %>
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<header id="header">
					<h2>대여 목록 조회</h2>
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

						<table>
							<thead>
								<tr>
									<th>대여번호</th>
									<th>id</th>
									<th>도서번호</th>
									<th>대여일</th>
									<th>반납일</th>
									<th>연장</th>
								</tr>
							</thead>
							<tbody>
								<%
									RentDAO rentdao = new RentDAO();
									List<Rent> rentlist = rentdao.getRentList();

									for (Rent rent : rentlist) {
								%>
								<tr>
									<td><%=rent.getRentNo()%></td>
									<td><%=rent.getId()%></td>
									<td><%=rent.getBookNo()%></td>
									<td><%=rent.getRentDate()%></td>
									<td><%=rent.getReturnDate()%></td>
									<td><%=rent.getExtension()%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
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
</body>
</html>