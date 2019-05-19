<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.RentDAO"%>
<%@page import="obj.Rent"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>대여 조회</title>
</head>
<body>
				<!-- Banner -->
				<section id="banner">
					<div class="content">
						<!-- Text -->
						
						<table>
						<thead>
						<tr><th>대여번호</th><th>id</th><th>도서번호</th><th>대여일</th><th>반납일</th><th>연장</th><th>ISBN</th><th>예약여부</th></tr>
						</thead>
						<tbody>
						<%
							RentDAO rentdao = new RentDAO();
							List<Rent> rentlist = rentdao.getRentList();
							
							for (Rent rent : rentlist){
							%>
								<tr><td><%=rent.getRentNo()%></td><td><%=rent.getId()%></td><td><%=rent.getBookNo()%></td><td><%=rent.getRentDate() %></td><td><%=rent.getReturnDate() %></td><td><%=rent.getExtension() %></td><td><%=rent.getIsbn()%></td><td><%=rent.getIsreservation()%></td></tr>
							<%
							}
						%>	
						</tbody>	
						</table>
					</div>
				</section>
</body>
</html>