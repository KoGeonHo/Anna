<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">

<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/1.1.0/proj4js-combined.min.js"></script>

<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/mfb.css" rel="stylesheet">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 
<script>


Proj4js.reportError = function(msg) { alert(msg); }
Proj4js.defs['GRS80'] = '+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs';
Proj4js.defs['WGS84'] ='+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs';

var GRS80 = new Proj4js.Proj('GRS80');
var WGS84 = new Proj4js.Proj('WGS84');

let locationList = [];

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
</head>
<body>
	<div class="wrapper">
		
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="wrapper main">
			<div class="container">
				<div id="map" style="width:100%; height:350px;"></div>
				<div>
					<form method="POST" action="updateLocation.do" id="locationFrm">
						<input type='hidden' name="selectedLocation" value="<c:forEach var="i" items="${ selectedDong }" varStatus="status">${i}<c:if test="${ not status.last }">,</c:if></c:forEach>">
					</form>
					<span style="display:block;">선택한 동네는 </span>
					<span id="location"> </span>
					<span>입니다. </span>
				</div>
				<div class="text-end">
					<button class="btn" style="background:#00AAB2; color:#fff;" onclick="javascript:$('#locationFrm').submit();">선택완료</button>
					<button class="btn" style="background:#00AAB2; color:#fff;" onclick="location.href='locationAuth.do'">다시선택하기</button>
				</div>
				
				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = { 
					    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					    level: 7 // 지도의 확대 레벨
					};
					
					//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
					var map = new kakao.maps.Map(mapContainer, mapOption),customOverlay = new kakao.maps.CustomOverlay({}); 
					
						$.ajax({
							url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
							data : "consumer_key=7b9a8af3d576479db243&consumer_secret=02e72ab8a0e046f9bf95",
							success : function(getToken){
								let AccessToken = getToken.result.accessToken;
								<c:forEach var="i" items="${ selectedDong }">
								//console.log("${ i } : ???");
									$.ajax({
										url : "https://sgisapi.kostat.go.kr/OpenAPI3/boundary/hadmarea.geojson",
										async : false,
										data : "accessToken="+AccessToken+"&year=2021&adm_cd=${ i }&low_search=0",
										success : function(geojson){
											let coordinates = geojson.features[0].geometry.coordinates;
											if(geojson.features[0].geometry.type == "Polygon"){
												let arr = coordinates[0];
												let resultPolygon = [];
												for(let i = 0; i < arr.length; i++){
													var p = new Proj4js.Point(arr[i][0],arr[i][1]);
													Proj4js.transform(GRS80, WGS84, p);
													resultPolygon.push(new kakao.maps.LatLng(p.y,p.x));
												}
												var centerP = new Proj4js.Point(geojson.features[0].properties.x,geojson.features[0].properties.y);
												Proj4js.transform(GRS80, WGS84, centerP);
												//console.log(centerP.x);
												//console.log(centerP.y);
												
												
												
												var polygon = new kakao.maps.Polygon({
													map: map,
												    path: [resultPolygon], // 좌표 배열의 배열로 하나의 다각형을 표시할 수 있습니다
												    strokeWeight: 2,
												    strokeColor: '#00AAB3',
												    strokeOpacity: 0.8,
												    fillColor: '#00AAB3',
												    fillOpacity: 0.4
												});
												
												//console.log(map);
												map.setCenter(new kakao.maps.LatLng(centerP.y, centerP.x));
												
												locationList.push([geojson.features[0].properties.adm_nm,centerP.y,centerP.x]);
												/* var customOverlay = new kakao.maps.CustomOverlay({
												    map: map,
												    clickable: false,
												    content: '<div>' + result.name + '</div>',
												    position: new kakao.maps.LatLng(centerP.y, centerP.x),
												    xAnchor: 0.5,
												    yAnchor: 1,
												    zIndex: 3
												}); */
			
												
											}else if(geojson.features[0].geometry.type == "MultiPolygon"){
												let resultPolygon = [];
												for(let i = 0; i < coordinates.length; i++){
													let arr = coordinates[i][0];
													let PolygonItem = [];
													for(let j = 0; j < arr.length;j++){
														//console.log("x:"+arr[j][0]+",y:"+arr[j][1]);
														var p = new Proj4js.Point(arr[j][0],arr[j][1]);
														Proj4js.transform(GRS80, WGS84, p);
														PolygonItem.push(new kakao.maps.LatLng(p.y,p.x));
													}
													resultPolygon.push(PolygonItem);
												}
												//console.log(resultPolygon);
												var polygon = new kakao.maps.Polygon({
													map: map,
												    path: [resultPolygon[0],resultPolygon[1]], // 좌표 배열의 배열로 하나의 다각형을 표시할 수 있습니다
												    strokeWeight: 2,
												    strokeColor: '#00AAB3',
												    strokeOpacity: 0.8,
												    fillColor: '#00AAB3',
												    fillOpacity: 0.4
												});
												
												var centerP = new Proj4js.Point(geojson.features[0].properties.x,geojson.features[0].properties.y);
												Proj4js.transform(GRS80, WGS84, centerP);
												
												map.setCenter(new kakao.maps.LatLng(centerP.y, centerP.x));
												
												locationList.push([geojson.features[0].properties.adm_nm,centerP.y,centerP.x]);
												
											}
										}
									});
								</c:forEach>
								console.log(locationList.length);
								for(let i = 0; i < locationList.length; i++){
									$("#location").append("<div style='cursor:pointer; margin:1rem;' onmouseover='setMapCenter("+locationList[i][1]+","+locationList[i][2]+");'>"+locationList[i][0]+"</div>");
								}
							}
						});
						
						function setMapCenter(x,y){
							map.setCenter(new kakao.maps.LatLng(x, y));
						}
				</script>
			</div>
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->	
	</div>
</body>
</html>

