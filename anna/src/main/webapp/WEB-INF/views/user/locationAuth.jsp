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
<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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

body { position: fixed; }

.container {
	justify-content: center;
	align-items: center;
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
			<div class="container main" >
				<h3 class="border-bottom" style="padding:1rem;">동네인증</h3>												
    		<div id='map' style='width:100%-20px;height:400px'></div>												
    		<script type='text/javascript'>		
    		$.ajax({
    			url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
    			data : "consumer_key=9ff16331dfd542b6a5b0&consumer_secret=32b9d18070d34db18be5",
    			success : function(data){
    				if(navigator.geolocation){
    					navigator.geolocation.getCurrentPosition(function(position){
    						
    						let utmkXY = new sop.LatLng (position.coords.latitude, position.coords.longitude);
    						
    						loadMap(position.coords.latitude,position.coords.longitude);
    						
    						console.log("x:"+utmkXY.x);
    						
    						console.log("y:"+utmkXY.y);
    						
    						$.ajax({
    	    	    			url : "https://sgisapi.kostat.go.kr/OpenAPI3/personal/findcodeinsmallarea.json",
    	    	    			data : "accessToken="+data.result.accessToken+"&x_coor="+utmkXY.x+"&y_coor="+utmkXY.y,
    	    	    			success : function(data2){
    	    	    				console.log(data2.result.sido_cd+data2.result.sgg_cd);
    	    	    				$.ajax({
    	    	    					url : "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json",
    	    	    					data : "accessToken="+data.result.accessToken+"&pg_yn=1&cd="+data2.result.sido_cd+data2.result.sgg_cd,
    	    	    					success : function(data3){
    	    	    						console.log(data3.result);
    	    	    					}
    	    	    				});
    	    	    			}
    	    	    		});
    					})
    				}
    				
    			}
    		});
    		
    		function loadMap(x,y){
	    		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    		mapOption = { 
	    		    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    		    level: 3 // 지도의 확대 레벨 
	    		}; 
	    		
	    		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	    		
	    		//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	    		if (navigator.geolocation) {
	    		
	    		// GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    		navigator.geolocation.getCurrentPosition(function(position) {
	    		    
	    		    var lat = x, // 위도
	    		        lon = y; // 경도
	    		    
	    		    var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	    		        message = '<div style="padding:5px;">여기서 뭐하니?</div>'; // 인포윈도우에 표시될 내용입니다
	    		    
	    		    // 마커와 인포윈도우를 표시합니다
	    		    displayMarker(locPosition, message);
	    		        
	    		    
	    		    //alert(lat+"-"+lon);
	    		    
	    		    $.ajax({
	    		    	url : 'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=' + lon +'&y=' + lat,
	    		        type : 'GET',
	    		        headers : {
	    		          'Authorization' : 'KakaoAK 32245dd905f9d9b6d898ebe61795735c'
	    		        },
	    		        success : function(data) {
	    		        	// 구 주소 정보를 가진 배열 addr, 도로명 주소의 정보를 가진 배열 road_addr
	    		        	let addr = data;
	    		        	let road_addr = data;
	    		          	console.log(addr);
	    		          	$("#user_addr").html("현재 위치는 "+addr.documents[0].address_name+"입니다");
	    		        },
	    		        error : function(e) {
	    		          console.log(e);
	    		        }
	    		      });
	    		        
	    		  });
	    		
	    		
	    		
	    		} else { 
	    		
	    			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),//geolocation을 사용할수 없을때 기본 좌표
	    		    message = 'geolocation을 사용할수 없어요..'
	    		    
	    			displayMarker(locPosition, message);
	    		}
	    		
	    		//지도에 마커와 인포윈도우를 표시하는 함수입니다
	    		function displayMarker(locPosition, message) {
	    		
	    		// 마커를 생성합니다
	    		var marker = new kakao.maps.Marker({  
	    		    map: map, 
	    		    position: locPosition
	    		}); 
	    		
	    		var iwContent = message, // 인포윈도우에 표시할 내용
	    		    iwRemoveable = true;
	    		
	    		// 인포윈도우를 생성합니다
	    		var infowindow = new kakao.maps.InfoWindow({
	    		    content : iwContent,
	    		    removable : iwRemoveable
	    		});
	    		
	    		// 인포윈도우를 마커위에 표시합니다 
	    		//infowindow.open(map, marker);
	    		
	    		// 지도 중심좌표를 접속위치로 변경합니다
	    		map.setCenter(locPosition);      
	    		} 
    		}
    		</script>
				
			</div>
		</div>
		
		<div id="footer" class="border-top" style="box-sizing: border-box; width:100vw; padding:1rem 0;">
			<div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_home.png"></div><!--  
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_comm.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_chat.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;" onclick="location.href='userInfoView.do';"><img src="${ path }/images/icon_my.png"></div><!--
			--><div class="ft-icon text-center" style="width:20vw; display:inline-block;"><img src="${ path }/images/icon_quick.png"></div>
		</div>
		
	</div>
</body>
</html>
