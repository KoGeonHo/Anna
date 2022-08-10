<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>안녕? 나야!</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>

<!-- 지도 API - 필요없으면 지워도 됨 -->
<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 지도 API -->

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<!-- path는 request.getContextPath()를 가져온것. -->
<style>

.th {
	background:#eee;
	text-align:center;
	vertical-align:middle;
}
.th, .td{
	padding:10px;
}

.tr{
	display:table; 
	width:100%;
}

</style>
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		
		<div class="wrapper">
			<div class="container main">
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">문의 하기</h3>
				<form method="POST" action="QnAWrite.do" enctype="multipart/form-data">
				
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">제목</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" name="title">
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">문의 유형</div>
						<div class="col-8 td" style="display:table-cell;">
							<select name="qType">
								<option value="system">시스템오류</option>
								<option value="login">로그인</option>
								<option value="service">서비스이용</option>
								<option value="bannedItem">판매 금지 품목</option>
								<option value="ETC">기타</option>
							</select>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">내용</div>
						<div class="col-8 td" style="display:table-cell;">
							<textarea class="form-control" name="contents" rows="10" cols="25"></textarea>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">첨부 파일</div>
						<div class="col-8 td" style="display:table-cell;">
							<input class="form-control" name="attachFile" type="file" id="formFile" accept=".gif, .jpg, .png">
						</div>
					</div>
					
					<div class="text-end tr">
						<div class="td">
							<button class="btn" style="background:#00AAB2; color:#fff;">등록</button>
							<button class="btn" style="background:#00AAB2; color:#fff;" type="button" onclick="location.href='${path}/customer/QnAList.do'">취소</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
