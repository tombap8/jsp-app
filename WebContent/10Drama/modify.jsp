<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>드라마 데이터 조회/수정/삭제하기</title>
    <link rel="stylesheet" href="css/drama.css">
    <style>
        body{
            text-align: center;
        }
        body, input {
        	font-size: 26px;
        }
        
        label{
            display: block;
            margin: 25px 0;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    $(function(){ /// jQB //////////////////
    	// 수정하기 버튼
        $("#mbtn").click(function(e){
            
            // 전송기능막기!
            e.preventDefault();
            
            // 각 항목이 비었는지 검사하기
            let res=true;//검사결과
            // 흰손수건의 법칙! 한번만 false여도 false!
            
            $("input[type=text]").each(
                function(idx,ele){
                //console.log("순번:"+idx);
                    
                // 각 입력양식 값이 빈값여부체크
                if($(ele).val().trim()==="") 
                    res = false;
                                        
            });////// each /////////
            
            console.log("검사결과:"+res);
            
            /// 검사결과 모든 항목이 통과면 서브밋하기
            if(res){
                $("#dform").submit();
                // 서브밋하면 form요소에 action속성에 지정된 
                // 페이지로 데이터와 함께 이동한다!
                // 서브밋(submit)은 "데이터 전송"의 의미를 가짐!
            }/////// if //////////
            /// 불통과시 메시지 보이기 /////
            else{
                alert("모든항목이 필수입니다!");
            }/////// else ////////////
            
            
        });////// click //////////////
        
        /// 삭제버튼 클릭시 ///////////
        $("#dbtn").click(function(e){

            // 전송기능막기!
            e.preventDefault();
            
        	let conf = confirm("정말 삭제하시겠습니까?");
        	// confirm(메시지)
        	// "확인"클릭시 true, "취소"클릭시 false 리턴
        	console.log("삭제여부:",conf);
        	
        	// 분기하기(true일경우)
        	if(conf){
        		// 삭제처리 페이지로 보내기!
        	} ////// if //////////
        	
        }); /////// click ///////////////
        
        // 리스트가기 버튼 클릭시 //////
        $("#lbtn").click(function(e){

            // 전송기능막기!
            e.preventDefault();
            
            // 리스트 페이지로 이동!
        	location.href = "list.jsp";
        }); //////// click /////////////
        
        
    });////////// jQB //////////////////////
    </script>
</head>
<body>
   <h1>드라마 데이터 조회·수정·삭제하기</h1>
   
   <%
   		// 파라미터 받기(모든 파라미터는 숫자가 넘어와도 모두 문자형이다!)
   		// idx값을 받아서 본 페이지에서 활용한다!
   		String idnum = request.getParameter("idx");
   		out.println("넘어온 레코드 idx키값:"+idnum);
   
   %>
   
   <form action="process/mod.jsp" method="post" id="dform">
       
       <label for="dname">드라마명</label>
       <input type="text" name="dname" id="dname" maxlength="100">
       <label for="actors">주연</label>
       <input type="text" name="actors" id="actors" maxlength="100">
       <label for="broad">제작사</label>
       <input type="text" name="broad" id="broad" maxlength="50">
       <label for="gubun">구분</label>
       <input type="text" name="gubun" id="gubun" maxlength="10">
       <label for="stime">방영시간</label>
       <input type="text" name="stime" id="stime" maxlength="50">
       <label for="total">방영횟수</label>
       <input type="text" name="total" id="total" maxlength="20">
       
       <br><br>
       <!-- 수정하기 버튼 -->
       <input type="submit" value="수정하기" id="mbtn">
       <!-- 삭제하기 버튼 -->
       <input type="submit" value="삭제하기" id="dbtn">
       <!-- 리스트가기 버튼 -->
       <input type="submit" value="리스트가기" id="lbtn">
       <!--
           form요소 내부의 submit버튼을 클릭하면
           form요소에 셋팅된 action속성의 페이지로
           전송된다!
       -->
   </form>
   
   
   
   
   
   
    
</body>
</html>