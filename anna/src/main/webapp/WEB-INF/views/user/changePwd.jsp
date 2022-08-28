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
		$(".form-control").keyup(function(e){
			if(e.keyCode != 13){
				if($("input[name=user_pwd]").val() != "" && $("input[name=user_pwd_chk]").val() != ""){
					if($("input[name=user_pwd]").val() == $("input[name=user_pwd_chk]").val()){
						console.log("비밀번호 일치");
						$("#btn_pwd_cng").prop("disabled",false);
					}else{
						console.log("비밀번호 불일치");
						$("#btn_pwd_cng").prop("disabled",true);
					}
				}
			}else{
				if($("#btn_pwd_cng").prop("disabled")){
					console.log("비밀번호 불일치");
				}else{
					console.log("비밀번호 일치");
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
				<h3 class="border-bottom" style="padding:1rem;">비밀번호 변경</h3>
				<div class="table" style="width:340px; padding:10px; border:1px solid #ddd; border-radius:10px; margin:auto; margin-top:20px;">
					<form action="changePwd.do" method="POST">
						<div class="tr row" style="display:flex; align-items:center;">
							<div class="td col-3">비밀번호</div>
							<div class="td col-9"><input class="form-control" type="password" name="user_pwd" placeholder="비밀번호"></div>
						</div>
						<div class="tr row" style="display:flex; align-items:center;">
							<div class="td col-3">비밀번호<br> 확인</div>
							<div class="td col-9"><input class="form-control" type="password" name="user_pwd_chk" placeholder="비밀번호 확인"></div>
						</div>
						<div class="tr row" >
							<div class="td col-12 text-end">
								<button id="btn_pwd_cng" class="btn" type="submit" disabled style="background:#00AAB2; color:#fff;">비밀번호 변경</button>
								<button class="btn" type="button" onclick="history.back()" style="background:#BBCE53; color:#fff;">취소</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		
	</div>
</body>
</html>
