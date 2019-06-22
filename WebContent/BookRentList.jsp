<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.RentDAO"%>
<%@page import="dao.BookInfoDAO"%>
<%@page import="obj.Rent"%>
<%@page import="obj.Book"%>
<%@page import="java.util.*"%>
<%@ page import="java.text.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>도서 대여 목록</title>
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
		BookInfoDAO bookinfo = new BookInfoDAO();
		RentDAO rentdao = new RentDAO();
		List<Rent> list = rentdao.getRentListID(identifier);
	%>
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
		<div id="main">
			<div class="inner">
				<!-- Header -->
				<header id="header">
				<h2>도서 대여 목록</h2>
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
								<th width=150>예약 번호</th>
								<th width=150>도서 번호</th>
								<th width=150>도서명</th>
								<th width=150>대여 날짜</th>
								<th width=150>반납 날짜</th>
								<th width=150>연장 가능 여부</th>
								<th width=150>반납</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<%
								for (int i = 0; i < list.size(); i++) {
							%>
							<tr id="<%=list.get(i).getRentNo()%>>">
								<td><%=list.get(i).getRentNo()%></td>
								<td><%=list.get(i).getBookNo()%></td>
								<td><%=bookinfo.getBookName(list.get(i).getBookNo())%></td>
								<td><%=list.get(i).getRentDate()%></td>
								<td><%=list.get(i).getReturnDate()%></td>
								<td>
									<%
										if (list.get(i).getExtension().equals("NO")) {
									%>
									<button onClick="extendRent(<%=list.get(i).getRentNo()%>);">연장</button>
									<%
										} else {
									%> 이미 연장된 책입니다. <%
										}
									%>
								</td>
								<td>
									<button
										onClick="returnBook(<%=list.get(i).getRentNo()%>,'<%=identifier%>');">반납</button>
								</td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<h3>연체 목록</h3>
					<table id="overdue">
						<thead>
							<tr>
								<th width=100>대여번호</th>
								<th width=100>도서명</th>
								<th width=100>대여날짜</th>
								<th width=100>반납날짜</th>
								<th width=100>연장여부</th>
							</tr>
						</thead>
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
		<jsp:param name="pageName" value="scripts" />
	</jsp:include>
	<script src="assets/js/BookManagement.js"></script>
	<script type="text/javascript">
		<%
		String start = null;
		String end = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String date = sdf.format(new Date());

		if (list.isEmpty() == false) {
			for (Rent rent : list) {
			%> 		 
				var tr = document.createElement("tr");
				var td1 = document.createElement("td");
				var td2 = document.createElement("td");
				var td3 = document.createElement("td");
				var td4 = document.createElement("td");
				var td5 = document.createElement("td");
				
				td1.appendChild(document.createTextNode("<%=rent.getRentNo()%>"));
				tr.appendChild(td1);
				td2.appendChild(document.createTextNode("<%=bookinfo.getBookName(rent.getBookNo())%>"));
				tr.appendChild(td2);
				td3.appendChild(document.createTextNode("<%=rent.getRentDate()%>"));
				tr.appendChild(td3);
				td4.appendChild(document.createTextNode("<%=rent.getReturnDate()%>"));
				tr.appendChild(td4);
				td5.appendChild(document.createTextNode("<%=rent.getExtension()%>"));
				tr.appendChild(td5);
				var obj;
			<%
				String returnDate = rent.getReturnDate(); //반납날짜
				end = returnDate;
				String compare = end.split("-")[0] + end.split("-")[1] + end.split("-")[2];
				System.out.println("compare : " + compare + " " + "currentDate : " + date );
				if (returnDate.isEmpty() == false) {
					if (Integer.parseInt(compare) < Integer.parseInt(date)) { //연체목록
				%>
		   	        	obj = document.getElementById("overdue");
	            <%
					}
				%>
					obj.appendChild(tr);
				<%
				}
			}
		}
		%>

	</script>
</body>
</html>