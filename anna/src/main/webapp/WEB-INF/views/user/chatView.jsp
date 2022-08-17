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
<style>
@media all and (max-width:  767px){
	
	#itemInfo {
		display:none;
	}
	
}

@media all and (min-width :768px){

	#itemInfo {
		display:flex;
	}
	
}
</style>
<script>
	let flagChat = 1;
	$(function(){
		$("#chatbox").scrollTop($('#chatbox')[0].scrollHeight);
		$("#chatContents").keydown(function(e){
			if(e.shiftKey&&e.keyCode == 13){
				console.log("쉬프트 엔터 동시에 누름");
			}else if(e.keyCode == 13){
				if(!$("#sendBtn").prop("disabled")){
					sendMessage();
				}
				return false;
				
			}
		});
		$("#chatContents").keyup(function(e){
			if(e.keyCode != 13){
				if($(this).val() != ""){
					$("#sendBtn").prop("disabled",false);
					$("#sendBtn").css("background","#00AAB2");
				}else{
					$("#sendBtn").prop("disabled",true);
					$("#sendBtn").css("background","#ccc");
				}
			}
		});
	});
	
	function sendMessage(){
		let item_idx = <%=request.getParameter("item_idx")%>;
		let invited = <%=request.getParameter("invited")%>;
		let chat_host = <%=request.getParameter("chat_host")%>;
		let contents = $("#chatContents").val();
		let chatData = "item_idx="+item_idx+"&invited="+invited+"&chat_host="+chat_host+"&contents="+contents+"&uidx=${uidx}";
		$.ajax({
			url : "sendMessage.do",
			data : chatData,
			success : function(){
				let html = "";
				html += '<div class="text-end border-bottom" style="padding:10px;">';
				html += '${ userLoginInfo.nickName }<br>';
				html += contents;
				html += '</div>';
				//console.log("Message Send Success");
				$("#chatContents").val("");
				$("#chatbox").append(html);
				$("#chatbox").scrollTop($('#chatbox')[0].scrollHeight);
				$("#chatContents").prop("disabled",true);
				$("#sendBtn").prop("disabled",true);
				$("#sendBtn").css("background","#ccc");
				setTimeout(function(){
					$("#chatContents").prop("disabled",false);
					/* $("#sendBtn").prop("disabled",false);
					$("#sendBtn").css("background","#00AAB2"); */
					$("#chatContents").focus();
				},1000);
			},
			erorr : function(){
				console.log("Message Send Failed");
			}
		});
	}
	
	
	let item_idx = <%=request.getParameter("item_idx")%>;
	let invited = <%=request.getParameter("invited")%>;
	let chat_host = <%=request.getParameter("chat_host")%>;
	
	setInterval(chkMessage, 500);
	
	function chkMessage(){
		
		let Data = "item_idx="+item_idx+"&invited="+invited+"&chat_host="+chat_host+"&uidx=${uidx}";
		
		$.ajax({
			url : "getMessage.do",
			data : Data,
			success : function(result){
				if(result != ""){
					let html = "";
					html += '<div class="text-start border-bottom" style="padding:10px;">';
					html += '${audience}<br>';
					html += result.contents;
					html += '</div>';
					$("#chatbox").append(html);
					$("#chatbox").scrollTop($('#chatbox')[0].scrollHeight);
				}
			}
		});
		
	}
</script>
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="container main" style="display:flex; flex-direction:column; flex:1; height:100%; overflow:auto;" >
			<div style="flex:1; display:flex; width:100%; height:100%;">
				<div id="chat-container" style="display:flex; flex-direction:column; flex:1;">
					<div style="padding:10px;">
						<h3>${ audience }님과의 채팅</h3>
					</div>
					<div id="chatbox" style="width:100%; overflow-y:auto; flex:1; border:2px solid #aaa; border-radius:5px; padding:10px;">
						<c:if test="${chatViewList.size() > 0}">
							<c:forEach var="i" items="${chatViewList}">
								<c:if test="${ i.uidx eq uidx }">
									<div class="text-end border-bottom" style="padding:10px;">
										<div>${ userLoginInfo.nickName }</div>
										<div>${i.contents}</div>
									</div>
								</c:if>
								<c:if test="${ i.uidx ne uidx }">
									<div class="text-start border-bottom" style="padding:10px; display:flex;">
										<div>
											<c:if test="${ i.uidx eq i.chat_host }">
												<img src="${i.hostProfileImg}" style="width:50px; height:auto; border-radius:100px;" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/NoProfile.png';">
											</c:if>
											<c:if test="${ i.uidx eq i.invited }">
												<img src="${i.invitedProfileImg}" style="width:50px; height:auto; border-radius:100px;" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/NoProfile.png';">
											</c:if>
										</div>
										<div style="flex:1; margin:auto; margin-left:10px;">
											<div>${audience}</div>
											<div>${i.contents}</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:if>	
					</div>
					<form style="width:100%; margin:0px;">
						<div id="chatInput" style="padding:10px 0; width:100%; display:flex;">
							<div class="td" style="flex:1; padding:0; margin:auto;">
								<textarea class="form-control" id="chatContents" style="height:60px; display:inline-block; width:100%; resize:none;"></textarea>
							</div>
							<div class="td text-end" style="width:70px; padding:5;">
								<button class="btn" type="button" id="sendBtn" style="width:60px; height:60px; background: #ccc; color:#fff;" disabled onclick="sendMessage()">전송</button>
							</div>
						</div>
					</form>
				</div>
				<div id="itemInfo" style="width:40%; height:100%; margin-left:10px; flex-direction:column;">
					<div class="border-bottom" style="padding:10px;">
						<h3>상품 정보</h3>
					</div>
					<div style="flex:1; display:flex; flex-direction:column; overflow-y:auto;">
						<div style="padding:10px;">
							<h4>${ itemVO.title }</h4>
							<div style="padding:10px; text-align:center;">
								<img src="${path}/images/upload/${itemVO.image1}" style="border:2px solid #aaa; border-radius:10px; width:95%;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
							</div>
							<div>
								<div class="table">
									<div class="tr border-top border-bottom">
										<div class="th" style="width:100px;">가격</div>
										<div class="td">${ itemVO.price }</div>
									</div>
									<div class="tr border-bottom">
										<div class="th" style="width:100px;">가격제안</div>
										<div class="td">
											<c:if test="${ itemVO.offer eq 1}">
												가능
											</c:if>
											<c:if test="${ itemVO.offer ne 1}">
												불가
											</c:if>
										</div>
									</div>
									<div class="tr border-bottom">
										<div class="th" style="width:100px;">상품 설명</div>
										<div class="td">${ itemVO.contents }</div>
									</div>
									<div class="tr border-bottom" >
										<div class="th" style="width:100px;">거래 상태</div>
										<div class="td">
											<c:if test="${ itemVO.state eq 1 }">
												거래중
											</c:if>
											<c:if test="${ itemVO.state eq 2 }">
												예약중
											</c:if>
											<c:if test="${ itemVO.state eq 3 }">
												거래 완료
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
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
