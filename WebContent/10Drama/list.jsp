<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- DB연결 객체 임포트 필수! -->
<%@page import="java.sql.*" %>
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
            
            try{
         		
             	// DB와 연결하려면 해당 DB의 jar파일이 DB폴더의
             	// lib 폴더안에 위치해 있어야한다!
             	// MySQL 설치폴더
             	// C:\Program Files\Apache Software Foundation
             	// \Tomcat 9.0\lib
             	// mysql-connector.jar 파일 이것!!!! 확인!
             	// 다이나믹 웹 프로젝트에서는 WEB-INF>lib 폴더에 넣는다!(관리용이)
             	
             	// 1. DB 연결 문자열값 만들기!
             	String DB_URL = "jdbc:mysql://localhost:3306/mydb";
             	// 형식 -> jdbc:db시스템종류://db아이피/db이름
             	// MySQL -> jdbc:mysql://localhost:3306/mydb
             	
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
             	String query = "SELECT * FROM `drama_info` ORDER BY `idx` DESC";
             	
             	// 8. DB 종류 클래스 등록하기 -> 해당 연결 드라이브 로딩!
             	Class.forName("com.mysql.jdbc.Driver");
             	// lib폴더의 jar파일과 연결!
             	
             	// 9. DB연결하기
             	conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PWD);
             	
             	// 10. 성공메시지띄우기
             	out.println("DB연결 성공하였습니다!");
             	
             	// 11. 쿼리문 연결 사용준비하기
             	// conn연결된 DB객체
             	pstmt = conn.prepareStatement(query);
             	// prepareStatement(쿼리문변수)
             	// - 쿼리문을 DB에 보낼 상태완료!
             	// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!
             	
             	// 12. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
             	// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
             	rs = pstmt.executeQuery();
             	// executeQuery() 쿼리실행 메서드
             	
          
             	// 13. 저장된 결과집합의 레코드 수 만큼 돌면서 코드만들기!
             	// 돌아주는 제어문은? while(조건){실행문}
             	// 레코드 유무 체크 메서드는? next()
             	// rs는 ResultSet 객체임!!!
             	// rs.next() -> 첫라인 다음라인이 있으면 true / 없으면 false!
             	// 첫번째 라인은 항상 컬럼명이 첫번째 라인이다!
             	// 따라서 다음라인이 있다는 것은 결과 레코드가 있다는 말!!!
             	
             	// 레코드 결과값 저장변수
             	String result = "";
             	
             	/// 결과셋에 레코드가 있는 동안 계속 순회함!
             	while(rs.next()){
             		result += 
             				"<tr>"+
             				"   <td>1</td>"+
             				"   <td><a href='#'>"+
             				rs.getString("dname")+"</a></td>"+
             				"   <td>"+rs.getString("actors")+"</td>"+
             				"   <td>"+rs.getString("broad")+"</td>"+
             				"   <td>"+rs.getString("gubun")+"</td>"+
             				"   <td>"+rs.getString("stime")+"</td>"+
             				"   <td>"+rs.getString("total")+"</td>"+
             				"</tr>";
             		
             	} //////////// while //////////////
             	
             	
            
                
                 
               
                 
                  
                 
                 
                 
                
                
                
            
             	
             	// 11. 연결해제하기
             	rs.close();
             	pstmt.close();
             	conn.close();
             	

             	} //// try /////
             	catch(Exception e) {
             		// DB연결 실패시 여기로 들어옴!
             		out.println("에러메시지:");
             		out.println(e.toString());
             		// toString() 문자데이터로 변환하는 메서드
             	} ///// catch //////
             	
             	
            
            
            
            %>
            
            <!-- 3.테이블 메인부분 -->
            <tbody>
            	
            </tbody>
            
            <!-- 4.테이블 하단부분-->
            <tfoot>
                <tr>
                    <td colspan="7">
                        ◀ 1 | <a href="#">2</a> | <a href="#">3</a> | <a href="#">4</a> | <a href="#">5</a> | <a href="#">6</a> | <a href="#">7</a> | <a href="#">8</a> | <a href="#">9</a> | <a href="#">10</a> ▶
                    </td>
                    <!-- 
                        colspan 속성은 기본적으로 td를 합칠때 사용함
                        상단의 td(th)가 7개 이고 이것을 합치려면
                        7개를 하나로 통합하는 값을 설정해 준다!
                        여기서 col은 column 컬럼(기둥)의 뜻
                        span은 "범위"라는 의미
                     -->
                </tr>
            </tfoot>
        </table>

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