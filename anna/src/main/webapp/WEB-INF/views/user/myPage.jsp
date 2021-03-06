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
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />

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
	margin:20px 20px 0 20px; 
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
		
		<!-- MyPage for Pc -->
		<div class="container main" id="container-pc">
			<h3 class="border-bottom" style="padding:1rem;">마이 페이지</h3>
			<div id="listOfInterested">
				<span>${ nickName }님이 관심있어 할만한 상품</span>
				<div id="slideOfInterested" class="carousel slide" data-bs-ride="carousel">
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
				</div>
			</div>
			
			<hr>
			<div id="listOfCommunity">
				<span>${ nickName }님의 판매중인 상품</span>
				<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
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
				<span>우리동네 커뮤니티</span>
				
			</div>
		</div>
		<!-- MyPage for Pc -->
		
		
		<!-- MyPage for Mobile -->
		<div class="container main" id='container-mobile'>
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
				<div class="col-4" style="padding:0px;">
					<div class="text-center btn-circle">이웃</div>
					<div class="text-center">이웃 관리</div>
				</div>
				<div class="col-4" style="padding:0px;">
					<div class="text-center btn-circle">질문</div>
					<div class="text-center">자주하는 질문</div>
				</div>
				<div class="col-4" style="padding:0px;">
					<div class="text-center btn-circle">QnA</div>
					<div class="text-center">문의 내역</div>
				</div>
			</div>
		</div>
		<!-- MyPage for Mobile -->
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
