<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>


<meta charset="utf-8">
<title>중고물품 리스트</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script> 
<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet"/>

<%-- <link type="text/css" rel="stylesheet" href="${path}/css/slick.css"/> --%>
<%-- 
<link rel="stylesheet" href="${path}/css/font-awesome.min.css"> --%>
		
<link type="text/css" rel="stylesheet" href="${path}/css/style.css"/>

<link href="${path}/css/bootstrap.css" rel="stylesheet" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/mfb.css" rel="stylesheet">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 

<script>
	
	$(function(){
		$("#btn_open").click(function(){ //레이어 팝업 열기 버튼 클릭 시
		console.log("채팅창 목록 열림")
			$('#popup').bPopup();
		});
		$("#btn_close").click(function(){ //닫기
			$('#popup').bPopup().close();  
		});			
	
	});


/* 
	function Chat__List() {
		$.get('./mychatlist',{
		chat_host : ${userLoginInfo.uidx}
		}, function(data) {
			for ( let i = 0; i < data.length; i++ ) {
				var mychatlist = data[i];
				Chat__drawMessages(mychatlist);
			}
			//setTimeout(Chat__loadNewMessages,1000);
		}, 'json');
	
	}
	function Chat__drawMessages(mychatlist) {
		var html = mychatlist.nickName+' 님과의 거래';
			$('.mychatlist').append(' <div>  <a class="chat">'+ html + '</a></div>');
	}
	$(function() {
		Chat__List();
		
	}); */
	/* 
	$(function(){
		$(".chat").click(function(){
			console.log("asd");
			$('#popup').bPopup();
		});
	});
 */
	//스크롤 시 이벤트 처리
	console.log("hi");
	//위로 스크롤된 길이


	//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
	let currentPage = 1;
	//현재 페이지가 로딩중인지 여부를 저장할 변수
	let isLoding=false;
	$(function(){
	   $("#main").on("scroll",function(){
		   console.log("ㅇㅇ");
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
	        	 
				html +='<div class="card-container" style="display:inline-block; font-size:1rem; flex:none; padding:5px;">';
				html +='<div class="card" style="margin:5px;" onclick="location.href=\'${path}/boarditem/itemview.do?item_idx='+appendList[i].item_idx+'\'">';
				html +='<img src="${ path }/resources/upload/'+appendList[i].image1+'" style="width:100%; height:210px;" onerror="this.onerror=null; this.src=\'${path}/images/no_image.gif\';" class="card-img-top" alt="...">';
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
				html +='<div class="text-end">';
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
<style>

/* .section .container . row. .col-lg-3 .row .products-tabs  .product .product-img  img{
width:100%;
height:160px;

} */


.cate_menu {
	list-style:none;
	margin:20px;
	padding-inline-start:0px;
}
.cate_menu li{
	display:inline-block;
	margin-right:20px;
	padding-right:5px; 
	padding-left:5px; 
	background-color: gainsboro;  
	border-radius: 6px;  
	color:grey;
	cursor:pointer;
}


.Pstyle {
	 opacity: 0;
	 display: none;
	 position: relative;
	 width: auto;
	 border: 5px solid #fff;
	 padding: 20px;
	 background-color: #fff;
	}    		
.Pstyle2{
	 opacity: 0;
	 display: none;
	 position: relative;
	 width: auto;
	 border: 5px solid #fff;
	 padding: 20px;
	 background-color: #fff;
	}    		
#container{
	height:5000px;
}
#log{
	position:fixed;
	top:0;
	left:0;
 	right:0;
	margin:0;
	height:200px;	
	background-color:rgba(0,0,0,0.7);	
	text-align:center;
	line-height:50px;
}
#container span{
	color:white;
}
#b{
	display:none;
}

a:link {
  color : black;
  text-decoration: none;
}

.box {float:left; overflow: hidden;}
.box-inner {width: auto; padding: 10px;}

