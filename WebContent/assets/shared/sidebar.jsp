<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
	<% if(session.getAttribute("identifier") != null) {%>
	<div id="sidebar">
		<div class="inner">
			<!-- Menu -->
			<nav id="menu"> <header class="major">
			<a href="MainChart.jsp"><h2>Library System</h2></a>
			<h2>Menu</h2>
			</header>
			<ul>
				<li><a href="BookSearch.jsp">도서 검색</a></li>
				<li>내 정보 관리</li>
				<ul>
					<li><a href="InformationGet.jsp">내 정보 조회</a></li>
					<li><a href="InformationModify.jsp">내 정보 수정</a></li>
				</ul>
				<%
					if(!session.getAttribute("identifier").equals("root")){
				%>
				<li>회원 도서 관리</li>
				<ul>
					<li><a href="BookRentList.jsp">도서 대여 목록</a></li>
					<li><a href="Application.jsp">도서 신청</a></li>
					<li><a href="ApplicationUser.jsp">신청 목록 조회</a></li>
				</ul>
				<% } %>
	
				<%
					if (session.getAttribute("identifier").equals("root")) {
				%>
				<li>관리자 도서 관리</li>
				<ul>
					<li><a href="BookCreate.jsp">도서 정보 추가</a></li>
					<li><a href="BookModify.jsp">도서 정보 수정</a></li>
					<li><a href="BookDelete.jsp">도서 정보 삭제</a></li>
					<li><a href="BookInstanceCreate.jsp">도서 추가</a></li>
					<li><a href="BookInstanceDelete.jsp">도서 삭제</a></li>	
					<li><a href="ApplicationManager.jsp">신청 관리</a></li>
					<li><a href="RentGet.jsp">대여 목록</a></li>
				</ul>
				<li>회원 관리</li>
				<ul>
					<li><a href="MemberGet.jsp">회원 조회</a></li>
					<li><a href="MemberDelete.jsp">회원 삭제</a></li>
				</ul>
				<%
					}
				%>
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
	<%} %>
	
