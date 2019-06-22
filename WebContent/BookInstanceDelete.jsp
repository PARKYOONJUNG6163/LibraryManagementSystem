<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.BookInfoDAO"%>
<%@page import="obj.Book"%>
<%@page import="java.util.*"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>도서 검색 - 삭제</title>
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
				<h2>도서 검색</h2>
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
					<div>
						<select name="demo-category" id="demo-category">
							<option value="name">도서명</option>
							<option value="author">저자명</option>
							<option value="publisher">출판사</option>
						</select>
						<button onclick="changeFun()">검색</button>
						</br> </br> <input type="text" id="content"></br> </br>
					</div>
					<!-- Text -->
					<%
						BookInfoDAO bookdao = new BookInfoDAO();
						List<Book> booklist = bookdao.getBookList();
					%>
					<table>
						<thead>
							<tr>
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

		<!-- Sidebar -->
		<jsp:include page="./assets/shared/sidebar.jsp" flush="false">
			<jsp:param name="pageName" value="sidebar" />
		</jsp:include>
	</div>
	<!-- Scripts -->
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts"/>
	</jsp:include>
	<script type="text/javascript">
	function changeFun(){
		document.getElementById("tbody").innerHTML=""; // tbody 초기화
		
		var category = document.getElementById("demo-category").value;
		var content = document.getElementById("content").value.toLowerCase().replace(/ /gi, "");
		<%for (Book book : booklist) {%>
				var equals = 0;
				if(category=="name"){
					var bookName = "<%=book.getBookName()%>";
					if(bookName.toLowerCase().replace(/ /gi, "").indexOf(content)!=-1){
						equals=1;
					}
				}else if(category=="author"){
					var author = "<%=book.getAuthor()%>";
					if(author.toLowerCase().replace(/ /gi, "").indexOf(content)!=-1){
						equals=1;
					}
				}else{
					var publisher = "<%=book.getPublisher()%>";
					if(publisher.toLowerCase().replace(/ /gi, "").indexOf(content)!=-1){
						equals=1;
					}
				}
				
				if(equals==1){
					var tbody = document.getElementById("tbody");
					var tr = document.createElement("tr");
					var td1 = document.createElement("td");
					var td2 = document.createElement("td");
					var td3 = document.createElement("td");
					var td4 = document.createElement("td");
					var td5 = document.createElement("td");
					
					tr.setAttribute("onClick","location.href='BookInstanceList.jsp?isbn=<%=book.getIsbn()%>'")
					tr.setAttribute("class","bookinfo")
					td1.appendChild(document.createTextNode("<%=bookdao.getBookCategory(book.getCategoryKey())%>"));
					tr.appendChild(td1);
					td2.appendChild(document.createTextNode("<%=book.getBookName() %>"));
					tr.appendChild(td2);
					td3.appendChild(document.createTextNode("<%=book.getAuthor()%>"));
					tr.appendChild(td3);
					td4.appendChild(document.createTextNode("<%=book.getPublisher()%>"));
					tr.appendChild(td4);
					td5.appendChild(document.createTextNode("<%=book.getPublishedDate()%>"));
				tr.appendChild(td5);

				tbody.appendChild(tr);
			}
	<%}%>
		}
	</script>
</body>
</html>







