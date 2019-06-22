<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.BookInfoDAO"%>
<%@page import="obj.Book"%>
<%@page import="obj.BookInstance"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>도서 보유 목록</title>
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
	<%
		String isbn = request.getParameter("isbn");
		BookInfoDAO bookinfodao = new BookInfoDAO();
		Book book = bookinfodao.getBook(isbn);
		ArrayList<BookInstance> booklist = bookinfodao.getBookInstance(isbn);
	%>
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
		<div id="main">
			<div class="inner">
				<!-- Header -->
				<header id="header">
				<h2>도서 보유 목록</h2>
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
					<table>
						<thead>
							<tr>
								<th width=150>책번호</th>
								<th width=150>카테고리</th>
								<th width=150>도서명</th>
								<th width=150>저자</th>
								<% if(!identifier.equals("root")){ %>
								<th width=150>예약/대여 가능 여부</th>
								<%}else{ %>
								<th width=150>삭제</th>
								<%} %>
							</tr>
						</thead>
						<tbody id="tbody">
							<%
								for (int i = 0; i < booklist.size(); i++) {
							%>
							<tr id="<%=booklist.get(i).getbookNo()%>">
								<td><%=booklist.get(i).getbookNo()%></td>
								<td><%=bookinfodao.getBookCategory(book.getCategoryKey())%></td>
								<td><%=book.getBookName()%></td>
								<td><%=book.getAuthor()%></td>
								<% if(!identifier.equals("root")){ %>
								<td>
									<%
										if (booklist.get(i).getIsreservation().equals("REV")) {
									%> 이미 예약된 책입니다. <%
										} else if (booklist.get(i).getIsreservation().equals("YES")) {
									%> 대여된 책입니다. <%
										} else {
									%>
									<button
										onClick="rentBookInstance(<%=booklist.get(i).getbookNo()%>)">
										대여</button>
									<button
										onClick="reserveBook(<%=booklist.get(i).getbookNo()%>,'REV')">
										예약</button> <%
 	}
 %>
									</td>
								<%}else{ %>
									<% if(booklist.get(i).getIsreservation().equals("REV") || booklist.get(i).getIsreservation().equals("YES")){ %>
										<td>
											<button onClick="removeBookInstance(<%=book.getIsbn() %>,<%=booklist.get(i).getbookNo()%>,'<%=identifier %>')">삭제</button>
										</td>
									<%}else{ %>
										<td>
											대여 또는 예약 상태
										</td>
									<%} %>
								<%} %>
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
			<jsp:param name="pageName" value="sidebar" />
		</jsp:include>
	</div>
	<!-- Scripts -->
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts"/>
	</jsp:include>
	<script src="assets/js/BookManagement.js"></script>
</body>
</html>