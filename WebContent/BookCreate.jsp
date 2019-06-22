<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>도서 정보 등록</title>
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
		location.href = "MainChart.jsp"
	</script>
	<%
		if (!(session.getAttribute("identifier").equals("root"))) {
	%>
	<script type="text/javascript">
		alert("접근 권한이 없습니다.")
		location.href = "MainChart.jsp"
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
					<h2>도서 정보 등록</h2>
					<<ul class="icons">
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
						<form onSubmit="return insertBookInfo();" method="post"
							name="check" action="BookCreate.jsp">
							<label for="isbn">ISBN</label> <input type="text" id="isbnInput"
								name="isbn" required /><br> <label for="category">분류</label>
							<select name="demo-category" id="demo-category">
								<option value>- Category -</option>
								<option value="1">철학</option>
								<option value="2">사회과학</option>
								<option value="3">자연과학</option>
								<option value="4">기술과학</option>
								<option value="5">예술</option>
								<option value="6">언어</option>
								<option value="7">문학</option>
								<option value="8">역사</option>
							</select><br> <br> <label for="name">도서명</label> <input
								type="text" id="nameInput" required /> <br> <label
								for="author">저자</label> <input type="text" id="authorInput"
								name="author" /> <br> <label for="publisher">출판사</label> <input
								type="text" id="publisherInput" name="publisher" /> <br> <label
								for="publishedDate">출판일</label> <input type="text"
								id="publishedDateInput" name="publishedDate" /> <br> <br>
							<center>
								<input type="submit" class="button big" value="등록하기" />
							</center>
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
	<!-- Scripts -->
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts"/>
	</jsp:include>
	<script src="assets/js/BookManagement.js"></script>
</body>
</html>