/* max가  0부터 ~ 까지라는뜨 */
/* 반응형 */@media all and (max-width:  767px){
   
   #myCarousel, #search, #bestitem, #boardlist, #productname  {
      display:none;
   }
   
   #itemlist {
      margin-top: -106px;
   }
 
 	

	
	#search-area{
		width:100%;
		text-align:center;
	}
	
 
 #Wish_area{
	width:16px;
	height: 16px;
	}
	
	 #Wish_area .image { 
	width: 16px;
	height : 16px;
	position:relative;text-align:center;color:#FFFFFF; 
	}
	 #Wish_area .image p { position: absolute;top:50%;left:50%;
			transform: translate(-50%, -50%);/*  background-color:#FFFFFF; */
			text-shadow: -1px 0 1px black, 0 1px 1px black, 1px 0 1px black, 0 -1px 1px black; 
			margin : auto;}
	}
	
	
}
@media all and (min-width :400px){
.product-img{
	width : 100%;
	heigh : 100%;
}





	  #Wish_area{
	width:16px;
	height: 16px;
	}
	
	 #Wish_area .image { 
	width: 16px;
	height : 16px;
	position:relative;text-align:center;color:#FFFFFF; 
	}
	#Wish_area .image p { position: absolute;top:50%;left:50%;
			transform: translate(-50%, -50%);/*  background-color:#FFFFFF; */
			text-shadow: -1px 0 1px black, 0 1px 1px black, 1px 0 1px black, 0 -1px 1px black; 
			margin : auto;}
	
		
	 #search-area{
		width:100%;
		text-align:center;
	}
	

	
}

@media all and (min-width :1400px){
	.card-container {
		width:20%;
	}

}

@media all and (max-width :1399px){
	.card-container {
		width:25%;
	}

}

@media all and (max-width :1199px){
	.card-container {
		width:33.3333%;
	}

}

@media all and (max-width :991px){
	.card-container {
		width:50%;
	}

}
@media all and (max-width:  767px){
	
	.card-container {
		width:100%;
	}
	
	
	
}

