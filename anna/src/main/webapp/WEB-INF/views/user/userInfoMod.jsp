<%@page import="edu.fourmen.vo.UserVO"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>안녕? 나야! - 마이 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1">
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

html, body,.wrapper {
	padding : 0px;
	height : 100%;
	width : 100%;
	overflow-x: hidden;
	min-width:320px;
}

body { position: fixed; }

form {
	margin-block-end: 0px;
}

.container {
	justify-content: center;
	align-items: center;
	min-width:320px;
	overflow-x: hidden;
}

.card {
    margin-left: 3px;
}

@media all and (max-width:  767px){
	
	.pc-header {
		display:none;
	}
	
	#input-interested {
		width:40vw;
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
	
	#input-interested {
		width:250px;
	}
	
	#input-nickName {
		width:20vw;
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
	margin:0px;
}

.th {
	background:#eee;
}

</style>
<script>

	let keyword = "${ userInfo.interested }";
	let arr = keyword.split(',');
	$(function(){
		$("#menu-btn").click(function(){
			
			if($("#menu").css("left") != "0px"){
				
				$("#menu").css("left","0px");
				
			}else{
				
				$("#menu").css("left","100%");
				
			}
			
		});
		let html = "";
		if(keyword != ""){
			for(let i = 0; i < arr.length; i++){
				html += arr[i]+"<span onclick='delKeyword(\""+arr[i]+"\");'>삭제</span><br>";
			}
	
			$("#interest_keywords").html(html);
			
		}else{
			
			$("#interest_keywords").html("등록된 관심키워드가 없습니다.");
			
		}
	});
	
	function delKeyword(item){
		arr = arr.filter(function(rti) {
		    return rti !== item;
		});
		let delResult = "";
		for(let i = 0; i < arr.length; i++){
			delResult += arr[i];
			if(i != (arr.length-1)){
				delResult += ",";
			}
			
		}
		
		//console.log(delResult+"delResult");
		let html = "";
		$.ajax({
			url : "updateKeyword.do",
			data : "interested="+delResult,
			success : function(rs){
				if(rs != 0){
					alert(item+" 키워드가 삭제 되었습니다.");
					for(let i = 0; i < arr.length; i++){
						html += arr[i]+"<span onclick='delKeyword(\""+arr[i]+"\");'>삭제</span><br>";
					}
					if(delResult != ""){
						$("#interest_keywords").html(html);
					} else {
						$("#interest_keywords").html("등록된 관심키워드가 없습니다.");
					}
				}
				
			} 
		});
	}
	
	function addInterested(){
		let item = $("input[name=interested]");
		
		if(item.val() != ""){
			if(!arr.includes(item.val())){
				if(arr.length >= 10){
					alert("관심사는 최대 10개까지 등록가능합니다.");
					return false;
				}
				arr.push(item.val());
				//배열에 빈값 삭제
				arr = arr.filter(function(rti) {
				    return rti !== "";
				});
				if(keyword == ""){
					keyword += item.val();
				}else{
					keyword += ","+item.val();
				}
				let html = "";
				$.ajax({
					url : "updateKeyword.do",
					data : "interested="+keyword,
					success : function(rs){
						//console.log(rs);
						alert("키워드가 등록되었습니다.");
						if(rs != 0){
							for(let i = 0; i < arr.length; i++){
								html += arr[i]+"<span onclick='delKeyword(\""+arr[i]+"\");'>삭제</span><br>";
							}
							$("#interest_keywords").html(html);
						}
						
					} 
				});
				item.val("");
				item.focus();
			} else {
				alert("이미 등록된 키워드 입니다.");
				item.val("");
				item.focus();
			}
		}else{
			alert("관심키워드를 입력해주세요");
			item.focus();
		}
		
	}
	
	function frmSubmit(){
		$("#userInfoModFrm").submit();
	}
	
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
				<h3 class="border-bottom" style="padding:1rem;">회원정보수정</h3>
				<form id="userInfoModFrm" method="POST" action="userInfoMod.do">
					<div id="profile" class="border-bottom" style="width:100%;">
						<div style="display:inline-block;"><img class="profile-image" style="border-radius:100px;" src="${ userInfo.profile_image }"></div>
						<div style="display:inline-block;">
							<div>
								<b>${ userInfo.nickName }</b>님의 프로필
							</div>
						</div>
					</div>
					<div class="row border-bottom">
						<div class="col-3 text-center th" style="line-height:3rem;">닉네임</div>
						<div class="col-9" style="line-height:3rem; align-self:center;"><input type="text" class="form-control" id="input-nickName" name="nickName" value="${ userInfo.nickName }"></div>
					</div>
					<div class="row border-bottom">
						<div class="col-3 text-center th" style="line-height:3rem;">이메일</div>
						<div class="col-9" style="line-height:3rem;">${ userInfo.user_email }</div>
					</div>
					<div class="row border-bottom">
						<div class="col-3 text-center th" style="line-height:3rem;">내동네</div>
						<div class="col-9" style="line-height:3rem; align-self:center;">
							<c:if test="${ empty userInfo.addr_code }">
								<button class="btn" style="background:#00AAB2; color:#fff;">동네 등록하기</button>
							</c:if>
							<c:if test="${ not empty userInfo.addr_code }">
								${ userInfo.addr1 } ${ userInfo.addr2 }
							</c:if>
						</div>
					</div>
					<div class="row border-bottom">
						<div class="col-3 text-center th" style="line-height:3rem;">소개글</div>
						<div class="col-9">
							<textarea class="form-control" name="introduce" style="margin:5px 0; resize:none;" rows="5">${ userInfo.introduce }</textarea>
						</div>
					</div>
				</form>
				<div class="row border-bottom">
					<div class="col-3 text-center th" style="line-height:3rem; min-width:4rem;">관심<br>키워드</div>
					<div class="col-9" style="line-height:3rem; margin:5px 0;">
						<input type="text" class="form-control" id="input-interested" autocomplete="off" style="display:inline-block;" name="interested">
						<button class="btn" type="button" style="display:inline-block; background-color: #00AAB2; color: #fff;" onclick="addInterested()">추가</button>
						<div id="interest_keywords">
						</div>
					</div>
				</div>
				<div style="padding:5px 0;">
					<div class="text-end">
						<button class="btn btn1" style="background:#00AAB2; color:#fff;" type="button" onclick="frmSubmit()">수정</button>
						<button class="btn" style="background:#BBCE53; color:#fff;" type="button" onclick="javascript:history.back();">돌아가기</button>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- mobile footer Start -->
		<div id="footer" class="border-top" style="box-sizing: border-box; width:100vw; padding:1rem 0; min-width:320px;">
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
