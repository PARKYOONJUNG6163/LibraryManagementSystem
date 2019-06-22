<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>내 정보 수정</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css?after" />
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
					<h2>내 정보 수정</h2>
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
						<form onSubmit="modify();" method="post" name="check" required>
							<label for="name">이름</label> <input type="text" id="nameInput"
								name="name" required> <br> <label for="email">이메일</label>
							<input type="email" id="emailInput" name="email"
								onblur="emailChecking();" required> <br> <label
								for="tel">연락처</label> <input type="text" id="telInput"
								name="tel" onblur="telChecking();" required> <br> <label
								for="birth">생년월일</label> <input type="date" id="birthInput"
								name="birth" required> <br> <label for="address">주소</label>
							<input type="text" id="addInput" name="address" required>
							<br> <br>
							<center>
								<input type="submit" class="button big" value="수정하기">
							</center>
						</form>
					</div>
				</section>
			</div>
		</div>

		<!-- Sidebar -->
		<jsp:include page="./assets/shared/sidebar.jsp" flush="false">
			<jsp:param name="pageName" value="sidebar"/>
		</jsp:include>
	</div>

	<!-- Scripts -->
	<jsp:include page="./assets/shared/scripts.jsp" flush="false">
		<jsp:param name="pageName" value="scripts"/>
	</jsp:include>
	<script>
		function modify() {
			var name = document.getElementById("nameInput").value;
			var tel = document.getElementById("telInput").value;
			var email = document.getElementById("emailInput").value;
			var birth = document.getElementById("birthInput").value;
			var address = document.getElementById("addInput").value;

			$.ajax({
				// ajax를 통한 백그라운드 연산.
				type : 'post',
				url : 'ajaxMemberInformation.jsp',
				data : {
					name : name,
					tel : tel,
					email : email,
					birth : birth,
					address : address
				},

				success : function(data) {
					// 서버에서 연산된 결과를 가지고 참 거짓을 판단하자.
					if ($.trim(data) == 'false') {
						alert("값을 모두 입력하여주세요.");
					} else if ($.trim(data) == 'true') {
						alert("회원 정보 수정을 성공하였습니다.")
						location.href="InformationGet.jsp"
					}else{
						location.href="InformationGet.jsp"
					}
				}
			});
		}
	</script>
	

</body>
</html>