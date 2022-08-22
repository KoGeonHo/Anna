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
		let email = $("input[name=user_email]");
		email.keyup(function(e){
			if(e.keyCode != 13){
				if(email.val() != ""){
					$.ajax({
						url : "checkEmailForFindPwd.do",
						data : "user_email="+email.val(),
						success : function(data){
							console.log(data);
						}
					});
				}else{
					
				}
			}
		});
	});
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
						<div class="td col-12 text-end">가입시 입력하신 이메일 주소를<br> 입력해 주세요.</div>
					</div>
					<div class="tr row">
						<div class="td col-12 text-end"><button class="btn"  type="button" disabled style="background:#00AAB2; color:#fff;">인증메일 전송</button></div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		
	</div>
</body>
</html>
