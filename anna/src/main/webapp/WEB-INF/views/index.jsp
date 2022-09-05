<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	
	<title>안녕? 나야!</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
	<meta charset="UTF-8">
	
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<link href="https://webfontworld.github.io/naver/NanumSquare.css" rel="stylesheet">

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->

<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/mfb.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 

<link rel="stylesheet" href="css/boardlist1.css" type="text/css" />


<style>
 @media all and (max-width :1399px){
	#kategorie_img {
		width:100%;
	}
	

}

@media all and (max-width :1199px){
	#kategorie_img {
		width:100%;
	}

}

@media all and (max-width :991px){
	#kategorie_img {
		width:100%;
	}

}
@media all and (max-width:  767px){
	
	#kategorie_img {
		width:100%;
	}
	
	#img-items{
		height:auto;
		width:120px;
	}
	
	
} 

@media all and (max-width: 767px) {
	 #itemcard {
	display: flex;
    flex-direction: row;
    margin: 0;
}

	#itemcard > img {
	width: 35%;
    height: 130px;
	}
	
	#itemtext {
	 margin-top: 37px;
	}
/* 	#item_list{
		margin-top: 65px;
	}  */
	#item_container{
		margin-top: -14px;
	}
	
}

@media all and (min-width :768px) {
	#itemcard > img {
	width: 100%;
    height: 210px;
	}
	#img-items{
		height:210px;
		width:100%;
	}

}

.imgAr{
	box-shadow: 5px 5px 5px grey;
}

</style>

<!-- 무한스크롤 -->
<script>
//스크롤 시 이벤트 처리
console.log("hi");
//위로 스크롤된 길이


//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
let currentPage = 1;
//현재 페이지가 로딩중인지 여부를 저장할 변수
let isLoding=false;
$(function(){
   $("#main").on("scroll",function(){
	  // console.log("ㅇㅇ");
      	var scrollTop = $(this).scrollTop();
        var innerHeight = $(this).innerHeight();
        var scrollHeight = $(this).prop('scrollHeight');
        //console.log(scrollTop + innerHeight);
        //console.log("scrollHeight:"+scrollHeight);
       if((scrollTop + innerHeight)+1 >= scrollHeight){
          console.log(isLoding);
            //만일 현재 마지막 페이지라면
            if(currentPage == ${totalPageCount} || isLoding){
               
               return; // 함수를 여기서 끝낸다.
            }
            //현재 로딩 중이라고 표시한다.
            isLoding= true;
            //console.log("탔습니다.");
            //로딩바를 띄우고
            $(".back-drop").show();
            //요청할 페이지 번호를 1증가시킨다.
            currentPage++;
            //추가로 받아올 페이지를 서버에 ajax 요청을 하고
            //console.log("inscroll" + currentPage);
            GetList(currentPage)
      }
   });
});

//카드 리스트를 가져오는 함수

