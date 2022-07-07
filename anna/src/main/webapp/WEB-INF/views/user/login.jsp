<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Signin Template for Bootstrap</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<link href="<%=request.getContextPath()%>/css/login.css" rel="stylesheet">
</head>
<body>

	<div class="wrapper">
		<div class="container">
			<div class="box">
				<form>
					<h2 class="form-signin-heading">로그인</h2>
					<label for="inputEmail" class="sr-only">이메일</label> 
						<input type="email" id="inputEmail" class="form-control" placeholder="이메일" required autofocus>
					<label for="inputPassword" class="sr-only">비밀번호</label> 
					<input type="password" id="inputPassword" class="form-control" placeholder="비밀번호" required>
					<div class="row find-join">
						<div class="col-8">아이디/비밀번호 찾기</div>
						<div class="col-4 text-align-right">회원가입</div>
					</div>
					<div class="loginBtn">
						<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
					</div>
					<div class="kakaoLoginBtn">
						<button class="btn btn-lg btn-primary btn-block" type="submit">카카오로그인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	 

	
</body>
</html>
