<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>안녕? 나야!</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<style>
	html, body, .wrapper {
		width:100%;
		height:100%;
		padding:0px;
		margin:0px;
	}
	
	.row {
		margin:0px;
		padding:0px;
	}
	
	.vcenter-item{
	    display: flex;
	    align-items: center;
	}
	
	.box {
		margin:auto;
		border-radius:10px;
		padding:20px;
		color:white;
		background:#555;
	}
	
	.loginBtn button, .kakaoLoginBtn button{
		width:100%;
		margin-top:5px;
	}
	
	.text-align-right {
		text-align:right;
		padding:0 3px;
	}
	
	.text-align-left {
		text-align:left;
		padding:0 5px;
	}
	
	.find-join {
		padding: 5px 0;
	}
	
</style>
</head>
<body>
	<div class="wrapper row vcenter-item">
		<div class="container row col-lg-12">
			<div class="col-lg-4"></div>
			<div class="col-lg-4 row">
				<form id="loginFrm" action="login.do">
					<div class="row col-12">
						<div class="col-lg-2 col-md-3 col-sm-1"></div>
						<div class="box col-lg-8 col-md-6 col-sm-10">
							<h2 class="form-signin-heading">로그인</h2>
							<label for="inputEmail" class="sr-only">이메일</label> 
							<input type="email" id="inputEmail" class="form-control" name="user_email" placeholder="이메일" required autofocus>
							<label for="inputPassword" class="sr-only">비밀번호</label> 
							<input type="password" id="inputPassword" class="form-control" name="user_pwd" placeholder="비밀번호" required>
							<div class="row find-join">
								<div class="col-8 text-align-left" >아이디/비밀번호 찾기</div>
								<div class="col-4 text-align-right"><span onclick="location.href='joinS1.do'">회원가입</span></div>
							</div>
							<div class="loginBtn">
								<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
							</div>
							<div class="kakaoLoginBtn">
								<button class="btn btn-lg btn-primary btn-block" type="button">카카오로그인</button>
							</div>
						</div>
						<div class="col-lg-2 col-md-3 col-sm-1"></div>
					</div>
				</form>
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
</body>
</html>