const GetList = function(currentPage){
   //console.log("inGetList" + currentPage);
   
   //무한스크롤
   $.ajax({
   
      url : "ajax_main.do",
      method : "GET",
      //검색 기능이 있는 경우 seachType과 seachVal를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른 것들이 덧붙여져 나온다.
      data : "pagenumber="+currentPage+"&SearchType=${searchType}&SearchVal=${searchVal}",
      //FreeBoard.jsp의 내용이 data로 들어온다. 
      success:function(data){
         //console.log(data.appendList);
         let appendList = data.appendList;
         let html = "";
         
         for(let i = 0; i < appendList.length; i++){
        	 
			html +='<div class="card-container" id="item_container" style="display:inline-block; font-size:1rem; flex:none; padding:5px;">';
			html +='<div class="card" id="itemcard"  style="margin:5px;" onclick="location.href=\'${path}/boarditem/itemview.do?item_idx='+appendList[i].item_idx+'\'">';
			
			html += '<div id="img-items" style="background:url(\'${path}/resources/upload/'+appendList[i].image1+'\'),url(\'${path}/images/no_image.gif\'); background-size: cover; background-position: center; background-repeat: no-repeat;"></div>';
			
			//html +='<img src="${ path }/resources/upload/'+appendList[i].image1+'"  onerror="this.onerror=null; this.src=\'${path}/images/no_image.gif\';" class="card-img-top" alt="...">';
			html +='<div class="card-body" style="padding:10px;">';
			html +='<div class="text-start" style="height:30px; display:flex; align-items:center;">';
			if(appendList[i].title.length >= 8){
				html +='<b>'+appendList[i].title.substr(0,8)+'</b>';
			}else{
				html +='<b>'+appendList[i].title+'</b>';
			}
			if(appendList[i].state == 2){
				html += '<span style="display:inline-block; padding:3px; border-radius:5px; background:green; color:#fff; font-size:0.8rem;">예약중</span>';
			}else if(appendList[i].state == 3){
				html += '<span style="display:inline-block; padding:3px; border-radius:5px; background:gray; color:#fff; font-size:0.8rem;">거래완료</span>';
			}
			html +='</div>';
			html +='<div>';
			html +='<span style="color:#00AAB2;">'+appendList[i].price+'</span>원';
			html +='</div>';
			html +='<div class="text-end" id="itemtext">';
			html +='<img src="${path}/images/icon_wish_count.png" style="width:26px; padding:2px;">'+appendList[i].wishCount+' &nbsp;<img src="${path}/images/icon_chat_count.png" style="width:28px; padding:1px;"> '+appendList[i].chatCount;
			html +='</div>';
			html +='</div>';
			html +='</div>';
			html +='</div>';
            
         }
         
         $("#item_list").append(html);	         
         
         //로딩바를 숨긴다.
         //$(".back-drop").hide();
         //로딩중이 아니라고 표시한다.
         isLoding=false;
      }   
   });
}
</script>
<!-- 무한스크롤 -->

<script>
	$(function(){
		let slide;
		let slideWidth = 0;
		
		$(window).resize(function(){
			$(".slide-container").css("left","0px");
		});
		
		$(".slide-btn-prev").click(function(){
			let slideContainer = $(this).data("container");
			slideWidth = $(slideContainer).css("width").replace("px","");
			let itemSize = $(this).data("itemsize");
			let NextMax = -((Math.ceil(itemSize / 5) - 1) * slideWidth);
			slide = $($(this).data("slide"));
			if((parseInt(slide.css("left").replace("px",""))%slideWidth) == 0){
				let left = slide.css("left").replace("px","");
				if(slide.css("left").replace("px","") == 0){
					left = NextMax;
				}else if((parseInt(left)+parseInt(slideWidth)) > 0){
					left = 0;
				}
				else{
					left = parseInt(left)+parseInt(slideWidth);
				}
				slide.css("left",left+"px");
			}
		});
		
		$(".slide-btn-next").click(function(){
			let itemSize = $(this).data("itemsize");
			let slideContainer = $(this).data("container");
			slideWidth = $(slideContainer).css("width").replace("px","");
			slide = $($(this).data("slide"));
			if((parseInt(slide.css("left").replace("px",""))%slideWidth) == 0){
				left = slide.css("left").replace("px","");
				let NextMax = -((Math.ceil(itemSize / 5) - 1) * slideWidth);
				if((parseInt(left)-parseInt(slideWidth)) >= parseInt(NextMax)){
					left = (parseInt(left)-parseInt(slideWidth));
				}else{
					left = 0;
				}
			}
			slide.css("left",left+"px");
		});
		
		
		
	});
</script>


		
<!--   Slick Slider -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>	
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!--   Slick Slider -->
	

</head>

<body>

