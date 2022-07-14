<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>

	<meta charset="UTF-8">
	<title>Home</title>
	

	<script src="jQuery/js/jquery-3.6.0.min.js"></script>
	<script src="resources/js/bootstrap.js"></script>
	<link href="resources/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
 -->	
 	<link href="${path}/css/bootstrap.css" rel="stylesheet"/> 
	
<style>

/*
반응형 기준 기록
	아주작은(xs)  576px 미만	  스마트폰 세로
	작은(sm) 	  576px 이상	  스마트폰 가로
	중간(md)	  768px 이상	  타블렛
	큰(lg)   	  992px 이상	  데스크탑
	아주큰(xl)	  1200px 이상	  큰 데스크탑
*/

.row {
	padding : 0px;
    margin: 0px;
}

.container {


    justify-content: center;
    align-items: center;
}

.card {
    margin-left: 3px;
}


.floating {
  position: fixed; 
  right: 50%; 
  top: 180px; 
  margin-right: -720px;
  text-align:center;
  width: 120px;
}

.floating {
background-color:#f9f9f9;
border:2px solid #000;
position: fixed; 
right: 40%; 
top: 180px; 
margin-right: -615px;
text-align:center;
width:70px;
border-radius: 8px;
-webkit-border-radius: 8px;
z-index : 1;
 }
.floating div:nth-child(1){

   border-radius: 8px;
}
.floating div:nth-child(2){
   border:2px solid #ff3535;
   border-radius: 8px;
}
.floating  div:nth-child(3){
   border:2px solid #ff3535;
   border-radius: 8px;
}




.bottom_menu {
			position: fixed;
			bottom: 0px;
			left: 0px;
			width: 100%;
			height: 130px;
			z-index:100;
			border-top: 1px solid black;
			background-color: white 
			}
			
.bottom_menu > div {
			float: left;
			width: 20%;
			height: 100%;
			text-align: center; 
			padding-top: 20px;
			}
			
	@media (min-width:  576px){
		.col-md-2 {
		
		    width : 30%;
		}
	}
	
	@media (min-width:  1200px){
		.col-md-2 {
			
		    width: 16.66666667%;
		}
	}
	
.navbar {
    height: 150;
    }
    
    

.offcanvas-collapse {
    top : 150px;
    
   		 }
    
  .navbar-toggler-icon {
    width: 4.5em;
    height: 5.5em;
    }
    
    .navbar-brand {

    margin-left: 1rem;
    }
    
    .navbar-dark .navbar-toggler-icon {
    margin-right: 1rem;
    }
    
    

</style>



</head>

