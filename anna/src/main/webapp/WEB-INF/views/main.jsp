<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	
	<title>안녕? 나야!</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
	<meta charset="UTF-8">
	
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>


<script>
//스크롤 시 이벤트 처리
console.log("hi");
//위로 스크롤된 길이


//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
let currentPage = 1;
//현재 페이지가 로딩중인지 여부를 저장할 변수
let isLoding=false;
$(function(){
	$("#mainWrapper").on("scroll",function(){
		var scrollTop = $(this).scrollTop();
        var innerHeight = $(this).innerHeight();
        var scrollHeight = $(this).prop('scrollHeight');
       // console.log(scrollTop + innerHeight);
        //console.log("scrollHeight:"+scrollHeight);
		 if((scrollTop + innerHeight) >= scrollHeight){
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
			//console.log(data);
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


		    

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->

<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/mfb.css" rel="stylesheet">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 

		
<!--   Slick Slider -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>	
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!--   Slick Slider -->
	
	
<!-- path는 request.getContextPath()를 가져온것. -->	


	
<style>

/*
반응형 기준 기록
	아주작은(xs)  576px 미만	  스마트폰 세로
	작은(sm) 	  576px 이상	  스마트폰 가로
	중간(md)	  768px 이상	  타블렛
	큰(lg)   	  992px 이상	  데스크탑
	아주큰(xl)	  1200px 이상	  큰 데스크탑
*/
.body {
	padding-top: -56px;
	
	
}
a {
  color: #000;
  text-decoration: none;
}
	
}

.row {
	padding: 0px;
	margin: 0px;
}

.container {
	justify-content: center;
	align-items: center;
}

.card {
	margin-left: 3px;
}



@media ( min-width : 576px) {
	.col-md-2 {
		width: 30%;
	}
}

@media ( min-width : 1200px) {
	.col-md-2 {
		width: 16.66666667%;
	}
}



.offcanvas-collapse {
	top: 150px;
}



.logo {
	padding-left: 2.5rem;
}

@media all and (max-width:  767px){
	
	#myCarousel, #search, #bestitem, #boardlist, #productname  {
		display:none;
	}
	
	#itemlist {
		margin-top: -106px;
	}
	
}

@media all and (min-width :768px){


  
</style>





</head>

<body>

<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->

	<div class="wrapper" id="mainWrapper">
			<div class="main"  id="main">

	<!-- 슬라이드 -->

		<div id="myCarousel" class="carousel slide " data-bs-ride="carousel">
			<div class="carousel-indicators ">
				<button type="button" data-bs-target="#myCarousel"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#myCarousel"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#myCarousel"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="images/slide_2.png" width="100%">

					<div class="container">
						<div class="carousel-caption text-start"></div>
					</div>
				</div>
				<div class="carousel-item">
					<img src="images/slide_1.png" width="100%">

					<div class="container">
						<div class="carousel-caption"></div>
					</div>
				</div>
				<div class="carousel-item">
					<img src="images/slide.png" width="100%">

					<div class="container">
						<div class="carousel-caption text-end"></div>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#myCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#myCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<br> <br>

	<!-- 슬라이드 -->


	<!-- 검색 -->
	<div id="search">
	<div class="container">
			<div class="row">
				<div class="col-md-1 col-sm-0"></div>
				<div class="col-md-10  col-sm-12">

					<form class="d-flex ">
						<input class="form-control me-6 vh-20" type="search"
							placeholder="검색어를 입력하세요" aria-label="Search">
						<button class="btn btn-outline-primary" type="submit">Search</button>
					</form>

				</div>
				<div class="col-md-1 col-sm-0"></div>
			</div>
		
	</div>
	</div>
	<!-- 검색 -->



	<!-- 인기상품 start -->
	<div id = "bestitem">
	<main>
		<div class="album py-5 ">
				<div class="container">

					<div class="container ">  
						<div class="row ">
							<div class="col-md-2">
								<h4>｜인기 상품</h4>
							</div>
							<div class="col-md-8"></div>
							<div class="col-md-2 ">
								<h6 style="text-align: right;">더보기</h6>
							</div>
							<hr>
						</div>
					</div>
				</div>
		</div>

	</main>
	

 	<!--   Slick Slider -->
 	<div class="container ">
			<div class="row">
	<!-- stlye 은 slick 영역 확인용 -->
	<div style="padding:30px 100px; background-color: #fff; margin-top:-75px;" >
	  	<div id="slider-div"  >


			

			<c:if test="${list.size() > 0}">
							<c:forEach var="vo" items="${list}">


								<div class="col-lg-3  col-md-12 ">

									<div class="card">
										<a href="boarditem/itemview.do?item_idx=${vo.item_idx}"> <img
											src="<%=request.getContextPath()%>/resources/upload/${vo.image1}"
											onerror=this.src="images/noimg_item.jpg" width="100%"
											height="255">
										</a>

										<div class="card-body">
											<h6 class="card-title">
												<a href="boarditem/itemview.do?item_idx=${vo.item_idx}">${vo.title}</a>
											</h6>
											<p class="card-text">${vo.price}원</p>
											<button type="button"
												class="btn btn-sm btn-outline-secondary"
												style="float: right">view 5</button>
											<button type="button"
												class="btn btn-sm btn-outline-secondary"
												style="float: right">♥2</button>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
			
			
				
	  	</div>
	</div>
	</div>
	
	
	<script>
  		$(function(){
			$('#slider-div').slick({
				slide: 'div',		//슬라이드 되어야 할 태그 ex) div, li 
				infinite : true, 	//무한 반복 옵션	 
				slidesToShow : 4,		// 한 화면에 보여질 컨텐츠 개수
				slidesToScroll : 1,		//스크롤 한번에 움직일 컨텐츠 개수
				speed : 100,	 // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
				arrows : true, 		// 옆으로 이동하는 화살표 표시 여부
				autoplay : true,			// 자동 스크롤 사용 여부
				autoplaySpeed : 5000, 		// 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
				pauseOnHover : true,		// 슬라이드 이동	시 마우스 호버하면 슬라이더 멈추게 설정
				vertical : false,		// 세로 방향 슬라이드 옵션
				prevArrow : "<img src='images/slicbtn_prev.png'  id ='slidebtn' class='slick-prev'></button>",		// 이전 화살표 모양 설정
				nextArrow : "<img src='images/slicbtn_next.png' id ='slidebtn' class='slick-next'></button>",		// 다음 화살표 모양 설정
				draggable : true, 	//드래그 가능 여부 
				
				responsive: [ // 반응형 웹 구현 옵션
					{  
						breakpoint: 960, //화면 사이즈 960px
						settings: {
							//위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
							slidesToShow:3 
						} 
					},
					{ 
						breakpoint: 768, //화면 사이즈 768px
						settings: {	
							//위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
							slidesToShow:2 
						} 
					}
				]

			});
  		})  		
	</script>
	
	
	<style>
	
#slidebtn {
width: 50px;
  color: white;
  font-size: 35px;
 	line-height: 50px;

}
	
	.slick-prev {
   
    position: absolute;
    z-index: 100;
    top: 42%;
    left: -80px;
    border : 0;

}

	.slick-next {
   
    position: absolute;
    z-index: 100;
    top: 42%;
    right: -80px;
    border : 0;

}


</style>
	</div>
 	 <!--   Slick Slider -->

<!-- 인기상품 end -->


	<!-- 게시글 -->
	<main>
		<div class="album py-5" id="boardlist">
			<div class="container">

					<div class="container ">
						<div class="row">
							<div class="col-md-2">
								<h4>｜일상 & 소통</h4>
							</div>
							<div class="col-md-8"></div>
							<div class="col-md-2">
								<h6 style="text-align: right;">
									<a href="board/FreeBoard.do">더보기</a>
								</h6>
							</div>
						</div>
					</div>
					<hr>


					<form>
						<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">




							<c:if test="${freeboard.size() ==0}">

								<h3>등록된 게시물이 없습니다.</h3>
							</c:if>

							<c:if test="${freeboard.size()>0 }">
								<c:forEach var="vo" items="${freeboard}">
									<c:if test="${vo.board_type eq 'free' }">

										<div class="col">
											<div class="card shadow-sm">
												<a href="board/viewBoard.do?Bidx=${vo.bidx}"> <img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}"	 onerror=this.src="images/noimg_item.jpg" width="100%"  height="225">
												</a>
												<div class="card-body">
													<h6 class="card-title">
														<a href="board/viewBoard.do?Bidx=${vo.bidx}">${vo.title}</a>
													</h6>
													<p class="card-text"></p>
													<button type="button"
														class="btn btn-sm btn-outline-secondary"
														style="float: right">view 5</button>
													<button type="button"
														class="btn btn-sm btn-outline-secondary"
														style="float: right">♥2</button>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</c:if>

						</div>
					</form>				
			</div>
		</div>
		</div>
		<br>

	</main>
	<!-- 게시글 -->



	<!-- 상품 -->
	<div id="itemlist">
	<main>
		<div class="album py-5 ">
			<div class="container">
				<div class="d-md-none d-lg-block d-xl-block">
					<div class="container ">
						<div class="row">
							<div class="col-md-2">
								<h4 id="productname">｜중고거래</h4>
							</div>
							<div class="col-md-8"></div>
							<div class="col-md-2">
								<h6 id="productname" style="text-align: right;">
									<a href="boarditem/itemlist.do">더보기</a>
								</h6>
							</div>
						</div>
					</div>
					<hr id="productname">

					<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3" >

						<c:if test="${list.size() > 0}">
							<c:forEach var="vo" items="${list}">


								<div class="col-lg-3  col-md-12 ">

									<div class="card">
										<a href="boarditem/itemview.do?item_idx=${vo.item_idx}"> <img
											src="<%=request.getContextPath()%>/resources/upload/${vo.image1}"
											onerror=this.src="images/noimg_item.jpg" width="100%"
											height="255">
										</a>

										<div class="card-body">
											<h6 class="card-title">
												<a href="boarditem/itemview.do?item_idx=${vo.item_idx}">${vo.title}</a>
											</h6>
											<p class="card-text">${vo.price}원</p>
											<button type="button"
												class="btn btn-sm btn-outline-secondary"
												style="float: right">view 5</button>
											<button type="button"
												class="btn btn-sm btn-outline-secondary"
												style="float: right">♥2</button>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>

					<div id="card-list" class="card-list">
						<!-- 무한스크롤부분 -->
						<div class="container">
							<div class="row card-list-container thumbnails"></div>
						</div>
					</div>




				</div>
			</div>
		</div>
	</main>
</div>



</div>
</div>
</div>

<!-- 퀵메뉴 시작 -->
			<%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>			
		<!-- 퀵메뉴 종료 -->
		


		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		


	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
 <script src="https://getbootstrap.kr/docs/5.1/examples/offcanvas-navbar/offcanvas.js"></script>
</body>
</html>
