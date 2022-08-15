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
<script>
	$(function(){
		let slide;
		let slideWidth = 0;
		
		$(window).resize(function(){
			$(".slide-container").css("left","0px");
		});
		
		$(".slide-btn-prev").click(function(){
			let slideContainer = $(this).data("container");
			slideWidth = $(slideContainer).css("width").replace("px","");
			slide = $($(this).data("slide"));
			if((parseInt(slide.css("left").replace("px",""))%slideWidth) == 0){
				let left = slide.css("left").replace("px","");
				if((parseInt(left)+parseInt(slideWidth)) > 0){
					left = 0;
				}
				else{
					left = parseInt(left)+parseInt(slideWidth);
				}
				slide.css("left",left+"px");
			}
		});
		
		$(".slide-btn-next").click(function(){
			let slideContainer = $(this).data("container");
			slideWidth = $(slideContainer).css("width").replace("px","");
			slide = $($(this).data("slide"));
			if((parseInt(slide.css("left").replace("px",""))%slideWidth) == 0){
				left = slide.css("left").replace("px","");
				let NextMax = -((Math.ceil(${ interestedList.size() / 5 })-1)*slideWidth);
				if((parseInt(left)-parseInt(slideWidth)) >= parseInt(NextMax)){
					left = (parseInt(left)-parseInt(slideWidth));
				}else{
					left = 0;
				}
			}
			slide.css("left",left+"px");
		});
		
		
		
	});
</script>
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
	margin:auto;
	margin-top:20px; 
	color:#fff; 
	line-height:80px;
}

.card-body{
	padding:10px;
}

.slide-btn {
	position:absolute;
	z-index:100; 
	height:100%; 
	top:0; 
	bottom:0; 
	align-items:center; 
	display:flex;
	cursor:pointer;
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
					
					<div id="slideOfInterested" style="width:100%; clear:both; overflow:hidden; position:relative;">
						<div class="slide-btn slide-btn-prev" data-slide="#slider-interested" data-container="#slideOfInterested" id="slide-btn-prev" style="left:0;"><img src='${path}/images/slicbtn_prev.png'></div>
						<div class="slide-btn slide-btn-next" data-slide="#slider-interested" data-container="#slideOfInterested" id="slide-btn-next" style="right:0;"><img src='${path}/images/slicbtn_next.png'></div>
						<div id="slider-interested" class="slide-container" style="display:flex; white-space:nowrap; font-size:0px; left:0; position:relative; transition: left 0.6s ease-in-out;">
							<c:forEach var="vo" items="${interestedList}">
								<div style="width:20%; display:inline-block; font-size:1rem; flex:none;">
									<div class="card" style="margin:5px;" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ vo.item_idx }'">
										<img src="<%=request.getContextPath()%>/upload/${ interestedList[j].image1}" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="...">
										<div class="card-body">
									    	<span style="display:block;">${ vo.title }</span>
									  	</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<hr>
				
				<div id="listOfCommunity">
					<div style="float:left; padding:5px;">${ userLoginInfo.nickName }님의 판매중인 상품</div>
					<div style="float:right; padding:5px;">더 보기</div>
					
					<div id="slideOfMyItem" style="width:100%; clear:both; overflow:hidden; position:relative;">
						<div class="slide-btn slide-btn-prev" data-slide="#slider-myItem" data-container="#slideOfMyItem" id="slide-btn-prev" style="left:0;"><img src='${path}/images/slicbtn_prev.png'></div>
						<div class="slide-btn slide-btn-next" data-slide="#slider-myItem" data-container="#slideOfMyItem" id="slide-btn-next" style="right:0;"><img src='${path}/images/slicbtn_next.png'></div>
						<div id="slider-myItem" class="slide-container" style="display:flex; white-space:nowrap; font-size:0px; left:0; position:relative; transition: left 0.6s ease-in-out;">
							<c:forEach var="vo" items="${interestedList}">
								<div style="width:20%; display:inline-block; font-size:1rem; flex:none;">
									<div class="card" style="margin:5px;" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ vo.item_idx }'">
										<img src="<%=request.getContextPath()%>/upload/${ interestedList[j].image1}" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="...">
										<div class="card-body">
									    	<span style="display:block;">${ vo.title }</span>
									  	</div>
									</div>
								</div>
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
						<div onclick="location.href='userInfoView.do'">내 정보</div>
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
					<div class="col-4" style="padding:0px;" onclick="alert('준비중입니다.')">
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
