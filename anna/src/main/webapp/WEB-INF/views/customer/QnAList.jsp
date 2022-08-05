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
			<h3 class="border-bottom" style="padding:1rem; margin:0px;">문의 하기</h3>
			<table class="table text-center">
				<thead>
					<tr>
						<th scope="col" style="width:50%;">
							제목
						</th>
						<th scope="col" style="width:30%;">
							작성일
						</th>
						<th scope="col" style="width:20%;">
							상태
						</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${ empty QnAList }">
						<tr>
							<td colspan="3">
								아직 작성한 글이 없습니다.
							</td>
						</tr>
					</c:if>
					<c:if test="${ not empty QnAList }">
						<c:forEach var="i" items="${ QnAList }">
							<tr>
								<td onclick="location.href='QnAView.do?qidx=${i.qidx}'">${ i.title }</td>
								<td>${ i.wDate }</td>
								<td>
									<c:if test="${ i.state eq 0 }">
										미열람
									</c:if>
									<c:if test="${ i.state eq 1 }">
										처리중
									</c:if>
									<c:if test="${ i.state eq 2 }">
										처리완료
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" class="text-end" style="border:0px;">
							<button type="button" class="btn btn-sm" style="background:#00AAB2; color:#fff;" onclick="location.href='${path}/customer/QnAWrite.do'">글작성</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
