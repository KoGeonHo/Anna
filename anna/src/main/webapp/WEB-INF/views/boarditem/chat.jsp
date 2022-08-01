<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	let invited=0;
	let chat_host=0;
	function sendMessage(form) {
		//작성자, 내용 유효성 검사
		form.nickName.value = form.nickName.value.trim();
		/* if (form.usernick.value.length == 0) {
			alert('작성자를 입력하세요');
			form.usernick.focus();
			return false;
		} */
		
		form.contents.value = form.contents.value.trim();
		if (form.contents.value.length == 0) {
			alert('내용 입력하세요');
			form.contents.focus();
			return false;
		}
		
		// AJAX -> doAddMessage 실행 및 출력값 가져오기
		$.post('./AddMessage',{
			nickName : form.nickName.value,
			contents : form.contents.value,
			item_idx : form.item_idx.value
		}, function(data) {
			uidx = data["uidx"];
		},'json');
		form.contents.value = '';
		form.contents.focus();
	}
	
	
	
	var Chat__lastReceivedMessagecidx = -1;
	
	
	function Chat__loadNewMessages() {
		$.get('./getMessages',{
			from : Chat__lastReceivedMessagecidx + 1
		}, function(data) {
			console.log(data);
			for ( let i = 0; i < data.length; i++ ) {
				var messages = data[i];
				Chat__lastReceivedMessagecidx = messages.cidx;
				Chat__drawMessages(messages);
			}
			setTimeout(Chat__loadNewMessages,1000);
		}, 'json');
	}
	function Chat__drawMessages(messages) {
		var html = '[' +messages.cidx + '] (' + messages.nickName + ') : ' + messages.contents;
		
		if(messages.uidx == ${uidx}){
			$('.chat-list').append('<div style="text-align:right;">'+ html + '</div>');
		}else{
			$('.chat-list').append('<div style="text-align:left;">' + html + '</div>');
			}
	}
	$(function() {
		Chat__loadNewMessages();
		
	});
	
	
	
</script>
<title>메인 페이지</title>
</head>
<body>
	<h1> 채팅 메시지 입력</h1>
		<form onsubmit="sendMessage(this); return false;">
			<input type="text" name="item_idx" value="${vo.item_idx}"><br>
			<input type="text" name="uidx" value="${vo.uidx}"><br>
			<input type="hidden" name="cidx" value="${cidx}">
			<input type="hidden" name="uidx" value="${uidx}">
			<input type="text" name="nickName" value="${nickName}">
			<input type="text" name="contents" placeholder="내용">
			<input type="submit" value="전송">
		</form>
		
	<div class="chat-list"></div>
	
</body>
</html>