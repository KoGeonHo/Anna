<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>


<meta charset="utf-8">
<title>중고물품 리스트</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script> 
<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${path}/css/bootstrap.css" rel="stylesheet" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/mfb.css" rel="stylesheet">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 

<script>
	
	$(function(){
		$("#btn_open").click(function(){ //레이어 팝업 열기 버튼 클릭 시
		console.log("채팅창 목록 열림")
			$('#popup').bPopup();
		});
		$("#btn_close").click(function(){ //닫기
			$('#popup').bPopup().close();  
		});			
	
	});



	function Chat__List() {
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
			$('.mychatlist').append(' <div>  <a class="chat">'+ html + '</a></div>');
	}
	$(function() {
		Chat__List();
		
	});
	
	$(function(){
		$(".chat").click(function(){
			console.log("asd");
			$('#popup').bPopup();
		});
	});

	//스크롤 시 이벤트 처리
	console.log("hi");
	//위로 스크롤된 길이


	//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
	let currentPage = 1;
	//현재 페이지가 로딩중인지 여부를 저장할 변수
	let isLoding=false;
	$(function(){
	   $(".main").on("scroll",function(){
		   console.log("ㅇㅇ");
	      	var scrollTop = $(this).scrollTop();
	        var innerHeight = $(this).innerHeight();
	        var scrollHeight = $(this).prop('scrollHeight');
	        //console.log(scrollTop + innerHeight);
	        //console.log("scrollHeight:"+scrollHeight);
	       if((scrollTop + innerHeight)+1 >= scrollHeight){
	          console.log(isLoding);
	            //만일 현재 마지막 페이지라면
	            if(currentPage == ${totalPageCount} || isLoding){
	               
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
	            GetList(currentPage)
	      }
	   });
	});
	/* 
	//웹브라우저의 창을 스크롤할 때마다  호출되는 함수 등록
	$(window).on("scroll",function(){
	   
	   let scrollTop = $(window).scrollTop();
	   console.log(scrollTop+"난 스크롤");
	   //웹브라우저 창의 높이
	   let windowHeight = $(window).height();
	   console.log(windowHeight+"난 윈도우");
	   //문서 전체의 높이
	   let documentHeight = $(document).height();
	   console.log(documentHeight+"난 문서");
	   

	   //바닥까지 스크롤 되었는지 여부를 알아낸다.
	   let isBottom = scrollTop + windowHeight >= documentHeight;
	   
	   if(isBottom){
	      console.log(isLoding);
	      //만일 현재 마지막 페이지라면
	      if(currentPage == ${totalPageCount} || isLoding){
	         
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
	}); */

	//카드 리스트를 가져오는 함수

	const GetList = function(currentPage){
	   //console.log("inGetList" + currentPage);
	   
	   //무한스크롤
	   $.ajax({
	   
	      url : "ajax_main.do",
	      method : "GET",
	      //검색 기능이 있는 경우 seachType과 seachVal를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른 것들이 덧붙여져 나온다.
	      data : "pagenumber="+currentPage+"&SearchType=${searchType}&SearchVal=${searchVal}",
	      //FreeBoard.jsp의 내용이 data로 들어온다. 
	      success:function(data){
	         //console.log(data.appendList);
	         let appendList = data.appendList;
	         let html = "";
	         
	         for(let i = 0; i < appendList.length; i++){
	            //console.log(appendList[i].uidx);
	            html +='<div class="col-lg-3  col-md-12 ">';
	            html +='   <div class="card">';
	            html +='<a href="boarditem/itemview.do?item_idx='+appendList[i].item_idx+'${vo.item_idx}">';
	            html +='<img src="<%=request.getContextPath()%>/resources/upload/'+appendList[i].image1+'"';
	            html +='onerror=this.src="../images/no_imgborder.jpg" width="100%" height="255">';
	            html +='</a>';
	            html +='<div class="card-body">';
	            html +='<h6 class="card-title">';
	            html +='<a href="boarditem/itemview.do?item_idx='+appendList[i].item_idx+'">'+appendList[i].title+'</a>';
	            html +='</h6>';
	            html +='<p class="card-text">'+appendList[i].price+'원</p>';
	            html +='<button type="button"';
	            html +='class="btn btn-sm btn-outline-secondary"';
	            html +='   style="float: right">view 5</button>';
	            html +='   <button type="button"';
	            html +='   class="btn btn-sm btn-outline-secondary"';
	            html +='   style="float: right">♥2</button>';
	            html +='</div>';
	            html +='</div>';
	            html +='   </div>';
	         }
	         
	         //console.log(html);
	         //응답된 문자열은 html형식이다. 
	         //해당 문자열은 .card-list-container div에 html로 해석하라고 추가한다.
	         $(".card-list-container").append(html);
	         //로딩바를 숨긴다.
	         //$(".back-drop").hide();
	         //로딩중이 아니라고 표시한다.
	         isLoding=false;
	         //console.log("ajax"); 
	      }   
	   });
	}





/* 
function delWish(){
	$.post('delWish',{
		item_idx : $("#wish_item_idx").val(),
		uidx : ${userLoginInfo.uidx},
	},'json');
	$('#wish-list').load(location.href+' #wish-list');
	//location.reload();
		console.log("찜 삭제 완료");
}

function delNeighbor(form) {
	
	// AJAX -> delNeighbor 실행 및 출력값 가져오기
	$.post('./delNeighbor',{
		neighbor_idx : ${vo.neighbor_idx},
		uidx : ${userLoginInfo.uidx},
	}, function(data) {
		uidx = data["uidx"];
	},'json');
	$('#Neighbor_area').load(location.href+' #Neighbor_area');
}
 */
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


/* 반응형 */
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
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="main" id="main" style="overflow: auto;">
			<input type="hidden" name="uidx" value="${userLoginInfo.uidx}">
			
			내 블랙리스트 (임시)
			<c:if test="${not empty blackList}">
					<c:forEach var="vo" items="${blackList}">
						${vo.nickName} , ${vo.black_idx} ||
					</c:forEach>
			</c:if>
			<br>
			내 찜리스트(임시)
			<div id="wish-list">
				<c:if test= "${mywish.size() > 0}">
					<c:forEach var="vo" items="${mywish}">
						<div class="col-lg-3">
							<div class="card">
								<span onclick="delWish(); return false;">찜 삭제</span>
								<input type="hidden" id="wish_item_idx" value="${vo.item_idx}">					
								<a href="itemview.do?item_idx=${vo.item_idx}"><img src="../resources/upload/${vo.image1}" ></a>
								<div class="card-body">
								<input type="hidden" value=">${vo.uidx}">
									<h5 class="card-title"><a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h5>
								</div>
							</div>
								<br>
						</div>
					</c:forEach>
				</c:if>
			</div>

			내 이웃리스트(임시)
			<div>
				<c:if test= "${myneighbor.size() > 0}">
					<c:forEach var="vo" items="${myneighbor}">
						<div class="col-lg-3">
							<div class="card">
								<span onclick="delNeighbor(); return false;">이웃 삭제</span>
								<div class="card-body">
								<input type="hidden" value=">${vo.uidx}">
								닉네임 : ${vo.nickName}
								</div>
							</div>
								<br>
						</div>
					</c:forEach>
				</c:if>
			
			</div>					
			
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

			<!-- 카테고리  -->
			<div>
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
			</div>		
			
			
				
		<form method="get" action="itemlist.do">
			<select name="searchType">
				<option value="title" <c:if test="${!empty svo.searchType and svo.searchType eq 'title'}">selected</c:if>>제목</option>
				<option value="nickName" <c:if test="${!empty svo.searchType and svo.searchType eq 'nickName'}">selected</c:if>>작성자</option>
				<option value="keyword" <c:if test="${!empty svo.searchType and svo.searchType eq 'keyword'}">selected</c:if>>태그</option>
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
			<!-- 채팅 리스트 -->
			<div id="popup" class="Pstyle">	
					<div class="mychatlist"  >
					</div>
					세션 uidx = ${userLoginInfo.uidx}"
					
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
				<a href="itemview.do?item_idx=${vo.item_idx}"><img src="../resources/upload/${vo.image1}" onerror=this.src="../images/no_imgborder.jpg" ></a>

					<div class="card-body">
					<input type="hidden" value=">${vo.uidx}">
						<h5 class="card-title"><a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h5> <c:if test="${vo.state ==1 }">
						거래중
						</c:if>
						<c:if test="${vo.state ==2 }">
						거래완료
						</c:if>
						<c:if test="${vo.state ==3 }">
						예약중
						</c:if>
						
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
	
	<!-- 무한스크롤부분 -->
<section id="card-list" class="card-list">
	<div class="container">
		<div class="row card-list-container thumbnails">
		
		</div>
	</div>
</section>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.js"></script>
<script src ="../js/boardlist.js"></script>
<script src="https://cdn.jsivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
		
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
