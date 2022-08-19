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
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="container main" style="flex:1; overflow:auto;">
			<h3 class="border-bottom" style="padding:1rem; margin:0px;">찜 목록</h3>
			<c:if test="${ empty wishList }">
				<div class="border-bottom" style="padding:10px;">
					<div class='text-center'>
						찜 목록이 비어있습니다.
					</div>
				</div>
			</c:if>
			<c:if test="${ not empty wishList }">
				<c:forEach var="i" items="${ wishList }">
					<div style="padding:0 10px; display:flex; cursor:pointer;" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ i.item_idx }'">
						<div><img src="${ path }/resources/upload/${i.image1}" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';" style="width:110px; height:110px; border:2px solid #ccc; border-radius:10px; margin:10px;"></div>
						<div style="flex:1; margin:auto; padding:10px;">
							<div><h5>${ i.title }</h5></div>
							<div>${ i.keyword }</div>
							<div>
								<c:if test="${ i.state eq 2 }"><span style="padding:5px; border-radius:5px; background:green; color:#fff; font-size:0.8rem;">예약중</span></c:if>
								<c:if test="${ i.state eq 3 }"><span style="padding:5px; border-radius:5px; background:gray; color:#fff; font-size:0.8rem;">거래완료</span></c:if>
								${ i.price }원</div>
						</div>
						<%-- <div class="text-center" style="width:100px; margin:auto;">
							<button type="button" class="btn" onclick="" style="background:#00AAB2; color:#fff; margin:5px;">작성글</button>
							<button type="button" class="btn" onclick="delNeighbor(${i.uidx})" style="background:#00AAB2; color:#fff; margin:5px;">삭제</button>
						</div> --%>
					</div>
					<div class="text-end border-bottom" style="padding:5px;">
						<img src="${path}/images/icon_chat_count.png" style="width:34px; height:auto; padding:3px;">${ i.chatCount }
						<img src="${path}/images/icon_wish_count.png" style="width:30px; height:auto; padding:5px;">${ i.wishCount }
						</div>
				</c:forEach>
			</c:if>
		</div>
		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
