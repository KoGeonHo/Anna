<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${path}/css/bootstrap.css" rel="stylesheet" />

<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script> 
<script>

$(function(){
	$("#dd").click(function(){ //레이어 팝업 열기 버튼 클릭 시
		$('#popup2').bPopup();
	});
	
	$("#btn_close").click(function(){ //닫기
		$('#popup2').bPopup().close();  
	});			

});

$(function(){
	$("#btn_open").click(function(){ //레이어 팝업 열기 버튼 클릭 시
		$('#popup').bPopup();
	});
	
	$("#btn_close").click(function(){ //닫기
		$('#popup').bPopup().close();  
	});			

});


function Chat__loadNewMessages() {
	$.get('./mychatlist',{
	chat_host : ${userLoginInfo.uidx}
	}, function(data) {
		for ( let i = 0; i < data.length; i++ ) {
			var mychatlist = data[i];
			Chat__drawMessages(mychatlist);
		}
		//setTimeout(Chat__loadNewMessages,1000);
	}, 'json');

}
function Chat__drawMessages(mychatlist) {
	var html = mychatlist.nickName+' 님과의 거래';
		$('.mychatlist').append('<div id="dd"> <a class="dd">'+ html + '</a></div>');
}
$(function() {
	Chat__loadNewMessages();
	
});
//스크롤 시 이벤트 처리




//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
let currentPage = 1;
//현재 페이지가 로딩중인지 여부를 저장할 변수
let isLoding=false;

//웹브라우저의 창을 스크롤할 때마다  호출되는 함수 등록
$(window).on("scroll",function(){

	
	//위로 스크롤된 길이
	let scrollTop = $(window).scrollTop();
	//웹브라우저 창의 높이
	let windowHeight = $(window).height();
	//문서 전체의 높이
	let documentHeight = $(document).height();
	//바닥까지 스크롤 되었는지 여부를 알아낸다.
	let isBottom = scrollTop + windowHeight + 10 >= documentHeight;
	
	if(isBottom){
		console.log(isLoding);
		//만일 현재 마지막 페이지라면
		if(currentPage == ${totalPageCount} || isLoding){
			console.log(currentPage);
			return; // 함수를 여기서 끝낸다.
		}
		//현재 로딩 중이라고 표시한다.
		isLoding= true;
		//console.log("탔습니다.");
		//로딩바를 띄우고
		$(".back-drop").show();
		//요청할 페이지 번호를 1증가시킨다.
		currentPage++;
		//추가로 받아올 페이지를 서버에 ajax 요청을 하고
		//console.log("inscroll" + currentPage);
		GetList(currentPage); 
	
	}

});

//카드 리스트를 가져오는 함수

const GetList = function(currentPage){

	//console.log("inGetList" + currentPage);
	
	//무한스크롤
	$.ajax({
	
		url : "ajax_item.do",
		method : "GET",
		//검색 기능이 있는 경우 seachType과 seachVal를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른 것들이 덧붙여져 나온다.
		data : "pagenumber="+currentPage+"&SearchType=${searchType}&SearchVal=${searchVal}",
		//FreeBoard.jsp의 내용이 data로 들어온다. 
		success:function(data){
			console.log(data);
			//응답된 문자열은 html형식이다. 
			//해당 문자열은 .card-list-container div에 html로 해석하라고 추가한다.
			$(".card-list-container").append(data);
			//로딩바를 숨긴다.
			$(".back-drop").hide();
			//로딩중이 아니라고 표시한다.
			isLoding=false;
			//console.log("ajax"); 
		}	
	});
}
</script>
<style>

.col-lg-3 .card img {

width:100%;
height:250px;

}




ul{
	list-style:none;
}
li{
	float:left;
	margin-right:20px;
}

@media ( max-width: 400px ) {

.container.row.col-lg-12.card.card-body{
	width:100%;


}


.col-lg-3 .card img {

width:293px;
height:250px;
}



}
</style>


<meta charset="utf-8">
<title>Insert title here</title>
<style>
.Pstyle {
	 opacity: 0;
	 display: none;
	 position: relative;
	 width: auto;
	 border: 5px solid #fff;
	 padding: 20px;
	 background-color: #fff;
	}    		
.Pstyle2{
	 opacity: 0;
	 display: none;
	 position: relative;
	 width: auto;
	 border: 5px solid #fff;
	 padding: 20px;
	 background-color: #fff;
	 z-index : 9999;
	}    		
