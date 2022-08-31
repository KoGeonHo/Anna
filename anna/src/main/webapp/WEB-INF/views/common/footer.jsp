<%@ page language="java" pageEncoding="UTF-8"%>
<% String urif = request.getRequestURI(); %>
<div id="footer" class="border-top" style="box-sizing: border-box; width:100vw; position:fixed; bottom:0px; height:50px; align-items:center;">
	<div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/';">
		<%if(urif.contains("/index") || urif.contains("/boarditem") || urif.contains("/customer")){ %>
			<img src="${ path }/images/icon_home_click.png">
		<%} else {%>
			<img src="${ path }/images/icon_home.png">
		<%} %>
		<br>
		<span style="font-size:0.8rem;">홈</span>
	</div><!--  
	--><div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/board/boardlist.do?board_type=free'">
		<%if(urif.contains("/board/")){ %>
			<img src="${ path }/images/icon_comm_click.png">
		<%} else {%>
			<img src="${ path }/images/icon_comm.png">
		<%} %>
		<br>
		<span style="font-size:0.8rem;">커뮤니티</span>
	</div><!--
	--><div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/boarditem/itemwrite.do'">
		<img src="${path}/images/icon_write_mobile.png" style="width:25px; height:25px;">
		
	</div><!-- 
	--><div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/user/chatList.do';">
		<%if(urif.contains("/user/chat")){ %>
			<img src="${ path }/images/icon_chat_click.png">
		<%} else {%>
			<img src="${ path }/images/icon_chat.png">
		<%} %>
		<br>
		<span style="font-size:0.8rem;">채팅</span>
	</div><!--
	--><%-- <div class="ft-icon text-center" style="width:20vw; display:inline-block; border-right:1px solid #ddd;" onclick="location.href='${path}/user/myPage.do';">
			<img src="${ path }/images/icon_my_click.png">
			<img src="${ path }/images/icon_my.png">
		<br>
		<span style="font-size:0.8rem;">myPage</span>
	</div> --%><!--
	--><div class="ft-icon text-center" style="width:20vw; display:inline-block;" onclick="location.href='${path}/user/myPage.do';">
		<%if(urif.contains("/user/myPage")){ %>
			<img src="${ path }/images/icon_menu_active.png">
		<%} else {%>
			<img src="${ path }/images/icon_quick.png">
		<%} %>
		<br>
		<span style="font-size:0.8rem;">메뉴</span>
	</div>
</div>

<!-- 퀵메뉴 -->
<script>
function hover(element) {
	  element.setAttribute('src', '<%=request.getContextPath()%>/images/icon_top.png');
	}

	function unhover(element) {
	  element.setAttribute('src', '<%=request.getContextPath()%>/images/icon_plus.png');
	}
	
	console.log('${chkSellNewMessage }');
</script>


<c:if test="${ not empty uidx }">
	<div>
		<ul id="quickmenu" class="mfb-component--br mfb-zoomin" data-mfb-toggle="hover">
			<li class="mfb-component__wrap" ><a href="" class="mfb-component__button--main">
			<div id="menu_plus" class="menu_plus" onClick="javascript:window.scrollTo(0,0)">
			<img src="<%=request.getContextPath()%>/images/icon_plus.png" width="25px" height="25px;" he style="margin-left: 16px; margin-top: 16px;"
			onmouseover="hover(this);" onmouseout="unhover(this);" >
			</div>
			
			</a>
				<ul class="mfb-component__list">
					<li>
						<a href="<%=request.getContextPath()%>/boarditem/itemwrite.do" data-mfb-label="글쓰기" class="mfb-component__button--child">
							<img src="<%=request.getContextPath()%>/images/icon_write.png" width="20px" height="20px;" he style="margin-left: 19px; margin-top: 18px;">
						</a>
					</li>
					<li>
						<c:if test="${ not empty chkSellNewMessage and not empty chkBuyNewMessage}">
							<c:if test="${ chkSellNewMessage ne 0 and chkBuyNewMessage ne 0}">
								<div style="display:inline-block; width:18px; height:18px; font-size:0.8rem; position:absolute; padding: 0px 0px 0px 5px; right:1px; top:0; background:red; margin-left: 10px;
													 margin-top: 10px; border-radius:10px; color:#fff; z-index:1;">${ chkSellNewMessage }</div>
							 </c:if>
						</c:if>
						<a href="<%=request.getContextPath()%>/user/chatList.do" data-mfb-label="채팅" class="mfb-component__button--child">
							<img src="<%=request.getContextPath()%>/images/icon_qc.png" width="23px" height="23px;" he style="margin-left: 17px; margin-top: 16px;">
						</a>
					</li>
					<li>
						<c:if test="${ not empty  chkAlarm}">
							<c:if test="${ chkAlarm ne 0}">
							<div style="display:inline-block; width:18px; height:18px; font-size:0.8rem; position:absolute; padding: 0px 0px 0px 5px; right:1px; top:0; background:red; margin-left: 10px;
												 margin-top: 10px; border-radius:10px; color:#fff; z-index:1;">${ chkAlarm }</div>
							</c:if>
						</c:if>
						<a href="<%=request.getContextPath()%>/user/alarmView.do" data-mfb-label="알림" class="mfb-component__button--child">
							<img src="<%=request.getContextPath()%>/images/icon_push.png" width="20px" height="20px;" he style="margin-left: 18px; margin-top: 18px;">
						</a>
					</li>
				</ul>
			</li>
		</ul>
	</div>

</c:if>
<!-- 퀵메뉴 -->