<body>
			<!-- 플로팅 메뉴 -->
			
				<div class="floating">
					광고코드붙혀넣는곳
				</div>
				
				
				<div class="floating">
					  <div><h5 style="font-size:4px;">방금 본 상품</h5></div>
					  <div>트위터 공유코드 삽입</div>
					  <div>	페이스북 공유코드 삽입</div>
				</div>

			<!-- 플로팅 메뉴 -->

			<!-- pc 헤더 -->
				  <div class="b-example-divider ">
						<div class="container ">
							<div class="d-md-none d-lg-block d-xl-block">
				
							    <header class="d-flex  align-items-center justify-content-center justify-content-sm-between py-3 mb-1  " >
							      <a href="/" class="d-flex align-items-center col-md-3 mb-1 col-sm-3 mb-md-0 text-dark text-decoration-none ">
							        <svg class="bi me-1" width="40" height="32" role="img" aria-label="Bootstrap"><img src="resources/image/logo.png" width="30%"><use xlink:href="#bootstrap"/></svg>
							      </a>
							
							      <ul class="nav col-12 col-md-auto  col-sm-0 mb-1 justify-content-center mb-md-0">
							        <li><a href="boarditem/itemlist.do" class="nav-link px-3 link-dark ">중고거래</a></li>
							        <li><a href="board/FreeBoard.do" class="nav-link px-3 link-dark">커뮤니티</a></li>
							        <li><a href="#" class="nav-link px-3 link-dark ">고객센터</a></li>
							        <li><a href="#" class="nav-link px-3 link-dark">마이페이지</a></li>
							      </ul>
							
							      <div class="col-md-3 text-end">
							        <button type="button" class="btn "  style="background-color : #00AAB2;  color: #fff;">로그인</button>
							        <button type="button" class="btn " style="background-color : #BBCE53;  color: #fff;">회원가입</button>
							      </div>
						    </header>
						  </div>
				  </div>
				  </div>
				  
			<!-- pc헤더 -->


			<!-- 모바일 헤더-->
			
			<div class="d-lg-none"> 
   				 <link href="https://getbootstrap.kr/docs/5.1/examples/offcanvas-navbar/offcanvas.css" rel="stylesheet">
					
    
					<nav class="navbar navbar-expand-lg fixed-top navbar-dark " style="background-color : #00AAB2;"  aria-label="Main navigation">
					
				  <div class="container-fluid">
				    <a class="navbar-brand fs-1 fw-bold" href="#">금암동</a>
				    <button class="navbar-toggler p-0 border-0" type="button" id="navbarSideCollapse" aria-label="Toggle navigation">
				      <span class="navbar-toggler-icon"></span>
				    </button>
				
				    <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
				      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
				        <li class="nav-item">
				          <a class="nav-link active" aria-current="page" href="#">Dashboard</a>
				        </li>
				        <li class="nav-item">
				          <a class="nav-link" href="#">Notifications</a>
				        </li>
				        <li class="nav-item">
				          <a class="nav-link" href="#">Profile</a>
				        </li>
				        <li class="nav-item">
				          <a class="nav-link" href="#">Switch account</a>
				        </li>
				        <li class="nav-item dropdown">
				          <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-bs-toggle="dropdown" aria-expanded="false">Settings</a>
				          <ul class="dropdown-menu" aria-labelledby="dropdown01">
				            <li><a class="dropdown-item" href="#">Action</a></li>
				            <li><a class="dropdown-item" href="#">Another action</a></li>
				            <li><a class="dropdown-item" href="#">Something else here</a></li>
				          </ul>
				        </li>
				      </ul>
				      <form class="d-flex">
				        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
				        <button class="btn btn-outline-success" type="submit">Search</button>
				      </form>
				    </div>
				  </div>
				
				</nav>		
				  </div>
			<!-- 모바일 헤더-->




			<!-- 슬라이드 -->
			<div class="d-md-none d-lg-block d-xl-block">??aa
			 <div id="myCarousel" class="carousel slide " data-bs-ride="carousel">
			    <div class="carousel-indicators ">
			      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
			      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
			    </div>
			    <div class="carousel-inner">
			      <div class="carousel-item active">
			     <img src="resources/image/slide_2.png" width="100%">
			       
			        <div class="container">
			          <div class="carousel-caption text-start">

			          </div>
			        </div>
			      </div>
			      <div class="carousel-item">
			        <img src="resources/image/slide_1.png" width="100%">
			        
			        <div class="container">
			          <div class="carousel-caption">
			          </div>
			        </div>
			      </div>
			      <div class="carousel-item">
			       <img src="resources/image/slide.png" width="100%">
			       
			        <div class="container">
			          <div class="carousel-caption text-end">

			          </div>
			        </div>
			      </div>
			    </div>
			    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
			      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			      <span class="visually-hidden">Previous</span>
			    </button>
			    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
			      <span class="carousel-control-next-icon" aria-hidden="true"></span>
			      <span class="visually-hidden">Next</span>
			    </button>
			  </div>
			<br>
			<br>
			</div>
		<!-- 슬라이드 -->
	
	
		<!-- 검색 -->
			<div class="container">
				<div class="d-md-none d-lg-block d-xl-block">
			    <div class="row">
			        <div class="col-md-1 col-sm-0"></div>
			        <div class="col-md-10  col-sm-12" >
			        
			            <form class="d-flex ">
				          <input class="form-control me-6 vh-20" type="search" placeholder="검색어를 입력하세요" aria-label="Search">
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
								        <div class="col-md-2"><h4>｜중고거래</h4></div>
								        <div class="col-md-8"></div>
								        <div class="col-md-2 "><h6  style="text-align:right;">더보기</h6></div>
							    </div>
						</div>
						</div>
						</div>
				<hr>				
			      
			      <div class="container ">
				       <div class="row">
			     <div class=" col-lg-3  col-md-12 " >
							
									  <div class="card ">
											  <img src="https://media.bunjang.co.kr/product/187617756_3_1652360665_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title ">후지카메라 x100v</h6>
												  <h5 class="card-text">1,450,000원</h5>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
							
			     <div class="col-lg-3  col-md-12 " >
							
									  <div class="card " >
											  <img src="https://media.bunjang.co.kr/product/190285795_2_1655981003_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">17-18 손흥민 유니폼</h6>
												  <p class="card-text">145,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
							
			     <div class=" col-lg-3  col-md-12 " >
							
									  <div class="card ">
											  <img src="https://media.bunjang.co.kr/product/193141726_1_1657512097_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">맥북 m1 에어 2020 기본형</h6>
												  <p class="card-text">800,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
							
			     <div class=" col-lg-3  col-md-12 " >
							
									  <div class="card " >
											  <img src="https://media.bunjang.co.kr/product/192931467_3_1657288958_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">루이까또즈 머니클립 지갑</h6>
												  <p class="card-text">35,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
						</div>
						</div>
			
			</main>
			  <!-- 상품 -->


			<!-- 게시글 -->
			<main>
			  <div class="album py-5">
			    <div class="container">
					 <div class="d-md-none d-lg-block d-xl-block">
					 
							<div class="container ">
								    <div class="row">
									        <div class="col-md-2"><h4>｜일상 & 소통</h4></div>
									        <div class="col-md-8"></div>
									        <div class="col-md-2"><h6  style="text-align:right;">더보기</h6></div>
								    </div>
							</div>
						<hr>
					
			      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
			      
			      
			        <div class="col">
				          <div class="card shadow-sm">
					            <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: " preserveAspectRatio="xMidYMid slice" focusable="false"><title></title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em"></text></svg>
					
									 <div class="card-body">
										  <h5 class="card-title">게시글 제목</h5>
										  <p class="card-text"></p>
			                              <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
									      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
									 </div>
				          </div>
			        </div>
			        
			        <div class="col">
				          <div class="card shadow-sm">
					            <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: " preserveAspectRatio="xMidYMid slice" focusable="false"><title></title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em"></text></svg>
					
									 <div class="card-body">
										  <h5 class="card-title">게시글 제목</h5>
										  <p class="card-text"></p>
			                              <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
									      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
									 </div>
				          </div>
			        </div>
			        
			        <div class="col">
				          <div class="card shadow-sm">
					            <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: " preserveAspectRatio="xMidYMid slice" focusable="false"><title></title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em"></text></svg>
					
									 <div class="card-body">
										  <h5 class="card-title">게시글 제목</h5>
										  <p class="card-text"></p>
			                              <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
									      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
									 </div>
				          </div>
			        </div>
			        
			        			        <div class="col">
				          <div class="card shadow-sm">
					            <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: " preserveAspectRatio="xMidYMid slice" focusable="false"><title></title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em"></text></svg>
					
									 <div class="card-body">
										  <h5 class="card-title">게시글 제목</h5>
										  <p class="card-text"></p>
			                              <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
									      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
									 </div>
				          </div>
			        </div>
			        </div>
			
			</main>
			<!-- 게시글 -->

			
			  <!-- 상품 -->
			<main>
			  <div class="album py-5 ">
			    <div class="container">
					 <div class="d-md-none d-lg-block d-xl-block">
						<div class="container ">
							    <div class="row">
								        <div class="col-md-2"><h4>｜중고거래</h4></div>
								        <div class="col-md-8"></div>
								        <div class="col-md-2"><h6  style="text-align:right;">더보기</h6></div>
							    </div>
						</div>
				<hr>
					
			      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
			      
			      
			     <div class="col-lg-3 col-md-6 " >
							
									  <div class="card" style="width: 19rem;">
											  <img src="https://media.bunjang.co.kr/product/193152448_2_1657519466_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">아이앱 스튜디오 후드 블랙</h6>
												  <p class="card-text">220,000원 </p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
							
			        <div class="col-lg-3 col-md-6 " >
							
									  <div class="card" style="width: 19rem;">
											  <img src="https://media.bunjang.co.kr/product/193052370_2_1657426178_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">킥보드 크루스rs팝니다</h6>
												  <p class="card-text">700,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
							
			      <div class="col-lg-3 col-md-6 " >
							
									  <div class="card" style="width: 19rem;">
											  <img src="https://media.bunjang.co.kr/product/193152157_10_1657519257_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">퓨리티 플러스 3D 회전형 젖병 소독기</h6>
												  <p class="card-text">145,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
							
							<div class="col-lg-3 col-md-6 " >
							
									  <div class="card" style="width: 19rem;">
											  <img src="https://media.bunjang.co.kr/product/189215558_2_1653819887_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">코드유 블랑 블라우스</h6>
												  <p class="card-text">29,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>  
							
			        <div class="col-lg-3 col-md-6 " >
							
									  <div class="card" style="width: 19rem;">
											  <img src="https://media.bunjang.co.kr/product/193053163_4_1657426794_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">new 닌텐더 2ds xl</h6>
												  <p class="card-text">100,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
							
			        <div class="col-lg-3 col-md-6 " >
							
									  <div class="card" style="width: 19rem;">
											  <img src="https://media.bunjang.co.kr/product/192865491_4_1657362057_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">엠스톤그루브 저소음갈축 풀윤활 키보드</h6>
												  <p class="card-text">115,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
							
			        <div class="col-lg-3 col-md-6 " >
							
									  <div class="card" style="width: 19rem;">
											  <img src="https://media.bunjang.co.kr/product/170033103_8_1657074193_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">어반드로워 사이드테이블</h6>
												  <p class="card-text">250,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>

			        <div class="col-lg-3 col-md-6 " >
							
									  <div class="card" style="width: 19rem;">
											  <img src="https://media.bunjang.co.kr/product/191947468_8_1656362331_w856.jpg" class="card-img-top" alt="...">
												  <div class="card-body">
												  <h6 class="card-title">마켓비 MKB 철제 캐비넷</h6>
												  <p class="card-text">55,000원</p>
			                                      <button type="button"  class="btn btn-sm btn-outline-secondary"  style="float:right">view 5</button>
											      <button type="button" class="btn btn-sm btn-outline-secondary" style="float:right">♥2</button>
											  </div>
									</div>
							</div>
						</div>
			</main>
			  <!-- 상품 -->


<!-- 	<a href="sample1.do">sample1.do</a> |
	<a href="sample2.do">sample2.do</a> |
	<br>
	<a href="user/register.do">register로 이동</a>	
	<br>
	<a href="user/join.do">회원가입하기</a><br>
	<br> -->


	    

<!--모바일 하단 메뉴버튼 -->
			<div class="visible-xs">
				<div class="container ">
					<div class="row d-lg-none"> 
							<div class="bottom_menu">
								<div>
									<img src="resources/image/icon_home.png" width="40%">
								</div>
								<div>
									<img src="resources/image/icon_comm.png"  width="40%">
								</div>
								<div>
									<img src="resources/image/icon_chat.png"  width="40%">
								</div>
								<div>
									<img src="resources/image/icon_my.png"  width="40%">
								</div>
								<div>
									<img src="resources/image/icon_quick.png"  width="40%">
								</div>
							</div>
					</div>
				</div>
			</div>
<!--모바일 하단 메뉴버튼 -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
 <script src="https://getbootstrap.kr/docs/5.1/examples/offcanvas-navbar/offcanvas.js"></script>
</body>
</html>