#container{
	height:5000px;
}
#log{
	position:fixed;
	top:0;
	left:0;
 	right:0;
	margin:0;
	height:200px;	
	background-color:rgba(0,0,0,0.7);	
	text-align:center;
	line-height:50px;
}
#container span{
	color:white;
}
#b{
	display:none;
}

.box {float:left; overflow: hidden; background: #f0e68c;}
.box-inner {width: 800px; padding: 10px;}
</style>
</head>
<body>
<c:if test="${uidx == null}">
<a href="../user/login.do">로그인하기</a>
</c:if>

<c:if test="${uidx != null}">
<a href="../user/logout.do">로그아웃</a>
</c:if>
<a href="itemwrite.do">중고거래글 작성하기</a>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">AnnA</a>
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">중고거래</a></li>
					<li class="nav-item"><a class="nav-link" href="#">커뮤니티</a></li>
					<li class="nav-item"><a class="nav-link" href="#">고객센터</a></li>
					<li class="nav-item"><a class="nav-link" href="#">마이페이지</a></li>
				</ul>
				<form class="d-flex">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>
<br>
<hr>
<br>

<div style="width:100px; background-color:grey;"class="slide-toggle">
	카테고리
</div>
	<div style=" height:70px;">
	
	<div class="box">
	    <div class="box-inner">
	    	<ul>
				<li><a href="itemlist.do" class="cate_menu">전체</a></li>
				<li><a href="itemlist.do?cate_idx=1" class="cate_gory">가전</a></li>
				<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
				<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
				<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
				<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
				<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
			</ul>
	    </div>
	</div>
</div>		
			
	<form method="get" action="itemlist.do">
		<select name="searchType">
			<option value="title" <c:if test="${!empty svo.searchType and svo.searchType eq 'title'}">selected</c:if>>제목</option>
		</select>
		<input type="text" name="searchVal" 
				<c:if test="${!empty svo.searchVal}">
				value=${svo.searchVal}
				</c:if>>
		<input type="submit" value="검색">
	</form>
		<div>
			<c:if test="${!empty pm.searchVal}">	
			<h1>${userLoginInfo.nickName} 님이 검색하신 ${pm.searchVal} 의 최저가 상품입니다</h1>
				<div class="col-lg-3">
					<div class="card">
					<a href="itemview.do?item_idx=${ssang.item_idx}"><img src="../resources/upload/${ssang.image1}" ></a>
						<div class="card-body">
						<input type="hidden" value=">${ssang.uidx}">
							<h5 class="card-title"><a href="itemview.do?item_idx=${ssang.item_idx}">${ssang.title}</a></h5>
							<p class="card-text">${ssang.price}원</p>
							<p class="card-text">${ssang.nickName}</p>
							<p class="card-text">${ssang.wdate}</p>
						</div>
					</div>
						<br>
				</div>

			</c:if>
		</div>
<br>
<hr>
<br>

			<div id="popup2" class="Pstyle2">	
					<div class="mychatlist2" id="chat" >
					adsasd 이게 나라냐 ㅋㅋ
					</div>
					
					<input type="button" id="btn_close" value="닫 기">
			</div>
			
			
			<div id="popup" class="Pstyle">	
					<div class="mychatlist" id="chat" >
					</div>
					
					<input type="button" id="btn_close" value="닫 기">
			</div>
				<div class="wrap2">
					<input type="button" id="btn_open" value="채팅리스트">
				</div>
<hr>

	<div class="container">
		<div class="row">
		<c:if test="${list.size() > 0}">
		<c:forEach var="vo" items="${list}">
		
			<div class="col-lg-3">
				<div class="card">
				<a href="itemview.do?item_idx=${vo.item_idx}"><img src="../resources/upload/${vo.image1}" ></a>

					<div class="card-body">
					<input type="hidden" value=">${vo.uidx}">
						<h5 class="card-title"><a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h5>
						<p class="card-text">${vo.price}원</p>
						<p class="card-text">${vo.nickName}</p>
						<p class="card-text">${vo.wdate}</p>
					</div>
				</div>
					<br>
			</div>
					</c:forEach>
		</c:if>
		</div>
	</div>
	
	
<section id="card-list" class="card-list">
	<div class="container">
		<div class="row card-list-container thumbnails"></div>
	</div>
</section>




<section id="card-list" class="card-list"><!-- 무한스크롤부분 -->
	<div class="container">
		<div class="row card-list-container thumbnails">
		
		</div>
	</div>
</section>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.js"></script>
<script src ="../js/boardlist.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</body>
</html>