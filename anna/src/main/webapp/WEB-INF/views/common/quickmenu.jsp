<%@ page language="java" pageEncoding="UTF-8"%>

<script>
function hover(element) {
	  element.setAttribute('src', '<%=request.getContextPath()%>/images/icon_top.png');
	}

	function unhover(element) {
	  element.setAttribute('src', '<%=request.getContextPath()%>/images/icon_plus.png');
	}

</script>

<ul id=quickmenu" class="mfb-component--br mfb-zoomin" data-mfb-toggle="hover">
				<li class="mfb-component__wrap"><a href="#wrapper" class="mfb-component__button--main">
				<div id="menu_plus" class="menu_plus">
				<img src="<%=request.getContextPath()%>/images/icon_plus.png" width="25px" height="25px;" he style="margin-left: 16px; margin-top: 16px;"
				onmouseover="hover(this);" onmouseout="unhover(this);">
				</div>
				
				</a>
					<ul class="mfb-component__list">
						<li>
							<a href="<%=request.getContextPath()%>/boarditem/itemwrite.do" data-mfb-label="판매글 등록" class="mfb-component__button--child">
								<img src="<%=request.getContextPath()%>/images/icon_write.png" width="20px" height="20px;" he style="margin-left: 19px; margin-top: 18px;">
							</a>
						</li>
						<li>
							<a href="<%=request.getContextPath()%>/itemwrite.do" data-mfb-label="알림" class="mfb-component__button--child">
								<img src="<%=request.getContextPath()%>/images/icon_push.png" width="20px" height="20px;" he style="margin-left: 18px; margin-top: 18px;">
							</a>
						</li>
				</ul>
			</li>
			</ul>