</style>
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div id="main" class="wrapper">
			<div class="container main">
			
			
				<!-- 용도가 무엇인지? -->
				<input type="hidden" name="uidx" value="${userLoginInfo.uidx}">
				<!--  -->
				
				
				
				<div class="categories text-center">
					<ul class="cate_menu">
						<li onclick="location.href='itemlist.do'">전체</li>
						<li onclick="location.href='itemlist.do?cate_idx=1'">가전제품</li>
						<li onclick="location.href='itemlist.do?cate_idx=2'">생활용품</li>
						<li onclick="location.href='itemlist.do?cate_idx=3'">완구&취미</li>
						<li onclick="location.href='itemlist.do?cate_idx=4'">패션&의류</li>
						<li onclick="location.href='itemlist.do?cate_idx=5'">인테리어</li>
						<li onclick="location.href='itemlist.do?cate_idx=6'">반려동물용품</li>
						<li onclick="location.href='itemlist.do?cate_idx=7'">뷰티&악세</li>
						<li onclick="location.href='itemlist.do?cate_idx=8'">자동차용품</li>
						<li onclick="location.href='itemlist.do?cate_idx=9'">스포츠&레저용품</li>
					</ul>
				</div>
				
				
				
				
				
				<!-- <br>
				<br>
	
			<div id="asd">
				카테고리 
					<div>
						div style="width:100px; background-color:grey;"class="slide-toggle">
					카테고리
						</div>																				
						<div style="">
							<div class="box">
							    <div class="box-inner" style="width:100%;">
							    	<ul class="cate_menu">
										<li  style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do" ><span style="color:grey;">전체</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=1" style=""><span style="color:grey;">가전제품</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=2" style="background-color: gainsboro; border-radius: 6px;"><span style="color:grey;">생활용품</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=3" style="background-color: gainsboro; border-radius: 6px;"><span style="color:grey;">완구&취미</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=4" style="background-color: gainsboro; border-radius: 6px;"><span style="color:grey;">패션&의류</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=5" style="background-color: gainsboro; border-radius: 6px;"><span style="color:grey;">인테리어</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=6" style="background-color: gainsboro; border-radius: 6px;"><span style="color:grey;">반려동물용품</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=7" style="background-color: gainsboro; border-radius: 6px;"><span style="color:grey;"> 뷰티&악세</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=8" style="background-color: gainsboro; border-radius: 6px;"><span style="color:grey;">자동차용품</span></a></li>
										<li style="padding-right:5px; padding-left:5px; background-color: gainsboro;  border-radius: 6px;  border-radius: 6px;"><a href="itemlist.do?cate_idx=9" style="background-color: gainsboro; border-radius: 6px;"><span style="color:grey;">스포츠&레저용품</span></a></li>
									</ul>
							    </div>
							</div>
						</div>		
					</div>		
				카테고리 끝
			</div> -->
				<div>
				<!-- 검색창 시작 -->
				
				<div class="searchFrm text-center" style="margin:20px;">
					<div style="display:flex;">
						<div style="flex:1; margin-right:10px;">		
							<form method="get" action="itemlist.do">
								<input class="form-control text-center" type="text" name="searchVal" class="search-control" placeholder="검색어를 입력해주세요" value="${pm.searchVal}">
							</form>
						</div>
						<input type="submit" value="검색" class="btn btn-outline-primary">
					</div>
				</div>
				<%-- <div class="col-md-12  col-sm-12 d-flex" id="search-area">
					<form method="get" action="itemlist.do"  class="d-flex">
						<input type="text" name="searchVal" class="search-control" placeholder="검색어를 입력해주세요"
							<c:if test="${!empty svo.searchVal}">
							value=${svo.searchVal}
							</c:if>>
						<input type="submit" value="검색" class="btn btn-outline-primary">
					</form>
						<button class="btn" style="background-color: #00AAB2; color: #fff;" onclick='location.href="itemwrite.do"'>글쓰기</button>
				</div> --%>
				<!-- 검색창 끝 -->
					<c:if test="${!empty pm.searchVal}">
						<c:forEach var="vo" items="${ssang}">
							<h1>${userLoginInfo.nickName} 님이 검색하신 ${pm.searchVal} 의 최저가 상품입니다</h1>
							
					<%-- 		<div class="col-lg-3">
							<div class="row">
								<div class="products-tabs">
									<!-- tab -->
											<!-- product -->
											<div class="product">
												<div class="product-img">
													<a href="itemview.do?item_idx=${vo.item_idx}"><img src="../resources/upload/${vo.image1}" onerror=this.src="../images/noimg_item.jpg" ></a>
												</div>
												<div class="product-body">
													<h3 class="product-name"><a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h3>
													
													<h4 class="product-price">지역번호 ${vo.addr_code} </h4>
													<h4 class="product-price">${vo.price} 원</h4>
													<c:if test="${vo.state==1}">
													<h4 class="product-price">거래중</h4>
													</c:if>												
													<c:if test="${vo.state==2}">
													<h4 class="product-price">예약중</h4>
													</c:if>												
													<c:if test="${vo.state==3}">
													<h4 class="product-price">거래완료</h4>
													</c:if>										
													${vo.hit} 조회수
												<div id="Wish_area">
													<c:if test="${vo.wishCheck == 0 }">
															<div class="image">
																<img src="../images/Wish_off.png" style="width:50px; height:50px;" >
																<p>${vo.wishCount}</p>
															</div>
													</c:if>
										
													<c:if test="${vo.wishCheck != 0}">
														<div class="image">
															<img src="../images/Wish_on.png" style="width:50px; height:50px;"  >
															<p style="background-color:ce3746;">${vo.wishCount}</p>
														</div>
													</c:if> 
												</div>
												</div>
											</div>
											<!-- /product -->
										<div id="slick-nav-1" class="products-slick-nav"></div>
									</div>
									<!-- /tab -->
								</div>
							</div>
							 --%>
							<div class="col-lg-3  col-md-12 ">
								<div class="card" >
									<a href="itemview.do?item_idx=${vo.item_idx}"><img src="../resources/upload/${vo.image1}" onerror=this.src="../images/noimg_item.jpg" ></a>
									<div class="card-body" style ="text-align: center; padding-top: 5px; ">											
													<h7 class="card-title"  style="color:#E52421; font-weight :  bold; font-size:14px;">
												<c:if test="${vo.state==1}">
													<h7 class="product-price"  >거래중</h7>
												</c:if>												
												<c:if test="${vo.state==2}">			
													<h7 class="product-price" >예약중</h7>
												</c:if>												
												<c:if test="${vo.state==3}" >			
													<h7 class="product-price" >거래완료</h7>
												</c:if>
													</h7>
											<h6 class="card-title" id="itemtitle"	>
												<a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a>
											</h6>
										<p class="card-text" id="itemtitle" style="color : #00AAB2;  font-size:17px">${vo.price}<span style="color:#000;">원</span></p>
											${vo.hit} 조회수123
										<div id="Wish_area">
											<c:if test="${vo.wishCheck == 0 }">
												<div class="image">
													<img src="../images/Wish_off.png" style="width: 16px; height: 16px;" >
													<span>${vo.wishCount}</span>
														</div>
											</c:if>
																	
											<c:if test="${vo.wishCheck != 0}">
												<div class="image">
													<img src="../images/Wish_on.png" style="width:16px; height:16px;"  >
													<span style="background-color:ce3746;">${vo.wishCount}</span>
												</div>
											</c:if> 
										</div>											
									</div>
								</div>
							
						</div>
						<br><br>
						</c:forEach>
					</c:if>
					<c:if test="${!empty pm.searchVal and ssang.size()==0}">
					검색 결과가 없습니다.
					</c:if>
				</div>
	
		<div class="section" style="padding:0px;">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row" id="item_list">
						<!-- Products tab & slick -->
						<c:if test="${list.size() > 0}">
							<c:forEach var="vo" items="${list}">
								<script>
									function addviewcount(obj) {
										
										$.post('./addviewcount',{
											item_idx : ${vo.item_idx},
										}, function(data) {
										},'json');
											$('.card-img-top').off('click');
											console.log("조회수 증가");
										}
									
								</script>
								<div class="card-container" style="display:inline-block; font-size:1rem; flex:none; padding:5px;">
									<div class="card" style="margin:5px;" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ vo.item_idx }'; addviewcount(this);">
										<img src="${ path }/resources/upload/${ vo.image1}"   style="width:100%; height:210px;" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="...">
										<div class="card-body" style="padding:10px;">
											<div class="text-start" style="height:30px; display:flex; align-items:center;">
												<c:if test="${ fn:length(vo.title) > 8 }">
													<b>${fn:substring(vo.title,0,8) }...</b>
												</c:if>
												<c:if test="${ fn:length(vo.title) <= 8 }">
													${ vo.title }
												</c:if>
												<c:if test="${ vo.state eq 2 }"><span style="display:inline-block; padding:3px; border-radius:5px; background:green; color:#fff; font-size:0.8rem;">예약중</span></c:if>
												<c:if test="${ vo.state eq 3 }"><span style="display:inline-block; padding:3px; border-radius:5px; background:gray; color:#fff; font-size:0.8rem;">거래완료</span></c:if>
											</div>
											<div>
												<span style="color:#00AAB2;">${ vo.price }</span>원
											</div>
									    	<div class="text-end">
									    		<img src="${path}/images/icon_wish_count.png" style="width:26px; padding:2px;"> ${ vo.wishCount }&nbsp;<img src="${path}/images/icon_chat_count.png" style="width:28px; padding:1px;"> ${ vo.chatCount }
									    	</div>
									  	</div>
									</div>
								</div>
								<%-- <div class="col-lg-3  col-md-12 " style="margin-bottom: 10px;">
									<div class="card" style="height:100%;">
										<a href="itemview.do?item_idx=${vo.item_idx}"><img src="../resources/upload/${vo.image1}" onerror=this.src="../images/noimg_item.jpg" ></a>
										<div class="card-body" style ="text-align: center; padding-top: 5px; ">											
														<h7 class="card-title"  style="color:#E52421; font-weight :  bold; font-size:14px;">
													<c:if test="${vo.state==1}">
														<h7 class="product-price"  >거래중</h7>
													</c:if>												
													<c:if test="${vo.state==2}">			
														<h7 class="product-price" >예약중</h7>
													</c:if>												
													<c:if test="${vo.state==3}" >			
														<h7 class="product-price" >거래완료</h7>
													</c:if>
														</h7>
												<h6 class="card-title" id="itemtitle"	>
													<a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a>
												</h6>
											<p class="card-text" id="itemtitle" style="color : #00AAB2;  font-size:17px">${vo.price}<span style="color:#000;">원</span></p>
												${vo.hit} 조회수
											<div id="Wish_area">
												<c:if test="${vo.wishCheck == 0 }">
													<div class="image">
														<img src="../images/Wish_off.png" style="width:16px; height:16px;" >
														<span>${vo.wishCount}</span>
													</div>
												</c:if>
																		
												<c:if test="${vo.wishCheck != 0}">
													<div class="image">
														<img src="../images/Wish_on.png" style="width:16px; height:16px;">
														<span style="background-color:ce3746;">${vo.wishCount}</span>
													</div>
												</c:if> 
											</div>											
										</div>
									</div>
								</div> --%>
							</c:forEach>
						</c:if>
						<!-- Products tab & slick -->
					</div>
					<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /SECTION -->
			
			
		<!-- 무한스크롤부분 -->
		<!-- <div class="container">
			<div class="row card-list">
			<br>
			</div>
		</div> -->
	
		
										<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
										<script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.js"></script>
										<script src ="../js/boardlist.js"></script>
										<!-- <script src="https://cdn.jsivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
										 -->
										<!-- jQuery Plugins -->	
											<!-- 	<script src="../js/slick.min.js"></script>
												<script src="../js/boarditemMain.js"></script> -->
												<!-- <script src="../js/nouiskider.min.js"></script>
												<script src="../js/jquery.zomm.min.js"></script>
									 -->
	
			</div>
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
