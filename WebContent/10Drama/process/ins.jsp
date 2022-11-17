<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert처리페이지</title>
</head>
<body>
<%
	//POST 방식의 한글처리 : 이것 안쓰면 한글깨짐!!!
	request.setCharacterEncoding("UTF-8");
	
	try{
		
		// 파라미터 정보 가져오기
		// 전송한 페이지인 insert.jsp의 form태그 안의 input요소들의
		// name 속성명으로 읽어온다!
		// request객체를 사용한다 -> HttpServletRequest 객체로 생성함!
		// request는 "요청"이라는 뜻!
		// 파라미터를 요청한다 -> 파라미터는 전달값을 말함!
		// 가져오는 메서드는? -> getParameter(name속성값)
		// ->>> request.getParameter(name속성값)
		String dname = request.getParameter("dname");
		String actors = request.getParameter("actors");
		String broad = request.getParameter("broad");
		String gubun = request.getParameter("gubun");
		String stime = request.getParameter("stime");
		String total = request.getParameter("total");
		
		// 넘어온값 찍기!
		out.println(
			"<h1>" +
			"♣ dname : " + dname + "<br>" +
			"♣ actors : " + actors + "<br>" +
			"♣ broad : " + broad + "<br>" +
			"♣ gubun : " + gubun + "<br>" +
			"♣ stime : " + stime + "<br>" +
			"♣ total : " + total + "</h1>"
		);
		
		
	       
		
	} ////////// try //////////
	catch(Exception e){
		
	} ///////// catch //////////







%>

</body>
</html>