<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.MemberDAO"%>
<%@page import="obj.Member"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 삭제</title>
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
					<h2>회원 삭제</h2>
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
									<th>구분</th>
									<th>ID</th>
									<th>PASSWORD</th>
									<th>이름</th>
									<th>전화번호</th>
									<th>이메일</th>
									<th>생일</th>
									<th>주소</th>
								</tr>
							</thead>
							<tbody>
								<%
									MemberDAO memberdao = new MemberDAO();
									List<Member> memberlist = memberdao.getMemberList();

									for (Member member : memberlist) {
								%>
								<tr>
								<tr id="<%=member.getId()%>">
									<td><button type="button"
											onclick="deleteMember(<%=member.getId()%>);">삭제</button></td>
									<td><%=member.getId()%></td>
									<td><%=member.getPw()%></td>
									<td><%=member.getName()%></td>
									<td><%=member.getTel()%></td>
									<td><%=member.getEmail()%></td>
									<td><%=member.getBirth()%></td>
									<td><%=member.getAddress()%></td>
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
	<script src="assets/js/MemberManagement.js"></script>
</body>
</html>