<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="${path}/css/bootstrap.css" rel="stylesheet" />
<script src="${path}/js/jquery-3.6.0.js"></script>
<script src="${path}/js/bootstrap.js"></script>
<script src="${path}/js/common/common.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type='text/css'>
@
-ms-viewport {
	width: device-width;
}

@
-o-viewport {
	width: device-width;
}

@
viewport {
	width: device-width;
}
</style>
<title>item view 페이지</title>

<style>

#Neighbor_area{

display: flex;
}

.chat-list {
	height: 300px;
	overflow-y: auto;
}

#viewcontent {
	
}
/* 상대방의 다른상품 리스트 이미지 크기 */
.row .col-lg-3 .card img {
	width: 100%;
	height: 150px;
}

.slider {
	width: 700px;
	height: 480px;
	position: relative;
	margin: 0 auto;
	overflow: hidden; /* 현재 슬라이드 오른쪽에 위치한 나머지 슬라이드 들이 보이지 않도록 가림 */
}
.slider-1>.page-btns>div.active {
		/* background-color:rgba(255,255,255,1); */
		background-color: whtie;
	}
.slider input[type=radio] {
	
}

ul.imgs {
	padding: 0;
	margin: 0;
	list-style: none;
}

ul.imgs li {
	position: absolute;
	left: 700px;
	transition-delay: 1s; /* 새 슬라이드가 이동해 오는 동안 이전 슬라이드 이미지가 배경이 보이도록 지연 */
	padding: 0;
	margin: 0;
}

.bullets {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 20px;
	z-index: 2;
}

.bullets label {
	display: inline-block;
	border-radius: 50%;
	background-color: rgba(0, 0, 0, 0.55);
	width: 20px;
	height: 20px;
	cursor: pointer;
}

.slides img {
	float: left;
	/* margin-left: 80px; */
	width: 100%;
	height: 400px;
}

/* #btn-area .btn{
width: 90px; 
height: 38px; 
background-color: #00AAB2; 
color: #fff; 
margin-left: 15px;
} */

/*557 보다 크거나 같아야 하고 991거나 작아야 같아야함 태블릿용*/
@media all and (767px <= width <= 3600px) {

#btn-area-web .btn{
	width: 30%;
    height: 38px;
    background-color: #00AAB2;
    color: #fff;
    margin-left: 8%;
    margin-top: 8px;
    margin-bottom: 8px;
    
}

#btn-area{
display:none;

}

#Neighbor_area-web{
	display:flex;
}


#btn-area .btn{
	text-align:center;
    height: 38px;
    width:24%;
    background-color: #00AAB2;
    color: #fff;
    display:none;
	}
#carouselExampleIndicators{
display:none;
}

}

/* 420이하 모바일*/
@media ( max-width : 767px ) {

	/* web 버전 */
	#btn-area-web .btn{
	text-align:center;
    height: 38px;
    width:24%;
    background-color: #00AAB2;
    color: #fff;
    display:none;
	}
	
	#btn-area .btn{
	text-align:center;
    height: 38px;
    width:24%;
    background-color: #00AAB2;
    color: #fff;
	}
	#viewcontent {
		margin-left: 0px;
	}
	.card-body img {
		width: 100%;
		height: 250px;
	}
	.slider {
		width: 300x;
		height: 250px;
		position: relative;
		margin: 0 auto;
		overflow: hidden; /* 현재 슬라이드 오른쪽에 위치한 나머지 슬라이드 들이 보이지 않도록 가림 */
		display: none;
	}
	.bullets label {
		display: inline-block;
		border-radius: 50%;
		background-color: rgba(0, 0, 0, 0.55);
		width: 4px;
		height: 4px;
		cursor: pointer;
	}
	body {
		/* 글자 드래그 방지 */
		-ms-user-select: none;
		-moz-user-select: -moz-none;
		-webkit-user-select: none;
		-khtml-user-select: none;
		user-select: none;
	}
	.slider-1 {
		width: 100%;
		height: 400px;
		position: relative;
		display: none;
	}

	/* 슬라이더 1 - 페이지 버튼 */
	.slider-1>.page-btns {
		text-align: center;
		position: absolute;
		bottom: 20px;
		left: 0;
		width: 100%;
		display: none;
	}
	.slider-1>.page-btns>div {
		width: 20px;
		height: 20px;
		/* background-color:rgba(255,255,255,.5); */
		background-color: white;
		border-radius: 4px;
		display: inline-block;
		cursor: pointer;
		display: none;
	}
	.slider-1>.page-btns>div.active {
		/* background-color:rgba(255,255,255,1); */
		background-color: white;
		display: none;
	}

	/* 슬라이더 1 - 슬라이드 */
	.slider-1>.slides>div {
		position: absolute;
		width: 500px;
		height: 350px;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		opacity: 0;
		transition: opacity 0.3s;
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
		display: none;
	}
	.slider-1>.slides>div.active {
		opacity: 1;
		display: none;
		width: 100%;
	}
	.slider-1>.slides>div.active img {
		width: 100%;
	}

	/* 슬라이더 좌우 버튼 */
	.slider-1>.side-btns>div {
		/*  position:absolute; */
		top: 0;
		left: 0;
		width: 25%;
		height: 100%;
		cursor: pointer;
		display: none;
		background-color: grey;
	}
	.slider-1>.side-btns>div:last-child {
		left: auto;
		right: 0;
		display: none;
	}
	.slider-1>.side-btns>div>span {
		position: absolute;
		top: 50%;
		left: 20px;
		transform: translatey(-50%);
		background-color: white;
		opacity: 0.5;
		padding: 1px 13px;
		border-radius: 50px;
		font-size: 25px;
		display: none;
	}
	.slider-1>.side-btns>div:last-child>span {
		left: auto;
		right: 20px;
		display: none;
	}
	.container {
		width: 100%;
		hieght: 50px;
	}
	
	.carousel-item > img{
	width:100%;
	height:100%;
	}
	
	.carousel-inner{
		height:340px;
	}
	
}

