<%@ page language="java"  pageEncoding="utf-8"%>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<style>
#nav {
	font-family: 'NanumSquare', sans-serif !important;
	font-size: 17.5px;
	line-height: 1.5;
	font-weight: 450;
}

.nav-li {
	padding-right: 0.8rem !important;
	padding-left: 0.7rem !important;
}

#nav>ul>li :hover {
	transform: scale(1.1);
}

#subMenu {
	font-family: 'NanumSquare', sans-serif !important;
	font-size: 15.6px;
	line-height: 1.5;
	font-weight: 400;
}

#subMenu_text :hover {
	text-decoration: underline;
	text-decoration-thickness: 1.5px;
	text-decoration-color: #00aab2;
	text-underline-offset: 7px;
}
</style>
<script>

	$(function(){
		$("input[name=header-searchVal]").keyup(function(e){
			if(e.keyCode == 13){
				location.href="${path}/boarditem/itemlist.do?searchVal="+$(this).val();
			}
		});
	});

	
	function setLocation(selBox){
		console.log(selBox.value);
		$.ajax({
			url: "${path}/user/setLocation.do",
			data : "location="+selBox.value,
			success : function(result){
				console.log(result);
				location.reload();
			}
		});
	}
	
</script>

<%
	String uri = request.getRequestURI();
