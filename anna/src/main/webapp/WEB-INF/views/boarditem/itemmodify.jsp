<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
 <!-- include libraries(jQuery, bootstrap) -->
        <!-- include libraries(jQuery, bootstrap) -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- include summernote css/js-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<meta charset="utf-8">
<title> 상품 등록 페이지</title>
<script>
    var fileCheck = document.getElementById("file").value;
    if(!fileCheck == null){
        alert("파일을 첨부해 주세요");
        return false;
    }
</script>
</head>
<body>
<h2>중고거래글 수정 페이지</h2>
<form action="itemmodify.do" method="post" enctype="multipart/form-data" name="frm">
	<input type="hidden" name="uidx" value="1"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->

	<input type="hidden" name="item_idx" value="${vo.item_idx}">
	제목: <input type="text" name="title" value="${vo.title}">
	카테고리:<select name="cate_idx">
			<option value="1">가전제품</option>
		   </select>
	가격제안:<select name="offer">
			<option value="1">불가능</option>
			<option value="2">가능</option>
		   </select>
	<textarea id="summernote" name="contents" >${vo.contents}</textarea>
	<br>
	<input type="hidden" name="addr1" value="1"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
	<input type="hidden" name="addr2" value="1"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
	<input type="hidden" name="addr_code" value="1"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
	
	
	키워드:<input type="text" name="keyword" value="1"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
		<br>
	가격:<input type="number" name="price" value="1"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
		<br>
		
	거래상태:<select name="state">
			<option value="1">거래중</option>
			<option value="2">거래완료</option>
			<option value="3">예약중</option>
		  </select>
	
		<br>

	
		 <div id="fileDiv">
			<p>
				<input type="file" id="file" name="file1">
				<a href="#this" class="btn" id="delete" name="delete">삭제</a>
			</p>
		</div>
		
		<br/><br/>
		<a href="#this" class="btn" id="addFile">파일 추가</a> ${vo.image1}
	<button id="saveBtn">작성하기</button>
	<button>취소하기</button>
	
</form>

<script>
    $(document).ready(function () {

	 
	    //위와 같이 값을 먼저 넣어준 후 초기화를 시킨다. 그럼 아래와 같이 입력이 된다.
	    //초기화
		$('#summernote').summernote({
			height : 400, // set editor height
			minHeight : null, // set minimum height of editor
			maxHeight : null, // set maximum height of editor
			focus : true,
			lang : 'ko-KR' // 기본 메뉴언어 US->KR로 변경
		});
	
	    //저장버튼 클릭
	    $(document).on('click', '#saveBtn', function () {
	        saveContents();
	        });
	        
	    });
	 function saveContents() {
    	
        //값 가져오기
        var Content = $('#summernote').summernote('code');        //썸머노트(설명)
        alert("contents : " + contents);
		
    }

</script>
	<script type="text/javascript">
		var gfv_count = 2;
	
		$(document).ready(function(){
			$("#list").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openBoardList();
			});
			
			$("#write").on("click", function(e){ //작성하기 버튼
				e.preventDefault();
				fn_insertBoard();
			});
			
			$("#addFile").on("click", function(e){ //파일 추가 버튼
				e.preventDefault();
				fn_addFile();
			});
			
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteFile($(this));
			});
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/boarditem/itemlist.do' />");
			comSubmit.submit();
		}
		
		function fn_insertBoard(){
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/boarditem/itemwrtie.do' />");
			comSubmit.submit();
		}
		
		function fn_addFile(){
			var str = "<p><input type='file' name='file"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></p>";
			$("#fileDiv").append(str);
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteFile($(this));
			});
		}
		
		function fn_deleteFile(obj){
			obj.parent().remove();
		}
	</script>
	
</body>
</html>