<%@ page language="java"  pageEncoding="utf-8"%>
<!-- PC 헤더 START-->
		<div class="pc-header border-bottom" style="position:sticky; top:0; left:0;">
			<div class="container">
		
				<header class="d-flex  align-items-center justify-content-center justify-content-sm-between py-3 mb-1  ">
					<a href="${ path }/main.do" class="d-flex align-items-center col-md-3 mb-1 col-sm-3 mb-md-0 text-dark text-decoration-none ">
						<img src="${ path }/images/logo.png" width="30%">
					</a>
	
					<ul class="nav col-12 col-md-auto  col-sm-0 mb-1 justify-content-center mb-md-0">
						<li><a href="${path}/boarditem/itemlist.do" class="nav-link px-3 link-dark ">중고거래</a></li>
						<li><a href="${path}/board/FreeBoard.do" class="nav-link px-3 link-dark">커뮤니티</a></li>
						<li><a href="${path}/customer/QnAList.do" class="nav-link px-3 link-dark">고객센터</a></li>
						<li><a href="${path}/user/myPage.do" class="nav-link px-3 link-dark">마이페이지</a></li>
					</ul>
					<div class="col-md-3 text-end">
						<c:if test="${ empty uidx }">
							<button type="button" class="btn" style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='${ path }/user/login.do';">
								로그인
							</button>
							<button type="button" class="btn" style="background-color: #BBCE53; color: #fff;" onclick="javascript:loacrion.href='${ path }/user/join.do';">
								회원가입
							</button>
						</c:if>
						<c:if test="${ not empty uidx }">
							<button type="button" class="btn" style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='${ path }/user/logout.do';">
								로그아웃
							</button>
						</c:if>
					</div>
				</header>
			</div>
		</div>
		<!-- PC헤더  END-->

		<!-- 모바일 헤더 START -->
		<nav class="navbar navbar-dark" style=" background:#00AAB2;">
			<div class="container-fluid">
				<div class="navbar-header">
					<select class="form-select" aria-label="Default select example">
						<option>내 동네</option>
					</select>
		    		<script>
			    		let locationList = [${ userLoginInfo.location_auth }];
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
											//console.log(dong);
											html += '<option value="'+locationList[i]+'"';
											if(i == 0){
												html += " selected "
											}
											html += '>'+locationLevel[locationLevel.length-1]+'</option>'
											$(".form-select").append('<option value="'+locationList[i]+'">'+locationLevel[locationLevel.length-1]+'</option>');
										}
									});
								}
							},
							error: function(){
								console.log("error");
							}
						});
		    		</script>
			    </div>
			    <div class="text-end" style="color:white; flex:1; padding:0 1rem;">
			    	<input type="text" class="form-control" placeholder="검색">
			    </div>
				<div id="div-menu-btn" class="navbar-right">
					<button class="navbar-toggler" type="button">
						<span id="menu-btn" class="navbar-toggler-icon"></span>
					</button>
				</div>
			</div>
		</nav>
		<!-- 모바일 헤더 END -->
		
		<div id="menu" class="container-fluid text-white menu-hide" style="position:absolute; top:56px; background:#00AAB2;">
			<div class="menu-item" onclick="location.href='${ path }/user/myPage.do'">
				마이페이지
			</div>
			<div class="menu-item" onclick="location.href='${ path }/user/userInfoView.do'">
				내정보
			</div>
			<div class="menu-item" onclick="location.href='${ path }/user/neighborMng.do'">
				이웃관리
			</div>
			<div class="menu-item" onclick="location.href='${ path }/user/myPage.do'">
				구매내역
			</div>
			<div class="menu-item" onclick="location.href='${ path }/user/myPage.do'">
				판매내역
			</div>
		</div>