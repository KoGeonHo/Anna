<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
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
@-ms-viewport{width : device-width;}
@-o-viewport{width: device-width;}
@viewport {width: device-width;}
</style>
<title>item view 페이지</title>

<style>
.chat-list{
height:300px;
overflow-y:auto;



}
.outer {
  border: 6px solid royalblue;
  width: 500px;
  height: 500px;
  margin: 0 auto;
  overflow-x: hidden;
  display:none;
}

.inner-list {
  display: flex;
  height: 100%;
  transition: .3s ease-out;
  display:none;
}

.inner {
} 



.row .col-lg-2 .card img{
width:100%;
height:150px;
}


.slider{
    width: 700px;
    height: 480px;
    position: relative;
    margin: 0 auto;
    overflow: hidden; /* 현재 슬라이드 오른쪽에 위치한 나머지 슬라이드 들이 보이지 않도록 가림 */
}
.slider input[type=radio]{
}

ul.imgs{
    padding: 0;
    margin: 0;
    list-style: none;    
}
ul.imgs li{
    position: absolute;
    left: 700px;
    transition-delay: 1s; /* 새 슬라이드가 이동해 오는 동안 이전 슬라이드 이미지가 배경이 보이도록 지연 */

    padding: 0;
    margin: 0;
}

.bullets{
    position: absolute; 
    left: 50%;
    transform: translateX(-50%);
    bottom: 20px;
    z-index: 2;
}
.bullets label{
    display: inline-block;
    border-radius: 50%;
    background-color: rgba(0,0,0,0.55);
    width: 20px;
    height: 20px;
    cursor: pointer;
}

.card-body img{
	float:center;
	width:500px;

	height:450px;
}

