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
			<h3 class="border-bottom">이메일인증</h3>
			<div class="row">
				<div class="col-lg-2"></div>
				<div class="col-lg-8 col-md-12 box">
					<div class="row ">
						<div class="col-md-2 text-center align-self-center"><span class="">인증번호</span></div>
						<div class="col-md-10"><input class="form-control" type="email" name="user_email" required autofocus><button type="button" class="btn btn-primary" onclick="emailChk()">이메일 확인</button></div>
					</div>
					<div class="row">
						<div class="text-end">
							<button type="submit" class="btn btn-primary">가입하기</button>
						</div>
					</div>
				</div>
				<div class="col-lg-2"></div>
			</div>
		</div>
	</div>	
</body>
</html>
