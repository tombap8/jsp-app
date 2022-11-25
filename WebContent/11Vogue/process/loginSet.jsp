<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="common.JDBConnector" %>
<%@ page import="common.SHA256" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리 페이지</title>
</head>
<body>
<%
		//1.아이디(입력항목)
		String mid = request.getParameter("mid");
		// 2.비번(입력항목)
		String mpw = request.getParameter("mpw");
		// 3.비번(db)
		String dbmpw = "";
		// 4.이름(db)
		String name = "";
		// 5.성별(db)
		String auth = "";

	try {
		// 1. DB 연결 문자열값 만들기!
		String DB_URL = "jdbc:mysql://localhost:3306/mydb";
		// 형식 -> jdbc:db시스템종류://db아이피/db이름
		// MySQL -> jdbc:mysql://localhost:3306/mydb

		// 참고) 오라클 JDBC 드라이버 로드 문자열
		// Oracle -> jdbc:oracle:thin:@localhost:1521:xe

		// 2. DB 아이디계정 : root는 슈퍼어드민 기본계정임
		String DB_USER = "root";

		// 3. DB 비밀번호 : root는 최초에 비밀번호가 없음
		String DB_PWD = "";

		// 4. 연결객체 선언
		Connection conn = null;

		// 5. 쿼리문 저장객체
		PreparedStatement pstmt = null;

		// 6. 결과저장 객체
		ResultSet rs = null;

		// 7. 쿼리문작성 할당
		String query = "SELECT * FROM `drama_info` WHERE `idx`=?";
		// 해당 유일키 idx값을 넣어서 선택하면 하나의 레코드만 선택된다!
		// 데이터가 들어갈 자리만 물음표(?)로 처리하면 끝!

		// 8. DB 종류 클래스 등록하기 -> 해당 연결 드라이브 로딩!
		Class.forName("com.mysql.jdbc.Driver");
		// lib폴더의 jar파일과 연결!

		// 9. DB연결하기
		conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);

		// 10. 성공메시지띄우기
		out.println("DB연결 성공하였습니다!");

		// 11. 쿼리문 연결 사용준비하기
		// conn연결된 DB객체
		pstmt = conn.prepareStatement(query);
		// prepareStatement(쿼리문변수)
		// - 쿼리문을 DB에 보낼 상태완료!
		// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!

		// 12. 쿼리에 추가할 데이터 셋팅하기!
		// -> 파라미터값이 숫자지만 String이므로 형변환 해야함!
		// 문자형을 숫자형으로 변환: Integer.parseInt(변수)
		pstmt.setInt(1, Integer.parseInt(idnum));
		// 형변환시 에러가 발생할 수 있으므로 try,catch문 안에서 변환한다!

		// 13. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
		// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
		rs = pstmt.executeQuery();
		// executeQuery() 쿼리실행 메서드

		// 14. 저장된 결과집합의 레코드 수 만큼 돌면서 코드만들기!
		// 돌아주는 제어문은? while(조건){실행문}
		// 레코드 유무 체크 메서드는? next()
		// rs는 ResultSet 객체임!!!
		// rs.next() -> 첫라인 다음라인이 있으면 true / 없으면 false!
		// 첫번째 라인은 항상 컬럼명이 첫번째 라인이다!
		// 따라서 다음라인이 있다는 것은 결과 레코드가 있다는 말!!!

		/// 결과셋에 레코드가 있는 동안 계속 순회함!
		// rs.getString(컬럼명)
		// -> 문자형일 경우 getString(), 숫자형은 getInt()
		// -> 컬럼명은 DB 테이블에 실제로 생성된 컬럼명이다!
		while (rs.next()) {
			dname = rs.getString("dname");
			actors = rs.getString("actors");
			broad = rs.getString("broad");
			gubun = rs.getString("gubun");
			stime = rs.getString("stime");
			total = rs.getString("total");
		} //////////// while //////////////

		// 14. 연결해제하기
		rs.close();
		pstmt.close();
		conn.close();

	} //// try /////
	catch (Exception e) {
		// DB연결 실패시 여기로 들어옴!
		out.println("에러메시지:");
		out.println(e.toString());
		// toString() 문자데이터로 변환하는 메서드
	} ///// catch //////
	%>
</body>
</html>