@media ( max-width: 400px ) {

.row{

}
	img{

	width:100%;

	height:250px;
	}

	
.slider{
    width: 300x;
    height: 250px;
    position: relative;
    margin: 0 auto;
    overflow: hidden; /* 현재 슬라이드 오른쪽에 위치한 나머지 슬라이드 들이 보이지 않도록 가림 */
	display : none;
}

.bullets label{
    display: inline-block;
    border-radius: 50%;
    background-color: rgba(0,0,0,0.55);
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

.outer {
  border: 3px solid royalblue;
  width: 100%;
  height: 250px;
  margin: 0 auto;
  overflow-x: hidden;
  display:block
}

.inner-list {
  display: flex;
  width:100%;
  height: 250px;
  transition: .3s ease-out;
}

.inner {
  padding: 0;
}



.slider-1 {
	width:500px;
    height:480px;
    position:relative;
    display : none;
}

/* 슬라이더 1 - 페이지 버튼 */
.slider-1 > .page-btns {
    text-align:center;
    position:absolute;
    bottom:20px;
    left:0;
    width:100%;
    display : none;
}

.slider-1 > .page-btns > div {
    width:20px;
    height:20px;
    /* background-color:rgba(255,255,255,.5); */
    background-color:white;
    border-radius:4px;
    display:inline-block;
    cursor:pointer;
    display : none;
}

.slider-1 > .page-btns > div.active {
    /* background-color:rgba(255,255,255,1); */
    background-color:gray;
    display : none;
}

/* 슬라이더 1 - 슬라이드 */

.slider-1 > .slides > div {
  position:absolute; 
    width:500px;
    height:350px;
    top:0;
    left:0;
    right:0;
    bottom:0;
    opacity:0;
    transition: opacity 0.3s;
    background-position:center;
 	background-size:cover;
    background-repeat:no-repeat;
    display : none;
}

.slider-1 > .slides > div.active {
    opacity:1;
    display : none;
}

.slider-1 > .slides > div.active img {
	width:100%;
}

/* 슬라이더 좌우 버튼 */
.slider-1 > .side-btns > div {
   /*  position:absolute; */
    top:0;
    left:0;
    width:25%;
    height:100%;
    cursor:pointer;
    display : none;
}
.slider-1 > .side-btns > div:last-child {
    left:auto;
    right:0;
    display : none;
}
.slider-1 >.side-btns > div > span {
    position:absolute;
    top:50%;
    left:20px;
    transform:translatey(-50%);
    background-color:white;
    opacity:0.5;
    padding:1px 13px;
    border-radius:50px;
    font-size:25px;
    display : none;
}
.slider-1 >.side-btns > div:last-child > span {
    left:auto;
    right:20px;
    display : none;
}


.container{
width:100%;
hieght:50px;
}


}


@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

html {
    font-family: "Noto Sans KR", sans-serif;
}

/* 노말라이즈 */
body, ul, li, h1, h2, h3, h4, h5 {
    margin:0;
    padding:0;
    list-style:none;
}

a {
    color:inherit;
    text-decoration:none;
}

/* 커스텀 */

/* 슬라이더 1 시작 */
.slider-1 {
	width:500px;
    height:480px;
    position:relative;
}

/* 슬라이더 1 - 페이지 버튼 */
.slider-1 > .page-btns {
    text-align:center;
    position:absolute;
    bottom:20px;
    left:0;
    width:100%;
}

.slider-1 > .page-btns > div {
    width:20px;
    height:20px;
    /* background-color:rgba(255,255,255,.5); */
    background-color:gray;
    border-radius:4px;
    display:inline-block;
    cursor:pointer;
}

.slider-1 > .page-btns > div.active {
    /* background-color:rgba(255,255,255,1); */
    background-color:grey;
}

/* 슬라이더 1 - 슬라이드 */

.slider-1 > .slides > div {
  position:absolute; 
    width:500px;
    height:500px;
    top:0;
    left:0;
    right:0;
    bottom:0;
    opacity:0;
    transition: opacity 0.3s;
    background-position:center;
    background-size:cover;
    background-repeat:no-repeat;
     display : block;
}

.slider-1 > .slides > div.active {
    opacity:1;
     display : block;
}

/* 슬라이더 좌우 버튼 */
.slider-1 > .side-btns > div {
   /*  position:absolute; */
    top:0;
    left:0;
    width:25%;
    height:100%;
    cursor:pointer;
}
.slider-1 > .side-btns > div:last-child {
    left:auto;
    right:0;
}
.slider-1 >.side-btns > div > span {
    position:absolute;
    top:50%;
    left:20px;
    transform:translatey(-50%);
    background-color:gray;
    opacity:0.5;
    padding:1px 13px;
    border-radius:50px;
    font-size:25px;
}
.slider-1 >.side-btns > div:last-child > span {
    left:auto;
    right:20px;
}

/* 슬라이더 1 끝 */
 	body{margin:0;padding:0;max-height:800px}	
	.wrap	{position:absolute;top:50%;left:50%;width:200px;height:100px;margin-top:-50px;margin-left:-100px;}
	
	table {width:100%;border-collapse:collapse; border:0; empty-cells:show; border-spacing:0; padding:0;}
	table th {height:24px; padding:4px 10px; border:1px solid #DDD; font-weight:bold; text-align:left; background:#ecf5fc;}
	table td {height:22px; padding:5px 10px; border:1px solid #DDD;}
	#btn_close{float:right}

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
	
	#Wish_area{
	width:50px;
	height: 50px;
	}
	
	#Wish_area .image { 
	width: 50px;
	height : 50px;
	position:relative;text-align:center;color:#FFFFFF; 
	}
	#Wish_area .image p { position: absolute;top:50%;left:50%;
			transform: translate(-50%, -50%);/*  background-color:#FFFFFF; */
			text-shadow: -1px 0 1px black, 0 1px 1px black, 1px 0 1px black, 0 -1px 1px black; 
			margin : auto;}
	
	
	
		
</style>
	
