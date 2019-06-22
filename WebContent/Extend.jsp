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
<title>도서 연장</title>
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
	<!-- 로그인한후 본인의 대여목록만 가져오도록 하는 코드 추가 -->
	<% String identifier = (String)session.getAttribute("identifier"); %>
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<header id="header">
				<h2>도서 연장</h2>
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
						RentDAO rentdao = new RentDAO();
						BookInfoDAO bookdao = new BookInfoDAO();
						List<Rent> rentlist = rentdao.getRentListUser();

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
						int dayInt = oCalendar.get(Calendar.DAY_OF_MONTH);
						String day = "";
						if (dayInt <= 9) {
							day = "0" + String.valueOf(dayInt);
						} else {
							day = String.valueOf(dayInt);
						}
						String date = year + month + day; // 오늘날짜
						
					%>
					<!-- Text -->
					<h3>연장가능목록</h3>
					<form method="post" action="ExtendPro.jsp">

						<table id="available">
							<tr id="tr">
								<th width=50></th>
								<th width=100>대여번호</th>
								<th width=100>도서명</th>
								<th width=100>대여날짜</th>
								<th width=100>반납날짜</th>
								<th width=100>연장여부</th>
							</tr>
						</table>
						<input type="submit" value="연장">
					</form>
					<br>
					<h3>연장목록</h3>
					<table id="extend">
						<tr>
							<th width=100>대여번호</th>
							<th width=100>도서명</th>
							<th width=100>대여날짜</th>
							<th width=100>반납날짜</th>
							<th width=100>연장여부</th>
						</tr>
					</table>
					<br>
					<h3>연체 목록</h3>
					<table id="overdue">
						<tr>
							<th width=100>대여번호</th>
							<th width=100>도서명</th>
							<th width=100>대여날짜</th>
							<th width=100>반납날짜</th>
							<th width=100>연장여부</th>
						</tr>
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
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts"/>
	</jsp:include>
	<script type="text/javascript">	
	  <%String start = null;
			String end = null;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			System.out.println(sdf.format(new Date()));

			if (rentlist.isEmpty() == false) {
				for (Rent rent : rentlist) {%> 		 
        		var tr = document.createElement("tr");
 				var td1 = document.createElement("td");
 				var td2 = document.createElement("td");
 				var td3 = document.createElement("td");
 				var td4 = document.createElement("td");
 				var td5 = document.createElement("td");
 				
 				td1.appendChild(document.createTextNode("<%=rent.getRentNo()%>"));
 				tr.appendChild(td1);
 				td2.appendChild(document.createTextNode("<%=bookdao.getBookName(rent.getBookNo())%>"));
 				tr.appendChild(td2);
 				td3.appendChild(document.createTextNode("<%=rent.getRentDate()%>"));
 				tr.appendChild(td3);
 				td4.appendChild(document.createTextNode("<%=rent.getReturnDate()%>"));
 				tr.appendChild(td4);
 				td5.appendChild(document.createTextNode("<%=rent.getExtension()%>"));
				tr.appendChild(td5);
				var obj;
				
				<%String returnDate = rent.getReturnDate(); //반납날짜
					String rentDate[] = rent.getRentDate().split("~");//대여날짜
					start = rentDate[0];
					end = rentDate[1];

					Date rentDate1 = sdf.parse(start);
					Date rentDate2 = sdf.parse(end);

					if (returnDate == null) {
						//System.out.println(end);
						//System.out.println("date"+date);
						System.out.println(rent.getExtension());
						if (Integer.parseInt(end) < Integer.parseInt(date)) { //연체목록%>
                    obj = document.getElementById("overdue");
                    <%} else if (rent.getExtension().equals("Y")) { //연장된 도서%>
                        obj = document.getElementById("extend");
                        <%} else { //연장가능목록%>
       		 			var radio = document.createElement("input");
       		 			radio.setAttribute("type","radio");
       		 			radio.setAttribute("value","<%=rent.getRentNo()%>
		");
		radio.setAttribute("name", "rentNo");

		var td0 = document.createElement("td");
		td0.appendChild(radio);

		var table1_tr = document.getElementById("tr");
		tr.insertBefore(radio, tr.childNodes[0]);

		obj = document.getElementById("available");
	<%}%>
		obj.appendChild(tr);
	<%}
				}
			}%>
		
	</script>
</body>
</html>
