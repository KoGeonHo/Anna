<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>

	<meta charset="UTF-8">
	<title>Home</title>
	

    <script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
	<script src="js/bootstrap.js"></script>
	<link href="css/offcanvas.css" rel="stylesheet" type="text/css" />
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
 	<link href="${path}/css/bootstrap.css" rel="stylesheet"/> 
 	
<!--   Slick Slider -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>	
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!--   Slick Slider -->
	
	<script>
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
	
		url : "ajax_main.do",
		method : "GET",	
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

.bottom_menu {
	position: fixed;
	bottom: 0px;
	left: 0px;
	width: 100%;
	height: 130px;
	z-index: 100;
	border-top: 1px solid black;
	background-color: white
}

.bottom_menu>div {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
	padding-top: 20px;
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

.navbar {
	height: 150;
}

.offcanvas-collapse {
	top: 150px;
}

.navbar-toggler-icon {
	width: 4.5em;
	height: 5.5em;
}

.navbar-brand {
	margin-left: 2rem;
}

.navbar-dark .navbar-toggler-icon {
	margin: 0 1rem;
}

.logo {
	padding-left: 2.5rem;
}
</style>



</head>

<body>

	<!-- pc 헤더 -->
	<div class="b-example-divider ">
		<div class="container ">
			<div class="d-md-none d-lg-block d-xl-block">

				<header
					class="d-flex  align-items-center justify-content-center justify-content-sm-between py-3 mb-1 ">
					<a href="/"
						class="d-flex align-items-center col-md-3 mb-1 col-sm-3 mb-md-0 text-dark text-decoration-none ">
						<div class="logo">
							<img src="images/logo.png" width="70%">
						</div>
					</a>

					<ul
						class="nav col-12 col-md-auto  col-sm-0 mb-1 justify-content-center mb-md-0">
						<li><a href="${path}/boarditem/itemlist.do" class="nav-link px-3 link-dark ">중고거래</a></li>
						<li><a href="${path}/board/FreeBoard.do" class="nav-link px-3 link-dark">커뮤니티</a></li>
						<li><a href="${path}/customer/QnAList.do" class="nav-link px-3 link-dark ">고객센터</a></li>
						<li><a href="${path}/user/myPage.do" class="nav-link px-3 link-dark">마이페이지</a></li>
					</ul>

					<div class="col-md-3 text-end">
						<c:if test="${uidx == null }">

							<button type="button" class="btn"
								style="background-color: #00AAB2; color: #fff;"
								onclick="javascript:location.href='<%=request.getContextPath()%>/user/login.do';">로그인</button>
							<button type="button" class="btn"
								style="background-color: #BBCE53; color: #fff;"
								onclick="javascript:location.href='<%=request.getContextPath()%>/user/join.do';">회원가입</button>
						</c:if>
						<c:if test="${uidx != null }">
							<button type="button" class="btn "
								style="background-color: #00AAB2; color: #fff;"
								onclick="javascript:location.href='<%=request.getContextPath()%>/user/logout.do';">로그아웃</button>
							
						</c:if>
					</div>
				</header>
			</div>
		</div>
	</div>

	<!-- pc헤더 -->


	<!-- 모바일 헤더-->

	<div class="d-lg-none">

		<nav class="navbar navbar-expand-lg fixed-top navbar-dark "
			style="background-color: #00AAB2;" aria-label="Main navigation">

			<div class="container-fluid">
				<a class="navbar-brand fs-1 fw-bold" href="#">금암동 ▼</a>


				<button class="navbar-toggler p-0 border-0" type="button"
					id="navbarSideCollapse" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="navbar-collapse offcanvas-collapse"
					id="navbarsExampleDefault">
					<br>
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link  fs-1 fw-bold"
							aria-current="page" href="#">메뉴</a></li>
						<li class="nav-item"><a class="nav-link  fs-1 fw-bold"
							href="#">추천</a></li>
						<li class="nav-item"><a class="nav-link  fs-1 fw-bold"
							href="#">받습</a></li>
						<li class="nav-item"><a class="nav-link  fs-1 fw-bold"
							href="#">니다</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<!-- 모바일 헤더-->


	<!-- 슬라이드 -->
	<div class="d-md-none d-lg-block d-xl-block">
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
	</div>
	<!-- 슬라이드 -->


	<!-- 검색 -->
	<div class="container">
		<div class="d-md-none d-lg-block d-xl-block">
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



	<!-- 상품 -->
	<main>
		<div class="album py-5 ">
			<div class="d-md-none d-lg-block d-xl-block">
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
		</div>

	</main>
	<!-- 상품 -->

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
	
 	 <!--   Slick Slider -->




	<!-- 게시글 -->
	<main>
		<div class="album py-5">
			<div class="container">
				<div class="d-md-none d-lg-block d-xl-block">

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
		</div>
		<br>

	</main>
	<!-- 게시글 -->



	<!-- 상품 -->
	<main>
		<div class="album py-5 ">
			<div class="container">
				<div class="d-md-none d-lg-block d-xl-block">
					<div class="container ">
						<div class="row">
							<div class="col-md-2">
								<h4>｜중고거래</h4>
							</div>
							<div class="col-md-8"></div>
							<div class="col-md-2">
								<h6 style="text-align: right;">
									<a href="boarditem/itemlist.do">더보기</a>
								</h6>
							</div>
						</div>
					</div>
					<hr>

					<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

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




	<!-- 상품 -->


	<!--
				<a href="sample1.do">sample1.do</a> |
				<a href="sample2.do">sample2.do</a> |
				<br>
				<a href="user/register.do">register로 이동</a>	
				<br>
				<a href="user/join.do">회원가입하기</a><br>
				<br> 
				-->

	<!--모바일 하단 메뉴버튼 시작-->
	<div class="visible-xs">
		<div class="container ">
			<div class="row d-lg-none">
				<div class="bottom_menu">
					<div>
						<img src="images/icon_home.png" width="40%">
					</div>
					<div>
						<img src="images/icon_comm.png" width="40%">
					</div>
					<div>
						<img src="images/icon_chat.png" width="40%">
					</div>
					<div>
						<img src="images/icon_my.png" width="40%">
					</div>
					<div>
						<img src="images/icon_quick.png" width="40%">
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--모바일 하단 메뉴버튼 종료	-->



	


		<!-- 퀵메뉴 시작 -->
		 <ul id="menu" class="mfb-component--br mfb-zoomin" data-mfb-toggle="hover">
      <li class="mfb-component__wrap">
        <a href="#" class="mfb-component__button--main">
          <i class="mfb-component__main-icon--resting ion-plus-round"></i>
          <i class="mfb-component__main-icon--active ion-close-round"></i>
        </a>
        <ul class="mfb-component__list">
          <li>
            <a href="boarditem/itemwrite.do" data-mfb-label="판매글 등록" class="mfb-component__button--child">
              <img src="images/icon_write.png" width="20px" height="20px;" he style="margin-left:19px; margin-top: 18px;">
              
            </a>
          </li>
          <li>
            <a href="itemwrite.do" data-mfb-label="알림" class="mfb-component__button--child">
              <img src="images/icon_push.png" width="20px" height="20px;" he style="margin-left:18px; margin-top: 18px;">
            </a>
          </li>


        </ul>
      </li>
    </ul>
		
		
		<link href="css/mfb.css" rel="stylesheet">
		<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 
		<!-- 퀵메뉴 종료 -->








<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
 <script src="https://getbootstrap.kr/docs/5.1/examples/offcanvas-navbar/offcanvas.js"></script>
</body>
</html>
