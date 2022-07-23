<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/1.1.0/proj4js-combined.min.js"></script>
<script>
Proj4js.reportError = function(msg) { alert(msg); }
Proj4js.defs['GRS80'] = '+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs';
Proj4js.defs['WGS84'] ='+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs';

var GRS80 = new Proj4js.Proj('GRS80');
var WGS84 = new Proj4js.Proj('WGS84');

$(function(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 7 // 지도의 확대 레벨
	};
	
	//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption),customOverlay = new kakao.maps.CustomOverlay({}); 
	
		$.ajax({
			url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
			data : "consumer_key=9ff16331dfd542b6a5b0&consumer_secret=32b9d18070d34db18be5",
			success : function(getToken){
				let AccessToken = getToken.result.accessToken;
				<c:forEach var="i" items="${ selectedDong }">
				console.log("${ i }");
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
								
								let result = {
									name : geojson.features[0].properties.adm_nm ,
									path : resultPolygon
								};
								
								var polygon = new kakao.maps.Polygon({
									map: map,
								    path: [result.path], // 좌표 배열의 배열로 하나의 다각형을 표시할 수 있습니다
								    strokeWeight: 2,
								    strokeColor: '#b26bb2',
								    strokeOpacity: 0.8,
								    fillColor: '#f9f',
								    fillOpacity: 0.4
								});
								
								map.setCenter(new kakao.maps.LatLng(centerP.y, centerP.x));
								
								var customOverlay = new kakao.maps.CustomOverlay({
								    map: map,
								    clickable: false,
								    content: '<div>' + result.name + '</div>',
								    position: new kakao.maps.LatLng(centerP.y, centerP.x),
								    xAnchor: 0.5,
								    yAnchor: 1,
								    zIndex: 3
								});

								
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
								    strokeColor: '#b26bb2',
								    strokeOpacity: 0.8,
								    fillColor: '#f9f',
								    fillOpacity: 0.4
								});
								
							}
						}
					});
				</c:forEach>
			}
		});
	});
</script>
</head>
<body>
	<div id="map" style="width:500px; height:500px;"></div>
</body>
</html>