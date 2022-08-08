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
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">문의하기 - ${ QnAItem.title }</h3>
				<div class="row border-bottom tr">
					<div class="col-4 th" style="display:table-cell;">문의유형</div>
					<div class="col-8 td" style="display:table-cell;">
						${ QnAItem.qType }
					</div>
				</div>
				<div class="row border-bottom tr">
					<div class="col-4 th" style="display:table-cell;">처리상태</div>
					<div class="col-8 td" style="display:table-cell;">
						<c:if test="${ QnAItem.state eq 0 }">
							미열람
						</c:if>
						<c:if test="${ QnAItem.state eq 1 }">
							처리중
						</c:if>
						<c:if test="${ QnAItem.state eq 2 }">
							처리완료
						</c:if>
					</div>
				</div>
				<div class="row border-bottom tr">
					<div class="col-4 th" style="display:table-cell;">내용</div>
					<div class="col-8 td" style="display:table-cell;">
						${ QnAItem.contents }
					</div>
				</div>
				<div class="row border-bottom tr">
					<div class="col-4 th" style="display:table-cell;">첨부파일</div>
					<div class="col-8 td" style="display:table-cell;">
						${ QnAItem.attach }
					</div>
				</div>
				<c:if test="${ QnAItem.state eq 2 }">
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">답변</div>
						<div class="col-8 td" style="display:table-cell;">
							${ QnAItem.answer }
						</div>
					</div>
				</c:if>
				<div class="row tr">
					<div class="col-12 td text-end" style="display:table-cell;">
						<button class="btn" type="button" style="background:#00AAB2; color:#fff;">삭제</button>
						<button class="btn" type="button" style="background:#00AAB2; color:#fff;">목록</button>
					</div>
				</div>
			</div>	
		</div>
		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->	
	</div>
</body>
</html>
