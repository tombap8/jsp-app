<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비동기 통신 테스트 페이지</title>
    <!-- 제이쿼리 라이브러리 CDN -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
        $(()=>{

            // 버튼클릭시
            $("#mybtn").click(e=>{
                // 기본 서브밋 이동막기!
                e.preventDefault();

            })

        }); ////////// jQB //////////////

    </script>
</head>
<body>
    <form action="process/ajaxtest.jsp" id="myform" method="post">
        <input type="text" name="name" id="name">
        <button id="mybtn" type="submit">전송하기</button>
    </form>
    
</body>
</html>