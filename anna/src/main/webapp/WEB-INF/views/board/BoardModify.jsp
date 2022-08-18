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
		
				<form action="BoardModify.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="Location" value="${userLoginInfo.location_auth}">
					<input type="hidden" name="board_type" value="${bv.board_type }">
					<input type="hidden" name="Bidx" value="${bv.bidx }">
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">제목</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" name="Title" placeholder="제목을 입력해주세요" value="${bv.title}">
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
							<textarea class="form-control" id="summernote" name="contents" rows="10" cols="25"> ${bv.contents }</textarea>
						</div>
					</div>
					

					
					<div class="text-end tr">
						<div class="td">
							<button class="btn" style="background:#00AAB2; color:#fff;">등록</button>
							<button class="btn" style="background:#00AAB2; color:#fff;" type="button" onclick="location.href='${path}/board/boardlist.do?=${pm.board_type}'">취소</button>
						</div>
					</div>
					
					<c:if test="${bv.image2 != null}">
						<span class="view2">${bv.image2}</span><br>
					</c:if>
					<c:if test="${bv.image3 != null}">
						<span>${bv.image3}</span><br>
					</c:if>
					<c:if test="${bv.image4 != null}">
						<span>${bv.image4}</span><br>
					</c:if>
					<c:if test="${bv.image5 != null}">
						<span>${bv.image5}</span>
					</c:if>
					

				</form>
				
			</div>
		</div>




		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>

   <h2>글 수정</h2>
    
<form action="BoardModify.do" method="post">

<input type="text" name="Location" value="${userLoginInfo.location_auth}">
<input type="hidden" name="board_type" value="${bv.board_type }">
<input type="hidden" name="Bidx" value="${bv.bidx }">

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
	<span class="view">${bv.image1}</span><br>
	<div class="viewimg">
		<img src="../resources/upload/${bv.image1}" alt ="안되는데요?">
	</div>
</c:if>


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

<script type="text/javascript">

$(".view").mouseover(function(){
	$(".viewimg").css("display","block")
	
	});

$(".view").mouseout(function(){
	$(".viewimg").css("display","none")
	
});

</script>


</body>
</html>