@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

html {
	font-family: "Noto Sans KR", sans-serif;
}

a {
	color: inherit;
	text-decoration: none;
}

/* 커스텀 */

/* 슬라이더 1 시작 */
.slider-1 {
	width: 100%;
	height: 400px;
	position: relative;
}

/* 슬라이더 1 - 페이지 버튼 */
.slider-1>.page-btns {
	text-align: center;
	position: absolute;
	bottom: 20px;
	left: 0;
	width: 100%;
}

.slider-1>.page-btns>div {
	width: 20px;
	height: 20px;
	background-color:rgba(255,255,255,.5);
	/* background-color: gray; */
	border-radius: 4px;
	display: inline-block;
	cursor: pointer;
}

.slider-1>.page-btns>div.active {
	/* background-color:rgba(255,255,255,1); */
	background-color: grey;
}

/* 슬라이더 1 - 슬라이드 */
.slider-1>.slides>div {
	position: absolute;
	width: 500px;
	/* height: 500px; */
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	opacity: 0;
	transition: opacity 0.3s;
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
	display: block;
}

.slider-1>.slides>div.active {
	opacity: 1;
	display: block;
}

/* 슬라이더 좌우 버튼 */
.slider-1>.side-btns>div {
	/*  position:absolute; */
	top: 0;
	left: 0;
	width: 25%;
	height: 100%;
	cursor: pointer;
}

.slider-1>.side-btns>div:last-child {
	left: auto;
	right: 0;
}

.slider-1>.side-btns>div>span {
	position: absolute;
	top: 50%;
	left: 20px;
	transform: translatey(-50%);
	background-color: gray;
	opacity: 0.5;
	padding: 1px 13px;
	border-radius: 50px;
	font-size: 25px;
}

.slider-1>.side-btns>div:last-child>span {
	left: auto;
	right: 20px;
}

/* 슬라이더 1 끝 */
.wrap {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 200px;
	height: 100px;
	margin-top: -50px;
	margin-left: -100px;
}

table {
	width: 100%;
	border-collapse: collapse;
	border: 0;
	empty-cells: show;
	border-spacing: 0;
	padding: 0;
}

table th {
	height: 24px;
	padding: 4px 10px;
	border: 1px solid #DDD;
	font-weight: bold;
	text-align: left;
	background: #ecf5fc;
}

table td {
	height: 22px;
	padding: 5px 10px;
	border: 1px solid #DDD;
}

#btn_close {
	float: right
}

/*레이어 팝업 영역*/
.Pstyle {
	opacity: 0;
	display: none;
	position: relative;
	width: auto;
	border: 5px solid #fff;
	padding: 20px;
	background-color: #fff;
}

.Pstyle2 {
	opacity: 0;
	display: none;
	position: relative;
	width: auto;
	border: 5px solid #fff;
	padding: 20px;
	background-color: #fff;
}

#Wish_area {
	height: 50px;
}

#Wish_area .image {
	width: 50px;
	height: 50px;
	position: relative;
	text-align: center;
	color: #FFFFFF;
}

#Wish_area .image p {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%); /*  background-color:#FFFFFF; */
	text-shadow: -1px 0 1px black, 0 1px 1px black, 1px 0 1px black, 0 -1px
		1px black;
	margin: auto;
}