<div class="wrapper" >
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->


			<div class="main"  id="main" style="overflow:auto; width:100%;">

	<!-- 슬라이드 -->

		<div id="myCarousel" class="carousel slide " data-bs-ride="carousel">
			<div class="carousel-indicators ">
				<button type="button" data-bs-target="#myCarousel"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#myCarousel"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#myCarousel"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="images/slide_2.png" width="100%">

					<div class="container">
						<div class="carousel-caption text-start"></div>
					</div>
				</div>
				<div class="carousel-item">
					<img src="images/slide_2.png" width="100%">

					<div class="container">
						<div class="carousel-caption"></div>
					</div>
				</div>
				<div class="carousel-item">
					<img src="images/slide_2.png" width="100%">

					<div class="container">
						<div class="carousel-caption text-end"></div>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#myCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#myCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<br> <br>

	<!-- 슬라이드 -->

		
	<!-- 검색 -->
	<div id="search">
	<div class="container">
			<div class="row">
				<div class="col-md-1 col-sm-0"></div>
				<div class="col-md-10  col-sm-12">

					<form class="d-flex" action="${ path }/boarditem/itemlist.do?searchVal=${pm.searchVal}">						
						<input class="form-control" type="text" id="searchVal" name="searchVal" class="search-control" placeholder="검색어를 입력해주세요" >&nbsp;
						<input type="submit" value="검색" class="btn btn-outline-primary" id="search" ">
					</form>

				</div>
				<div class="col-md-1 col-sm-0"></div>
			</div>
		
	</div>
	</div>
	<!-- 검색 -->

			<!-- 카테고리 메뉴 -->
			<div  style="padding-bottom: 62px;">
				<div class="container" id="kategorie_img">
					<div class="row" style="margin-top: 40px;">
						<div class="col-md-6 col-sm-6 ">
							<a href="${path}/boarditem/itemlist.do"><img src="images/main_menu_img1.jpg" style="margin-left: 20px;" width="94.5%"></a>
						</div>
						<div class="col-md-6 col-sm-6 " style="padding: 0; display: -webkit-inline-box;">
							<a href="${path}/board/boardlist.do?board_type=free"><img src="images/main_menu_img2.jpg" width="97%"></a> <a
								href="${path}/board/boardlist.do?board_type=notice"><img src="images/main_menu_img3.jpg" style="margin-top: 15px;" width="47%"></a>
							<a href="${path}/customer/QnAList.do"><img src="images/main_menu_img4.jpg" style="margin-left: 15px; margin-top: 17px;" width="47%"></a>
						</div>
					</div>
				</div>
			</div>
			<!-- 카테고리 메뉴 -->



			<!-- 인기상품 start -->
			<div id="bestitem">
				<main>
					<div class="album py-5" style="background-color: #f9f9f9; height: 118px; ">
							<div class="container ">
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8" style="text-align:center; transform: translate(10px, -14px);">
									<h4 style="font-weight:bold; font-size:20px;">인기상품</h4>
									<h6 style="color:#aaa; font-size:16px;">AnnA의 인기 아이템을 확인하세요</h6>
									</div>
									<div class="col-md-2 "></div>
								</div>
							</div>
						</div>
				</main>
				<!--   Slick Slider -->
				<div class="container ">
					<div class="row">
						<!-- stlye 은 slick 영역 확인용 -->
						
						<c:if test="${list.size() > 0}">
							<div id="slideOfInterested" style="width:100%; clear:both; overflow:hidden; position:relative; margin-top: 39px; padding-right:0; ">
								<c:if test="${list.size() > 5}">
									<div class="slide-btn slide-btn-prev" data-slide="#slider-interested" data-container="#slideOfInterested" data-itemsize="${ list.size() }" id="slide-btn-prev" style="left:0;"><img src='<%=request.getContextPath()%>/images/slicbtn_prev.png'></div>
									<div class="slide-btn slide-btn-next" data-slide="#slider-interested" data-container="#slideOfInterested" data-itemsize="${ list.size() }" id="slide-btn-next" style="right:0;"><img src='<%=request.getContextPath()%>/images/slicbtn_next.png'></div>
								</c:if>
								<div id="slider-interested" class="slide-container" style="display:flex; white-space:nowrap; font-size:0px; left:0; position:relative; transition: left 0.6s ease-in-out;">
									<c:forEach var="vo" items="${list}">
										<div style="width:20%; display:inline-block; font-size:1rem; flex:none;">
											<div class="card" style="margin:5px;" onclick="location.href='<%=request.getContextPath()%>/boarditem/itemview.do?item_idx=${ vo.item_idx }'">
												<div style="width:100%; height:210px; background:url('${path}/resources/upload/${ vo.image1 }'),url('${path}/images/no_image.gif');background-size:cover; background-position:center; background-repeat:no-repeat;"></div>
												<%-- <img src="<%=request.getContextPath()%>/resources/upload/${ vo.image1 }" style="width:100%; height:210px;" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="..."> --%>
												<div class="card-body">
													<div class="text-start" style="height:30px; display:flex; align-items:center;">
														<c:if test="${ fn:length(vo.title) > 8 }">
															<b>${fn:substring(vo.title,0,8) }...</b>
														</c:if>
														<c:if test="${ fn:length(vo.title) <= 8 }">
															<b>${ vo.title }</b>
														</c:if>
														<c:if test="${ vo.state eq 2 }"><span style="padding:3px; border-radius:5px; background:green; color:#fff; font-size:0.8rem; margin-left:5px;">예약중</span></c:if>
														<c:if test="${ vo.state eq 3 }"><span style="padding:3px; border-radius:5px; background:gray; color:#fff; font-size:0.8rem; margin-left:5px;">거래완료</span></c:if>
													</div>
													<div>
														<span style="color:#00AAB2;"><fmt:formatNumber value="${ vo.price }" pattern="#,###"/></span>원
													</div>
											    	<div class="text-end">
											    		<img src="<%=request.getContextPath()%>/images/icon_wish_count.png" style="width:26px; padding:2px;"> ${ vo.wishCount }&nbsp;<img src="${path}/images/icon_chat_count.png" style="width:28px; padding:1px;"> ${ vo.chatCount }
											    	</div>
											  	</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</c:if>					
					</div>
				</div>

				
								<!--   Slick Slider -->

				<!-- 인기상품 end -->


				<!-- 게시글 -->
				<main style="padding-top: 60px;">
					<div class="album py-5" style="background-color: #f9f9f9; height: 118px; ">

							<div class="container ">
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8" style="text-align:center; transform: translate(10px, -14px);">
									<h5 style="font-weight:bold; font-size:20px;">일상 &amp; 소통</h5>
									<h6 style="color:#aaa; font-size:16px;">이웃과 따뜻해지는 동네를 만들어요</h6>
									</div>
									<div class="col-md-2 "></div>
								</div>
							</div>
					</div>
				</main>
				
				<main>
					<div class="album py-5" id="boardlist">
						<div class="container">
							<div class="container ">
							</div>
							<form>						
							
					<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">								
					
			<div id="bo_gall" style="width:100%">
				<ul id="gall_ul" class="gall_row">
			
			<c:if test="${board.size()>0}">
				<c:forEach var="vo" items="${board}">
					
					<li class="gall_li col-gn-4 gallWST" style="margin-bottom:5px;">
            			<div class="gall_box" >
                			<div class="gall_con">
                    			<div class="gall_boxa">
                        			<a href="board/viewBoard.do?Bidx=${vo.bidx}">
                  						<em class="iconPs bo_tit"></em>
                  						<i class="imgAr">
                  							<div style="width:auto; height:200px; background:url('${path}/resources/upload/${ vo.image1 }'),url('${path}/images/no_image.gif');background-size:cover; background-position:center; background-repeat:no-repeat;"></div>
                  							<%-- <img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}" alt="없어요" onerror=this.src="images/no_imgborder.jpg" style="width :200px; height : 200px"> --%>
                  						</i>
                  						<em class="gall_info">
                     						<span class="sound_only">조회 </span>
                     						<i class="fa fa-eye" aria-hidden="true"></i>
                     						${vo.hit}
                     						<span class="gall_date">
                     							<span>작성일</span>
                     							<i class="fa fa-clock-o" aria-hidden="true"></i>
                     							${vo.wdate }
                     						</span>
                     						<u>
                     							<span>작성자 </span>${vo.nickName }
                     						</u>
                  						</em>
                        			</a>
                    			</div>
			                    <div class="gall_text_href bo_tit" >
			                    	<a href="viewBoard.do?Bidx=${vo.bidx}" style="float:left;">
			                            ${vo.title }
			                        </a>
			                        <span style="float:right;"><img src="images/icon_comment.png" style="margin-top: -1px; margin-right: 3px; height: 15px;">${vo.ccount}</span>
			                        <span style="float:right;"><img src="images/icon_wish_count.png" height="23px" style="margin-top:-4px; width: 18px; height: 16px;">${vo.cntLike}</span>
			                    </div>
			                </div>
            			</div>
        			</li>
					
				</c:forEach>
			</c:if>
				</ul>
			</div>									
								</div>
							</form>
						</div>
					</div>
			</div>
			<br>
			</main>
			
			
			
			
			<!-- 게시글 -->


			<div id="event_img">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<img src="images/main_event_img.jpg" style="margin-top: -78px;     width: 100%;">
						</div>
					</div>
				</div>
			</div>


			<!-- 상품 -->
			<div id="itemlist">
				<main>
					<div id="itemtitlename">
						<div class="album py-5"
							style="background-color: #f9f9f9; height: 118px; margin-top: 78px; margin-bottom: 30px;">

							<div class="container ">
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8"
										style="text-align: center; transform: translate(10px, -14px);">
										<h5 style="font-weight: bold; font-size: 20px;">중고거래</h5>
										<h6 style="color: #aaa; font-size: 16px;">최신 상품들을 만나보세요</h6>
									</div>
									<div class="col-md-2 "></div>
								</div>
							</div>
						</div>
					</div>

					<div class="container">
						<div class="d-md-none d-lg-block d-xl-block">


							<div class="section" style="padding: 0px;">
								<!-- container -->
								<div class="container">
									<!-- row -->
									<div class="row" id="item_list">
										<!-- Products tab & slick -->
										<c:if test="${list.size() > 0}">
											<c:forEach var="vo" items="${list}">

												<div class="card-container" id="item_container"
													style="display: inline-block; font-size: 1rem; flex: none; padding: 5px;">
													<div class="card" id="itemcard" style="margin: 5px;"
														onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ vo.item_idx }'; addviewcount(this);">
														<div id="img-items" style=" background:url('${path}/resources/upload/${ vo.image1 }'),url('${path}/images/no_image.gif');background-size:cover; background-position:center; background-repeat:no-repeat;"></div>
														<%-- <img src="${ path }/resources/upload/${ vo.image1}"
															
															onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';"
															class="card-img-top" alt="..."> --%>
														<div class="card-body" style="padding: 10px;">
															<div class="text-start"
																style="height: 30px; display: flex; align-items: center;">
																<c:if test="${ fn:length(vo.title) > 8 }">
																	<b>${fn:substring(vo.title,0,8) }...</b>
																</c:if>
																<c:if test="${ fn:length(vo.title) <= 8 }">
																	${ vo.title }
																</c:if>
																&nbsp;
																<c:if test="${ vo.state eq 2 }">
																	<span
																		style="display: inline-block; padding: 3px; border-radius: 5px; background: green; color: #fff; font-size: 0.8rem;">예약중</span>
																</c:if>
																<c:if test="${ vo.state eq 3 }">
																	<span
																		style="display: inline-block; padding: 3px; border-radius: 5px; background: gray; color: #fff; font-size: 0.8rem;">거래완료</span>
																</c:if>
															</div>
															<div>
																<span style="color: #00AAB2;"><fmt:formatNumber value="${vo.price}" pattern="#,###"/></span>원
															</div>
															<div class="text-end" id="itemtext">
																<img src="${path}/images/icon_wish_count.png"
																	style="width: 26px; padding: 2px;"> ${ vo.wishCount }&nbsp;<img
																	src="${path}/images/icon_chat_count.png"
																	style="width: 28px; padding: 1px;"> ${ vo.chatCount }
															</div>
														</div>
													</div>
												</div>

											</c:forEach>
										</c:if>
										<!-- Products tab & slick -->
									</div>
									<!-- /row -->
								</div>
								<!-- /container -->
							</div>
							<!-- /SECTION -->
						</div>
					</div>
			</div>
		</div>
	</main>
</div>


</div>




		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		


</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
 <script src="https://getbootstrap.kr/docs/5.1/examples/offcanvas-navbar/offcanvas.js"></script>
</body>
</html>