<script>
	//찜 부분
	function addWish(){
		$.post('addWish',{
			item_idx : ${vo.item_idx},
			uidx : ${userLoginInfo.uidx},
		},'json');
		$('#Wish_area').load(location.href+' #Wish_area');
		//location.reload();
			console.log("찜 완료");
	}
	function delWish(){
		$.post('delWish',{
			item_idx : ${vo.item_idx},
			uidx : ${userLoginInfo.uidx},
		},'json');
		$('#Wish_area').load(location.href+' #Wish_area');
		//location.reload();
			console.log("찜 삭제 완료");
	}

	

		//신고 팝업 여는 부분
		$(function(){
			$("#btn_open2").click(function(){ //레이어 팝업 열기 버튼 클릭 시
				$('#popup2').bPopup();
			});
			$("#btn_close2").click(function(){ //닫기
				$('#popup2').bPopup().close();  
			});			
		});
		
		
		
		//신고 글 작성하는 부분
	/* 	
		formdate = 
		function delNeighbor() {
		$.ajax({
			url : 'delNeighbor',
			data : 'neighbor_idx=${vo.uidx}',
			success : function(data){
				console.log("완");
				$('#Neighbor_area').load(location.href+' #Neighbor_area');
			}
		}); */
		/* function report(form){
		$.post('report',{
			item_idx : ${vo.item_idx},
			bidx : ${vo.item_idx},
			repoter : ${userLoginInfo.uidx},
			evidence : 1,
			target : ${vo.uidx},
			contents : form.contents.value,
			file1 : form.fiel1.value,
		
		},'json');
		//location.reload();
		$('#popup2').bPopup().close();  
		alert("신고완료");
			console.log("신고 완료");
	} */
		
		
		//채팅 리스트 여는 부분
		$(function(){
			$("#btn_open").click(function(){ //레이어 팝업 열기 버튼 클릭 시
				$('#popup').bPopup();
			});
			$("#btn_close").click(function(){ //닫기
				$('#popup').bPopup().close();  
			});			
		});
		
		//채팅부분
	let invited=0;
	function sendMessage(form) {
		//작성자, 내용 유효성 검사
		
		form.contents.value = form.contents.value.trim();
		if (form.contents.value.length == 0) {
			alert('내용 입력하세요');
			form.contents.focus();
			return false;
		}
		
		// AJAX -> doAddMessage 실행 및 출력값 가져오기
		$.post('./AddMessage',{
			nickName : form.nickName.value,
			contents : form.contents.value,
			item_idx : form.item_idx.value,
			chat_host :form.chat_host.value,
			uidx : form.uidx.value, 
			invited : form.invited.value,
		},  
		function(data) {
			uidx = data["uidx"];
		},'json'); 
		form.contents.value = '';
		form.contents.focus();
		return false;
	}
	
	
	var Chat__lastReceivedchatlistcidx = -1;
	
	
	function Chat__loadNewMessages() {
		$.get('./getMessages',{
			item_idx : ${vo.item_idx},
			chat_host : $("#chat_host").val(),
			uidx : ${userLoginInfo.uidx},
			from : Chat__lastReceivedchatlistcidx + 1 
		}, function(data) {
			
			for ( let i = 0; i < data.length; i++ ) {
				var chatlist = data[i];
				Chat__lastReceivedchatlistcidx = chatlist.cidx;
				Chat__drawMessages(chatlist);
				//$("#chat").scrollTop($("#chat")[0].scrollHeight);
				
			}
			//setTimeout($("#chat").scrollTop($("#chat")[0].scrollHeight),1000);
			

		}, 'json');

	}
	function Chat__drawMessages(chatlist) {
		var html = '[' +chatlist.cidx + '] (' + chatlist.nickName + ') : ' + chatlist.contents;
		
		if(chatlist.uidx == ${uidx}){
			$('.chat-list').append('<div style="text-align:right;">'+ html + '</div>');
		}else if(chatlist.uidx != ${uidx}){
			$('.chat-list').append('<div style="text-align:left;">' + html + '</div>');
			}
	}
	$(function() {
		Chat__loadNewMessages();
		
	});
	
	
	
	
	
	function addNeighbor(form) {
		//작성자, 내용 유효성 검사
		if (${userLoginInfo.uidx} == null) {
			alert('회원만 이웃추가 기능을 사용할 수 있습니다');
			return false;
		}
		// AJAX -> addNeighbor 실행 및 출력값 가져오기
		$.post('./addNeighbor',{
			neighbor_idx : ${vo.uidx},
			uidx : ${userLoginInfo.uidx},
			item_idx : ${vo.item_idx},
		}, function(data) {
			uidx = data["uidx"];
		},'json');
		$('#Neighbor_area').load(location.href+' #Neighbor_area');
	}
	

	function delNeighbor() {
		$.ajax({
			url : 'delNeighbor',
			data : 'neighbor_idx=${vo.uidx}',
			success : function(data){
				console.log("완");
				$('#Neighbor_area').load(location.href+' #Neighbor_area');
			}
		});
		// AJAX -> delNeighbor 실행 및 출력값 가져오기
		/* $.post('./delNeighbor',{
			neighbor_idx : ${vo.uidx},
		}, function(data) {
			uidx = data["uidx"];
		},'json'); */
		
	}
	

</script>
		
	
<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<!-- path는 request.getContextPath()를 가져온것. -->
		
</head>
<body>
<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		
		<div class="wrapper">
			<div class="container main">
	
	

	
		

