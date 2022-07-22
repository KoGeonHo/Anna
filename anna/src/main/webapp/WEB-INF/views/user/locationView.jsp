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
<script>
$(function(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	
	//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		$.ajax({
			url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
			data : "consumer_key=9ff16331dfd542b6a5b0&consumer_secret=32b9d18070d34db18be5",
			success : function(getToken){
				console.log(getToken.result.accessToken);
				let AccessToken = getToken.result.accessToken;
					<c:forEach var="i" items="${ selectedDong }">
						console.log(${ i });
						$.ajax({
							url : "https://sgisapi.kostat.go.kr/OpenAPI3/boundary/hadmarea.geojson",
							async : false,
							data : "accessToken="+AccessToken+"&year=2021&adm_cd=${ i }&low_search=0",
							success : function(geojson){
								//console.log(geojson.errMsg);
								//console.log(geojson.features[0].geometry.coordinates[0].length);
								let coordinates = geojson.features[0].geometry.coordinates;
								console.log(geojson.features[0].geometry.type);
								if(geojson.features[0].geometry.type == "Polygon"){
									let arr = coordinates[0]
									for(let i = 0; i < arr.length; i++){
										console.log("x:"+arr[i][0]+",y:"+arr[i][1]);
									}
								}else if(geojson.features[0].geometry.type == "MultiPolygon"){
									//console.log(coordinates[0][0].length+":len1");
									//console.log(coordinates[1][0].length+":len2");
									for(let i = 0; i < coordinates.length; i++){
										let arr = coordinates[i][0];
										//console.log(coordinates[0][0].length);
										//console.log(coordinates[1][0].length);
										for(let j = 0; j < arr.length;j++){
											//console.log("?");
											console.log("x:"+arr[j][0]+",y:"+arr[j][1]);
										}
										console.log("multi-------------------------------------------------");
									}
								}
								
								console.log("-------------------------------------------------");
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