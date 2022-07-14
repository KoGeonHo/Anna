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
	let EmailAuthKey = '';
	$(function(){
		let user_pwd = $("input[name=user_pwd]");
		let pwdChk = $("input[name=pwdChk]");
		
		$("input[name=user_email]").keyup(function(){
			$("#emailChecked").val(0);
		});
		
		$("#joinFrm").submit(function(){
			let emailChecked = $("#emailChecked");
			let pwdChecked = $("#pwdChecked");
			let mailAuthChk = $("#mailAuthChk");
			if(emailChecked.val() != 1){
				alert("이메일을 확인해 주세요.");
				return false;
			}else if($("#pwdChecked").val() != 1){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}else if($("#mailAuthChk").val() != 1){
				alert("메일 인증 절차를 진행해주세요.");
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
			$("#pwdChecked").val(1);
		}else{
			$("#pwdMsg").html("<span style='color:#dc3545;'>비밀번호가 일치하지 않습니다.</span>");
			$("#pwdChecked").val(0);
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
				$("#chkBtn").prop("disabled",true);
				$.ajax({
					url : "emailChk.do",
					data : "user_email="+email.val(),
					success : function(result){
						console.log(result.result);
						 if(result.result == 1){
							alert("이미 사용중인 이메일 입니다.");
							email.val("");
							email.focus();
							$("#chkBtn").prop("disabled",false);
						} else{
							alert("사용가능한 이메일 주소입니다.\n해당 이메일로 인증메일을 발송합니다.\n확인 후 인증번호를 입력해주세요.");
							$.ajax({
								url : "sendAuthEmail.do",
								data : "user_email="+email.val(),
								success : function(authKey){
									EmailAuthKey = authKey;
								}
							});
							$("#emailChecked").val(1);
							email.prop("readonly",true);
							$("#emailAuth").css("display","flex");
							$("#chkBtn").css("display","none");
							$("#authEmailBtn").css("display","inline-block");
						}
					}
				});       
			} 
		}
	}
	
	function sendAuthEmail(){
		let email = $("input[name=user_email]").val();
		if(confirm("인증 메일을 재전송 합니다.")){
			$.ajax({
				url : "sendAuthEmail.do",
				data : "user_email="+email,
				success : function(authKey){
					EmailAuthKey = authKey;
				}
			});
		}
	}
	
	function authOk(){
		if($("#authKey").val() == EmailAuthKey){
			alert("인증이 완료되었습니다.");
			$("#mailAuthChk").val(1);
			$("#emailAuth").css("display","none");
			$("#emailAuthMsg").css("display","flex");
			$("#authEmailBtn").prop("disabled",true);
		}else{
			alert("잘못된 인증번호 입니다.");
			$("#mailAuthChk").val(0);
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
	
	#emailAuth {
		display:none;
	}
	
	#emailAuthMsg {
		display:none;
	}
	
	#authEmailBtn {
		display:none;
	}
</style>
</head>
<body>
	<div class="container">
		<div> 
			<h3 class="border-bottom">회원가입</h3>
			<div class="col-12">
				<h3>이용약관</h3>
			</div> 
			<div class="col-12">
				<textarea class="" style="width:100%; height:300px;" readonly> </textarea>
			</div>
			<div class="text-align-right">
				<input type="checkbox" id="chkbox" value="1"> <label for="chkbox">약관에 동의 합니다.</label>
			</div>
			<div class="text-align-right">
				<button type="button" class="btn btn-primary" onclick="next()">다음</button>
			</div>
		</div>
			<form id="joinFrm" method="POST" action="joinS2.do">
				<input type='hidden' id="emailChecked" value="0">
				<input type='hidden' id="pwdChecked" value="0">
				<input type='hidden' id="mailAuthChk" value="0">
				<div class="row">
					<div class="col-lg-2"></div>
					<div class="col-lg-8 col-md-12 box">
						<div class="row">
							<div class="col-md-2 text-center align-self-center"><span>이메일</span></div>
							<div class="col-md-10"><input class="form-control" type="email" name="user_email" required autofocus>
								<button type="button" id="chkBtn" class="btn btn-primary" onclick="emailChk()">이메일 확인</button>
								<button type="button" id="authEmailBtn" class="btn btn-primary" onclick="sendAuthEmail()">인증번호 다시받기</button>
							</div>
						</div>
						<div class="row" id="emailAuth">
							<div class="col-md-2 text-center align-self-center"><span class="">이메일인증</span></div>
							<div class="col-md-10"><input class="form-control" type="text" id="authKey">
								<button type="button" class="btn btn-primary" onclick="authOk()">확인</button>
							</div>
						</div>
						<div class="row" id="emailAuthMsg">
							<div class="col-md-12 text-center align-self-center"><span class="">이메일인증이 완료되었습니다.</span></div>
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
							<div class="text-end">
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
