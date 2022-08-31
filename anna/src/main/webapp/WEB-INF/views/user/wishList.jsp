<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<%@ page trimDirectiveWhitespaces="true" %>
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
<style>


@media all and (max-width : 575px){
	.card-container{
		width:100%
	}
	
	.card{
		flex-direction:row;
	}
	
	.card-img-div{
		width:120px; 
		height:120px;
	}
}
	
@media all and (min-width : 576px){
	.card-container{
		width:50%
	}
	
	.card{
		flex-direction:column;
	}
	
	.card-img-div{
		width:100%; 
		height:210px;
	}
}
	
	
@media all and (min-width : 768px){
	.card-container{
		width:33.333333%
	}
	
	.card{
		flex-direction:column;
	}
	
	.card-img-div{
		width:100%; 
		height:210px;
	}
}


@media all and (min-width : 992px){
	.card-container{
		width:25%
	}
	
	.card{
		flex-direction:column;
	}
	
	.card-img-div{
		width:100%; 
		height:210px;
	}
}
@media all and (min-width : 1200px){
	.card-container{
		width:20%
	}
	
	.card{
		flex-direction:column;
	}
	
	.card-img-div{
		width:100%; 
		height:210px;
	}
}

.card-img-div{
	border-radius:5px
}

.card-body{
	padding:10px;
}

</style>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="wrapper main" >
			<div class="container" style="flex:1;">
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">찜 목록</h3>
				<c:if test="${ empty wishList }">
					<div class="border-bottom" style="padding:10px;">
						<div class='text-center'>
							찜 목록이 비어있습니다.
						</div>
					</div>
				</c:if>
				<c:if test="${ not empty wishList }">
					<c:forEach var="i" items="${ wishList }"><!-- 
						 --><div class="card-container" style="display:inline-block; font-size:1rem;">
							<div class="card" style="margin:5px; display:flex; " onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ i.item_idx }'">
								<div class="card-img-div" style="background:url('${ path }/resources/upload/${ i.image1 }'),url('${path}/images/no_image.gif'); background-size:cover; background-position:center; background-repeat:no-repeat;"></div>
								<div class="card-body" style="display:flex; flex-direction:column;">
									<div class="text-start" style="height:30px; display:flex; align-items:center;">
										<c:if test="${ fn:length(i.title) > 8 }">
											<b>${fn:substring(i.title,0,8) }...</b>
										</c:if>
										<c:if test="${ fn:length(i.title) <= 8 }">
											<b>${ i.title }</b>
										</c:if>
										<c:if test="${ i.state eq 2 }"><span style="padding:3px; border-radius:5px; background:green; color:#fff; font-size:0.8rem; margin-left:5px;">예약중</span></c:if>
										<c:if test="${ i.state eq 3 }"><span style="padding:3px; border-radius:5px; background:gray; color:#fff; font-size:0.8rem; margin-left:5px;">거래완료</span></c:if>
									</div>
									<div style="flex:1;">
										<span style="color:#00AAB2;"><fmt:formatNumber value="${ i.price }" pattern="#,###"/></span>원
									</div>
							    	<div class="text-end">
							    		<img src="${path}/images/icon_wish_count.png" style="width:26px; padding:2px;"> ${ i.wishCount }&nbsp;<img src="${path}/images/icon_chat_count.png" style="width:28px; padding:1px;"> ${ i.chatCount }
							    	</div>
							  	</div>
							</div>
						</div><!-- 
					--></c:forEach>
				</c:if>
			</div>
		</div>
		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
