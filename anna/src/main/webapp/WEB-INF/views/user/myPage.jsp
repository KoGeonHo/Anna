<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>안녕? 나야! - 마이 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script>
	$(function(){
	    $('.slider-wrap').slick({
	      slide: 'div',        //슬라이드 되어야 할 태그
	      infinite : true,     //무한 반복 옵션     
	      slidesToShow : 5,        // 한 화면에 보여질 컨텐츠 개수
	      slidesToScroll : 1,        //스크롤 한번에 움직일 컨텐츠 개수
	      speed : 500,     // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
	      arrows : true,         // 옆으로 이동하는 화살표 표시 여부
	      dots : true,         // 스크롤바 아래 점으로 페이지네이션 여부
	      autoplay : true,            // 자동 스크롤 사용 여부
	      autoplaySpeed : 2000,         // 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
	      pauseOnHover : true,        // 슬라이드 이동    시 마우스 호버하면 슬라이더 멈추게 설정
	      vertical : false,        // 세로 방향 슬라이드 옵션
	      prevArrow : "<img src='${path}/images/slicbtn_prev.png'  id ='slidebtn' class='slick-prev'></button>",		// 이전 화살표 모양 설정
			nextArrow : "<img src='${path}/images/slicbtn_next.png' id ='slidebtn' class='slick-next'></button>",		// 다음 화살표 모양 설정
	      draggable : true,     //드래그 가능 여부 
	      responsive: [ // 반응형 웹 구현 옵션
	        {  
	          breakpoint: 960, //화면 사이즈 960px
	          settings: {
	            slidesToShow: 4
	          } 
	        },
	        { 
	          breakpoint: 768, //화면 사이즈 768px
	          settings: {    
	            slidesToShow: 5
	          } 
	        }
	      ]
	
	    });
	});
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


.card {
    margin-left: 3px;
    cursor:pointer;
}

@media all and (max-width:  767px){
	
	#container-pc {
		display:none;
	}
	
}

@media all and (min-width :768px){

	#footer, #container-mobile{
		display:none
	}
	
}

.prev{
	position: absolute;
    top: 0;
    bottom: 0;
    z-index: 1;
    display: flex;
    padding-left:15px;
    align-items: center;
    justify-content: center;
    color: #000;
    text-align: center;
    background: none;
    border: 0;
    opacity: 0.5;
    transition: opacity 0.15s ease;
}

.next{
	position: absolute;
    top: 0;
    bottom: 0;
    z-index: 1;
    padding-right:15px;
    display: flex;
    align-items: center;
    justify-content: center;
    right:0;
    color: #000;
    text-align: center;
    background: none;
    border: 0;
    opacity: 0.5;
    transition: opacity 0.15s ease;
}

.btn-circle {
	border-radius:100px; 
	background:#777; 
	width:80px;
	height:80px; 
	margin:auto;
	margin-top:20px; 
	color:#fff; 
	line-height:80px;
}

.card-body{
	padding:10px;
}


