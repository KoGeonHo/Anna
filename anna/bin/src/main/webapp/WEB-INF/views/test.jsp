<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/All.css">
<!-- include libraries(jQuery, bootstrap) -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- include summernote css/js-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
  
    <title>Nav Bar</title>
  </head>

  <body>
    <nav class="navbar">

      <div class="navbar__logo">
        <i class="fas fa-blog"></i>
        <a href="">ANNA</a>
      </div>

      <ul class="navbar__menu">
        <li><a href="#">중고거래</a></li>
        <li><a href="#">커뮤니티</a></li>
        <li><a href="#">고객센터</a></li>
        <li><a href="#">마이페이지</a></li>
        
      </ul>

      <ul class="navbar__icons">
        <li><i class="fab fa-google"></i></li>
        <li><i class="fab fa-slack"></i></li>
      </ul>
      
    </nav>
    <article>
    
    <div>
    	<img src="" alt="사진이 없습니다.">
    
    </div>
    
    
    </article>
    <h1>Summernote</h1>
<div id="summernote"></div>
<script>
    // 메인화면 페이지 로드 함수
    $(document).ready(function () {
        $('#summernote').summernote({
            placeholder: '내용을 작성하세요',
            height: 400,
            maxHeight: 400
        });
    });
</script>
  </body>
</html>