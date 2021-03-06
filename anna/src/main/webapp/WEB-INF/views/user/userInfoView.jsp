<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<style>

@media all and (min-width :768px){

	#profile {
		padding:0 150px;
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
</head>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
		<div class="container main" style="flex:1; overflow:auto;">
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
				<div class="col-3 text-center th" style="padding:1rem;">닉네임</div>
				<div class="col-9" style="padding:1rem;">${ userInfo.nickName }</div>
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
							let locationList = [${ userInfo.location_auth }];
								$.ajax({
									url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
									data : "consumer_key=9ff16331dfd542b6a5b0&consumer_secret=32b9d18070d34db18be5",
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
				<div class="col-9" style="padding:1rem;">
					<c:if test="${ not empty userInfo.introduce }">
					<% pageContext.setAttribute("newLineChar", "\n"); %>
					${fn:replace(userInfo.introduce, newLineChar, "<br/>")}
					</c:if>
					<c:if test="${ empty userInfo.introduce }">
						-
					</c:if>
				</div>
			</div>
			<div class="row border-bottom">
				<div class="col-3 text-center th" style="padding:1rem; min-width:4rem;">관심사</div>
				<div class="col-9" style="padding:1rem;">
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
		
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		
	</div>
</body>
</html>
