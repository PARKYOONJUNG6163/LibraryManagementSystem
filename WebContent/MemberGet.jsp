<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.MemberDAO"%>
<%@page import="obj.Member"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 조회</title>
</head>
<body>
				<!-- Banner -->
				<section id="banner">
					<div class="content">
						<!-- Text -->
						
						<table>
						<thead>
						<tr><th>ID</th><th>PASSWORD</th><th>이름</th><th>전화번호</th><th>이메일</th><th>생일</th><th>주소</th></tr>
						</thead>
						<tbody>
						<%
							MemberDAO memberdao = new MemberDAO();
							List<Member> memberlist = memberdao.getMemberList();
							
							for (Member member : memberlist){
							%>
								<tr><td><%=member.getId()%></td><td><%=member.getPw()%></td><td><%=member.getName()%></td><td><%=member.getTel() %></td><td><%=member.getEmail() %></td><td><%=member.getBirth() %></td><td><%=member.getAddress()%></td></tr>
							<%
							}
						%>	
						</tbody>	
						</table>
					</div>
				</section>
</body>
</html>