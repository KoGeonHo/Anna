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

.td {
	font-size:0.9rem;
}

</style>
<script>

$(function(){
	$("#input_pwd_chk").keyup(function(e){
		let password = $(this).val();
		if(e.keyCode != 13){
			if(password != ""){
				$.ajax({
					url : "passcheck.do",
					data : "password="+password,
					success : function(result){
						if(result == "correct"){
							$("#pwd_chk_msg").html("비밀번호 일치");
							$("#btn_pwd_chk").prop("disabled",false);
						}else{
							$("#pwd_chk_msg").html("비밀번호 불일치");
							$("#btn_pwd_chk").prop("disabled",true);
						}
					}
				});
			}else{
				$("#pwd_chk_msg").html("");
				$("#btn_pwd_chk").prop("disabled",true);
			}
		}else{
			if($("#btn_pwd_chk").prop("disabled")){
				alert("비밀번호가 일치하지 않습니다.");
			}else{
				console.log("비밀번호 일치");
				location.href="changePwd.do";
			}
		}
	});
});


function openModal(){
	$("#modal_pwd_chk").fadeIn();
}

function closeModal(){
	$("#pwd_chk_msg").html("");
	$("input[name=chkPwd]").val("");
	$("#btn_pwd_chk").prop("disabled",true);
	$("#modal_pwd_chk").fadeOut();
}

function userWithdrawal(){
	if(confirm("정말 회원 탈퇴 하시겠습니까?")){
		alert('준비중입니다.');
	}
}

</script>
</head>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
		<div class="wrapper main">
			<div class="container">
				<h3 class="border-bottom" style="padding:1rem;">회원정보</h3>
				<div id="profile" class="border-bottom" style="width:100%; display:flex;">
					<div style="border-radius:100px; margin:20px; width:80px; height:80px; background:url('${userInfo.profile_image}'),url('${path}/images/NoProfile.png'); background-position: center; background-repeat: no-repeat; background-size: cover;"></div>
					<div style="display:inline-block; flex:1; display:flex; align-items:center;">
						<div>
							${ userInfo.nickName }님의 프로필
						</div>
					</div>
				</div>
				<div class="row border-bottom">
					<div class="col-3 text-center th" style="padding:1rem;">닉네임</div>
					<div class="col-9 td" style="padding:1rem;">${ userInfo.nickName }</div>
				</div>
				<div class="row border-bottom">
					<div class="col-3 text-center th" style="padding:1rem;">이메일</div>
					<div class="col-9 td" style="padding:1rem;">${ userInfo.user_email }</div>
				</div>
				<div class="row border-bottom">
					<div class="col-3 text-center th" style="padding:1rem;">내동네</div>
					<div class="col-9 td" style="padding:1rem; align-self:center;" id="locaList">
						
						<c:if test="${ empty userInfo.location_auth }">
							-
						</c:if>
						<c:if test="${ not empty userInfo.location_auth }">
							<div class="spinner-border text-primary" role="status">
								<span class="visually-hidden">Loading...</span>
							</div>
							<script>
								locationList = [${userInfo.location_auth}];
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
									},
									error: function(){
										console.log("error");
									}
								});
							</script>
						</c:if>
					</div>
				</div>
				<div class="row border-bottom tr">
					<div class="col-3 text-center th" style="padding:1rem;">소개글</div>
					<div class="col-9 td" style="padding:1rem;">
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
					<div class="col-9 td" style="padding:1rem;">
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
						<button class="btn" style="background:#00AAB2; color:#fff;" onclick="location.href='${path}/user/userInfoMod.do';">회원정보 수정</button>
						<c:if test="${ empty userInfo.kakao_auth }">
							<button id="btn_pwd_cng" class="btn" style="background:#BBCE53; color:#fff;" onclick="openModal()">비밀번호 변경</button>
						</c:if>
						<button class="btn" style="background:#00AAB2; color:#fff;" onclick="userWithdrawal()">회원탈퇴</button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="modal_pwd_chk" style="display:none; position:absolute;">
			<div style="width:100vw; height:100vh; background:rgba(0,0,0,0.5); display:flex; align-items:center; margin:auto;" >
				<div style="padding:20px; margin:auto; background:#fff; border-radius:10px;">
					<div class="border-bottom">
						<h5><b>비밀번호 변경</b></h5>
					</div>
					<div class="text-end" style="padding:10px;">
						<p style="padding:5px; margin:0px;">본인확인을 위해 비밀번호를<br> 입력해주세요.</p>
						<input id="input_pwd_chk" class="form-control" type='password' name="chkPwd" placeholder="비밀번호">
					</div>
					<div id="pwd_chk_msg" class="text-end" style="padding:10px;">
						
					</div>
					<div class="text-end" style="padding:10px;">
						<button id="btn_pwd_chk" class="btn" style="background:#00AAB2; color:#fff;" disabled onclick="location.href='changePwd.do'">비밀번호 확인</button>
						<button class="btn" style="background:#00AAB2; color:#fff;" onclick="closeModal()">닫기</button>
					</div>
				</div>
		</div>
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		
	</div>
</body>
</html>
