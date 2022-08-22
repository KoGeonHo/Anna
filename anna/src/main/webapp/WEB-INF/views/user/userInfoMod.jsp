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
<script src="${ path }/js/common/common.js"></script>
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
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


form {
	margin-block-end: 0px;
}


@media all and (max-width:  767px){
	
	#input-interested {
		width:40vw;
	}
	
}

@media all and (min-width :768px){
	
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

.profile-image{
	width:5rem;
	height:5rem;
	margin:1rem;
}

.th {
	background:#eee;
}

</style>
<script>

	let keyword = "${ userInfo.interested }";
	let arr = keyword.split(',');
	$(function(){
		
		let html = "";
		if(keyword != ""){
			for(let i = 0; i < arr.length; i++){
				html += arr[i]+"<span onclick='delKeyword(\""+arr[i]+"\");'>삭제</span><br>";
			}
	
			$("#interest_keywords").html(html);
			
		}else{
			
			$("#interest_keywords").html("등록된 관심키워드가 없습니다.");
			
		}
		
		$("#input-interested").on("keyup",function(e){
			if(e.keyCode == 13){
				addInterested();
			}
		});
		
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
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
		<div class="wrapper">
			<div class="container  main">
				<h3 class="border-bottom" style="padding:1rem;">회원정보수정</h3>
				<form id="userInfoModFrm" method="POST" action="userInfoMod.do">
					<div id="profile" class="border-bottom" style="width:100%;">
						<div style="display:inline-block;"><img class="profile-image" onerror="this.onerror=null; this.src='${path}/images/NoProfile.png';" style="border-radius:100px;"  src="${ userInfo.profile_image }"></div>
						<div style="display:inline-block;">
							<div>
								<b>${ userInfo.nickName }</b>님의 프로필
							</div>
						</div>
					</div>
					<div class="row border-bottom" style="display:table; width:100%;">
						<div class="col-3 text-center th" style="padding:1rem; display:table-cell; width:25%;">닉네임</div>
						<div class="col-9" style="padding:1rem; align-self:center; display:table-cell; width:auto;"><input type="text" class="form-control" id="input-nickName" name="nickName" value="${ userInfo.nickName }"></div>
					</div>
					<div class="row border-bottom">
						<div class="col-3 text-center th" style="padding:1rem;">이메일</div>
						<div class="col-9" style="padding:1rem;">${ userInfo.user_email }</div>
					</div>
					<div class="row border-bottom">
						<div class="col-3 text-center th" style="padding:1rem;">내동네</div>
						<div class="col-9" style="padding:1rem; align-self:center;" id="locaList">
							<c:if test="${ empty userInfo.location_auth }">
								<button class="btn" style="background:#00AAB2; color:#fff;" onclick="location.href='locationAuth.do';">동네 등록하기</button>
							</c:if>
							<c:if test="${ not empty userInfo.location_auth }">
								<div class="spinner-border text-primary" role="status">
									<span class="visually-hidden">Loading...</span>
								</div>
								<script>
									
									$.ajax({
										url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
										data : "consumer_key=7b9a8af3d576479db243&consumer_secret=02e72ab8a0e046f9bf95",
										success : function(data){
											$(".spinner-border").css("display","none");
											for(let i = 0; i < locationList.length; i++){
												$.ajax({
													url : "https://sgisapi.kostat.go.kr/OpenAPI3/boundary/hadmarea.geojson",
													async : false,
													data : "accessToken="+data.result.accessToken+"&year=2021&adm_cd="+locationList[i]+"&low_search=0",
													success : function(geojson){
														$("#locaList").append(geojson.features[0].properties.adm_nm+"<br>");
													}
												});
											}
											$("#locaList").append("<button class='btn' type='button' style='background:#00AAB2;  color:#fff;' onclick=\"location.href='locationAuth.do';\">동네 다시 등록하기</button>");
										},
										error: function(){
											console.log("error");
										}
									});
								</script>
							</c:if>
						</div>
					</div>
					<div class="row border-bottom">
						<div class="col-3 text-center th" style="padding:1rem;">소개글</div>
						<div class="col-9">
							<textarea class="form-control" name="introduce" style="margin:5px 0; resize:none;" rows="5">${ userInfo.introduce }</textarea>
						</div>
					</div>
				</form>
				<div class="row border-bottom">
					<div class="col-3 text-center th" style="padding:1rem; min-width:4rem;">관심<br>키워드</div>
					<div class="col-9" style="padding:1rem; margin:5px 0;">
						<input type="text" class="form-control" id="input-interested" autocomplete="off" style="display:inline-block;" name="interested">
						<button class="btn" type="button" style="display:inline-block; background-color: #00AAB2; color: #fff;" onclick="addInterested()">추가</button>
						<div id="interest_keywords">
						</div>
					</div>
				</div>
				<div style="padding:5px 0;">
					<div class="text-end">
						<button class="btn" style="background:#00AAB2; color:#fff;" type="button" onclick="frmSubmit()">수정</button>
						<button class="btn" style="background:#BBCE53; color:#fff;" type="button" onclick="javascript:location.href='userInfoView.do';">돌아가기</button>
					</div>
				</div>
			</div>
		</div>
		
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		
	</div>
</body>
</html>
