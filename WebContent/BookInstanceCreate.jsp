<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.BookInfoDAO"%>
<%@page import="obj.Book"%>
<%@page import="dao.BookDAO"%>
<%@page import="java.util.*"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>도서 객체 등록</title>
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
		if (!(session.getAttribute("identifier").equals("root"))) {
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
				<h2>도서 객체 등록</h2>
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
					<%
						BookInfoDAO bookdao = new BookInfoDAO();
						List<Book> booklist = bookdao.getBookList();

						BookDAO bookInsDAO = new BookDAO();
					%>

					<form method="post" action="BookInstanceCreatePro.jsp">
						<table>
							<thead>
								<tr>
									<th width=50></th>
									<th width=150>카테고리</th>
									<th width=150>도서명</th>
									<th width=150>저자</th>
									<th width=150>출판사</th>
									<th width=150>출판일</th>
									<th width=150>재고</th>
								</tr>
							</thead>
							<tbody id="tbody">
							</tbody>
						</table>
						<input type="submit" value="등록">
					</form>
				</div>
				</section>
			</div>
		</div>

		<!-- Sidebar -->
		<jsp:include page="./assets/shared/sidebar.jsp" flush="false">
			<jsp:param name="pageName" value="sidebar" />
		</jsp:include>
	</div>
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts"/>
	</jsp:include>
	<script type="text/javascript">
				<%for (Book book : booklist) {%>
					var tbody = document.getElementById("tbody");
					var tr = document.createElement("tr");
					var radio = document.createElement("input");
					var label = document.createElement("label");
					
					radio.setAttribute("type","radio");
					radio.setAttribute("value","<%=book.getIsbn()%>");
					radio.setAttribute("name", "isbn");
					radio.setAttribute("id","<%=book.getIsbn()%>");
					
					label.setAttribute("for","<%=book.getIsbn()%>")
					
					var td0 = document.createElement("td");
					var td1 = document.createElement("td");
					var td2 = document.createElement("td");
					var td3 = document.createElement("td");
					var td4 = document.createElement("td");
					var td5 = document.createElement("td");
					var td6 = document.createElement("td");
					
					td0.appendChild(radio);
					td0.appendChild(label);
					tr.appendChild(td0);
					td1.appendChild(document.createTextNode("<%=bookdao.getBookCategory(book.getCategoryKey())%>"));
					tr.appendChild(td1);
					td2.appendChild(document.createTextNode("<%=book.getBookName()%>"));
					tr.appendChild(td2);
					td3.appendChild(document.createTextNode("<%=book.getAuthor()%>"));
					tr.appendChild(td3);
					td4.appendChild(document.createTextNode("<%=book.getPublisher()%>"));
					tr.appendChild(td4);
					td5.appendChild(document.createTextNode("<%=book.getPublishedDate()%>"));
					tr.appendChild(td5);
					td6.appendChild(document.createTextNode("<%=bookInsDAO.getBookNum(book.getIsbn())%>"));
		tr.appendChild(td6);

		tbody.appendChild(tr);
	<%}%>
	</script>
</body>
</html>