a:link {
	color: black;
	text-decoration: none;
}
</style>

<script>
let item_idx = <%=request.getParameter("item_idx")%>;
let uidx = ${userLoginInfo.uidx};
<%-- let uidx = <%=request.getParameter("uidx")%>; --%>
console.log("addwish");
	function addWish(){
		if( uidx != null){		
			$.post('addWish',{
				item_idx : item_idx,
			},'json');
			$('#Neighbor_area').load(location.href+' #Neighbor_area');
			$('#Neighbor_area-web').load(location.href+' #Neighbor_area-web');
			$('#count-area').load(location.href+' #count-area');
			
				console.log("찜 완료");
		}
	}
	

	function delWish(){
		if(uidx != null){
			$.post('delWish',{
				item_idx : item_idx,
			},'json');
			$('#Neighbor_area').load(location.href+' #Neighbor_area');
			$('#Neighbor_area-web').load(location.href+' #Neighbor_area-web');
			$('#count-area').load(location.href+' #count-area');
			
				console.log("찜 삭제 완료");
		}
	}

		//신고 팝업 여는 부분
		$(function(){
			$("#btn_open2").click(function(){ //레이어 팝업 열기 버튼 클릭 시
				$('#reportpopup').bPopup();
			});
			$("#btn_close2").click(function(){ //닫기
				$('#reportpopup').bPopup().close();  
			});			
		});
		
		
		
		
		//삭제 팝업 여는 부분
		$(function(){
			$("#btn_open").click(function(){ //레이어 팝업 열기 버튼 클릭 시
				$('#delpopup').bPopup();
			});
			$("#btn_close").click(function(){ //닫기
				$('#delpopup').bPopup().close();  
			});			
		});
		
	
	function addNeighbor(form) {
		
		//작성자, 내용 유효성 검사
		if (uidx != null ) {
				// AJAX -> addNeighbor 실행 및 출력값 가져오기
				$.post('./addNeighbor',{
					neighbor_idx : ${vo.uidx},
				}, function(data) {
					uidx = data["uidx"];
				},'json');
				$('#Neighbor_area').load(location.href+' #Neighbor_area');
		}
	}

	function delNeighbor() {
		if (uidx != null ) {
			$.ajax({
				url : 'delNeighbor',
				data : 'neighbor_idx=${vo.uidx}',
				success : function(data){
					console.log("완");
					$('#Neighbor_area').load(location.href+' #Neighbor_area');
				}
			});
		}
	}
/* 	function updatestate() {
		$.ajax({
			url : 'updatestate',
			data : state= $("#state").val(),
				   item_idx = ${vo.item_idx}
			success : function(data){
				console.log("거래상태 변경 완료");
			}
		});
	} */
	function updatestate(){
		
		if($('.state').val() == 1){
			var result = confirm("거래 상태를 거래중 으로 변경하시겠습니까?");
			if(result == true){
				$.post('updatestate',{
					state : $('.state').val(),
					item_idx : ${vo.item_idx},
				},
				'json');
					console.log("거래중으로 변경 완료");
					//$('#state').load(location.href+' #state');
			    alert("거래중 처리가 완료되었습니다.");
			    
			}else if(result == false){
				$(".state").val(${vo.state});
				//$('#state').load(location.href+' #state');
			    alert("처리를 취소하였습니다.");
			}
		}
		
		
		if($('.state').val() == 2){
			var result = confirm("거래 상태를 예약중으로 변경하시겠습니까?");
			if(result == true){
				$.post('updatestate',{
					state : $('.state').val(),
					item_idx : ${vo.item_idx},
				},
				'json');
					console.log("예약중으로 변경 완료");
					//$('#state').load(location.href+' #state');
			    alert("예약중 처리가 완료되었습니다.");
			    
			}else if(result == false){
				$(".state").val(${vo.state});
				//$('#state').load(location.href+' #state');
			    alert("처리를 취소하였습니다.");
			}
		}
		
		
		if($('.state').val() == 3){
			var result = confirm("거래 상태를 거래완료로 변경하면 더 이상 상대방과의 채팅이나 글 수정이 불가능합니다. 변경하시겠습니까?");
			if(result){
			
				$.post('updatestate',{
					state : $('.state').val(),
					item_idx : ${vo.item_idx},
				},
				'json');
					
					//글 작성자에게 거래완료 채팅을 보냄
					/* $.post('AddMessage',{
						chat_host : 1,
						item_idx : ${vo.item_idx},
						invited : ${vo.uidx},
						contents : "거래완료 처리가 되었습니다. ",
						uidx : 1,
					},
					'json'); */
					
					//구매 완료한 사람에게 거래완료 채팅을 보냄
					 
				
				
					console.log("거래상태 변경 완료");
					$('#state').load(location.href+' #state');
			    alert("거래완료 처리가 완료되었습니다.");
			    
			    $("#state").attr("disabled", true);
			    $("#state").attr("value", "거래완료");
			}else{
				$('#state').load(location.href+' #state');
				$(".state").val(${vo.state});
			    alert("처리를 취소하였습니다.");
			}
		}
		
	}
	
	
	/* 끌올 처리 */
