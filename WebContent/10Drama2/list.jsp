<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통패키지 -->
<%@page import="common.JDBConnector"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>한국 최신 드라마 리스트</title>
<link rel="stylesheet" href="css/drama.css">
</head>
<body>
	<!-- 한국 최신 드라마 리스트 -->
	<table class="tbl" id="drama">
		<!-- 
           테이블 기본 사이간극은
           border="1" 속성을 넣고 확인해 본다!
           없애려면 CSS에서
           border-collapse:collapse 설정함!
        -->
		<!-- 1.테이블제목 -->
		<caption>한국 최신 드라마 리스트</caption>
		<!-- 2.테이블 머릿부분 -->
		<thead>
			<tr>
				<th>번호</th>
				<th>드라마명</th>
				<th>주연</th>
				<th>제작사</th>
				<th>구분</th>
				<th>방영시간</th>
				<th>방영횟수</th>
			</tr>
		</thead>

		<%
			/////// 동적 데이터 바인딩 영역 //////////

		// POST 방식의 한글처리
		request.setCharacterEncoding("UTF-8");

		// DB레코드결과변수
		String result = "";

		// ***** 페이징 변수 ****** 
		// 1.시작 레코드번호 : LIMIT의 시작값
		int startNum = 0;
		// 2.페이지당 레코드개수 : LIMIT의 개수
		int onePageCnt = 3;
		// 3.전체 레코드수
		int totalCnt = 0;
		// 4.리스트 그룹수 : 전체개수 ÷ 페이지당개수
		int listGroup = 0;
		// 5.남은 레코드수 : 리스트 그룹에서 남은 레코드수
		int etcRecord = 0;
		// 6.페이징링크 코드 저장변수
		String pgCode = "";

		try {
			
			// DB연결 클래스 생성
			JDBConnector jdbc = new JDBConnector();
			
			
			// 7. 쿼리문작성 할당
			String query = "SELECT * FROM `drama_info` ORDER BY `idx` DESC LIMIT ?,?";
			
			// 11. 쿼리문 연결 사용준비하기
			jdbc.pstmt = jdbc.conn.prepareStatement(query);

			/**************************************** 
			[ 페이징 변수처리전 페이지번호로 시작번호 변경하기 ]
			*****************************************/
			// 페이지번호 가져오기
			String pgNum = request.getParameter("pgnum");
			out.println("파라미터:" + pgNum + "<br>");

			// 파라미터 형변환 변수(현재 페이지번호)
			int pageSeq = 1; // 기본값 1(파라미터가 없으면 1들어감!)

			// 파라미터가 있으면 시작값 처리하기
			if (pgNum != null) { // null이 아니면!
				// 파라미터 형변환!
				try {
					pageSeq = Integer.parseInt(pgNum);
				} catch (NumberFormatException ex) {
					out.println("파라미터가 숫자가 아닙니다!<br>");
					// 기본값으로 돌려보낸다!
					pageSeq = 1;
				}
				// 시작번호 계산하기 : 페이지당 레코드수 * (페이지번호-1)
				startNum = onePageCnt * (pageSeq - 1);

			} //////////// if //////////////

			/****************************************
				12. 페이징 변수 처리하기
			*****************************************/
			// LIMIT 쿼리의 시작번호셋팅
			jdbc.pstmt.setInt(1, startNum);
			// LIMIT 쿼리의 개수셋팅
			jdbc.pstmt.setInt(2, onePageCnt);

			// 13. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
			// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
			jdbc.rs = jdbc.pstmt.executeQuery();
			// executeQuery() 쿼리실행 메서드

			// 14. 저장된 결과집합의 레코드 수 만큼 돌면서 코드만들기!
			// 돌아주는 제어문은? while(조건){실행문}
			// 레코드 유무 체크 메서드는? next()
			// rs는 ResultSet 객체임!!!
			// rs.next() -> 첫라인 다음라인이 있으면 true / 없으면 false!
			// 첫번째 라인은 항상 컬럼명이 첫번째 라인이다!
			// 따라서 다음라인이 있다는 것은 결과 레코드가 있다는 말!!!

			// 일련번호용 변수
			// 페이지에 따른 시작일련번호 구하기
			int listNum = 1;
			if (pageSeq != 1)
				listNum = (pageSeq - 1) * onePageCnt + 1;
			// (2-1) * 3 + 1 = 4
			// (3-1) * 3 + 1 = 7
			// (4-1) * 3 + 1 = 10

			/// 결과셋에 레코드가 있는 동안 계속 순회함!
			// rs.getString(컬럼명)
			// -> 문자형일 경우 getString(), 숫자형은 getInt()
			// -> 컬럼명은 DB 테이블에 실제로 생성된 컬럼명이다!
			while (jdbc.rs.next()) {
				// += 대입연산자로 기존값에 계속 더함!
				result += "<tr>" + "   <td>" + listNum + "</td>" +
				// "   <td>"+rs.getInt("idx")+"</td>"+
				// 일련번호는 DB의 idx 기본키를 쓰지 않고
				// 반복되는 동안 순번을 만들어서 사용한다!
				"   <td><a href='modify.jsp?idx="+ 
						jdbc.rs.getInt("idx") + 
				"&pgnum="+pageSeq+"'>" +
				// 조회수정 페이지인 modify.jsp로 갈때
				// ?idx=유일키값 : Get방식으로 전송함!
				// pgnum=현재페이지번호 : 추가전송!
				jdbc.rs.getString("dname") + "</a></td>" + 
				"   <td>" + jdbc.rs.getString("actors") + "</td>" + "   <td>"
				+ jdbc.rs.getString("broad") + "</td>" + "   <td>" + 
				jdbc.rs.getString("gubun") + "</td>" + "   <td>"
				+ jdbc.rs.getString("stime") + "</td>" + "   <td>" + 
				jdbc.rs.getString("total") + "</td>" + "</tr>";

				// 일련번호증가
				listNum++;

			} //////////// while //////////////

			// 결과화면출력 	
			//    out.println(result);

			/********************************* 
				15. 페이징 링크 생성하기
				______________________________
				
				1)시작 레코드번호 : startNum
				2)페이지당 레코드개수 : onePageCnt
				3)전체 레코드수 : totalCnt
				4)리스트 그룹수 : listGroup
					(전체개수 ÷ 페이지당개수) 
				5)남은 레코드수 : etcRecord
				6)페이징링크 코드 저장변수 pgCode
				
			*********************************/
			// 15-1. 전체 레코드 수 구하기
			// 레코드수 구하기 쿼리
			String cntQuery = "SELECT COUNT(*) FROM `drama_info`";
			// 쿼리를 PreparedStatement에 넣기
			jdbc.pstmt = jdbc.conn.prepareStatement(cntQuery);
			// 쿼리실행! -> 개수정보를 리턴받아 ResultSet에 담는다!
			jdbc.rs = jdbc.pstmt.executeQuery();

			// 개수결과가 있으면 가져오기
			if (jdbc.rs.next()) {
				totalCnt = jdbc.rs.getInt(1);
				// getInt(1)은 정수형 결과를 가져옴!
			} ////// if ///////////

			// 15-2. 리스트 그룹수 : 전체개수 ÷ 페이지당개수
			listGroup = totalCnt / onePageCnt;

			// 15-3. 남은 레코드수 : 전체개수 % 페이지당개수
			// 나머지 구할땐 %연산자
			etcRecord = totalCnt % onePageCnt;

			// 한계수 체크: 나머지가 있고 없고에 따라 1개차이남
			int limit = etcRecord == 0 ? listGroup : listGroup + 1;
			// 나머지가 있으면 1페이지 더 추가!

			// 15-4. 페이징 링크 코드 만들기
			for (int i = 0; i < limit; i++) {
				// 만약 현재 페이지와 같은 번호는 a링크 걸지말고
				// b태그로 두꺼운 글자 표시만 해주자!
				if (i == pageSeq - 1) { // i는 0부터니까 1뺌
			pgCode += "<b>" + (i + 1) + "</b>";
				} /// if ////
				else {
			// pgCode변수에 모두 넣는다
			pgCode += "<a href='list.jsp?pgnum=" + (i + 1) + "'>" + (i + 1) + "</a>";
				} /// else //////

				// 사이바 찍기 
				// (한계값-1,즉 마지막번호 전까지만 사이바출력)
				if (i < limit - 1) {
			pgCode += " | ";
				}

			} ////////// for //////////////

			// 화면에 찍어보기
			out.println("<h1>");
			out.println("# 전체개수:" + totalCnt + "개<br>");
			out.println("# 페이지당개수:" + onePageCnt + "개<br>");
			out.println("# 리스트 그룹수:" + listGroup + "개<br>");
			out.println("# 남은 레코드수:" + etcRecord + "개<br>");
			out.println("</h1>");

			// 16. 연결해제하기
			jdbc.close();

		} //// try /////
		catch (Exception e) {
			// DB연결 실패시 여기로 들어옴!
			out.println("에러메시지:");
			out.println(e.toString());
			// toString() 문자데이터로 변환하는 메서드
		} ///// catch //////

		/////////////////////////////////////////////////
		%>

		<!-- 3.테이블 메인부분 -->
		<tbody>
			<%=result%>
		</tbody>

		<!-- 4.테이블 하단부분-->
		<tfoot>
			<tr>
				<td colspan="7">◀ <%=pgCode%> ▶
				</td>
			</tr>
		</tfoot>
	</table>

	<!-- 입력페이지 이동버튼 -->
	<div class="gubun" onclick="location.href='insert.jsp'"
		style="text-align: right; margin-bottom: 50px;">
		<button style="font-size: 24px;">입력하기</button>
	</div>

	<!-- 구분테이블 박스 -->
	<div class="gubun">
		<table class="tbl" id="gubun">
			<tr>
				<td rowspan="4">구분</td>
				<td>월화:월화드라마</td>
				<!-- 
                        rowspan 속성은 위아래 행을 합치는 속성
                        여기서는 4줄을 합치므로 값을 4로 설정함
                        아래쪽 행에서는 첫번째 td를 모두 쓰지 않는다!
                        row는 "행/줄"의 뜻
                     -->
			</tr>
			<tr>
				<td>수목:수목드라마</td>
			</tr>
			<tr>
				<td>금토:금토드라마</td>
			</tr>
			<tr>
				<td>토일:토일드라마</td>
			</tr>
		</table>
	</div>

	<!-- 
            [ 가장 복잡한 그룹요소인 테이블!!! ]
            1. table : 테이블 전체 부모요소
            2. tr : 테이블 레코드행 (table row)
            3. td : 테이블 데이터요소 (table data)
            4. th : 테이블 머릿부분에 사용될 경우 
            td대신 th를 사용할 수 있다.
            (기본디자인-중앙정렬+두꺼운글자)
            ________________________________  
            (테이블 구조를 위한 추가요소들)
            5. caption : 테이블 제목
            6. thead : 테이블 머릿부분
            7. tbody : 테이블 중앙 내용부분
            8. tfoot : 테이블 하단부분

            ※tbody는 일반적으로 table tr td 로 구성하는
            테이블일 경우 자동으로 생성되어 표시된다!

         -->


</body>
</html>