<form  method="post" enctype="multipart/form-data" name="frm">

	<div class="container">
	<div class="row">
			<div class="col-lg-12 col-sm-12">

				<div class="card">
				
					<div class="card-body">
						
							<c:if test="${vo.cate_idx == 1}">
						상품카테고리 > 가전 
							</c:if>
							<c:if test="${vo.cate_idx == 2}">
						상품카테고리 > 주방
							</c:if>
							
							<div style="right;">
								<a href="itemmodify.do?item_idx=${vo.item_idx}">수정</a>
								<a href="itemdelete.do?item_idx=${vo.item_idx}">삭제</a>
								조회수 : ${viewCount}
							</div>
				<hr>
				


						<div class="slider-1" >

						    <div class="slides">
						    	<c:if test="${vo.image1 != null}">
						        <div class="active"><img src="../resources/upload${vo.image1}" onclick="window.open(this.src)"></div>
						        </c:if>
						        <c:if test="${vo.image2 != null}">
						        <div ><img src="../resources/upload/${vo.image2}" onclick="window.open(this.src)"></div>
						         </c:if>
						        <c:if test="${vo.image3 != null}">
						        <div ><img src="../resources/upload/${vo.image3}"></div>
						         </c:if>
						        <c:if test="${vo.image4 != null}">
						        <div ><img src="../resources/upload/${vo.image4}"></div>
						         </c:if>
						        <c:if test="${vo.image5 != null}">
						        <div ><img src="../resources/upload/${vo.image5}"></div>
						         </c:if>
						        <c:if test="${vo.image6 != null}">
						        <div ><img src="../resources/upload/${vo.image6}"></div>
						         </c:if>
						        <c:if test="${vo.image7 != null}">
						        <div ><img src="../resources/upload/${vo.image7}"></div>
						         </c:if>
						        <c:if test="${vo.image8 != null}">
						        <div ><img src="../resources/upload/${vo.image8}"></div>
						         </c:if>
						        <c:if test="${vo.image9 != null}">
						        <div ><img src="../resources/upload/${vo.image9}"></div>
						         </c:if>
						        <c:if test="${vo.image10 != null}">
						        <div ><img src="../resources/upload/${vo.image10}"></div>
						        </c:if>
						    </div>
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
						    <div class="side-btns">
						        <div>
						            <span><i class="fas fa-angle-left"></i></span>
						        </div>
						        <div>
						            <span><i class="fas fa-angle-right"></i></span>
						        </div>
						    </div>
						</div>
										
				
				
				

					<div class="outer" >

					  <div class="inner-list">
					    <div class="inner">
					      <img src="../resources/upload${vo.image1}">
					    </div>
					    <c:if test="${vo.image2 != null }">
						    <div class="inner">
						      <img src="../resources/upload/${vo.image2}">
						    </div>
						</c:if> 
					    <c:if test="${vo.image3 != null }">
						    <div class="inner">
						      <img src="../resources/upload/${vo.image3}">
						    </div>
					    </c:if>
					    <c:if test="${vo.image4 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image4}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image5 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image5}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image6 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image6}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image7 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image7}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image8 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image8}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image9 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image9}">
					    </div>
						   </c:if>
					    <c:if test="${vo.image10 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image10}">
					    </div>
					    </c:if>
					  </div>
					  </div>
				

				    
					</div>
					
				
						<h5 class="card-title">${vo.title}</h5>
							<input type="hidden" value="${vo.uidx}"> 
							<input type="hidden"  id="vo.item_idx"value="${vo.item_idx}">
							<input type="hidden" name="neighbor_idx" value="${vo.uidx}">


								<p class="card-text">판매자 : ${vo.nickName}</p>
								<p class="card-text">내용 : ${vo.contents}</p>
								<p class="card-text">판매가격 : ${vo.price}</p>
								<p class="card-text">거래지역 : ${vo.addr2}</p>
								<p class="card-text">키워드 : ${vo.keyword}</p>
					
						</div><!-- card body 끝 -->
					</div>
				</div>
				</div>