</style>
</head>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		
		<div class="wrapper" id="container-pc">
			<!-- MyPage for Pc -->
			<div class="container main">
				<h3 class="border-bottom" style="padding:1rem;">마이 페이지</h3>
				<div id="listOfInterested">
					<div style="float:left; padding:5px;">${ userLoginInfo.nickName }님이 관심있어 할만한 상품</div>
					<div style="float:right; padding:5px;">더 보기</div>
					<div class="slider-wrap">
						<c:forEach var="vo" items="${interestedList}" step="5">
						    <div class="cont">
								<div class="card" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ vo.item_idx }'">
									<img src="${path}/upload/${ vo.image1}" onerror="this.onerror=null; this.src='${path}/images/no_image.gif';" class="card-img-top" alt="...">
									<div class="card-body">
								    	<span style="display:block;">${ vo.title }</span>
								  	</div>
								</div>
							</div>
					    </c:forEach>
					</div>
					
					<%-- <div id="slideOfInterested" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner">
							<c:forEach var="i" begin="0" end="${ interestedList.size() - 1 }" step="5">
								<c:if test="${ i == 0 }">
									<div class="carousel-item active">
										<div class="row">
											<c:forEach var="j" begin="${ i }" end="${ i + 4 }" step="1">
												<div class="col-3" style="width:20%;">
													<div class="card" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ interestedList[j].item_idx }'">
														<img src="<%=request.getContextPath()%>/upload/${ interestedList[j].image1}" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="...">
														<div class="card-body">
													    	<span style="display:block;">${ interestedList[j].title }</span>
													  	</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
									<button class="prev" type="button" style="cursor:default;">
										<span class="carousel-control-prev-icon" style="cursor:pointer;" data-bs-target="#slideOfInterested" data-bs-slide="prev" aria-hidden="true"></span>
									</button>
									<button class="next" type="button" style="cursor:default;">
										<span class="carousel-control-next-icon" style="cursor:pointer;" data-bs-target="#slideOfInterested" data-bs-slide="next" aria-hidden="true"></span>
									</button>
								</c:if>
								<c:if test="${ i != 0 }">
									<div class="carousel-item">
										<div class="row">
											<c:forEach var="j" begin="${ i }" end="${ i + 4 }" step="1">
												<div class="col-3" style="width:20%;">
													<div class="card" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ interestedList[j].item_idx }'">
														<img src="<%=request.getContextPath()%>/upload/${ interestedList[j].image1}" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="...">
														<div class="card-body">
													    	<span style="display:block;">${ interestedList[j].title }</span>
													  	</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
									<button class="prev" type="button" style="cursor:default;">
										<span class="carousel-control-prev-icon" style="cursor:pointer;" data-bs-target="#slideOfInterested" data-bs-slide="prev" aria-hidden="true"></span>
									</button>
									<button class="next" type="button" style="cursor:default;">
										<span class="carousel-control-next-icon" style="cursor:pointer;" data-bs-target="#slideOfInterested" data-bs-slide="next" aria-hidden="true"></span>
									</button>
								</c:if>
							</c:forEach>
						</div>
					</div> --%>
				</div>
				
				<hr>
				<div id="listOfCommunity">
					<div style="float:left; padding:5px;">${ userLoginInfo.nickName }님의 판매중인 상품</div>
					<div style="float:right; padding:5px;">더 보기</div>
					<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner">
							<c:forEach var="i" begin="0" end="${ interestedList.size() }" step="5">
								<c:if test="${ i == 0 }">
									<div class="carousel-item active">
										<div class="row">
											<c:forEach var="j" begin="${ i }" end="${ i + 4 }" step="1">
												<div class="col-3" style="width:20%;">
													<div class="card" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ interestedList[j].item_idx }'">
														<img src="<%=request.getContextPath()%>/upload/${ interestedList[j].image1}" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="...">
														<div class="card-body">
													    	<span style="display:block;">${ interestedList[j].title }</span>
													  	</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
									<button class="prev" type="button" style="cursor:default;">
										<span class="carousel-control-prev-icon" style="cursor:pointer;" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev" aria-hidden="true"></span>
									</button>
									<button class="next" type="button" style="cursor:default;">
										<span class="carousel-control-next-icon" style="cursor:pointer;" data-bs-target="#carouselExampleIndicators" data-bs-slide="next" aria-hidden="true"></span>
									</button>
								</c:if>
								<c:if test="${ i != 0 }">
									<div class="carousel-item">
										<div class="row">
											<c:forEach var="j" begin="${ i }" end="${ i + 4 }" step="1">
												<div class="col-3" style="width:20%;">
													<div class="card" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ interestedList[j].item_idx }'">
														<img src="<%=request.getContextPath()%>/upload/${ interestedList[j].image1}" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="...">
														<div class="card-body">
													    	<span style="display:block;">${ interestedList[j].title }</span>
													  	</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
									<button class="prev" type="button" style="cursor:default;">
										<span class="carousel-control-prev-icon" style="cursor:pointer;" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev" aria-hidden="true"></span>
									</button>
									<button class="next" type="button" style="cursor:default;">
										<span class="carousel-control-next-icon" style="cursor:pointer;" data-bs-target="#carouselExampleIndicators" data-bs-slide="next" aria-hidden="true"></span>
									</button>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<hr>
				
				<div id="listOfCommunity">
					<div style="float:left; padding:5px;">우리동네 커뮤니티</div>
					<div style="float:right; padding:5px;">더 보기</div>
					<div class="list">
				
						<div class="tr border-bottom">
							<div class="th" style="width:50%;">제목</div>
							<div class="th" style="width:10%;">구분</div>
							<div class="th" style="width:10%;">작성자</div>
							<div class="th" style="width:20%;">작성일</div>
							<div class="th" style="width:10%;">조회수</div>
						</div>
						<c:if test="${ not empty myTownCommunityList }">
							<c:forEach var="i" items="${ myTownCommunityList }">
								<div class="tr border-bottom">
									<div class="td text-center" style="width:50%;">${ i.title }</div>
									<div class="td text-center" style="width:10%;">${ i.board_type }</div>
									<div class="td text-center" style="width:10%;">${ i.nickName }</div>
									<div class="td text-center" style="width:20%;">${ i.wdate }</div>
									<div class="td text-center" style="width:10%;">${ i.hit }</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
			<!-- MyPage for Pc -->
		</div>
		
		<div class="wrapper" id='container-mobile'>
			<!-- MyPage for Mobile -->
			<div class="container main" >
				<h3 class="border-bottom" style="padding:1rem;">마이 페이지</h3>
				<div class="border-bottom">
					<div style="display:inline-block;">
						<img src="${ userInfo.profile_image }" style="border-radius:100px; width:100px; height:auto;padding:1rem;">
					</div>
					<div style="display:inline-block; vertical-align: middle;">
						<div>${ userInfo.nickName }</div>
						<div>내 정보</div>
					</div>
				</div>
				<div class="row">
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle">구매</div>
						<div class="text-center">구매 내역</div>
					</div>
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle">판매</div>
						<div class="text-center">판매 내역</div>
					</div>
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle">찜</div>
						<div class="text-center">찜 목록</div>
					</div>
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle">관심</div>
						<div class="text-center">관심 상품</div>
					</div>
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle">공지</div>
						<div class="text-center">공지사항</div>
					</div>
					<div class="col-4" style="padding:0px;" onclick="location.href='${path}/user/neighborMng.do'">
						<div class="text-center btn-circle">이웃</div>
						<div class="text-center">이웃 관리</div>
					</div>
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle">질문</div>
						<div class="text-center">자주하는 질문</div>
					</div>
					<div class="col-4" style="padding:0px;" onclick="location.href='${path}/customer/QnAList.do'">
						<div class="text-center btn-circle">QnA</div>
						<div class="text-center">문의 내역</div>
					</div>
				</div>
			</div>
			<!-- MyPage for Mobile -->
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
