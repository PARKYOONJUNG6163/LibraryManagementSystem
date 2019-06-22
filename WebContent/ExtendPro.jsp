<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.RentDAO"%>
<%@page import="obj.Rent"%>
<%@page import="java.util.*"%>
<%@ page import = "java.text.*" %>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>연장pro</title>
</head>
<body>
	<% 
		RentDAO rentdao = new RentDAO();
		List<Rent> rentlist = rentdao.getRentListUser();
		String chboxName = request.getParameter("rentNo");
		System.out.println(chboxName);
		
		for (Rent rent : rentlist){
			if(rent.getRentNo()==Integer.parseInt(chboxName)){
				String returnDate = rent.getReturnDate(); //반납날짜
	       		String rentDate[] = rent.getRentDate().split("~");//대여날짜
	       		String start = rentDate[0];
	       		String end = rentDate[1];
	       		
	       		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");//7일증가
       			Date rentDate2 = sdf.parse(end);
	       		Calendar cal = Calendar.getInstance();
       		 	cal.setTime(rentDate2);
       		 	cal.add(Calendar.DATE, 7);
       		 	end = sdf.format(cal.getTime());

				System.out.println(start+"~"+end);
       		 	rent.setRentDate(start+"~"+end);
       		 	rent.setExtension("Y");
       		 	rentdao.updateRentDate(rent);
       		 	break;
			}
		}
		
	%>
	<script type="text/javascript">
    	alert("연장이 완료되었습니다.");
    	location.href="Extend.jsp";
    </script>
</body>
</html>