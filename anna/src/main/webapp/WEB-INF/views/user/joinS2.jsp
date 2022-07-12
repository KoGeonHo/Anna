<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>안녕? 나야!</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<script>

	$(function(){
		let user_pwd = $("input[name=user_pwd]");
		let pwdChk = $("input[name=pwdChk]");
		
		$("input[name=user_email]").keyup(function(){
			$("#emailChecked").val(0);
		});
		
		$("#joinFrm").submit(function(){
			let emailChecked = $("#emailChecked");
			alert(emailChecked.val());
			if(emailChecked.val() != 1){
				alert("이메일을 확인해 주세요!");
				return false;
			}
		});
		
		user_pwd.keyup(function(){
			if(user_pwd.val() != "" && pwdChk.val() != ""){
				pwd_chk(user_pwd.val(),pwdChk.val());
			}
		});
		
		pwdChk.keyup(function(){
			if(user_pwd.val() != "" && pwdChk.val() != ""){
				pwd_chk(user_pwd.val(),pwdChk.val());
			}
		});
		
	});
	
	function pwd_chk(pwd1,pwd2){
		if(pwd1 == pwd2){
			$("#pwdMsg").html("<span style='color:#0d6efd;'>비밀번호가 일치합니다.</span>");
		}else{
			$("#pwdMsg").html("<span style='color:#dc3545;'>비밀번호가 일치하지 않습니다.</span>");
		}
	}
	
	function emailChk(){
		let email = $("input[name=user_email]");
		
		if(email.val() == ""){
			alert("이메일을 입력해주세요");
			email.focus();
		} else {
			let reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			if(!reg_email.test(email.val())) {                            
				alert("올바르지 않은 이메일 형식입니다.");
				email.focus(); 
			} else {                       
				$.ajax({
					url : "emailChk.do",
					data : "user_email="+email.val(),
					success : function(result){
						if(result.trim() == 1){
							alert("이미 사용중인 이메일 입니다.");
							email.val("");
							email.focus();
						}else{
							alert("사용가능한 이메일 주소입니다.");
							$("#emailChecked").val(1);
						}
					}
				});       
			} 
		}
	}
	
</script>
<style>

	html, body, .wrapper {
		width:100%;
		height:100%;
		padding:0px;
		margin:0px;
	}
	.row {
		margin:0px;
		padding:5px;
	}
	
	.box {
		margin:auto;
		border-radius:10px;
		padding:20px;
		color:white;
		background:#555;
	}
	textarea {
		resize:none;
	}
	
	.text-align-right {
		text-align:right;
	}
	
	.form-control {
		display:inline-block;
		width:250px;
		margin:0 5px;
	}
	
	.table-th {
		border-right : 1px solid #555;
		text-align:center;
	}
	
	h3 {
		padding:10px;
	}
	
	#pwdMsg {
		display:inline-block;
	}
</style>
</head>
<body>
	<div class="container">
		<div> 
			<h3 class="border-bottom">회원가입</h3>
			<form id="joinFrm" method="POST" action="joinS2.do">
				<input type='hidden' id="emailChecked" value="0">
				<input type='hidden' id="pwdChecked" value="0">
				<div class="row">
					<div class="col-lg-2"></div>
					<div class="col-lg-8 col-md-12 box">
						<div class="row ">
							<div class="col-md-2 text-center align-self-center"><span class="">이메일</span></div>
							<div class="col-md-10"><input class="form-control" type="email" name="user_email" required autofocus><button type="button" class="btn btn-primary" onclick="emailChk()">이메일 확인</button></div>
						</div>
						<div class="row">
							<div class="col-md-2 text-center align-self-center">닉네임</div>
							<div class="col-md-10"><input class="form-control" type="text" name="nickName" required autofocus></div>
						</div>
						<div class="row">
							<div class="col-md-2 text-center align-self-center">비밀번호</div>
							<div class="col-md-10"><input class="form-control" type="password" name="user_pwd" required autofocus><div id="pwdMsg"></div></div>
						</div>
						<div class="row">
							<div class="col-md-2 text-center align-self-center">비밀번호 확인</div>
							<div class="col-md-10"><input class="form-control" type="password" name="pwdChk" required autofocus></div>
						</div>
						<div class="row">
							<div colspan="2" class="text-end">
								<button type="submit" class="btn btn-primary">가입하기</button>
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
			</form>
		</div>
	</div>	
</body>
</html>
