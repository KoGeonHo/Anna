<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <% pageContext.setAttribute("chat_host", request.getParameter("chat_host")); %>
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
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
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

.carousel-indicators [data-bs-target]{
	box-sizing: border-box;
	background:#ddd;
	border-radius:30px;
	width:10px;
	height:10px;
	border:0px;
	
}

.carousel-indicators button{
	margin:0px;
}

.carousel-control-prev-icon, .carousel-control-next-icon {
	width:20px;
	height:20px;
}
</style>
<script>
	let flagChat = 1;
	let prevSelected = ${itemVO.state};
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
		
		$("#changeState").on("focus",function(){
			prevSelected = $(this).val();
			console.log(prevSelected);
		})
		
		
	});
	
	function sendMessage(){
		let item_idx = <%=request.getParameter("item_idx")%>;
		let invited = <%=request.getParameter("invited")%>;
		let chat_host = <%=request.getParameter("chat_host")%>;
		let contents = $("#chatContents").val();
		contents = contents.replaceAll("\n","<br>");
		let chatData = "item_idx="+item_idx+"&invited="+invited+"&chat_host="+chat_host+"&contents="+contents+"&uidx=${uidx}";
		
		
		
		$("#chatContents").prop("disabled",true);
		$("#sendBtn").prop("disabled",true);
		$("#sendBtn").css("background","#ccc");
		$.ajax({
			url : "sendMessage.do",
			data : chatData,
			success : function(){
				let html = "";
				html += '<div class="text-end " style="padding:5px;">';
				html += '<div style="padding:5px;">${ userLoginInfo.nickName }</div>';
				html += '<div><p style="padding:5px; color:#fff; background:#00AAB2; border-radius:5px; display:inline-block; text-align:start;">'+contents+'</p></div>';
				html += '</div>';
				//console.log("Message Send Success");
				$("#chatContents").val("");
				$("#chatbox").append(html);
				$("#chatbox").scrollTop($('#chatbox')[0].scrollHeight);
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
					
					html += '<div class="text-start" style="padding:5px; display:flex;">';
					html += '<div style="display:flex; align-items:center;">';
					if(result.uidx == result.chat_host){
						html += '<img src="'+result.hostProfileImg+'" style="width:50px; height:auto; border-radius:100px;" onerror="this.onerror=null; this.src=\'${path}/images/NoProfile.png\';">';
					}else if(result.uidx == result.invited){
						html += '<img src="'+result.invitedProfileImg+'" style="width:50px; height:auto; border-radius:100px;" onerror="this.onerror=null; this.src=\'${path}/images/NoProfile.png\';">';
					}
					html += '</div>';
					html += '<div style="flex:1; margin:auto; margin-left:10px;">';
					html += '<div style="padding:5px;">${audience}</div>';
					html += '<div><p style="padding:5px; color:#fff; background:darkgray; border-radius:5px; display:inline-block; text-align:start;">'+result.contents+'</p></div>';
					html += '</div>';
					html += '</div>';
					$("#chatbox").append(html);
					$("#chatbox").scrollTop($('#chatbox')[0].scrollHeight);
				}
			}
		});
		
	}
	
	function updateState(selectBox){
		let state = selectBox.value;
		if(state == 3){
			if(!confirm("거래 완료로 변경하시면 더이상 상대방과 채팅이 불가능 하며,\n거래상태를 변경할수 없게 됩니다.\n거래 완료로 변경하시겠습니까?")){
				$("#changeState").val(prevSelected);
				return false;
			}
		}else if(state == 2){
			if(!confirm("판매중인 게시글에도 예약중으로 노출됩니다. 예약중으로 변경 하시겠습니까?")){
				$("#changeState").val(prevSelected);
				return false;
			}
		}else if(state == 1){
			if(!confirm("거래중으로 변경합니다.")){
				$("#changeState").val(prevSelected);
				return false;
			}
		}
		let item_idx = <%=request.getParameter("item_idx")%>;
		$.ajax({
			url : "${path}/boarditem/updatestate",
			data : "state="+state+"&item_idx="+item_idx,
			success : function(){
				if(state == 3){
					$("#chatContents").prop("disabled",true);
					$("#changeState").prop("disabled",true);
				}else{
					$("#chatContents").prop("disabled",false);
				}
				console.log("success");
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
					<div class="border-bottom" style="display:flex;">
						<div style="padding:10px; flex:1; ">
							<h3 style="margin:0;font-size: 1.3rem; font-weight: bold;">${ audience }님과의 채팅</h3>
						</div>
						<c:if test="${ chat_host eq uidx }">
							<div style="margin:auto;">
								<select id="changeState" onchange="updateState(this)" <c:if test="${ itemVO.state eq 3 }">disabled</c:if>>
									<option value="1" <c:if test="${ itemVO.state eq 1 }">selected</c:if>>거래중</option>
									<option value="2" <c:if test="${ itemVO.state eq 2 }">selected</c:if>>예약중</option>
									<option value="3" <c:if test="${ itemVO.state eq 3 }">selected</c:if>>거래완료</option>
								</select>
							</div>
						</c:if>
						<c:if test="${ chat_host ne uidx }">
							<div style="margin:auto;">
								<c:if test="${ itemVO.state eq 1 }"><span style="padding:5px; border-radius:5px; background:#00AAB2; color:#fff; font-size:0.8rem;">거래중</span></c:if>
								<c:if test="${ itemVO.state eq 2 }"><span style="padding:5px; border-radius:5px; background:green; color:#fff; font-size:0.8rem;">예약중</span></c:if>
								<c:if test="${ itemVO.state eq 3 }"><span style="padding:5px; border-radius:5px; background:gray; color:#fff; font-size:0.8rem;">거래완료</span></c:if>
							</div>
						</c:if>
					</div>
					<div style="width:100%; height:80px; padding:5px;">
						<div style="display:flex;">
							<div>
								<img style="width:70px; height:70px; border:2px solid #aaa; border-radius:5px; margin:auto; display:flex; align-items:center;" src="${path}/resources/upload/${itemVO.image1}" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
							</div>
							<div style="flex:1; padding:5px;">
								<div>
									<div><h3>${ itemVO.title }</h3></div>
									<div style="padding-left:10px;">
										<fmt:parseNumber var="price" type="number" value="${itemVO.price}" />								
										<fmt:setLocale value=""/><fmt:formatNumber  type="currency" value="${ price }"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="chatbox" style="width:100%; overflow-y:auto; flex:1; border:2px solid #aaa; border-radius:5px; padding:10px; position:relative;">
						
						<c:if test="${chatViewList.size() > 0}">
							<c:forEach var="i" items="${chatViewList}">
								<c:if test="${ i.uidx eq uidx }">
									<div class="text-end" style="padding:5px;">
										<div style="padding:5px;">${ userLoginInfo.nickName }</div>
										<div><p style="padding:5px; color:#fff; background:#00AAB2; border-radius:5px; display:inline-block; text-align:start;">${i.contents}</p></div>
									</div>
								</c:if>
								<c:if test="${ i.uidx ne uidx }">
									<div class="text-start" style="padding:5px; display:flex;">
										<div style="display:flex; align-items:center;">
											<c:if test="${ i.uidx eq i.chat_host }">
												<img src="${i.hostProfileImg}" style="width:50px; height:auto; border-radius:100px;" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/NoProfile.png';">
											</c:if>
											<c:if test="${ i.uidx eq i.invited }">
												<img src="${i.invitedProfileImg}" style="width:50px; height:auto; border-radius:100px;" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/NoProfile.png';">
											</c:if>
										</div>
										<div style="flex:1; margin:auto; margin-left:10px;">
											<div style="padding:5px;">${audience}</div>
											<div><p style="padding:5px; color:#fff; background:darkgray; border-radius:5px; display:inline-block; text-align:start;">${i.contents}</p></div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:if>	
					</div>
					
					
					<form style="width:100%; margin:0px;">
						<div id="chatInput" style="padding:10px 0; width:100%; display:flex;">
							<div class="td" style="flex:1; padding:0; margin:auto;">
								<textarea class="form-control"  wrap="hard" cols="20" id="chatContents" <c:if test="${ itemVO.state eq 3 }">disabled</c:if> style="height:30px; display:inline-block; width:100%;resize:none;" placeholder="채팅내용을 입력하세요."></textarea>
							</div>
							<div class="td text-end" style="width:70px; padding:5;">
								<button class="btn" type="button" id="sendBtn" style="width:60px; height:100%; background: #ccc; color:#fff;" disabled onclick="sendMessage()">전송</button>
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
							<div style="padding:10px; height:380px; text-align:center;">
								<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
								  <div class="carousel-indicators">
								  	<c:if test="${ not empty itemVO.image2}">
								   	 	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
								    </c:if>
								    <c:if test="${ not empty itemVO.image3}">
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
								    </c:if>
								    <c:if test="${ not empty itemVO.image4}">
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
								    </c:if>
								    <c:if test="${ not empty itemVO.image5}">
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
								    </c:if>
								    <c:if test="${ not empty itemVO.image6}">
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="5" aria-label="Slide 6"></button>
								    </c:if>
								    <c:if test="${ not empty itemVO.image7}">
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="6" aria-label="Slide 7"></button>
								    </c:if>
								    <c:if test="${ not empty itemVO.image8}">
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="7" aria-label="Slide 8"></button>
								    </c:if>
								    <c:if test="${ not empty itemVO.image9}">
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="8" aria-label="Slide 9"></button>
								    </c:if>
								    <c:if test="${ not empty itemVO.image10}">
								    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="9" aria-label="Slide 10"></button>
								    </c:if>
								  </div>
								  <div class="carousel-inner">
								    <div class="carousel-item active">
								    	<img class="d-block" src="${path}/resources/upload/${itemVO.image1}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
								    </div>
								    <c:if test="${ not empty itemVO.image2}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image2}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								    <c:if test="${ not empty itemVO.image3}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image3}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								    <c:if test="${ not empty itemVO.image4}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image4}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								    <c:if test="${ not empty itemVO.image5}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image5}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								    <c:if test="${ not empty itemVO.image6}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image6}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								    <c:if test="${ not empty itemVO.image7}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image7}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								    <c:if test="${ not empty itemVO.image8}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image8}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								    <c:if test="${ not empty itemVO.image9}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image9}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								    <c:if test="${ not empty itemVO.image10}">
									    <div class="carousel-item">
									    	<img class="d-block" src="${path}/resources/upload/${itemVO.image10}" style="border:2px solid #aaa; border-radius:5px; width:350px; height:350px; margin:auto; display:flex; align-items:center;" onerror="this.onerror=null; this.src='${path}/images/noimg_item.jpg';">
									    </div>
								    </c:if>
								  </div>
								  <c:if test="${ not empty itemVO.image2}">
									  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev" style="color:gray;">
									    <div style="background:#ddd;">
										    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
										    <span class="visually-hidden">Previous</span>
									    </div>
									  </button>
									  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next" style="color:gray;">
									  	<div style="background:#ddd;">
										    <span class="carousel-control-next-icon" aria-hidden="true"></span>
										    <span class="visually-hidden">Next</span>
									   	</div>
									  </button>
								  </c:if>
								</div>
							</div>
							<div>
								<div class="table">
									<div class="tr border-top border-bottom">
										<div class="th" style="width:100px;">가격</div>
										<div class="td">		
											<fmt:parseNumber var="price" type="number" value="${itemVO.price}" />								
											<fmt:setLocale value=""/><fmt:formatNumber  type="currency" value="${ price }"/>
										</div>
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