%>
<!-- PC 헤더 START-->
		<div id="header-container">
			<div class="pc-header border-bottom">
				<div class="container" style="display:flex; flex-direction:row;">
					<div style="width:130px; padding:15px;">
						<img src="${ path }/images/logo.png" style="width:100px; cursor:pointer;" onclick="location.href='${path}/'">
					</div>
					<div style="flex:1;" id="nav">
						<ul class="nav col-12 col-md-auto  col-sm-0 mb-1 justify-content-center mb-md-0" style="margin-left:16px;">
							<li class="nav-li"><a href="${path}/boarditem/itemlist.do" class="nav-link px-3 link-dark ">중고거래</a></li>
							<li class="nav-li"><a href="${path}/board/boardlist.do?board_type=free" class="nav-link px-3 link-dark">커뮤니티</a></li>
							<li class="nav-li"><a href="${path}/board/boardlist.do?board_type=notice" class="nav-link px-3 link-dark">고객센터</a></li>
							<li class="nav-li"><a href="${path}/user/myPage.do" class="nav-link px-3 link-dark">마이페이지</a></li>
						</ul>
					</div>
					<div class="text-end" style="width:130px;">
						<c:if test="${ empty uidx }">
							<button type="button" class="btn" style="background-color: #00AAB2; color: #fff;" onclick="location.href='${ path }/user/login.do';">
								로그인
							</button>
							<%-- <button type="button" class="btn" style="background-color: #BBCE53; color: #fff;" onclick="loacrion.href='${ path }/user/join.do';">
								회원가입
							</button> --%>
						</c:if>
						<c:if test="${ not empty uidx }">
							<button type="button" class="btn" style="background-color: #00AAB2; color: #fff;" onclick="location.href='${ path }/user/logout.do';">
								로그아웃
							</button>
						</c:if>
					</div>
				</div>
			</div>
			<div style="height:0px; backgorund:#fff; position:relative;">
				<div id="subMenu" class="border-bottom" style="position:absolute; width:100%; background:#fff; display:none; z-index:1000;" >
					<div style="flex:1;">
						<ul class="nav col-12 col-md-auto  col-sm-0 mb-1 justify-content-center mb-md-0" style="text-align : center;">
							<li>
								<ul id="subMenu_text" style="list-style:none; padding-inline-start:0; width:118px;">
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/boarditem/itemlist.do'">중고거래</li>
								</ul>
							</li>
							<li>
								<ul id="subMenu_text" style="list-style:none; padding-inline-start:0; width:118px;">									
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/board/boardlist.do?board_type=free'">일상소통</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/board/boardlist.do?board_type=job'">구인구직</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/board/boardlist.do?board_type=meeting'">모임</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/board/boardlist.do?board_type=hotplace'">핫플레이스</li>
								</ul>
							<li>
								<ul id="subMenu_text" style="list-style:none; padding-inline-start:0; width:118px;">
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/board/boardlist.do?board_type=notice'">공지사항</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/customer/FaQList.do'">자주하는질문</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/customer/QnAList.do'">문의하기</li>
								</ul>
							<li>
								<ul id="subMenu_text" style="list-style:none; padding-inline-start:0; width:118px; ">
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/user/myPage.do'">마이페이지</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/user/userInfoView.do'">내정보</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/user/wishList.do'">찜목록</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/user/neighborMng.do'">이웃관리</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/user/chatList.do';">채팅목록</li>
									<%-- <li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/user/myPage.do'">구매내역</li>
									<li class="nav-link px-3 link-dark" style="cursor:pointer;" onclick="location.href='${path}/boarditem/itemlist.do?searchUidx=${uidx}'">판매내역</li> --%>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<script>
			$(".nav-li").on("mouseenter",function(){
				NavSlideDown();
			});
			
			function NavSlideDown(){
				$(".nav-li").off("mouseenter");
				$("#header-container").off("mouseleave");
				$("#subMenu").slideDown("fast",function(){
					$(".nav-li").on("mouseenter",function(){
						NavSlideDown();
					});
					$("#header-container").on("mouseleave",function(){
						NavSlideUp();
					});
				});
			}
			
			
			
			$("#header-container").on("mouseleave",function(){
				NavSlideUp();
			});
			
			function NavSlideUp(){
				$(".nav-li").off("mouseenter");
				$("#header-container").off("mouseleave");
				$("#subMenu").slideUp("fast",function(){
					$(".nav-li").on("mouseenter",function(){
						NavSlideDown();
					});
					$("#header-container").on("mouseleave",function(){
						NavSlideUp();
					});
				});
			}
		
		</script>
		<!-- PC헤더  END-->





		<!-- 모바일 헤더 START -->
		<nav class="navbar navbar-dark" style="background:#00AAB2;">
			<div class="container-fluid">
				<div class="navbar-header">
					<select class="form-select" aria-label="Default select example" onchange="setLocation(this)">
						<option value="${ userLoginInfo.location_auth }" <c:if test="${ userLoginInfo.location_auth eq locationSet }" > selected </c:if>>내 동네</option>
					</select>
		    		<script>
			    		let locationList = [${ userLoginInfo.location_auth }];
			    		//console.log('${ userLoginInfo.location_auth }');
			    		let html = '';
			    		$.ajax({
							url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
							data : "consumer_key=7b9a8af3d576479db243&consumer_secret=02e72ab8a0e046f9bf95",
							success : function(data){
								$(".spinner-border").css("display","none");
								for(let i = 0; i < locationList.length; i++){
									$.ajax({
										url : "https://sgisapi.kostat.go.kr/OpenAPI3/boundary/hadmarea.geojson",
										async : false,
										data : "accessToken="+data.result.accessToken+"&year=2021&adm_cd="+locationList[i]+"&low_search=0",
										success : function(geojson){
											let locationLevel = geojson.features[0].properties.adm_nm.split(" ");
											//dong.push(locationLevel[locationLevel.length-1]);
											//console.log((locationList[i]==${locationSet}));
											html += '<option value="'+locationList[i]+'"';
											if(locationList[i].toString()=='${locationSet}'){
												html += " selected "
											}
											html += '>'+locationLevel[locationLevel.length-1]+'</option>'
											//$(".form-select").append('<option value="'+locationList[i]+'">'+locationLevel[locationLevel.length-1]+'</option>');
										}
									});
								}
								$(".form-select").append(html);
							},
							error: function(){
								console.log("error");
							}
						});
		    		</script>
			    </div>
			    <div class="text-end" style="color:white; flex:1; padding:0 1rem;">
			    	<input type="text" name="header-searchVal" class="form-control" value="<%if(request.getParameter("searchVal") != null) { out.print(request.getParameter("searchVal")); }%>" placeholder="상품검색" >
			    </div>
				<div id="div-menu-btn" class="navbar-right">
					<button class="navbar-toggler" type="button">
						<span id="menu-btn" class="navbar-toggler-icon"></span>
					</button>
				</div>
			</div>
		</nav>
		<!-- 모바일 헤더 END -->
		
		
		
		
		<%if(!uri.contains("/user/chat") && uri.contains("/user")){%>
			<div id="menu" class="container-fluid text-white menu-hide" style="position:absolute; top:50px; background:#00AAB2;">
				<div class="menu-item" onclick="location.href='${ path }/user/myPage.do'">
					마이페이지
				</div>
				<div class="menu-item" onclick="location.href='${ path }/user/userInfoView.do'">
					내정보
				</div>
				<div class="menu-item" onclick="location.href='${ path }/user/neighborMng.do'">
					이웃관리
				</div>
				<div class="menu-item" onclick="location.href='${ path }/user/wishList.do'">
					찜목록
				</div>
			</div>
		<%} else if(uri.contains("/board/")){%>
			<div id="menu" class="container-fluid text-white menu-hide" style="position:absolute; top:50px; background:#00AAB2;">
				<div class="menu-item" onclick="location.href='${path}/board/boardlist.do?board_type=free'">
					일상소통
				</div>
				<div class="menu-item" onclick="location.href='${path}/board/boardlist.do?board_type=job'">
					구인구직
				</div>
				<div class="menu-item" onclick="location.href='${path}/board/boardlist.do?board_type=meeting'">
					모임
				</div>
				<div class="menu-item" onclick="location.href='${path}/board/boardlist.do?board_type=hotplace'">
					핫플레이스
				</div>
				<%-- <div class="menu-item" onclick="location.href='${ path }/user/myPage.do'">
					판매내역
				</div> --%>
			</div>			
		<%} else {%>
			<div id="menu" class="container-fluid text-white menu-hide" style="position:absolute; top:50px; background:#00AAB2;">
				<div class="menu-item" onclick="location.href='${path}/boarditem/itemlist.do'">
					중고거래
				</div>
				<div class="menu-item" onclick="location.href='${path}/board/boardlist.do?board_type=free'">
					커뮤니티
				</div>
				<div class="menu-item" onclick="location.href='${path}/customer/QnAList.do'">
					고객센터
				</div>
				<div class="menu-item" onclick="location.href='${path}/user/myPage.do'">
					메뉴
				</div>
			</div>
		<%}%>
		
		
		
		
		
		
		
		
		
		
		
		
		
		