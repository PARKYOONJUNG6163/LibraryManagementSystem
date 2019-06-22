<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.RentDAO"%>
<%@page import="obj.Rent"%>
<%@page import="dao.BookInfoDAO"%>
<%@page import="obj.Book"%>
<%@page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>도서 관리 시스템</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="is-preload">
	<!-- 로그인한후 본인의 대여목록만 가져오도록 하는 코드 추가 -->
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
		<div id="main">
			<div class="inner">
				<!-- Header -->
				<header id="header"> <%
 	if (session.getAttribute("identifier") == null) {
 %>
				<ul class="actions">
					<li><a href="SignUp.jsp" class="button primary">SignUp</a></li>
					<li><a href="SignIn.jsp" class="button">SignIn</a></li>
				</ul>
				<%
					} else {
				%>
				<ul class="actions">
					<li><a href="Logout.jsp" class="button primary">LogOut</a></li>
				</ul>
				<%
					}
				%>
				<h3>Chungnam National University Book Management System</h3>
				</header>
				<!-- Banner -->
				<section id="banner">
				<div class="content">
					<header>
					<h1>
						충남대학교<br /> 도서 관리 시스템
					</h1>
					<p>박주영 함진규 박윤정 허아정</p>
					</header>
					</br> </br>
					<h2>인기도서 일일차트</h2>
					<%
						RentDAO rentdao = new RentDAO();
						BookInfoDAO bookdao = new BookInfoDAO();

						Calendar oCalendar = Calendar.getInstance();
						String year = String.valueOf(oCalendar.get(Calendar.YEAR));
						oCalendar.add(Calendar.MONTH, 1);// 한달이 적게 나와서 추가한 코드
						int monthInt = oCalendar.get(Calendar.MONTH);
						String month = "";
						if (monthInt <= 9) {
							month = "0" + String.valueOf(monthInt);
						} else {
							month = String.valueOf(monthInt);
						}
						oCalendar.add(Calendar.DAY_OF_MONTH, -1);
						int dayInt = oCalendar.get(Calendar.DAY_OF_MONTH);
						String day = "";
						if (dayInt <= 9) {
							day = "0" + String.valueOf(dayInt);
						} else {
							day = String.valueOf(dayInt);
						}
						String date = year + month + day; // 오늘날짜

						List<Integer> rentRankList = rentdao.getRank(date);
					%>
					<table id="table">
						<thead>
							<tr>
								<th width=150>순위</th>
								<th width=150>카테고리</th>
								<th width=150>도서명</th>
								<th width=150>저자</th>
								<th width=150>출판사</th>
								<th width=150>출판일</th>
							</tr>
						</thead>
						<tbody id="tbody">
						</tbody>
					</table>
				</div>
				</section>
			</div>
		</div>
		<%
			if (session.getAttribute("identifier") != null) {
		%>
		<jsp:include page="./assets/shared/sidebar.jsp" flush="false">
			<jsp:param name="pageName" value="sidebar" />
		</jsp:include>
		<%
			} else {
		%>
		<div id="sidebar">
			<div class="inner">
				<!-- Menu -->
				<nav id="menu"> <header class="major"> <a
					href="MainChart.jsp"><h2>Library System</h2></a>
				<h2>Menu</h2>
				</header>
				<ul>
					<li><a href="BookSearch.jsp">도서 검색</a></li>
				</ul>
				</nav>
				<!-- Section -->
				<section> <header class="major">
				<h2>Get in touch</h2>
				</header>
				<ul class="contact">
					<li class="fa-envelope-o"><a href="#">information@untitled.tld</a></li>
					<li class="fa-phone">(000) 000-0000</li>
					<li class="fa-home">1234 Somewhere Road #8254<br />
						Nashville, TN 00000-0000
					</li>
				</ul>
				</section>
				<!-- Footer -->
				<footer id="footer">
				<p class="copyright">
					&copy; Untitled. All rights reserved. Demo Images: <a
						href="https://unsplash.com">Unsplash</a>. Design: <a
						href="https://html5up.net">HTML5 UP</a>.
				</p>
				</footer>
			</div>
		</div>
		<%
			}
		%>
	</div>
	<script type="text/javascript">	
	var tb = document.getElementById("tbody");
	  <%int i = 1;

			if (rentRankList.isEmpty() == false) {

				for (Integer rentRank : rentRankList) {

					Book book = bookdao.getBook(String.valueOf(rentRank));%> 		
 		var tr = document.createElement("tr");
 		var td0 = document.createElement("td");
		var td1 = document.createElement("td");
		var td2 = document.createElement("td");
		var td3 = document.createElement("td");
		var td4 = document.createElement("td");
		var td5 = document.createElement("td");
				
		td0.appendChild(document.createTextNode("<%=i%>"));
		tr.appendChild(td0);
		td1.appendChild(document.createTextNode("<%=bookdao.getBookCategory(book.getCategoryKey())%>"));
		tr.appendChild(td1);
		td2.appendChild(document.createTextNode("<%=book.getBookName()%>"));
		tr.appendChild(td2);
		td3.appendChild(document.createTextNode("<%=book.getAuthor()%>"));
		tr.appendChild(td3);
		td4.appendChild(document.createTextNode("<%=book.getPublisher()%>"));
		tr.appendChild(td4);
		td5.appendChild(document.createTextNode("<%=book.getPublishedDate()%>
		"));
		tr.appendChild(td5);

		tb.appendChild(tr);
	<%i++;
				}
			}%>
		
	</script>
	<!-- Scripts -->
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts" />
	</jsp:include>
</body>
</html>