function updatewdate(){
	let Days = ${Days};
			if(Days > 31){
				$.post('updatewdate',{
					item_idx : item_idx,
				},
				'json');
					console.log("끌올 완료");
			    alert("끌올 처리가 완료되었습니다.");
				}else{
				
				alert("글 작성일로부터 한 달이 지나야 끌올이 가능합니다!")
			}
	}
	
function itemdelete(){
				$.post('itemdelete',{
					item_idx : item_idx,
				},
				'json');
					console.log("삭제 완료");
			    alert("게시물 삭제가 완료되었습니다.");
			}
	
	
	
</script>


<!-- include libraries(jQuery, bootstrap) -->
<!-- include libraries(jQuery, bootstrap) -->
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- include summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${ path }/css/bootstrap.css" rel="stylesheet"
	type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet"
	type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet"
	type="text/css" />
<link href="${ path }/css/mfb.css" rel="stylesheet">
<link rel="stylesheet"
	href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- path는 request.getContextPath()를 가져온것. -->
<!-- 지도 API - 필요없으면 지워도 됨 -->
<!-- <script type='text/javascript'
	src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script> -->
<!-- <script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script> -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


<!-- 지도 API -->

</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="wrapper main" id="main" style="overflow-y: auto; overflow-x: hidden;">
			<div class="container">
				<div class="row">
					<!-- 신고하기 팝업 영역  -->
					<div id="reportpopup" class="Pstyle2">
						<!-- form 은 기본 전송방식이 post 임!! 잊지말것  -->
						<form method="POST" action="report.do" enctype="multipart/form-data" name="frm" id="joinFrm">
							<div class="row  tr">
								<input type="hidden" name="item_idx" value="${vo.item_idx}">
								<input type="hidden" name="repoter"
									value="${userLoginInfo.uidx}"> <input type="hidden"
									name="target" value="${vo.uidx}">
								<div class="col-4 th" style="display: table-cell;">신고유형</div>
								<div class="col-8 td" style="display: table-cell;">
									<select name="report_type">
										<option value="0">노쇼</option>
										<option value="1">비속어&비매너채팅</option>
										<option value="2">게시물 규칙 위반</option>
										<option value="3">허위매물</option>
										<option value="4">기타</option>
									</select>
								</div>
							</div>
							<div class="row  tr">
								<div class="col-4 th" style="display: table-cell;">내용</div>
								<div class="col-8 td" style="display: table-cell;">
									<textarea name="contents"></textarea>
								</div>
							</div>

							<div class="row  tr">
								<div class="col-4 th" style="display: table-cell;">첨부 파일</div>
								<div class="col-8 td" style="display: table-cell;">
									<div id="fileDiv">
										<input type="file" id="file" name="file1"
											accept='image/jpeg,image/gif,image/png'
											onchange='chk_file_type(this)'>
									</div>
									<br /> <br /> <a href="#this" class="btn" id="addFile">파일
										추가</a>
								</div>
							</div>

							<div class="text-end tr">
								<div class="td">
								
									<button class="btn" style="background: #00AAB2; color: #fff;">신고하기</button>
									<button class="btn" style="background: #00AAB2; color: #fff;"
										type="button" id="btn_close2">취소</button>
								</div>
							</div>
						</form>
						</div>

						<!-- 삭제 팝업 영역  -->
				 <div id="delpopup" class="Pstyle" style="width:25%;">	
		 				<div class="col-4 th" style="display: table-cell;">정말 게시글을 삭제하시겠습니까?</div>
								<button class="btn" style="background: #00AAB2; color: #fff; width:50%;" onclick="<c:if test="${vo.state == 3 }">alert('거래완료 처리된 글은 ')</c:if> <c:if test="${vo.state != 3 }">itemdelete(); location.href='itemlist.do'</c:if>">삭제하기</button>
								<button class="btn" style="background: #00AAB2; color: #fff; width:50%;" type="button" id="btn_close">취소</button>
				</div>

						<div class="container">
							<div class="row">
								<div class="col-sm-12">
									<%-- <div class="card">

									<div class="card-body">

										<c:if test="${vo.cate_idx == 1}">
											상품카테고리 > 가전제품 
										</c:if>
										<c:if test="${vo.cate_idx == 2}">
										상품카테고리 > 생활용품
										</c:if>
										<c:if test="${vo.cate_idx == 3}">
										상품카테고리 > 완구&취미
										</c:if>
										<c:if test="${vo.cate_idx == 4}">
										상품카테고리 > 패션&의류
										</c:if>
										<c:if test="${vo.cate_idx == 5}">
										상품카테고리 > 인테리어
										</c:if>
										<c:if test="${vo.cate_idx == 6}">
										상품카테고리 > 반려동물용품
										</c:if>
										<c:if test="${vo.cate_idx == 7}">
										상품카테고리 > 뷰티&악세
										</c:if>
										<c:if test="${vo.cate_idx == 8}">
										상품카테고리 > 자동차용품
										</c:if>
										<c:if test="${vo.cate_idx == 9}">
										상품카테고리 > 스포츠&레저
										</c:if>

										<div style="">
											
											조회수 : ${viewCount} 
											<div id="count-area">
												찜 :${wishCount}
											</div>
											</div>
										
									</div>
								</div> --%>
									<div class="border-bottom" style="display: flex; text-align:center;">
										<span style="padding: 10px; font-size: 3rem; font-weight: bold;">${vo.title}</span>
									</div>



									<div class="container">
										<div class="row">
											<div class="col-sm-6">
												<div class="slider-1" style="float: left;">

													<div class="slides">
														<c:if test="${vo.image1 != null}">
															<div class="active" style="width: 100%;">
																<img src="../resources/upload${vo.image1}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
														<c:if test="${vo.image2 != null}">
															<div style="width: 100%;">
																<img src="../resources/upload/${vo.image2}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
														<c:if test="${vo.image3 != null}">
															<div style="width: 100%;">
																<img src="../resources/upload/${vo.image3}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div >
														</c:if>
														<c:if test="${vo.image4 != null}">
															<div style="width: 100%;"> 
																<img src="../resources/upload/${vo.image4}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
														<c:if test="${vo.image5 != null}">
															<div style="width: 100%;">
																<img src="../resources/upload/${vo.image5}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
														<c:if test="${vo.image6 != null}">
															<div style="width: 100%;">
																<img src="../resources/upload/${vo.image6}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
														<c:if test="${vo.image7 != null}">
															<div style="width: 100%;">
																<img src="../resources/upload/${vo.image7}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
														<c:if test="${vo.image8 != null}">
															<div style="width: 100%;">
																<img src="../resources/upload/${vo.image8}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
														<c:if test="${vo.image9 != null}">
															<div style="width: 100%;">
																<img src="../resources/upload/${vo.image9}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
														<c:if test="${vo.image10 != null}">
															<div style="width: 100%;">
																<img src="../resources/upload/${vo.image10}"
																	onerror=this.src="../images/no_imgborder.jpg">
															</div>
														</c:if>
													</div>
													<c:if test="${vo.image2 !=null }">
														<div class="page-btns">
															<c:if test="${vo.image1 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image2 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image3 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image4 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image5 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image6 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image7 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image8 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image9 != null}">
																<div></div>
															</c:if>
															<c:if test="${vo.image10 != null}">
																<div></div>
															</c:if>
														</div>
													</c:if>
													<c:if test="${vo.image2 != null }">
														<div class="side-btns">
															<div>
																<span><img src="../images/arrow-left.png"
																	style="width: 20px; height: 20px;"></span>
															</div>
															<div>
																<span><img src="../images/arrow-right.png"
																	style="width: 20px; height: 20px;"></span>
															</div>
														</div>
													</c:if>
												</div>
											</div>

											<div class="col-sm-6">
												<div id="viewcontent">
												<!-- 모바일 터치 슬라이드 -->
												<script>
												$('.carousel').carousel({
													  interval: false,
													});
												</script>
												
													<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel"  data-interval="false">
													  <div class="carousel-indicators">
													    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
													    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
													    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
													  </div>
													  <div class="carousel-inner">
													  
														    <div class="carousel-item  active"  data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image1}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100">
														    </div>
														    
													    <c:if test="${vo.image2 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image2}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100" >
														    </div>
														</c:if>
													    <c:if test="${vo.image3 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image3}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100" >
														    </div>
														</c:if>
													    <c:if test="${vo.image4 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image4}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100" >
														    </div>
														</c:if>
													    <c:if test="${vo.image5 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image5}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100" >
														    </div>
														</c:if>
													    <c:if test="${vo.image6 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image6}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100" >
														    </div>
														</c:if>
													    <c:if test="${vo.image7 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image7}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100" >
														    </div>
														</c:if>
													    <c:if test="${vo.image8 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image8}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100" >
														    </div>
														</c:if>
													    <c:if test="${vo.image9 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image9}" onerror=this.src="../images/no_imgborder.jpg" class="d-block w-100" >
														    </div>
														</c:if>
													    <c:if test="${vo.image10 != null }">
														    <div class="carousel-item" data-bs-interval="50000000 ">
														      <img src="../resources/upload/${vo.image10}" onerror=this.src="../images/no_imgborder.jpg"  class="d-block w-100" >
														    </div>
														</c:if>
													  </div>
													  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
													    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
													    <span class="visually-hidden">Previous</span>
													  </button>
													  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
													    <span class="carousel-control-next-icon" aria-hidden="true"></span>
													    <span class="visually-hidden">Next</span>
													  </button>
													</div>
														
														
														
														
														
														
														
														
														
														
														
														<div class="row tr">
															<div class="col-5 th"
																style="display: table-cell; background-color: white; border: 0; font-size: 20px;">판매가격</div>
															<input type="hidden" value="${vo.uidx}"> <input
																type="hidden" id="vo.item_idx" value="${vo.item_idx}">
															<input type="hidden" name="neighbor_idx"
																value="${vo.uidx}">

															<div class="col-8 td" style="display: table-cell;">
																<span style="color:#00AAB2;"><fmt:formatNumber value="${ vo.price }" pattern="#,###"/></span>원
																</div>
																
														</div>

														<div class="row tr" style="border: 0;">
															<div class="col-5 th"
																style="display: table-cell; background-color: white; border: 0; font-size: 20px;">판매자</div>
															<div class="col-8 td" style="display: table-cell;">
																${vo.nickName}</div>
														</div>


														<div class="row tr" style="border: 0;">
															<!-- <th style="width: 100px; > -->

															<div class="col-5 th"
																style="display: table-cell; background-color: white; border: 0; font-size: 20px;">가격제안</div>
															<div class="col-8 td" style="display: table-cell;">
																<c:if test="${vo.offer ==0 }">
																	<p style="margin: auto;">불가능</p>
																</c:if>
																<c:if test="${vo.offer ==1 }">
																	<p style="margin: auto;">가능</p>
																</c:if>
															</div>

														</div>
														<div class="row  tr" style="border: 0;">
															<div class="col-5 th"
																style="display: table-cell; background-color: white; border: 0; font-size: 20px;">거래지역</div>
															<div class="col-8 td" style="display: table-cell;">
																<div class="addr_zone" aria-label="Default select example"></div>
													    		<script>
														    		let locationList2 = [${ vo.addr_code }];
														    		let html2 = '';
														    		$.ajax({
																		url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
																		data : "consumer_key=7b9a8af3d576479db243&consumer_secret=02e72ab8a0e046f9bf95",
																		success : function(data){
																			$(".spinner-border").css("display","none");
																			for(let i = 0; i < locationList2.length; i++){
																				$.ajax({
																					url : "https://sgisapi.kostat.go.kr/OpenAPI3/boundary/hadmarea.geojson",
																					async : false,
																					data : "accessToken="+data.result.accessToken+"&year=2021&adm_cd="+locationList2[i]+"&low_search=0",
																						success : function(geojson){
																						let locationLevel = geojson.features[0].properties.adm_nm.split(" ");
																						//dong.push(locationLevel[locationLevel.length-1]);
																						//console.log(dong);
																						$(".addr_zone").append('<span>'+locationLevel[locationLevel.length-1]+',</span>');
																					}
																				});
																			}
																		},
																		error: function(){
																			console.log("error");
																		}
																	});
													    		</script>
															</div>
														</div>

														<div class="row tr" style="border: 0;">
															<div class="col-5 th"
																style="display: table-cell; background-color: white; border: 0; font-size: 20px;">키워드</div>
															<div class="col-8 td" style="display: table-cell;">
																${vo.keyword}</div>
														</div>


															<!-- 		<div class="col-4 th" style="display:table-cell;"></div> -->
											<div id="btn-area-web" style="display: flex; width: 100%; padding: 0px; flex-direction: row; justify-content: center;">
													<c:if test="${userLoginInfo.uidx != null and vo.uidx != userLoginInfo.uidx}">
															<div class="row tr" style="border: 0;">
																	
																			<input type="button"  onclick="<c:if test="${vo.state!=3 }">location.href='<%=request.getContextPath()%>/user/chatView.do?item_idx=${vo.item_idx}&chat_host=${vo.uidx}&invited=${userLoginInfo.uidx}'</c:if> <c:if test="${vo.state ==3 }">alert('이미 거래가 완료된 글입니다');</c:if>" value="연락하기" class="btn" style="background-color:#00aab2;padding: 0px;" >
																		<input type="submit" id="btn_open2" style="background-color:#d92929; padding: 0px;"class="btn btn" value="신고하기" class="btn">
																	<!-- 이웃 영역 시작 -->
																		<div id="Neighbor_area-web" style="width:100%;     padding: 0px;">
																			<c:if test="${result == 0 }">
																				<input type="button"style="background-color:#fab915;  padding: 0px;"onclick="addNeighbor(); return false;"class="btn" value="이웃추가">
																			</c:if>

																			<c:if test="${result != 0}">
																				<input type="button" style="background-color:#fab915;  padding: 0px;"value="이웃삭제"onclick="delNeighbor(); return false;"class="btn">
																			</c:if>

																			<c:if test="${wish == 0}">
																				<input type="button" class="btn" style="background-color:#BBCD53;  padding: 0px;" value="찜 추가"onclick="addWish(); return false;">
																			</c:if>

																			<c:if test="${wish != 0}">
																				<input type="button" class="btn" style="background-color:#BBCD53;  padding: 0px;" value="찜 삭제"onclick="delWish(); return false;">
																			</c:if>
																		</div>
															</div>
													</c:if>
													<c:if test="${userLoginInfo.uidx == vo.uidx}">
														<div class="row  tr" style="border: 0;">
																<button onclick="updatewdate()" class="btn"  style="background-color:#BBCD53; padding: 0px;">끌올</button>
																	
																<select name="state"  class="state btn" onchange="updatestate();" id="state" style="background-color:#00aab2;">
																	<c:if test="${vo.state == 1 }">
																		<option selected disabled hidden>거래중</option>
																	</c:if>
																	<c:if test="${vo.state == 2 }">
																		<option selected disabled hidden>예약중</option>
																	</c:if>
																	<c:if test="${vo.state == 3 }">
																		<option  selected disabled hidden>거래완료</option>
																	</c:if>
																	
																	<option value="1">거래중</option>
																	<option value="2">예약중</option>
																</select>
																	
															<button onclick="<c:if test="${vo.state ==3 }">alert('거래완료 처리된 글은 수정이 불가능합니다');</c:if> <c:if test="${vo.state != 3 }">location.href='itemmodify.do?item_idx=${vo.item_idx}'</c:if>" style="background-color:#fab915;" class="btn "id="btn-modi" >수정</button>
															<button id="btn_open" class="btn"  style="background-color:#d92929;" >삭제</button>
														</div>
													</c:if>
																
															
											</div>
													
												</div>  <!-- viewcontent 끝 -->
													
											</div>
										</div>
										
										<div class="col-sm-12 col-lg-12" style="min-height:250px; max-heigth:550px;">  <!--내용 하단 -->
											
												<div class="row border-top tr" style="border: 0; height:100%;">
												<div class="col-5 th"
													style="display: table-cell; background-color: white; border: 0; font-size: 20px;">내용</div>
												<div class="col-8 td" style="display: table-cell;">
													${vo.contents}</div>
											</div>
										</div>
										
										
									<div id="btn-area" style="display: flex; width: 100%; padding: 0px; flex-direction: row; justify-content: center;">
													<c:if test="${userLoginInfo.uidx != null and vo.uidx != userLoginInfo.uidx}">
															<div class="row tr" style="border: 0;">
																	
																			<input type="button"  onclick="<c:if test="${vo.state!=3 }">location.href='<%=request.getContextPath()%>/user/chatView.do?item_idx=${vo.item_idx}&chat_host=${vo.uidx}&invited=${userLoginInfo.uidx}'</c:if> <c:if test="${vo.state ==3 }">alert('이미 거래가 완료된 글입니다');</c:if>" value="연락하기" class="btn" style="background-color:#00aab2;padding: 0px;" >
																		<input type="submit" id="btn_open2" style="background-color:#d92929; padding: 0px;"class="btn btn" value="신고하기" class="btn">
																	<!-- 이웃 영역 시작 -->
																		<div id="Neighbor_area" style="width:100%;     padding: 0px;">
																			<c:if test="${result == 0 }">
																				<input type="button"style="background-color:#fab915;  padding: 0px;"onclick="addNeighbor(); return false;"class="btn" value="이웃추가">
																			</c:if>

																			<c:if test="${result != 0}">
																				<input type="button" style="background-color:#fab915;  padding: 0px;"value="이웃삭제"onclick="delNeighbor(); return false;"class="btn">
																			</c:if>
																			
																			<c:if test="${wish == 0}">
																				<input type="button" class="btn" style="background-color:#BBCD53;  padding: 0px;" value="찜 추가"onclick="addWish(); return false;">
																			</c:if>
																			<c:if test="${wish != 0}">
																				<input type="button" class="btn" style="background-color:#BBCD53;  padding: 0px;" value="찜 삭제"onclick="delWish(); return false;">
																			</c:if>
																		</div>
																		<input type="text" value="${wish}">asd
															</div>
													</c:if>
																	<c:if test="${userLoginInfo.uidx == vo.uidx}">
																	<div class="row  tr" style="border: 0;">
																			<button onclick="updatewdate()" class="btn"  style="background-color:#BBCD53; padding: 0px;">끌올</button>
																				
																			<select name="state"  class="state btn" onchange="updatestate();" id="state" style="background-color:#00aab2;">
																				<c:if test="${vo.state == 1 }">
																					<option selected disabled hidden>거래중</option>
																				</c:if>
																				<c:if test="${vo.state == 2 }">
																					<option selected disabled hidden>예약중</option>
																				</c:if>
																				<c:if test="${vo.state == 3 }">
																					<option  selected disabled hidden>거래완료</option>
																				</c:if>
																				
																				<option value="1">거래중</option>
																				<option value="2">예약중</option>
																			</select>
																				
																		<button onclick="<c:if test="${vo.state ==3 }">alert('거래완료 처리된 글은 수정이 불가능합니다');</c:if> <c:if test="${vo.state != 3 }">location.href='itemmodify.do?item_idx=${vo.item_idx}'</c:if>" style="background-color:#fab915;" class="btn "id="btn-modi" >수정</button>
																		<button id="btn_open" class="btn"  style="background-color:#d92929;" >삭제</button>
																	</div>
																	</c:if>
																
															
											</div>
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										<!-- 판매자의 다른 상품 -->
										<div style="border-bottom:solid 2px;">
											<h2 style="text-align: center;">
												<a href="../user/myPage.do?uidx=${vo.uidx}">${vo.nickName}</a>님의 다른상품
											</h2>
										</div>
										<div class="container-fluid">
											<div class="row">
														<c:if test="${youritem.size() > 0}">
															<c:forEach var="vo" items="${youritem}">
								
														<div class="col-lg-3  col-md-12 " style="margin-bottom: 10px;">
															<div class="card">
																<a href="itemview.do?item_idx=${vo.item_idx}"><img
																	src="../resources/upload/${vo.image1}"
																	style="width: 100%;" onerror=this.src="../images/noimg_item.jpg" ></a>
																<div class="card-body"
																	style="text-align: center; padding-top: 5px;">
																	<h7 class="card-title"
																		style="color:#E52421; font-weight :  bold; font-size:14px;">
																	<c:if test="${vo.state==1}">
																		<h7 class="product-price">거래중</h7>
																	</c:if> <c:if test="${vo.state==2}">
																		<h7 class="product-price">예약중</h7>
																	</c:if> <c:if test="${vo.state==3}">
																		<h7 class="product-price">거래완료</h7>
																	</c:if> </h7>
																	<h6 class="card-title" id="itemtitle">
																		<a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a>
																	</h6>
																	<p class="card-text" id="itemtitle"
																		style="color: #00AAB2; font-size: 17px">${vo.price}<span
																			style="color: #000;">원</span>
																	</p>
																	${vo.hit} 조회수
																	<!-- div id를 바꿔서 본 글에 찜 추가 눌렀을때 안 나오게 해둠 -->
																	<div id="Wish_area2">
																		<c:if test="${vo.wishCheck == 0 }">
																			<div class="image">
																				<img src="../images/Wish_off.png"
																					style="width: 16px; height: 16px;"> <span>${vo.wishCount}</span>
																			</div>
																		</c:if>
																		<c:if test="${vo.wishCheck != 0}">
																			<div class="image">
																				<img src="../images/Wish_on.png"
																					style="width: 16px; height: 16px;"> <span
																					style="background-color: ce3746;">${vo.wishCount}</span>
																			</div>
																		</c:if>
																	</div>
																</div>
															</div>
														</div>
													</c:forEach>
												</c:if>
												<c:if test="${youritem.size() <= 0}">
													<div style="text-align: center; border-top: solid 1px;">
														<h3 style="text-align: center;">${vo.nickName}님의다른
															상품이 없습니다</h3>
													</div>
												</c:if>

											</div>
										</div>

									</div>
							</div>
						</div>
					</div>
				</div>

			</div>


			<!--팝업 영역 끝 -->
			<script
				src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
			<script
				src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.js"></script>
			<script src="../js/boarditem2.js"></script>
</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->
	</div>
</body>
</html>