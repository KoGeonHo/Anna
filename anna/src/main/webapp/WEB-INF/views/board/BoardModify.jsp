<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- include summernote css/js-->
<script src="${pageContext.request.contextPath}/js/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/js/summernote-ko-KR.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<style>
    

.viewimg{

display : none;
position: fixed;


}

    
</style>
<script>

$(".view").mouseover(function(){
	$(".viewimg").fadeIn()
	
	});



$("#test").mouseleave(function(){$(this).css("color", "black");}

</script>
</head>
<body>

   <h2>글 수정</h2>
    
<form action="BoardWrite.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="uidx" value="${uidx}">
<input type="text" name="Location" value="${userLoginInfo.location_auth}">
<input type="text" name="board_type" value="${bv.board_type }">

<c:if test="${bv.board_type eq 'free'}">
	일상&amp;소통
</c:if>
<c:if test="${bv.board_type eq 'job'}">
	구인구직
</c:if>
<c:if test="${bv.board_type eq 'meeting'}">
	모임
</c:if>
<c:if test="${bv.board_type eq 'hotplace'}">
	우리동네 핫플레이스
</c:if>

<input type="text" name="Title" placeholder="제목을 입력해주세요" value="${bv.title}">
 
<textarea id="summernote" class="summernote" name="Contents">${bv.contents }</textarea>

<c:if test="${bv.image1 != null}">
	<div class="view">${bv.image1}</div>
	<div class="viewimg">
		<img src="../resources/upload/${bv.image1}" alt ="안되는데요?">
	</div>
</c:if>

<c:if test="${bv.image2 != null}">
	<div class="view2">${bv.image2}</div>
</c:if>
<c:if test="${bv.image3 != null}">
	<div>${bv.image3}</div>
</c:if>
<c:if test="${bv.image4 != null}">
	<div>${bv.image4}</div>
</c:if>
<c:if test="${bv.image5 != null}">
	<div>${bv.image5}</div>
</c:if>
 
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