<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>도서 등록</title>
</head>
<body>
	<!-- Banner -->
	<section id="banner">
		<div class="content">
			<!-- Text -->
			<form onSubmit="return insertBookInfo();" method="post" name="check" action="BookCreate.jsp">
			<label for="isbn">ISBN</label> 
			<input type="text" id="isbnInput" name="isbn" required /><br> 
			<label for="category">분류</label> 
			<select name="demo-category" id="demo-category">
			<option value> - Category - </option>
			<option value="1">철학</option>
			<option value="2">사회과학</option>
			<option value="3">자연과학</option>
			<option value="4">기술과학</option>
			<option value="5">예술</option>
			<option value="6">언어</option>
			<option value="7">문학</option>
			<option value="8">역사</option>
			</select><br>
			<label for="name">도서명</label> 
			<input type="text" id="nameInput" required/> <br> 
			<label for="author">저자</label>
			<input type="text" id="authorInput" name="author"/> <br> 
			<label for="publisher">출판사</label>
			<input type="text" id="publisherInput" name="publisher"/> <br>
			<label for="publishedDate">출판일</label> 
			<input type="text" id="publishedDateInput" name="publishedDate"/> <br> <br>
			<center>
				<input type="submit" class="button big" value="등록하기"/>
			</center>
			</form>
		</div>
	</section>
	</div>
	</div>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/BookManagement.js"></script>
</body>
</html>