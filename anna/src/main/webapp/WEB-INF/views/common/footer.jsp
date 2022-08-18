<%@ page language="java" pageEncoding="UTF-8"%>
<% String uri = request.getRequestURI(); %>
<div id="footer" class="border-top" style="box-sizing: border-box; width:100vw; padding:0.8rem 0;">
	<div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/main.do';">
		<%if(uri.contains("/main")){ %>
			<img src="${ path }/images/icon_home_click.png">
		<%} else {%>
			<img src="${ path }/images/icon_home.png">
		<%} %>
		<br>
		<span style="font-size:0.9rem;">홈</span>
	</div><!--  
	--><div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/board/boardlist.do?board_type=free'">
		<%if(uri.contains("/board")){ %>
			<img src="${ path }/images/icon_comm_click.png">
		<%} else {%>
			<img src="${ path }/images/icon_comm.png">
		<%} %>
		<br>
		<span style="font-size:0.9rem;">커뮤니티</span>
	</div><!--
	--><div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/user/chatList.do';">
		<%if(uri.contains("/user/chat")){ %>
			<img src="${ path }/images/icon_chat_click.png">
		<%} else {%>
			<img src="${ path }/images/icon_chat.png">
		<%} %>
		<br>
		<span style="font-size:0.9rem;">채팅</span>
	</div><!--
	--><div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/user/myPage.do';">
		<%if(!uri.contains("/user/chat") && uri.contains("/user")){ %>
			<img src="${ path }/images/icon_my_click.png">
		<%} else {%>
			<img src="${ path }/images/icon_my.png">
		<%} %>
		<br>
		<span style="font-size:0.9rem;">myPage</span>
	</div><!--
	--><div class="ft-icon text-center" style="width:20vw; display:inline-block;" onclick="alert('준비중입니다.')">
		<img src="${ path }/images/icon_quick.png">
		<br>
		<span style="font-size:0.9rem;">메뉴</span>
	</div>
</div>