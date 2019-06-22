<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="dao.ApplicationDAO"%>
<%@page import="obj.Application"%>

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
				<h2>신청 목록 조회</h2>
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
					<%
						ApplicationDAO appdao = new ApplicationDAO();
						String id = (String) session.getAttribute("identifier");
						List<Application> appList = appdao.getApplicationList(id);
					%>
					<table id="table">
						<thead>
							<tr>
								<th width=100>신청 일자</th>
								<th width=100>도서명</th>
								<th width=100>저자명</th>
								<th width=100>출판사</th>
								<th width=100>처리상태</th>
								<th width=100>거절사유</th>
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
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts" />
	</jsp:include>
	<script type="text/javascript">
	function changeFun(){
		var tb = document.getElementById("table");
    	<%for (Application app : appList) {%>
   	    	var tr = document.createElement("tr");
   	    	var td1 = document.createElement("td");
   	    	var td2 = document.createElement("td");
   	    	var td3 = document.createElement("td");
   	    	var td4 = document.createElement("td");
   	    	var td5 = document.createElement("td");
   	    	var td5 = document.createElement("td");
   	    	var td6 = document.createElement("td");
    	    	
   	    	td1.appendChild(document.createTextNode("<%=app.getApplicationDate()%>"));
   	    	td2.appendChild(document.createTextNode("<%=app.getBookName()%>"));
   	    	td3.appendChild(document.createTextNode("<%=app.getAuthor()%>"));
   	    	td4.appendChild(document.createTextNode("<%=app.getPublisher()%>"));
    	    	
   	    	var accept = "<%=app.getAccept()%>";
   	    	var content = "";
   	    	if(accept=="Y"){
   	    		accept="수락";
   	    	}
   	    	else if(accept=="N"){
   	    		accept="처리중";
   	    	}
   	    	else{
   	    		accept="거절";
   	    		content="<%=app.getReason()%>";
			}
			td5.appendChild(document.createTextNode(accept));
			td6.appendChild(document.createTextNode(content));

			tr.appendChild(td1);
			tr.appendChild(td2);
			tr.appendChild(td3);
			tr.appendChild(td4);
			tr.appendChild(td5);
			tr.appendChild(td6);

			tb.appendChild(tr);
	<%}%>
		}
		changeFun()
	</script>
</body>
</html>