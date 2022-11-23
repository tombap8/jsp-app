<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통패키지 -->
<%@page import="common.JDBConnector"%>
<%@page import="common.Paging"%>
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
		
		// 페이지번호 파라미터 받기(만약없으면 null이므로 "1"할당!)
		String pgNum = request.getParameter("pgnum");
		if(pgNum==null) pgNum="1";

		// DB레코드결과변수
		String result = "";

		// DB연결 클래스 생성
		JDBConnector jdbc = new JDBConnector();

		// 페이지 클래스 생성
		Paging pg = new Paging();

		try {

			// 7. 쿼리문작성 할당
			String query = "SELECT * FROM `drama_info` ORDER BY `idx` DESC LIMIT ?,?";

			// 11. 쿼리문 연결 사용준비하기
			jdbc.pstmt = jdbc.conn.prepareStatement(query);
			
			/**************************************** 
			[ 페이징 변수처리전 페이지번호로 시작번호 변경하기 ]
			*****************************************/
			pg.changeStartNum(pgNum);

			/****************************************
				12. 페이징 변수 처리하기
			*****************************************/
			// LIMIT 쿼리의 시작번호셋팅
			jdbc.pstmt.setInt(1, pg.startNum);
			// LIMIT 쿼리의 개수셋팅
			jdbc.pstmt.setInt(2, pg.onePageCnt);

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
			if (pg.pageSeq != 1)
				listNum = (pg.pageSeq - 1) * pg.onePageCnt + 1;
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
				"   <td><a href='modify.jsp?idx=" + jdbc.rs.getInt("idx") + "&pgnum=" + pg.pageSeq + "'>" +
				// 조회수정 페이지인 modify.jsp로 갈때
				// ?idx=유일키값 : Get방식으로 전송함!
				// pgnum=현재페이지번호 : 추가전송!
				jdbc.rs.getString("dname") + "</a></td>" + "   <td>" + jdbc.rs.getString("actors") + "</td>" + "   <td>"
				+ jdbc.rs.getString("broad") + "</td>" + "   <td>" + jdbc.rs.getString("gubun") + "</td>" + "   <td>"
				+ jdbc.rs.getString("stime") + "</td>" + "   <td>" + jdbc.rs.getString("total") + "</td>" + "</tr>";

				// 일련번호증가
				listNum++;

			} //////////// while //////////////

			// 결과화면출력 	
			//    out.println(result);

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
				<td colspan="7">◀ <%=pg.makePaging()%> ▶
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