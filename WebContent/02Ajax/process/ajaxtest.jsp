<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비동기 통신 테스트 처리페이지</title>
</head>
<body>
	<%
		//POST 방식의 한글처리 : 이것 안쓰면 한글깨짐!!!
		request.setCharacterEncoding("UTF-8");
	
		// POST 방식으로 넘어온 값 받기
		String name = request.getParameter("name");
		
		// 넘어온값 화면출력!
		out.print("받은값 : "+name);
		
	%>

</body>
</html>