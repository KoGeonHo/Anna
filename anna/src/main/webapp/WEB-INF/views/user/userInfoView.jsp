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
	min-width:320px;
}


body { position: fixed; }

.container {
	justify-content: center;
	align-items: center;
	min-width:320px;
}

.card {
    margin-left: 3px;
}

#footer {
	background:#fff;
	position:fixed; 
	bottom:0px;
}

@media all and (max-width:  767px){
	
	.pc-header {
		display:none;
	}
	
	.main {
		padding-bottom: 70px;
	}
	
}

@media all and (min-width :768px){

	.navbar, .collapse, #menu{
		display:none
	}
	
	#footer {
		display:none;
	}
	
	#profile {
		padding:0 150px;
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

.profile-image{
	width:5rem;
	height:5rem;
	margin:1rem;
}

.row {
	height:3rem;
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
			<div class="container main" >
				<h3 class="border-bottom" style="padding:1rem;">회원정보</h3>
				<div id="profile" class="border-bottom" style="width:100%;">
					<div style="display:inline-block;"><img class="profile-image" style="border-radius:100px;" src="${ userInfo.profile_image }"></div>
					<div style="display:inline-block;">
						<div>
							${ userInfo.nickName }님의 프로필
						</div>
					</div>
				</div>
				<div class="row border-bottom">
					<div class="col-3 text-center" style="line-height:3rem;">닉네임</div>
					<div class="col-9" style="line-height:3rem;">${ userInfo.nickName }</div>
				</div>
				<div class="row border-bottom">
					<div class="col-3 text-center" style="line-height:3rem;">이메일</div>
					<div class="col-9" style="line-height:3rem;">${ userInfo.user_email }</div>
				</div>
				<div class="row border-bottom">
					<div class="col-3 text-center" style="line-height:3rem;">내동네</div>
					<div class="col-9" style="line-height:3rem; align-self:center;">
						<c:if test="${ empty userInfo.addr_code }">
							<button class="btn" style="background:#00AAB2; color:#fff;" onclick="location.href='locationAuth.do';">동네 등록하기</button>
						</c:if>
						<c:if test="${ not empty userInfo.addr_code }">
							${ userInfo.addr1 } ${ userInfo.addr2 }
						</c:if>
					</div>
				</div>
				<div class="row border-bottom">
					<div class="col-3 text-center" style="line-height:3rem;">소개글</div>
					<div class="col-9" style="line-height:3rem;">
						<c:if test="${ not empty userInfo.introduce }">
							${ userInfo.introduce }
						</c:if>
						<c:if test="${ empty userInfo.introduce }">
							-
						</c:if>
					</div>
				</div>
				<div class="row border-bottom">
					<div class="col-3 text-center" style="line-height:3rem; min-width:4rem;">관심사</div>
					<div class="col-9" style="line-height:3rem;">
						<c:if test="${ not empty userInfo.interested }">
							${ userInfo.interested }
						</c:if>
						<c:if test="${ empty userInfo.interested }">
							-
						</c:if>
					</div>
				</div>
				<div style="padding:5px 0;">
					<div class="text-end">
						<button class="btn btn1" style="background:#00AAB2; color:#fff;" onclick="location.href='${path}/user/userInfoMod.do';">회원정보 수정</button>
						<button class="btn" style="background:#BBCE53; color:#fff;">비밀번호 변경</button>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- mobile footer Start -->
		<div id="footer" class="border-top" style="box-sizing:border-box; width:100vw; padding:1rem 0; min-width:320px; ">
			<div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_home.png"></div><!--  
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_comm.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_chat.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_my.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_quick.png"></div>
		</div>
		<!-- mobile footer End -->
		
	</div>
</body>
</html>
