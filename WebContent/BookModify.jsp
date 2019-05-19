<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.BookInfoDAO"%>
<%@page import="obj.Book"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>도서 수정</title>
</head>
<body>
					<!-- Banner -->
				<section id="banner">
					<div class="content">
						<!-- Text -->
						
						<table>
						<thead>
						<tr><th>구분</th><th>isbn</th><th>분류</th><th>도서명</th><th>저자</th><th>출판사</th><th>출판일</th></tr>
						</thead>
						<tbody>
						<%
							BookInfoDAO bookinfodao = new BookInfoDAO();
							List<Book> booklist = bookinfodao.getBookList();
							
							for (Book book : booklist){
							%>
							<tr><td><button type="button" onclick="getModifyForm(<%=book.getIsbn()%>);">수정</button></td><td><%=book.getIsbn()%></td><td><%=book.getCategoryKey()%></td><td><%=book.getBookName()%></td><td><%=book.getAuthor() %></td><td><%=book.getPublisher() %></td><td><%=book.getPublishedDate() %></td></tr>
							<%
							}
						%>	
						</tbody>	
						</table>
					</div>
				</section>

			<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/BookManagement.js"></script>
</body>
</html>