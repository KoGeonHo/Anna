<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>안녕? 나야! - 마이 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />

<style>

/*
반응형 기준 기록
	아주작은(xs)  576px 미만	  스마트폰 세로
	작은(sm) 	  576px 이상	  스마트폰 가로
	중간(md)	  768px 이상	  타블렛
	큰(lg)   	  992px 이상	  데스크탑
	아주큰(xl)	  1200px 이상	  큰 데스크탑
*/

html, body {
	padding : 0px;
	width: 100%;
	overflow-x: hidden;
}

.container {
	justify-content: center;
	align-items: center;
}

.card {
    margin-left: 3px;
}

@media all and (max-width:  767px){
	
	.pc-header {
		display:none;
	}

	
}

@media all and (min-width :768px){

	.navbar, .collapse, #menu{
		display:none
	}
	
	#footer {
		display:none;
	}
	
}

.menu-hide {
	 left:100%;
}


#menu{

	transition: all 0.5s ease-out;
	
}

.menu-item{

	padding:1rem;
	font-size:1rem;
	
}

.wrapper {
	display: flex;
    flex-direction: column;
    height: 100vh;
    
}

.ft-icon {
	border:0px;
	margin:0px;
}

</style>
<script>
	$(function(){
		$("#menu-btn").click(function(){
			
			if($("#menu").css("left") != "0px"){
				$("#menu").css("left","0px");
			}else{
				$("#menu").css("left","100%");
			}
			
		});
	});
</script>
</head>
<body>
	<div class="wrapper">
	
		<!-- PC 헤더 START-->
		<div class="pc-header border-bottom" style="position:sticky; top:0; left:0;">
			<div class="container">
		
				<header class="d-flex  align-items-center justify-content-center justify-content-sm-between py-3 mb-1  ">
					<a href="${ path }/main.do" class="d-flex align-items-center col-md-3 mb-1 col-sm-3 mb-md-0 text-dark text-decoration-none ">
						<img src="${ path }/images/logo.png" width="30%">
					</a>
	
					<ul class="nav col-12 col-md-auto  col-sm-0 mb-1 justify-content-center mb-md-0">
						<li><a href="#" class="nav-link px-3 link-dark ">중고거래</a></li>
						<li><a href="#" class="nav-link px-3 link-dark">커뮤니티</a></li>
						<li><a href="#" class="nav-link px-3 link-dark ">고객센터</a></li>
						<li><a href="#" class="nav-link px-3 link-dark">마이페이지</a></li>
					</ul>
					<div class="col-md-3 text-end">
						<c:if test="${ empty uidx }">
							<button type="button" class="btn" style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='${ path }/user/login.do';">
								로그인
							</button>
							<button type="button" class="btn" style="background-color: #BBCE53; color: #fff;" onclick="javascript:loacrion.href='${ path }/user/join.do';">
								회원가입
							</button>
						</c:if>
						<c:if test="${ not empty uidx }">
							<button type="button" class="btn" style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='${ path }/user/logout.do';">
								로그아웃
							</button>
						</c:if>
					</div>
				</header>
			</div>
		</div>
		<!-- PC헤더  END-->

		<!-- 모바일 헤더 START -->
		<nav class="navbar navbar-dark" style=" background:#00AAB2;">
			<div class="container-fluid">
				<div class="navbar-header">
			    	<a class="navbar-brand" href="#" style="color:white;">효자동</a>
			    </div>
			    <div class="text-end" style="color:white; flex:1; padding:0 1rem;">
			    	<input type="text" class="form-control" placeholder="검색">
			    </div>
				<div id="div-menu-btn" class="navbar-right">
					<button class="navbar-toggler" type="button">
						<span id="menu-btn" class="navbar-toggler-icon"></span>
					</button>
				</div>
			</div>
		</nav>
		<!-- 모바일 헤더 END -->
		
		<div id="menu" class="container-fluid text-white menu-hide" style="position:absolute; top:56px; background:#00AAB2;">
			<div class="menu-item">
				마이페이지
			</div>
			<div class="menu-item">
				전주시
			</div>
			<div class="menu-item">
				전주시
			</div>
			<div class="menu-item">
				전주시
			</div>
		</div>
	
		<div class="wrapper" style="flex:1; overflow:auto;">
			<div class="container" >
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
				<h3 class="border-bottom">마이 페이지</h3>
				<div id="listOfInterested">
					<span>${ nickName }님이 관심있어 할만한 상품</span>
				</div>
			</div>
		</div>
		
		<div id="footer" class="border-top" style="box-sizing: border-box; width:100vw; padding:1rem 0;">
			<div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_home.png"></div><!--  
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_comm.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_chat.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_my.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_quick.png"></div>
		</div>
		
	</div>
</body>
</html>