</form>
							<h2>${vo.nickName}님	의 다른상품</h2>
				<a href="../user/myPage.do?uidx=${vo.uidx}">더 보기</a>
			<div class="container-fluid">
				<div class="row">
					<c:if test="${youritem.size() > 0}">
						<c:forEach var="vo" items="${youritem}">
							<div class="col-lg-2 col-md-4" >
								<div class="card">
								<img src="../resources/upload/${vo.image1}" >
										<div class="card-body">
											<input type="text" value="${vo.uidx}">
											<h5 class="card-title"><a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h5>
											<p class="card-text">${vo.price}원</p>
											<p class="card-text">${vo.nickName}</p>
											<p class="card-text">${vo.wdate}</p> 
										<c:if test="${userLoginInfo.udix == vo.uidx}">
											<select name="state">
												<option value="1">거래중</option>
												<option value="2">거래완료</option>
												<option value="3">예약중</option>
											</select>
										</c:if>
										</div>
								</div>
								<br>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			
			<!-- 신고하기 팝업 영역  -->
			<div id="popup2" class="Pstyle2">	
				<!-- form 은 기본 전송방식이 post 임!! 잊지말것  -->
				<form action="report.do" enctype="multipart/form-data" method="POST">
					<select name="report_type">
						<option value="0">노쇼</option>		
						<option value="1">비속어&비매너채팅</option>
						<option value="2">게시물 규칙 위반</option>
						<option value="3">허위매물</option>	
						<option value="4">기타</option>
					</select>
					<textarea name="contents"></textarea>
					<input type="hidden" name="item_idx" value="${vo.item_idx}">
					<input type="hidden" name="repoter" value="${userLoginInfo.uidx}">
					<input type="hidden" name="target" value="${vo.uidx}">
					<input type="file" name="file1">
					<input type="submit" value="신고하기">
				</form>
			</div>
			<c:if test="${uidx != null }">
				<div class="wrap2">
					<input type="submit" id="btn_open2" value="신고하기">
				</div>
			</c:if>
			
			
			
			
			<!-- 채팅 팝업 영역  -->
			<div id="popup" class="Pstyle">	
				<form onsubmit="sendMessage(this); return false;" id="frm">
					<input type="text" name="item_idx" value="${vo.item_idx}"><br>
					글주인번호<input type="text" id="chat_host"name="chat_host" value="${vo.uidx}"><br>
					<c:if test="${userLoginInfo.uidx == vo.uidx}">
					<input type="text" name="invited" value="${chatlist.uidx}">
					</c:if>
					<c:if test="${userLoginInfo.uidx != vo.uidx}">
					<input type="text" name="invited" value="${userLoginInfo.uidx}">
					</c:if>
					<input type="text" name="uidx" value="${userLoginInfo.uidx}">
					<input type="text" name="nickName" value="${userLoginInfo.nickName}"readonly="readonly">
					<input type="text" name="contents" placeholder="내용" >
					<input type="submit" value="전송">
				</form>
					<div class="chat-list" id="chat" ></div>
					<input type="button" id="btn_close" value="닫 기">
			</div>
			<c:if test="${uidx != null }">
				<div class="wrap2">
					<input type="button" id="btn_open" value="연락하기">
				</div>
			</c:if>
			
			<!-- 이웃 영역 시작 -->
			<c:if test="${uidx != null }">
				<div id="Neighbor_area">
				<c:if test="${result == 0 }">
				<button onclick="addNeighbor(); return false;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-plus-fill" viewBox="0 0 16 16">
						  <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
						  <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
						</svg> 이웃추가</button>
				</c:if>
				
				<c:if test="${result != 0}">
				<button onclick="delNeighbor(); return false;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-x-fill" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6.146-2.854a.5.5 0 0 1 .708 0L14 6.293l1.146-1.147a.5.5 0 0 1 .708.708L14.707 7l1.147 1.146a.5.5 0 0 1-.708.708L14 7.707l-1.146 1.147a.5.5 0 0 1-.708-.708L13.293 7l-1.147-1.146a.5.5 0 0 1 0-.708z"/>
					</svg> 이웃삭제</button>
				</c:if>
				</div>
			</c:if>

			<c:if test="${uidx != null }">
				<div id="Wish_area">
					<c:if test="${wish == 0}">
							<div class="image">
								<img src="../images/Wish_off.png" style="width:50px; height:50px;" onclick="addWish(); return false;" >
								<p>${wishCount}</p>
							</div>
					</c:if>
		
					<c:if test="${wish != 0}">
						<div class="image">
							<img src="../images/Wish_on.png" style="width:50px; height:50px;" onclick="delWish(); return false;" >
							<p style="background-color:ce3746;">${wishCount}</p>
						</div>
					</c:if>
				</div>
			</c:if>
	<!--팝업 영역 끝 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.js"></script>
	<script src ="../js/boarditem.js"></script>
	<script src ="../js/boarditem2.js"></script>
	
	
	</div>
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>