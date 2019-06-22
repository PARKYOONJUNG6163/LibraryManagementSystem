<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.BookInfoDAO"%>
<%@page import="obj.Book"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<title>도서 수정</title>
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
					<h2>도서 수정</h2>
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
									<th>isbn</th>
									<th>분류</th>
									<th>도서명</th>
									<th>저자</th>
									<th>출판사</th>
									<th>출판일</th>
								</tr>
							</thead>
							<tbody>
								<%
									BookInfoDAO bookinfodao = new BookInfoDAO();
									List<Book> booklist = bookinfodao.getBookList();

									for (Book book : booklist) {
								%>
								<tr>
									<td><button type="button"
											onclick="getModifyForm(<%=book.getIsbn()%>);">수정</button></td>
									<td><%=book.getIsbn()%></td>
									<td><%=book.getCategoryKey()%></td>
									<td><%=book.getBookName()%></td>
									<td><%=book.getAuthor()%></td>
									<td><%=book.getPublisher()%></td>
									<td><%=book.getPublishedDate()%></td>
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
		<jsp:include page="./assets/shared/scripts.jsp" flush="false">
			<jsp:param name="pageName" value="scripts"/>
		</jsp:include>
		<script src="assets/js/BookManagement.js"></script>
</body>
</html>