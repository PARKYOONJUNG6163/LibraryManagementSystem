<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="dao.ApplicationDAO"%>
<%@page import="obj.Application"%>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>도서 신청 목록 조회</title>
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
		}else{
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
				<h2>신청 관리</h2>
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
						List<Application> appList = appdao.getApplicationList("root");
					%>
					<div>
						<select name="category" id="category"
							onchange="getCategory(this);">
							<option value="전체">전체</option>
							<option value="수락">수락</option>
							<option value="처리중">처리중</option>
							<option value="거절">거절</option>
						</select>
					</div>
					<br>

					<form method="post" action="ApplicationUpdate.jsp">
						<table id="table" border="1"
							style="border-collapse: collapse; text-align: center;">
							<tr>
								<th width=50>선택</th>
								<th width=100>신청 번호</th>
								<th width=100>신청 일자</th>
								<th width=100>신청자</th>
								<th width=100>도서명</th>
								<th width=100>저자명</th>
								<th width=100>출판사</th>
								<th width=100>처리상태</th>
								<th width=100>거절사유</th>
							</tr>
						</table>
						<br> <input id="updateBtn" type="submit" value="변경" disabled>
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
		<jsp:param name="pageName" value="scripts" />
	</jsp:include>
	<script type="text/javascript">
	function getCategory(category){
	      var c = category.value;
	      
	      var table = document.getElementById("table");
	      for(var i=1, row; row = table.rows[i]; i++){
	         if (category.value=="전체") {
	            row.style.display = "";
	         }
	         if (new String(category.value)=="수락"){
	            if(new String(row.id)=="Y"){
	               row.style.display = '';
	            }else{
	               row.style.display = 'none';
	            }
	         }
	         if (new String(category.value)=="처리중"){
	            if(new String(row.id)=="N"){
	               row.style.display = '';
	            }else{
	               row.style.display = 'none';
	            }
	         }
	         if (new String(category.value)=="거절"){
	            if(new String(row.id)=="R"){
	               row.style.display = '';
	            }else{
	               row.style.display = 'none';
	            }
	         }
	      };
	   };
	       <%
	          for (Application app : appList) {
	       %>
	             var tb = document.getElementById("table");
	              var tr = document.createElement("tr");
	              var td = document.createElement("td");
	              var td0 = document.createElement("td");
	              var td1 = document.createElement("td");
	              var td2 = document.createElement("td");
	              var td3 = document.createElement("td");
	              var td4 = document.createElement("td");
	              var td5 = document.createElement("td");
	              var td6 = document.createElement("td");
	              var td7 = document.createElement("td");
	              tr.id="<%=app.getAccept()%>";
	              
	              td.appendChild(document.createTextNode("<%=app.getApplicationNo()%>"));
									
                 var radio = document.createElement("input");
       		     var label = document.createElement("label");
				 label.setAttribute("for","appNo<%=app.getApplicationNo()%>")
	             radio.setAttribute("type","radio");
				 radio.setAttribute("id","appNo<%=app.getApplicationNo()%>");
	             radio.setAttribute("value","<%=app.getApplicationNo()%>");
	             radio.setAttribute("name", "appNo");
	             radio.onclick = function() {document.getElementById("updateBtn").disabled=false;};
	              td0.appendChild(radio);
	              td0.appendChild(label);
	              td1.appendChild(document.createTextNode("<%=app.getApplicationDate()%>"));
	              td2.appendChild(document.createTextNode("<%=app.getId()%>"));
	              td3.appendChild(document.createTextNode("<%=app.getBookName()%>"));
	              td4.appendChild(document.createTextNode("<%=app.getAuthor()%>"));
	              td5.appendChild(document.createTextNode("<%=app.getPublisher()%>"));
	              
	              var accept = "<%=app.getAccept()%>";
	              var array = ["Y", "N", "R"];
	              var select = document.createElement("select");
	              select.name = "<%=app.getApplicationNo()%>";
	              for (var i=0; i<array.length; i++){
	                 var option = document.createElement("option");
	                 option.value = array[i];
	                 
	                 if(i==0){
	                     option.text = "수락";
	                     if("<%=app.getAccept()%>" == "Y"){
	                      option.selected=true;
	                     }
	                  }
	                  else if(i==1){
	                     option.text = "처리중";
	                     if("<%=app.getAccept()%>" == "N"){
	                     option.selected=true;
	                     }
	                  }
	                  else if(i==2){
	                     option.text = "거절";
	                     if("<%=app.getAccept()%>" == "R"){
	                     option.selected=true;
	                     }
	                  }
	                 
	                 select.appendChild(option);
	              }
	              
	             select.addEventListener("change", function func(event){
	                var e = event.currentTarget;
	                var txtbox = document.getElementById(e.name);
	                
	                if(new String(e.value)==("Y")){
	                   txtbox.disabled = true;
	                }
	                else if(new String(e.value)==("N")){
	                   txtbox.disabled = true;
	                }
	                else if(new String(e.value)==("R")){
	                   txtbox.disabled = false;
	                }
	             });
	              td6.appendChild(select);
	              
	              var text = document.createElement("input");
	              text.setAttribute("type", "text");
	              text.setAttribute("id", "<%=app.getApplicationNo()%>");
	             text.setAttribute("name", "<%=app.getApplicationNo()%>");
	              if("<%=app.getAccept()%>"=="R"){
	                 text.setAttribute("value", "<%=app.getReason()%>");
	              }
	              else{
	                 text.disabled=true;
	                 text.setAttribute("value", "<%=""%>");
	              }
	              td7.appendChild(text);	              
	              tr.appendChild(td0);
	              tr.appendChild(td);
	              tr.appendChild(td1);
	              tr.appendChild(td2);
	              tr.appendChild(td3);
	              tr.appendChild(td4);
	              tr.appendChild(td5);
	              tr.appendChild(td6);
	              tr.appendChild(td7);
	              
	              tb.appendChild(tr);
	       <%
	          }
	       %>
		
	</script>
</body>
</html>