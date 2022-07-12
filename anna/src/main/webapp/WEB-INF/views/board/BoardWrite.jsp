<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<!-- include libraries(jQuery, bootstrap) -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- include summernote css/js-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
  
</head>
<body>



    <h1>Summernote</h1>
    
<form action="BoardWrite.do" method="post">
<select name="BoardType">
	<option value="free">일상&amp;소통</option>
	<option value="job">구인구직</option>
	<option value="metting">만남</option>
	<option value="hotplace">우리동네 핫플레이스</option>
</select>
<input type="text" name="Title" placeholder="제목을 입력해주세요">
 
<textarea id="summernote" name="Contents"></textarea>


<button type="button">취소</button>
<button>작성완료</button>
</form>

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