<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통패키지 -->
<%@page import="drama.ListController"%>
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
		
		// 페이징블록 파라미터 받기(만약없으면 null이므로 "1"할당!)
		String bkNum = request.getParameter("bknum");
		if(bkNum==null) bkNum="1";
		
		// 검색어관련 파라미터 받기(만약없으면 null값으로 셋팅됨!)
		String pmCol = request.getParameter("col");
		String pmKey = request.getParameter("key");
		
		// 리스트 컨트롤러 생성하기 ////
		ListController listcon = new ListController(); 

		// 결과 리스트를 변수에 할당
		String showList = listcon.setList(pgNum,bkNum,pmCol,pmKey);
		/////////////////////////////////////////////////
		%>

		<!-- 3.테이블 메인부분 -->
		<tbody>
		<%
        	// 결과가 없을 경우 표시코드 생성
        	if(showList.equals("")) out.print(
        	"<tr><td style=\"text-align:center\" "
        	+"colspan=\"6\">데이터가 없습니다!</td></tr>");
        	// 결과 리스트가 있을 경우 출력
        	else out.print(showList);
        %>
		</tbody>

		<!-- 4.테이블 하단부분-->
		<tfoot>
			<tr>
				<td colspan="7"><%=listcon.setPaging()%></td>
			</tr>
		</tfoot>
	</table>
	
	
	<!-- 검색박스 -->	
    <div class="gubun" style="text-align:center;padding:40px 0;">
		<!-- 검색항목 선택 select박스 -->
		<select name="selcol" id="selcol" style="font-size:24px">
			<option value="dname">드라마제목</option>
			<option value="actors">주연</option>
		</select>
		<input type="text" name="keyword" id="keyword" style="font-size:24px">
		<button id="sbtn" style="font-size:24px">검색하기</button>
	</div>

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
	
	<!-- 제이쿼리 라이브러리 -->
    <script src="./js/jquery-3.6.1.min.js"></script>
    <script>
    $(()=>{ ///////// jQB ///////////////
    	
    	// 키워드 검색 엔터시 버튼클릭 트리거 발생!    	
    	$("#keyword").focus().keypress(function(e) {
    		  if (e.keyCode === 13) {
    		    e.preventDefault();
    		    $("#sbtn").trigger("click");
    		  }
    		});
    	
    	// 파라미터 가져오기 메서드 //////////
    	$.urlParam = function(name) {
		    let results = new RegExp('[\?&]' 
		    		+ name + '=([^&#]*)').exec(window.location.href);
		    if (results==null) {
		        return null;
		    } else {
		        return results[1] || 0;
		    }
		} ///////// urlParam 함수 ////////
    	

    	// 검색요소 변수할당
    	let selcol = $("#selcol");
    	let keyword = $("#keyword");
    	
    	// 넘어온 파라미터에 key값이 있으면!
    	if($.urlParam("key")!= null){
    		// val(값) - 선택요소에 값 셋팅!
    		selcol.val($.urlParam("col"));
    		keyword.val(decodeURIComponent($.urlParam("key")));
    		// decodeURIComponent() -> 2byte 한글 안깨지게 처리
    	}
    	
    	// 1. 검색버튼 클릭시 처리하기
    	$("#sbtn").click(function(){
    		// 1-1.검색항목 읽어오기
    		let col = selcol.val();
    		// 1-2.검색키워드 읽어오기
    		let key = keyword.val();
    		// 1-3.검색어관련 파라미터로 list페이지 다시호출하기
    		// 검색항목 : col=값 / 검색어 : key=값
    		location.href = 
    			"list.jsp?pgnum=1&col="+col+"&key="+key;
    		
    	}); ///////// click ////////////
    	
    }); ///////////// jQB ///////////////
    </script>


	

</body>
</html>