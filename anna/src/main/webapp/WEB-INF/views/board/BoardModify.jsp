<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>

    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
   	<script src="${ path }/js/bootstrap.js"></script>
	<script src="${ path }/js/common/common.js"></script>

    
<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
	
	<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />

<style>
    

.viewimg{

display : none;
position: fixed;


}

.viewimg2{

display : none;
position: fixed;


}
.viewimg3{

display : none;
position: fixed;


}
.viewimg4{

display : none;
position: fixed;


}
.viewimg5{

display : none;
position: fixed;


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

    
</style>

</head>
<body>

<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		
		<div class="wrapper">
			<div class="container main">
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">글 수정</h3>
		
				<form action="BoardModify.do" method="post" enctype="multipart/form-data" id="frm">
					<input type="hidden" name="Location" value="${userLoginInfo.location_auth}">
					<input type="hidden" name="Bidx" value="${bv.bidx }">
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">제목</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" id="Title" name="Title" placeholder="제목을 입력해주세요" value="${bv.title}">
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">게시판 분류</div>
						<div class="col-8 td" style="display:table-cell;">
							<select name="board_type" onchange="javascript:locationMap(this);" id="board_type">
								<option value="free">일상&amp;소통</option>
								<option value="job">구인구직</option>
								<option value="meeting">모임</option>
								<option value="hotplace">우리동네 핫플레이스</option>
							</select>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">내용</div>
						<div class="col-8 td" style="display:table-cell;">
							<textarea class="form-control" id="summernote" name="contents" rows="10" cols="25">${bv.contents }</textarea>
						</div>
					</div>
					

					
					
					<c:if test="${bv.image1 != null}">
						<span class="view">${bv.image1}</span><br>
						<div class="viewimg">
							<img src="../resources/upload/${bv.image1}" alt ="안되는데요?" style="width:500px">
						</div>
					</c:if>
					<c:if test="${bv.image2 != null}">
						<span class="view2">${bv.image2}</span><br>
						<div class="viewimg2">
							<img src="../resources/upload/${bv.image2}" alt ="안되는데요?" style="width:500px">
						</div>
					</c:if>
					<c:if test="${bv.image3 != null}">
						<span class="view3">${bv.image3}</span><br>
						<div class="viewimg3">
							<img src="../resources/upload/${bv.image3}" alt ="안되는데요?" style="width:500px">
						</div>
					</c:if>
					<c:if test="${bv.image4 != null}">
						<span class="view4">${bv.image4}</span><br>
						<div class="viewimg4">
							<img src="../resources/upload/${bv.image4}" alt ="안되는데요?" style="width:500px">
						</div>
					</c:if>
					<c:if test="${bv.image5 != null}">
						<span class="view5">${bv.image5}</span>
						<div class="viewimg5">
							<img src="../resources/upload/${bv.image5}" alt ="안되는데요?" style="width:500px">
						</div>
					</c:if>
					
					
					<div class="text-end tr">
						<div class="td">
							<button class="btn" style="background:#00AAB2; color:#fff;" onclick="check()">수정</button>
							<button class="btn" style="background:#00AAB2; color:#fff;" type="button" onclick="location.href='${path}/board/boardlist.do?=${bv.board_type}'">취소</button>
						</div>
					</div>
					<input type="hidden" id="place_location" name="place_location" value="${bv.place_location}">
				</form>
				<input type="hidden" class="boardtype" value="${bv.board_type}">
				
			</div>
		</div>




		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>

<script type="text/javascript">

var boardtype = $(".boardtype").val();

console.log(boardtype);

$('#board_type').val(boardtype).prop("selected",true);

$(".view").mouseover(function(){
	$(".viewimg").css("display","block")
	
	});

$(".view").mouseout(function(){
	$(".viewimg").css("display","none")
	
});

$(".view2").mouseover(function(){
	$(".viewimg2").css("display","block")
	
	});

$(".view2").mouseout(function(){
	$(".viewimg2").css("display","none")
	
});

$(".view3").mouseover(function(){
	$(".viewimg3").css("display","block")
	
	});

$(".view3").mouseout(function(){
	$(".viewimg3").css("display","none")
	
});

$(".view4").mouseover(function(){
	$(".viewimg4").css("display","block")
	
	});

$(".view4").mouseout(function(){
	$(".viewimg4").css("display","none")
	
});

$(".view5").mouseover(function(){
	$(".viewimg5").css("display","block")
	
	});

$(".view5").mouseout(function(){
	$(".viewimg5").css("display","none")
	
});

var title = $("#Title").val();

function check(){
	
	var title = $("#Title").val();
	
	if(title == ""){
		alert("제목을 입력하세요");
		$("#Title").focus();
		return false;
	}
	else if($("#board_type").val()==""){
		alert("게시글 분류를 선택해주세요");
		$("#board_type").focus();
		return false;
	}else if($("#summernote").val()==""){
		alert("내용을 입력하세요");
		$("#summernote").focus();
		return false;
	}else{
		
		$("#frm").submit();
	}
	

}
	

</script>


</body>
</html>