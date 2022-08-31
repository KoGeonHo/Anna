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
<script>
	function delNeighbor(neighbor_idx){
		$.ajax({
			url : "${path}/boarditem/delNeighbor",
			data : "neighbor_idx="+neighbor_idx,
			success : function(){
				location.reload();
			}
		});
		
		//${path}/BoardItem/delNeighbor?uidx=${uidx}&neighbor_idx=${i.uidx}
	}
</script>
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="wrapper main">
			<div class="container" >
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">이웃 관리</h3>
				<c:if test="${ empty nList }">
					<div class="border-bottom" style="padding:10px;">
						<div class='text-center'>
							등록한 이웃이 없습니다.
						</div>
					</div>
				</c:if>
				<c:if test="${ not empty nList }">
					<c:forEach var="i" items="${ nList }">
						<div class="border-bottom" style="padding:10px; display:flex;">
							<div style="width:100px; height:100px;"><img src="${i.profile_image}" onerror="this.onerror=null; this.src='${path}/images/NoProfile.png';" style="width:80px; height:80px; border-radius:100px; margin:10px;"></div>
							<div style="flex:1; margin:auto; padding:10px;">
								<div><h5>${ i.nickName }</h5></div>
								<div>${ i.introduce }</div>
							</div>
							<div class="text-center" style="width:100px; margin:auto;">
								<button type="button" class="btn" style="background:#00AAB2; color:#fff; margin:5px;" onclick="location.href='${path}/board/boardlist.do?searchUidx=${i.uidx}'">작성글</button>
								<button type="button" class="btn" onclick="delNeighbor(${i.uidx})" style="background:#00AAB2; color:#fff; margin:5px;">삭제</button>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
