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
<script src="${ path }/js/common/common.js"></script>
<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=7b9a8af3d576479db243'></script>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />

<script>
	$(function(){
		
		$.ajax({
			url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
			data : "consumer_key=7b9a8af3d576479db243&consumer_secret=02e72ab8a0e046f9bf95",
			success : function(data){
				if(navigator.geolocation){
					navigator.geolocation.getCurrentPosition(function(position){
						
						let utmkXY = new sop.LatLng(position.coords.latitude, position.coords.longitude);
						
						console.log("x:"+utmkXY.x);
						
						console.log("y:"+utmkXY.y);
						
						$.ajax({
	    	    			url : "https://sgisapi.kostat.go.kr/OpenAPI3/personal/findcodeinsmallarea.json",
	    	    			data : "accessToken="+data.result.accessToken+"&x_coor="+utmkXY.x+"&y_coor="+utmkXY.y,
	    	    			success : function(data2){
	    	    				console.log(data2);
	    	    				$("#dongList").append("<div class='text-center border-bottom border-top' style='padding:1rem;'>현위치는 <b>"+data2.result.sido_nm+" "+data2.result.sgg_nm+"</b>입입니다.</div>");
	    	    				$.ajax({
	    	    					url : "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json",
	    	    					data : "accessToken="+data.result.accessToken+"&pg_yn=0&cd="+data2.result.sido_cd+data2.result.sgg_cd,
	    	    					success : function(data3){
	    	    						for(let i = 0; i < data3.result.length; i++){
	    	    							$("#dongList").append("<div class='border-bottom'><input onclick='chkCnt(this)' style='margin: 1rem;' name='dong' type='checkbox' id='chk"+i+"' value="+data3.result[i].cd+"><label for='chk"+i+"'>"+data3.result[i].full_addr+"</label></div>");
	    	    						}
	    	    						$("#loading").fadeOut();
	    	    					}
	    	    				});
	    	    			}
	    	    		});
					})
				}
				
			}
		});
	});
	
	function chkChkBox(){
		var items = [];
		if($('input[name=dong]:checked').length == 0){
			alert("최소 한개 이상의 항목을 선택해주세요.");
			return false;
		}else{
			$('input[name=dong]:checked').each(function () {
			    items.push($(this).val());
			});
		}
		$("#locationFrm").submit();
		
	}
	
	function chkCnt(chkbox){
		if($('input[name=dong]:checked').length > 5){
			alert("최대 5개까지만 선택 가능합니다.");
			chkbox.checked = false;
		}
	}
	
	
</script>
</head>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
		<div id="loading" style="width:100%; height:100%; background:#000; position:relative; color:white; line-height:100%;" class="text-center">
			<div style="line-height:500px;">
			<span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
  			Loading...
  			</div>
		</div>
		
		<div class="container main" style="flex:1; overflow:auto;">
			<h3 class="border-bottom" style="padding:1rem; margin:0px;">동네설정</h3>
			<form id="locationFrm" action="locationView.do">
				<div class='text-center' style='padding:1rem;'>거래를 원하시는 동네를 선택해주세요.</div>
				<div id="dongList">
				</div>
			</form>
			<div class="text-end"><button class="btn btn1" style="background:#00AAB2; color:#fff; margin:5px 0;" type="button" onclick="chkChkBox()">확인</button></div>
			<div class="text-end"><button class="btn btn1" style="background:#00AAB2; color:#fff; margin:5px 0;" type="button" onclick="location.href='userInfoView.do'">돌아가기</button></div>
		</div>
		
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		
	</div>
</body>
</html>
