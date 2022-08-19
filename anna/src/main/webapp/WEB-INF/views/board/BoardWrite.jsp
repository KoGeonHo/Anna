<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<!-- include libraries(jQuery, bootstrap) -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
   	<script src="${ path }/js/bootstrap.js"></script>
	<script src="${ path }/js/common/common.js"></script>

<!-- 지도 API - 필요없으면 지워도 됨 -->
	<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script>	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 지도 API -->

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
	
	<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
	<!-- include summernote css/js-->

<!-- path는 request.getContextPath()를 가져온것. -->

<style>
    
#file{
	width: calc(100% - 35px);

}    
 
.th {
	background:#eee;
	text-align:center;
	vertical-align:middle;
}
.th, .td{
	padding:10px;
}

.tr{
	display:table; 
	width:100%;
}

html{

width : 100%;

}

body {


}

#location_kakao{

display: none;

}

.note{


}


</style>
</head>
<body>

<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
	<div class="container main">
		<div class="wrapper">
			<div class="container main">
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">글 쓰기</h3>
		
				<form action="BoardWrite.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="uidx" value="${uidx}">
					<c:if test="${ pm.board_type eq 'notice' }">
						<input type="hidden" name="Location" value="notice">
					</c:if>
					<c:if test="${ pm.board_type ne 'notice' }">
						<input type="hidden" name="Location" value="${userLoginInfo.location_auth}">
					</c:if>
					
				
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">제목</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" name="Title" placeholder="제목을 입력해주세요">
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">게시판 분류</div>
						<div class="col-8 td" style="display:table-cell;">
							<c:if test="${ pm.board_type eq 'notice' }"> 
								공지사항 
								<input type="hidden" name="board_type" value="notice">
							</c:if>
							<c:if test="${ pm.board_type ne 'notice' }">
								<select name="board_type" onchange="javascript:locationMap(this);" id="board_type">
									<option value="free" <c:if test="${ pm.board_type eq 'free' }"> selected </c:if>>일상&amp;소통</option>
									<option value="job" <c:if test="${ pm.board_type eq 'job' }"> selected </c:if>>구인구직</option>
									<option value="meeting" <c:if test="${ pm.board_type eq 'meeting' }"> selected </c:if>>모임</option>
									<option value="hotplace" <c:if test="${ pm.board_type eq 'hotplace' }"> selected </c:if>>우리동네 핫플레이스</option>
								</select>
							</c:if>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">내용</div>
						<div class="col-8 td" style="display:table-cell;">
							<textarea class="form-control" id="summernote" name="contents" rows="10" cols="25"></textarea>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">첨부 파일</div>
						
						<div id="boxWrap" class="col-8 td" style="display:table-cell;">
							<!-- <button type="button" id="file_btn">추가</button> -->
							<input class="form-control" type="file" id="file" name="FileName1" accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'>
						</div>
					</div>
					
					<div class="text-end tr">
						<div class="td">
							<button class="btn" style="background:#00AAB2; color:#fff;">등록</button>
							<button class="btn" style="background:#00AAB2; color:#fff;" type="button" onclick="location.href='${path}/board/boardlist.do?=${pm.board_type}'">취소</button>
						</div>
					</div>
					<!-- <div id="location_kakao">

					서비스 준비중입니다.
					
					</div> -->
				</form>
					<input type="hidden" class="boardtype" value="${pm.board_type}">
			</div>
		</div>




		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</div>
</body>




<script>


$(document).ready(function() {
	var i=2; // 변수설정은 함수의 바깥에 설정!
  $("#file_btn").click(function() {
    if(i<=5){
    	
    	$("#boxWrap").append("<input class='form-control' id='file' type='file' name='FileName"+i+"' accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'><a class='del'>삭제</a>");
    }
    
    i++;
    
    if(i==6){
    	$("#file_btn").css("display","none");
    }
   
    

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
<script>

var boardtype = $(".boardtype").val();

console.log(boardtype);

$('#board_type').val(boardtype).prop("selected");




function locationMap(obj){
	

	var board_type = $("#board_type").val();
	
	console.log(board_type);
	
	if(board_type != 'free'){
	
		$("#location_kakao").css("display","block")

	}else if(board_type == 'free'){
		
		$("#location_kakao").css("display","none")
	}
}


function myListener(obj) {alert(obj.value);
// 선택된 option의 value가 출력된다!    }
}
</script>

</body>
</html>