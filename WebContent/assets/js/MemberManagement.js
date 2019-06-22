function deleteMember(id){
	var delete_data = document.getElementById(id);
	delete_data.parentNode.removeChild(delete_data); 
	
	$.ajax({
		// 학번 부여 후 디비에 저장
		type : 'post',
		url : 'ajaxMemberDelete.jsp',
		data : {
			id : id
		},

		success : function(data) {
			// 뒤에서 연산한 결과를 가지고 가부를 판단
			if ($.trim(data) == 'false') {
				alert("회원 삭제 실패!");
			}else if($.trim(data) == 'true'){
				alert("회원 삭제 성공!");
			}
		}
	});	
}

function outMember(id){
	
	$.ajax({
		// 학번 부여 후 디비에 저장
		type : 'post',
		url : 'ajaxMemberDelete.jsp',
		data : {
			id : id
		},

		success : function(data) {
			// 뒤에서 연산한 결과를 가지고 가부를 판단
			if ($.trim(data) == 'false') {
				alert("회원 탈퇴 실패!");
				location.reload();
			}else if($.trim(data) == 'true'){
				alert("회원 탈퇴 성공!");
				location.href="Logout.jsp"
			}
		}
	});	
}