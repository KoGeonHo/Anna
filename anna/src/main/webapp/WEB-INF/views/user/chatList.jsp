<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String type = request.getParameter("type") ;
	pageContext.setAttribute("type", type);
%>
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
	
	.item_thumbnail {
		border:1px solid #ddd; 
		border-radius:10px; 
		padding:0; 
		width:80px; 
		height:80px;
	}
	
	.profileImg_div {
		width:70px; 
		text-align:center;
		margin:auto;
	}
	
	.profileImg {
		padding:5px !important;
		width:70px; 
		height:auto; 
		border-radius:100px;
	}
	
	.NewMessageAlert {
		width:25px; 
		height:25px; 
		position:absolute; 
		padding:0; 
		line-height:25px; 
		text-align:center; 
		color:#fff; 
		background:red; 
		border-radius:100px;
	}
</style>
<script>
	
	$(function(){
		getChatList();
		setInterval(function(){
			getChatList();
		},10*1000);
		
		$(".chk").click(function(){
			if($("input:checkbox:checked").length != 0){
				$("#btnSubmit").prop("disabled",false);
			}else{
				$("#btnSubmit").prop("disabled",true);
			}
		});
	});
	
	function getChatList(){
		$.ajax({
			url : "checkNewMessage.do",
			data : "type=${type}",
			success : function(chatList){
				let html = "";
				for(let i = 0; i < chatList.length; i++){
					html += '<div class="tr border-bottom" style="padding:5px; display:flex; position:relative;">';
					
					if(chatList[i].state == 3){
						
						if(chatList[i].chkReview > 0){
							if(chatList[i].myReview > 0){
								html += '<div class="profileImg_div" style="position:absolute; align-items:center; display:flex; top:0; left:0; width:100%; height:100%; background:rgba(255,255,255,0.5);">';
								html += '<div style="flex:1;">';
								html += '<button type="button" class="btn" style="background:#00AAB2; color:#fff; margin-right:10px; font-size:0.8rem;" onclick="openViewReview(\'' + chatList[i].item_idx + '\',\'' + chatList[i].chat_host + '\',\'' + chatList[i].invited + '\')">거래 후기 보기</button>';
								html += '<button type="button" class="btn" style="background:#bbcd53; color:#fff; font-size:0.8rem;" onclick="location.href=\'chatView.do?item_idx='+chatList[i].item_idx+'&chat_host='+chatList[i].chat_host+'&invited='+chatList[i].invited+'\'">채팅 보기</button>';
								html += '</div>';
								html += '</div>';
							}
						}else{
							html += '<div class="profileImg_div" style="position:absolute; align-items:center; display:flex; top:0; left:0; width:100%; height:100%; background:rgba(255,255,255,0.5);">';
							html += '<div style="flex:1;">';
							html += '<button type="button" class="btn" style="background:#00AAB2; color:#fff; margin-right:10px; font-size:0.8rem;" onclick="openModal(\'' + chatList[i].item_idx + '\',\'' + chatList[i].chat_host + '\',\'' + chatList[i].invited + '\',';
							if(chatList[i].chat_host == ${uidx}){
								html += '\''+chatList[i].invitedNickName+'\'';
							}else if(chatList[i].invited == ${uidx}) {
								html += '\''+chatList[i].hostNickName+'\'';
							}
							html += ')">후기 등록하기</button>';
							html += '<button type="button" class="btn" style="background:#bbcd53; color:#fff; font-size:0.8rem;" onclick="location.href=\'chatView.do?item_idx='+chatList[i].item_idx+'&chat_host='+chatList[i].chat_host+'&invited='+chatList[i].invited+'\'">채팅 보기</button>';
							html += '</div>';
							html += '</div>';
						}
						
						
					}
					html += '<div class="profileImg_div" onclick="location.href=\'chatView.do?item_idx='+chatList[i].item_idx+'&chat_host='+chatList[i].chat_host+'&invited='+chatList[i].invited+'\'">';
					
					if(chatList[i].chat_host == ${uidx}){
						html += '<img src="'+chatList[i].invitedProfileImg+'" class="profileImg" onerror="this.onerror=null; this.src=\'${path}/images/NoProfile.png\';">';
					}else if(chatList[i].invited == ${uidx}) {
						html += '<img src="'+chatList[i].hostProfileImg+'" class="profileImg" onerror="this.onerror=null; this.src=\'${path}/images/NoProfile.png\';">';
					}
					
					html += '</div>';
					html += '<div style="flex:1; margin:auto;" onclick="location.href=\'chatView.do?item_idx='+chatList[i].item_idx+'&chat_host='+chatList[i].chat_host+'&invited='+chatList[i].invited+'\'">';
					html += '<div style="padding:5px;">';
					
					var today = new Date();

					var year = today.getFullYear();
					var month = ('0' + (today.getMonth() + 1)).slice(-2);
					var day = ('0' + today.getDate()).slice(-2);

					var dateString = year + '/' + month  + '/' + day;
					let lastChatDate = chatList[i].lastChatDate;
					
					if(lastChatDate.split(" ")[0] == dateString){
						lastChatDate = lastChatDate.split(" ")[1]+" "+lastChatDate.split(" ")[2];
					}else{
						lastChatDate = lastChatDate.split(" ")[0];
					}
					
					if(chatList[i].chat_host == ${uidx}){
						html += chatList[i].invitedNickName+'<span style="font-size:0.8rem;">('+lastChatDate+')</span>';
					}else if(chatList[i].invited == ${uidx}) {
						html += chatList[i].hostNickName+'<span style="font-size:0.8rem;">('+lastChatDate+')</span>';
					}
					html += '</div>';
					html += '<div style="padding:5px; font-size:0.8rem; class="text-start">';

					if(chatList[i].state == 3){
						html += '<span style="padding:3px; font-size:11px; border-radius:5px; background:gray; color:#fff; margin-right:5px;">거래완료</span>';
					}else if(chatList[i].state == 2){
						html += '<span style="padding:3px; font-size:11px; border-radius:5px; background:green; color:#fff; margin-right:5px;">예약중</span>';
					}
					if(chatList[i].lastChat.indexOf("&image") != -1){
						html += "사진을 보냈습니다.";
					}else if(chatList[i].lastChat.indexOf("&image") == -1){
						html += chatList[i].lastChat;
					}
					html += '</div>';
					html += '</div>';
					html += '<div style="width:80px; text-align:center; margin:auto;">';
					html += '<img src="${path}/resources/upload/'+chatList[i].itemThumbNail+'" style="padding:0" class="item_thumbnail" onclick="location.href=\'${path}/boarditem/itemview.do?item_idx='+chatList[i].item_idx+'\'" onerror="this.onerror=null; this.src=\'${path}/images/noimg_item.jpg\';">';
					
					
					html += '</div>';
					if(chatList[i].newMessages > 0){
						html += '<div class="NewMessageAlert">'+chatList[i].newMessages+'</div>';
					}
					html += '</div>';
					
				}
				$("#chatDiv").html(html);
			}
		});
	}
	
	function openModal(item_idx,chat_host,invited,nickName){
		$("input[name=item_idx]").val(item_idx);
		$("input[name=seller]").val(chat_host);
		$("input[name=buyer]").val(invited);
		$("#modalForReView").fadeIn();
		$("#modalTitle").html(nickName+"님과 거래후기");
	}
	function closeModal(){
		$("input[name=item_idx]").val("");
		$("input[name=seller]").val("");
		$("input[name=buyer]").val("");
		$("#modalForReView").fadeOut();
	}
	function checkLike(radiobox){
		if(radiobox.value == 'Y'){
			$("input:checkbox").prop("checked", false);
			$("#btnSubmit").prop("disabled",true);
			$("#label1").html("&nbsp;친절해요");
			$("#label2").html("&nbsp;응답이 빨라요");
			$("#label3").html("&nbsp;상품이 설명한 것과 같아요");
		}else if(radiobox.value == 'N'){
			$("input:checkbox").prop("checked", false);
			$("#btnSubmit").prop("disabled",true);
			$("#label1").html("&nbsp;불친절해요");
			$("#label2").html("&nbsp;연락이 잘 안돼요");
			$("#label3").html("&nbsp;상품이 설명한 것과 달라요");
		}
	}
	
	function insertReView(){
		$("#ReViewFrm").submit();
	}
	
	function openViewReview(item_idx,seller,buyer){
		$.ajax({
			url : "",
			data : "",
			success : function(result){
				
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
		<div class="wrapper main" style="overflow:auto;">
			<div class="container" style="position:relative;">
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">채팅 목록</h3>
				<div class="tr border-bottom">
					<div class="td text-center" onclick="location.href='chatList.do'" <c:if test="${ empty type }"> style="background:#777; color:#fff;"</c:if> style="border-right:1px solid #ddd;" >전체</div>
					<div class="td text-center" onclick="location.href='chatList.do?type=sell'"  <c:if test="${ type eq 'sell' }"> style="background:#777; color:#fff;"</c:if> style="border-right:1px solid #ddd;" >판매</div>
					<div class="td text-center" onclick="location.href='chatList.do?type=buy'"  <c:if test="${ type eq 'buy' }"> style="background:#777; color:#fff;"</c:if>>구매</div>
				</div>
				<div class="table" id="chatDiv">
					<div>
						Loading...
					</div>
				</div>
			</div>
			<div id="modalForReView" style="display:none;">
				<div class="profileImg_div" style="position:absolute; align-items:center; display:flex; top:0; left:0; width:100%; height:100%; background:rgba(255,255,255,0.5);">
					<div style="margin:auto; width:280px; height:300px; background:#fff; border-radius:10px; border:2px solid #ddd; box-shadow: 2px 2px 2px 2px gray; position:relative;">
						<p class="border-bottom text-start" style="width:100%; margin:0px;"><b id="modalTitle" style="margin:0; padding:5px; font-size:20px;"></b></p>	
						<div>
							<form id="ReViewFrm" method="POST" action="insertReView.do">
								<input type="hidden" name="item_idx" value="">
								<input type="hidden" name="seller" value="">
								<input type="hidden" name="buyer" value="">
								<div class="tr border-bottom">
									<div class="td"><input id="like" checked name="satisfied" type="radio" onclick="checkLike(this)" value="Y"><label for="like">&nbsp;만족</label></div>
									<div class="td"><input id="dislike" name="satisfied" type="radio" onclick="checkLike(this)" value="N"><label for="dislike">&nbsp;불만족</label></div>
								</div>
								<div id="ckeckLike">
									<div class="tr" >
										<div class="td text-start">
											<input id="opt1" class="chk" name="option1" type="checkbox" value="1"><label id="label1" for="opt1">&nbsp;친절해요</label>
										</div>
									</div>
									<div class="tr">
										<div class="td text-start">
											<input id="opt2" class="chk" name="option2" type="checkbox" value="1"><label id="label2" for="opt2">&nbsp;응답이 빨라요</label>
										</div>
									</div>
									<div class="tr" >
										<div class="td text-start">
											<input id="opt3" class="chk" name="option3" type="checkbox" value="1"><label id="label3" for="opt3">&nbsp;상품이 설명과 같아요</label>
										</div>
									</div>
								</div>
							</form>
						</div>
						<div style="position:absolute; bottom:0; width: 100%;">
							<div class="text-end" style="padding:10px;">
								<button class="btn" type="button" id="btnSubmit" disabled style="background:#00AAB2; color:#fff;" onclick="insertReView()">등록</button>
								<button class="btn" type="button" style="background:#00AAB2; color:#fff;" onclick="closeModal()">닫기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			<div id="viewReView" style="display:none;">
				<div class="profileImg_div" style="position:absolute; align-items:center; display:flex; top:0; left:0; width:100%; height:100%; background:rgba(255,255,255,0.5);">
					<div style="margin:auto; width:280px; height:300px; background:#fff; border-radius:10px; border:2px solid #ddd; box-shadow: 2px 2px 2px 2px gray; position:relative;">
						<p class="border-bottom text-start" style="width:100%; margin:0px;"><b style="margin:0; padding:5px; font-size:20px;">거래후기 등록</b></p>	
						<div>
							<div id="review" class="tr border-bottom">
								
							</div>
						</div>
						<div style="position:absolute; bottom:0; width: 100%;">
							<div class="text-end" style="padding:10px;">
								<button class="btn" type="button" id="btnSubmit" disabled style="background:#00AAB2; color:#fff;" onclick="insertReView()">등록</button>
								<button class="btn" type="button" style="background:#00AAB2; color:#fff;" onclick="closeModal()">닫기</button>
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
