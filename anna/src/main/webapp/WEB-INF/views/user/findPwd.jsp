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
	let email_auth_key = "";
	$(function(){
		let email = $("input[name=user_email]");
		email.keyup(function(e){
			if(e.keyCode != 13){
				if(email.val() != ""){
					$.ajax({
						url : "checkEmailForFindPwd.do",
						data : "user_email="+email.val(),
						success : function(result){
							if(result > 0){
								$("#btn_send_random_pwd").prop("disabled",false);
								$("#msg_email_chk").html("이메일 전송 버튼을 눌러<br> 이메일 인증을 진행해 주세요.");
							}else{
								$("#btn_send_random_pwd").prop("disabled",true);
								$("#msg_email_chk").html("가입되지 않은 이메일 주소 입니다.");
							}
						}
					});
				}else{
					$("#btn_send_random_pwd").prop("disabled",true);
					$("#msg_email_chk").html("가입시 입력하신 이메일 주소를<br> 입력해 주세요.");
				}
			}else{
				if(!$("#btn_send_random_pwd").prop("disabled")){
					sendRandomPwdEmail();
				}
			}
		});
	});
	
	function sendRandomPwdEmail(){
		let user_email = $("input[name=user_email]").val();
		alert("인증 이메일을 전송합니다.\n확인 후 인증번호를 입력해 주세요.");
		$("input[name=user_email]").prop("disabled",true); 
		$("#btn_send_random_pwd").html("인증메일 재전송");
		$(".Auth").css("display","table");
		$.ajax({
			url : "sendAuthEmail.do",
			data : "user_email="+user_email,
			success : function(auth_key){
				email_auth_key = auth_key;
			}
		});
	}
	
	function check_auth_key(){
		let email_auth = $("input[name=email_auth]").val();
		
		let email = $("input[name=user_email]").val();
		
		if(email_auth == email_auth_key){
			alert("인증이 완료되었습니다.\n 임시 비밀번호를 인증하신 이메일주소로 전송합니다.\n로그인하신 후 비밀번호를 반드시 변경해 주세요.");
			$.ajax({
				url : "sendRandomPwd.do",
				data : "user_email="+email,
				success : function(randompwd){
					location.href="login.do";
					//console.log(randompwd);
				}
			});
		}else{
			alert("인증번호가 일치하지 않습니다.");
		}
	}
</script>
</head>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
		<div class="wrapper">
			<div class="container main">
				<h3 class="border-bottom" style="padding:1rem;">비밀번호 찾기</h3>
				<div class="table" style="width:340px; padding:10px; border:1px solid #ddd; border-radius:10px; margin:auto; margin-top:20px;">
					<div class="tr row" style="display:flex; align-items:center;">
						<div class="td col-12"><input class="form-control" type="email" name="user_email" placeholder="이메일"></div>
					</div>
					<div class="tr row">
						<div id="msg_email_chk" class="td col-12 text-end">가입시 입력하신 이메일 주소를<br> 입력해 주세요.</div>
					</div>
					<div class="tr row">
						<div class="td col-12 text-end"><button class="btn" id="btn_send_random_pwd" type="button" disabled style="background:#00AAB2; color:#fff;" onclick="sendRandomPwdEmail()">인증메일 전송</button></div>
					</div>
					<div class="tr Auth" style="display:none;">
						<div class="td col-12"><input class="form-control" type="number" name="email_auth" placeholder="인증번호를 입력해 주세요."></div>
					</div>
					<div class="tr Auth text-end" style="display:none;">
						<div class="td col-12"><button type="button" class="btn" style="background:#00AAB2; color:#fff;" onclick="check_auth_key()">인증하기</button></div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		
	</div>
</body>
</html>
