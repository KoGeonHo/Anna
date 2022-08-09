<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
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



  <script src="${pageContext.request.contextPath}/js/summernote-lite.js"></script>
  <script src="${pageContext.request.contextPath}/js/summernote-ko-KR.js"></script>


     <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
  
</head>
<body>
${uidx}


    <h1>Summernote</h1>
    
<form action="BoardWrite.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="uidx" value="${uidx}">
<select name="board_type">
	<option value="free">일상&amp;소통</option>
	<option value="job">구인구직</option>
	<option value="metting">만남</option>
	<option value="hotplace">우리동네 핫플레이스</option>
</select>
<input type="text" name="Title" placeholder="제목을 입력해주세요">
 
<textarea id="summernote" class="summernote" name="Contents"></textarea>
<div id="boxWrap">
<button type="button" id="file_btn">추가</button>
<input type="file" name="FileName1" accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'>


</div>

<button type="button">취소</button>
<button>작성완료</button>
</form>

<script>
$('#summernote').summernote({
	  // 에디터 높이
	  height: 150,
	  // 에디터 한글 설정
	  lang: "ko-KR",
	  // 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
	  focus : true,
	  toolbar: [
		    // 글꼴 설정
		    ['fontname', ['fontname']],
		    // 글자 크기 설정
		    ['fontsize', ['fontsize']],
		    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    // 글자색
		    ['color', ['forecolor','color']],
		    // 표만들기
		    ['table', ['table']],
		    // 글머리 기호, 번호매기기, 문단정렬
		    ['para', ['ul', 'ol', 'paragraph']],
		    // 줄간격
		    ['height', ['height']],
		    // 그림첨부, 링크만들기, 동영상첨부
		    ['insert',['picture','link','video']],
		    // 코드보기, 확대해서보기, 도움말
		    ['view', ['codeview','fullscreen', 'help']]
		  ],
		  // 추가한 글꼴
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
		 // 추가한 폰트사이즈
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	  
	});
</script>
<script>

$(document).ready(function() {
	var i=2; // 변수설정은 함수의 바깥에 설정!
  $("#file_btn").click(function() {
    if(i<=5){
    	
    	$("#boxWrap").append("<input type='file' name='FileName"+i+"' accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'>");
    }
    
    i++;
   
    

  });
});

function chk_file_type(obj) {
    var file_kind = obj.value.lastIndexOf('.');
    var file_name = obj.value.substring(file_kind+1,obj.length); 
    var file_type = file_name.toLowerCase();



   var check_file_type = new Array();
    check_file_type=['jpg','gif','png','jpeg','bmp',];



    if(check_file_type.indexOf(file_type)==-1){
     alert('이미지 파일만 선택할 수 있습니다.');
     var parent_Obj=obj.parentNode
     var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);
     return false;
     
     }
    
}

</script>


</body>
</html>