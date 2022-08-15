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
<link href="${ path }/css/mfb.css" rel="stylesheet">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 
<!-- path는 request.getContextPath()를 가져온것. -->

<script>
	
	$(function(){
		getChatList();
		setInterval(function(){
			getChatList();
		},10*1000);
	});
	
	function getChatList(){
		$.ajax({
			url : "checkNewMessage.do",
			success : function(chatList){
				let html = "";
				for(let i = 0; i < chatList.length; i++){
					html += '<div class="tr border-bottom" style="padding:10px;" onclick="location.href=\'chatView.do?item_idx='+chatList[i].item_idx+'&chat_host='+chatList[i].chat_host+'&invited='+chatList[i].invited+'\'">';
					html += '<div>';
					if(${uidx} == chatList[i].chat_host){
						html += chatList[i].invitedNickName;
					}else{
						html += chatList[i].hostNickName;
					}
					if(chatList[i].newMessages > 0){
						html += ' <div style="width: 25px;height: 25px; display:inline-block;padding: 0;line-height: 25px;text-align: center;color: #fff;background: red;border-radius: 100px;">'+chatList[i].newMessages+'</div>'
					}
					html += '</div>';
					html += '<div class="text-end">'+chatList[i].lastChat+'<span style="font-size:0.8rem;">('+chatList[i].lastChatDate+')</span></div>';
					html += '</div>';
					
				}
				$("#chatDiv").html(html);
				console.log("chatListReloaded");
			},
		});
	}

</script>

</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="wrapper">
			<div class="container main">
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">채팅 목록</h3>
				<div class="table" id="chatDiv">
					<c:if test="${chatList.size() > 0}">
						<c:forEach var="i" items="${chatList}">
							<div class="tr border-bottom" style="padding:10px;" onclick="location.href='chatView.do?item_idx=${i.item_idx}&chat_host=${i.chat_host}&invited=${i.invited}'">
								<div>
									<c:if test="${ uidx eq i.chat_host}">
										${ i.invitedNickName }
									</c:if>
									<c:if test="${ uidx eq i.invited}">
										${ i.hostNickName }
									</c:if>
									<c:if test="${ i.newMessages > 0 }">
										<div style="width: 25px;height: 25px; display:inline-block;padding: 0;line-height: 25px;text-align: center;color: #fff;background: red;border-radius: 100px;">${i.newMessages}</div>
									</c:if>
								</div>
								<div class="text-end">${ i.lastChat }<span style="font-size:0.8rem;">(${i.lastChatDate})</span></div>
							</div>
						</c:forEach>
					</c:if>		
				</div>
			</div>
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
