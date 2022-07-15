<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- PC 헤더 START-->
<div class="pc-header border-bottom">
	<div class="container">

		<header class="d-flex  align-items-center justify-content-center justify-content-sm-between py-3 mb-1  ">
			<a href="${ path }/main.do" class="d-flex align-items-center col-md-3 mb-1 col-sm-3 mb-md-0 text-dark text-decoration-none ">
				<img src="${ path }/images/AnnaLogo.png" width="30%">
			</a>

			<ul class="nav col-12 col-md-auto  col-sm-0 mb-1 justify-content-center mb-md-0">
				<li><a href="#" class="nav-link px-3 link-dark ">중고거래</a></li>
				<li><a href="#" class="nav-link px-3 link-dark">커뮤니티</a></li>
				<li><a href="#" class="nav-link px-3 link-dark ">고객센터</a></li>
				<li><a href="#" class="nav-link px-3 link-dark">마이페이지</a></li>
			</ul>

			<div class="col-md-3 text-end">
				<button type="button" class="btn" style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='${ path }/user/login.do';">
					로그인
				</button>
				<button type="button" class="btn" style="background-color: #BBCE53; color: #fff;" onclick="javascript:loacrion.href='${ path }/user/join.do';">
					회원가입
				</button>
			</div>
		</header>
	</div>
</div>
<!-- PC헤더  END-->

<!-- 모바일 헤더 START -->
<nav class="navbar navbar-dark bg-dark">
	<div class="container-fluid">
		<div class="navbar-header">
	    	<a class="navbar-brand" href="#" style="color:white;">효자동</a>
	    </div>
	    <div class="text-end" style="color:white; flex:1;">
	    	검색버튼
	    	<!-- <input type="text" class="form-control"> -->
	    </div>
		<div id="div-menu-btn" class="navbar-right">
			<button class="navbar-toggler" type="button">
				<span id="menu-btn" class="navbar-toggler-icon"></span>
			</button>
		</div>
	</div>
</nav>
<!-- 모바일 헤더 END -->


<div id="menu" class="container-fluid bg-dark text-white menu-hide" style="position:absolute;">
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