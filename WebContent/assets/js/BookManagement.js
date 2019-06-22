// 도서 정보 받아와서 등록하기
function insertBookInfo() {
	var isbn = document.getElementById("isbnInput").value;
	var select_category = document.getElementById("demo-category");
	var category = select_category.options[select_category.selectedIndex].value;
	var name = document.getElementById("nameInput").value;
	var author = document.getElementById("authorInput").value;
	var publisher = document.getElementById("publisherInput").value;
	var publishedDate = document.getElementById("publishedDateInput").value;

	$.ajax({
		// 학번 부여 후 디비에 저장
		type : 'post',
		url : 'ajaxBookCreate.jsp',
		data : {
			isbn : isbn,
			category : category,
			name : name,
			author : author,
			publisher : publisher,
			publishedDate : publishedDate
		},

		success : function(data) {
			// 뒤에서 연산한 결과를 가지고 가부를 판단
			if ($.trim(data) == '0') {
				alert("도서 등록 실패!");
			} else if ($.trim(data) == '1') {
				alert("이미 등록되어있는 도서입니다.");
			} else if ($.trim(data) == '2') {
				alert("도서 등록 완료!");
			}
		}
	});
}

function getModifyForm(isbn) {
	location.href = "BookModifyForm.jsp?isbn=" + isbn;
}

// 입력한 내용에 따라 도서정보 수정
function modifyBookInfo() {
	var isbn = document.getElementById("isbnInput").value;
	var select_category = document.getElementById("demo-category");
	var category = select_category.options[select_category.selectedIndex].value;
	var name = document.getElementById("nameInput").value;
	var author = document.getElementById("authorInput").value;
	var publisher = document.getElementById("publisherInput").value;
	var publishedDate = document.getElementById("publishedDateInput").value;

	$.ajax({
		// 학번 부여 후 디비에 저장
		type : 'post',
		url : 'ajaxBookModify.jsp',
		data : {
			isbn : isbn,
			category : category,
			name : name,
			author : author,
			publisher : publisher,
			publishedDate : publishedDate
		},

		success : function(data) {
			// 뒤에서 연산한 결과를 가지고 가부를 판단
			if ($.trim(data) == 'false') {
				alert("도서 수정 실패!");
			} else if ($.trim(data) == 'true') {
				alert("도서 수정 성공!");
			}
		}
	});
}

function deleteBookInfo(isbn) {
	var delete_data = document.getElementById(isbn);
	delete_data.parentNode.removeChild(delete_data);

	$.ajax({
		// 학번 부여 후 디비에 저장
		type : 'post',
		url : 'ajaxBookDelete.jsp',
		data : {
			isbn : isbn
		},

		success : function(data) {
			// 뒤에서 연산한 결과를 가지고 가부를 판단
			if ($.trim(data) == 'false') {
				alert("도서 삭제 실패!");
			} else if ($.trim(data) == 'true') {
				alert("도서 삭제 성공!");
			}
		}
	});
}

function reserveBook(bookNo, isRev) {
	$.ajax({
		type : 'post',
		url : 'ajaxUpdateRev.jsp',
		data : {
			bookNo : bookNo,
			isRev : isRev,
		},

		success : function(data) {
			if ($.trim(data) == 'false') {
				alert('이미 예약된 책입니다!');
				location.reload();
			} else if ($.trim(data) == 'true') {
				alert('예약 완료!');
				location.reload();
			}
		},
	})
}

function rentBookInstance(bookNo) {
	$.ajax({
		type : 'post',
		url : 'ajaxBookRent.jsp',
		data : {
			bookNo : bookNo,
		},

		success : function(data) {
			if ($.trim(data) == 'false') {
				alert('대여 불가!');
				location.reload();
			} else {
				alert('대여 완료!');
				location.href = 'BookRentList.jsp'
			}
		},
	})
}

function extendRent(rentNo) {
	$.ajax({
		type : 'post',
		url : 'ajaxBookExtend.jsp',
		data : {
			rentNo : rentNo,
		},

		success : function(data) {
			if ($.trim(data) == 'false') {
				alert('연장 실패!')
				location.reload()
			} else {
				alert('연장 성공')
				location.reload()
			}
		}
	})
}

function returnBook(rentNo,id){
	$.ajax({
		type : 'post',
		url : 'ajaxReturnBook.jsp',
		data : {
			rentNo : rentNo,
			id:id
		},

		success : function(data) {
			if ($.trim(data) == 'false') {
				alert('반납 실패!')
				location.reload()
			} else {
				alert('반납 성공')
				location.reload()
			}
		}
	})
}

function removeBookInstance(isbn,bookNo,id){
	$.ajax({
		type : 'post',
		url : 'BookInstanceDeletePro.jsp',
		data : {
			isbn:isbn,
			bookNo:bookNo,
			id:id
		},

		success : function(data) {
			if ($.trim(data) == 'false') {
				alert('삭제 실패!')
				location.reload()
			} else {
				alert('삭제 성공!')
				location.reload()
			}
		}
	})
}
