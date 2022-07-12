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
		padding:0px;
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
		width:200px;
		margin:0 5px;
	}
	
	.table-th {
		border-right : 1px solid #555;
		text-align:center;
	}
	
	h3 {
		padding:10px;
	}
</style>
</head>
<body>
	<div class="container">
		<div> 
			<h3 class="border-bottom">회원가입</h3>
			<form method="POST" action="joinS2.do">
				<input type='hidden' id="emailChecked">
				<div class="row">
					<div class="col-12">
						<table>
							<tbody>
								<tr>
									<th>이메일</th>
									<td><input class="form-control" type="email" name="user_email" required autofocus><button type="button" class="btn btn-primary" onclick="emailChk()">이메일 확인</button></td>
								</tr>
								<tr>
									<th>닉네임</th>
									<td><input class="form-control" type="text" name="nickName" required autofocus></td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input class="form-control" type="password" name="user_pwd" required autofocus></td>
								</tr>
								<tr>
									<th>비밀번호확인</th>
									<td><input class="form-control" type="password" name="pwdChk" required autofocus></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="2" class="text-end">
										<button class="btn btn-primary">가입하기</button>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>	
</body>
</html>
