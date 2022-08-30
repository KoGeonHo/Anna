<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	
	<title>안녕? 나야!</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
	<meta charset="UTF-8">
	
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>





		    

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->

<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 
<link rel="stylesheet" href="${ path }/css/boardlist1.css" type="text/css" />
<link href="${ path }/css/mfb.css" rel="stylesheet">


		
<!--   Slick Slider -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>	
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!--   Slick Slider -->
	
	
<!-- path는 request.getContextPath()를 가져온것. -->	


<style>


</style>	
<style>

/*
반응형 기준 기록
	아주작은(xs)  576px 미만	  스마트폰 세로
	작은(sm) 	  576px 이상	  스마트폰 가로
	중간(md)	  768px 이상	  타블렛
	큰(lg)   	  992px 이상	  데스크탑
	아주큰(xl)	  1200px 이상	  큰 데스크탑
*/


.nickName{

font-size :12px;
margin: 0 5px 0 0;
}

.wdate{

font-size :12px;
margin: 0 5px 0 0;
}

.hit{

font-size :12px;
margin: 0 5px 0 0;
}


.com-btn{
    display: block;
    margin-left: 5px;
    width: 30px;
    height: 50px;
    background: #f7f7f7;
    border-radius: 5px;
    text-align: center;
    line-height: 11px;

}

.com-btn > span{

font-size: 11px;
display: block;

}

.com-btn > .ccount{

padding: 12px 0 5px;

}

a{

text-decoration: none;

}

.custom-table-responsive {
  background-color: #efefef;
  padding: 20px;
  border-radius: 4px; }
  
.custom-table .tr .td, .title {
    background: #fff;
    border: none; }
    


@media all and (577px <= width <= 767px){

	.search-control{
	
	width:300px;

	}
	
	#search >*{
	
	font-size: 15px;
	
	}
	

}

@media all and (max-width: 576px){

	.search-control{
		width:75%;
		
		}
		
	#search >*{
	

	
	}

}

@media all and (max-width : 767px){

	.tabs{
	
	display:none;
	
	}

	.pageing{
	
	width:40%;
	
	}
	


	#search{
	
	margin:25px 0 0 0;
	
	}
	
	#btn{
	
	margin:25px 0 0 0;
	
	}
	
	
	.m-none{
	
	display: none;
	
	}
	.con{

	width: calc(100% - 35px);
	
	}
	
	.title{
	
	text-align: left;
	width: calc(100% - 35px);
	text-overflow: ellipsis;
	white-space  : nowrap;
	overflow     : hidden;
	
	}
	
	.mdiv{
	
	height:100px;
	
	}
	


	#mlist >*{
	
	display: block;
	
	}
	
	#plist > *{
	
	display: none;
	
	}
	
	#plist-top > *{
	
	display: none;
	
	}


		
	.p{
	
	display:none;
	
	}
	
	.value{
	
	display:block;
	
	}
	
}

@media all and (min-width : 768px){

	.pageing{
	
	width:30%;
	
	}

	.mdiv{
	
	height:150px;
	
	}


	#plist > *{
	
	display: block;
	
	}
	


	
	#plist-top > *{
	
	display: table-cel;
	
	}
	
	#mlist > *{
	
	display: none;
	
	}

	.title{

	width: 40%;
	text-align:center !important;
	padding: 10px;
    display: table-cell;
    
	white-space  : nowrap;
	overflow : hidden;
	text-overflow: ellipsis;
	}
	
	.value{
	
	display:none;
	
	}


}



  
</style>





</head>
<body>

<div class="wrapper">
<!-- 헤더 및 메뉴 -->
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
	<div class="main" id="main" style="overflow: auto; flex:1; width:100%;">
		
		<img alt="" src="../images/board_bn.jpg" style="width:100%; margin-bottom: 34px;" class="m-none">
		
		<div class="container">
		<c:if test="${pm.board_type ne 'notice' }">
			<div class="tabs" style="text-align: center; padding-left: 30px; padding-right: 30px;">
				<input id="tab1" type="radio" name="tab_btn" onclick='location.href="${path}/board/boardlist.do?board_type=free<c:if test="${pm.searchUidx != null and pm.searchUidx != 0}">&searchUidx=${pm.searchUidx}</c:if><c:if test="${pm.location_auth != null }">&location_auth=${pm.location_auth}</c:if>";'<c:if test="${ pm.board_type eq 'free' }">checked</c:if>  />
				<label for="tab1">일상&amp;소통</label>
				<input id="tab2" type="radio" name="tab_btn" onclick='location.href="${path}/board/boardlist.do?board_type=job<c:if test="${pm.searchUidx != null and pm.searchUidx != 0}">&searchUidx=${pm.searchUidx}</c:if><c:if test="${pm.location_auth != null }">&location_auth=${pm.location_auth}</c:if>";'<c:if test="${ pm.board_type eq 'job' }">checked</c:if>/>
				<label for="tab2">구인&amp;구직</label>
				<input id="tab3" type="radio" name="tab_btn" onclick='location.href="${path}/board/boardlist.do?board_type=meeting<c:if test="${pm.searchUidx != null and pm.searchUidx != 0}">&searchUidx=${pm.searchUidx}</c:if><c:if test="${pm.location_auth != null }">&location_auth=${pm.location_auth}</c:if>";'<c:if test="${ pm.board_type eq 'meeting' }">checked</c:if>/>
				<label for="tab3">모임</label>
				<input id="tab4" type="radio" name="tab_btn" onclick='location.href="${path}/board/boardlist.do?board_type=hotplace<c:if test="${pm.searchUidx != null and pm.searchUidx != 0}">&searchUidx=${pm.searchUidx}</c:if><c:if test="${pm.location_auth != null }">&location_auth=${pm.location_auth}</c:if>";'<c:if test="${ pm.board_type eq 'hotplace' }">checked</c:if>/>
				<label for="tab4">핫플레이스</label>
				<div class="line"></div>
			</div>
		</c:if>
		
		<c:if test="${pm.searchUidx != null and pm.searchUidx != 0 }">
			
			<div style="margin: -25px 0 20px 0;"><span style="font-size: 23px;">${search_nickName}님이 작성하신 글</span></div>
			
		</c:if>
		
	
		<div class="col-md-12  col-sm-12 " style=" display: flex; ">
			<div style="flex:1">
				<form method="get" action="boardlist.do" class="d-flex "  id="search">
					
					<input type="hidden" value="${pm.board_type}" name="board_type" id="board_type">
					
					<c:if test="${pm.board_type != 'free'}">
					<input type="hidden" value="1" name="page">	
					</c:if>
					
					<c:if test="${pm.board_type == null }">
					<input type="hidden" value="${pm.searchUidx}" name="searchUidx">
					</c:if>
					
					<c:if test="${pm.location_auth != null }">	
					<input type="hidden" value="${pm.location_auth}" name="location_auth">
					</c:if>
					
					<input type="text" name="SearchVal" class="search-control" <c:if test="${!empty pm.searchVal}">value="${pm.searchVal}"</c:if> placeholder="검색어를 입력해주세요">
					<input type="submit" value="검색" class="btn btn-outline-primary">
					
				</form>
			</div>
			<div>
				<c:if test="${ pm.board_type eq 'free' }">
					<button type="button" id="btn"class="btn" style="background-color: #00AAB2;color: #fff; float:right;" onclick="javascript:location.href='${ path }/board/BoardWrite.do?board_type=${ pm.board_type }';">글쓰기</button>
				</c:if>
			</div>
			
		</div>

		<form>
			

		<c:if test="${pm.board_type eq 'free'}">
			<c:if test="${board.size() ==0}">		
				<div style="margin: 15px 0 0 0;"><span style="font-size:25px">등록된 게시물이 없습니다.</span></div>
			</c:if>
		
			<div id="bo_gall" style="width:100%">
				<ul id="gall_ul" class="gall_row">
			
			<c:if test="${board.size()>0}">
				<c:forEach var="vo" items="${board}">
					
					<li class="gall_li col-gn-4 gallWST" style="margin-bottom:5px;">
            			<div class="gall_box" >
                			<div class="gall_con">
                    			<div class="gall_boxa">
                        			<a href="viewBoard.do?Bidx=${vo.bidx}">
                  						<em class="iconPs bo_tit"></em>
                  						<i class="imgAr">
                  							<img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}" alt="없어요" onerror=this.src="../images/no_imgborder.jpg" style="width :200px; height : 200px">
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
			                            <c:if test="${ fn:length(vo.title) > 10 }">
											<b>${fn:substring(vo.title,0,9) }...</b>
										</c:if>
										<c:if test="${ fn:length(vo.title) <= 10 }">
											<b>${ vo.title }</b>
										</c:if>
			                        </a>
			                        <span style="float:right;"><img src="../images/icon_comment.png" style="margin-top: -1px; margin-right: 3px; height: 15px;">${vo.ccount}</span>
			                        <span style="float:right;"><img src="../images/icon_like.png" height="23px" style="margin-top:-4px;">${vo.cntLike}</span>
			                    </div>
			                </div>
            			</div>
        			</li>
					
				</c:forEach>
			</c:if>

				</ul>
			</div>	
		</c:if>
		<c:if test="${pm.board_type != 'free'}">
			<div class="table-responsive custom-table-responsive">
				<div class="list custom-table">
					<div class="tr border-bottom" id="plist-top">
						<div class="th" style="width:40%;">제목</div>
						<div class="th" style="width:20%;">작성자</div>
						<div class="th" style="width:20%;">작성일</div>
						<div class="th" style="width:10%;">조회수</div>
						<div class="th" style="width:10%;">추천</div>
					</div>
					<c:if test="${board.size() ==0}">		
						<div style="margin: 15px 0 0 0;"><span style="font-size:25px">등록된 게시물이 없습니다.</span></div>
					</c:if>
						<c:if test="${ not empty board }">
							<c:forEach var="vo" items="${ board }">
		
								<div class="tr border-bottom d-flex">
									
										
											<div class="title" onClick="location.href='<%=request.getContextPath()%>/board/viewBoard.do?Bidx=${vo.bidx}'">
												<span style="font-weight:bold" class="p">${vo.title }</span>
													<div class="value">
														<span  style="font-weight:bold">${vo.title }</span>
														<c:if test="${vo.image1 != null}">
															<span><img src="../images/icon_image.png" style="height:15px; margin-top: -5px;"></span>
														</c:if>
													</div>
												
												<div class="value">
													<span class="nickName">
														<c:if test="${pm.board_type ne 'notice' }">
															${ vo.nickName }
														</c:if>
														<c:if test="${pm.board_type eq 'notice' }">
															관리자
														</c:if>
													</span> 
													<span class="hit">조회${vo.hit}</span>
													<span class="wdate">${vo.wdate }</span>
												</div>
											</div>
										
											<a class="com-btn value">
												<span class="ccount">${vo.ccount }</span>
												<span>댓글</span>
											</a>
											<div class="td text-center p" style="width:20%;">
												<c:if test="${pm.board_type ne 'notice' }">
													${ vo.nickName }
												</c:if>
												<c:if test="${pm.board_type eq 'notice' }">
													관리자
												</c:if>
											</div>
											<div class="td text-center p" style="width:20%;">${ vo.wdate }</div>
											<div class="td text-center p" style="width:10%;">${ vo.hit }</div>
											<div class="td text-center p" style="width:10%;">${ vo.cntLike}</div>
										
								</div>
								
							
							</c:forEach>
						</c:if>
					</div>
			
			
				
		<div class="container">
			<div class="bs-component mb-3">
				<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups" style="justify-content: space-around;">
					<div class="btn-group me-2" role="group" aria-label="First group">
						<c:if test="${pm.isPrev() == true}">
							<button type="button" class="btn btn-secondary" onclick="location.href='${ path }/board/boardlist.do?board_type=${pm.board_type}&page=${pm.getStartPage()-1}<c:if test="${pm.searchVal != null }">&SearchVal=${pm.searchVal}</c:if><c:if test="${pm.searchUidx != null and pm.searchUidx != 0}">&searchUidx=${pm.searchUidx}</c:if><c:if test="${pm.location_auth != null }">&location_auth=${pm.location_auth}</c:if>'">
								◀
							</button>
						</c:if>
						<c:forEach var="i" begin="${pm.getStartPage()}" end="${pm.getEndPage()}">
							<button type="button" class="btn btn-secondary" onclick="location.href='${path}/board/boardlist.do?<c:if test="${pm.board_type != null }">board_type=${pm.board_type}</c:if>&page=${i}<c:if test="${pm.searchVal != null }">&SearchVal=${pm.searchVal}</c:if><c:if test="${pm.searchUidx != null and pm.searchUidx != 0}">&searchUidx=${pm.searchUidx}</c:if><c:if test="${pm.location_auth != null }">&location_auth=${pm.location_auth}</c:if>'">${i}</button>
						</c:forEach>
						<c:if test="${pm.isNext() && pm.getEndPage() >0}" >
							<button type="button" class="btn btn-secondary" onclick="location.href='${ path }/board/boardlist.do?board_type=${pm.board_type}&page=${pm.getEndPage()+1}<c:if test="${pm.searchVal != null }">&SearchVal=${pm.searchVal}</c:if><c:if test="${pm.searchUidx != null and pm.searchUidx != 0}">&searchUidx=${pm.searchUidx}</c:if><c:if test="${pm.location_auth != null }">&location_auth=${pm.location_auth}</c:if>'">
								▶
							</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		
				<c:if test="${ pm.board_type eq 'notice' }">
					<c:if test="${ userLoginInfo.isAdmin eq 'Y' }">
						<button type="button" id="btn" class="btn" style="background-color: #00AAB2;color: #fff; float:right;" onclick="javascript:location.href='${ path }/board/BoardWrite.do?board_type=notice';">글쓰기</button>
					</c:if>
				</c:if>
					<c:if test="${ pm.board_type ne 'notice' and pm.board_type ne 'free' }">
						<button type="button" id="btn" class="btn" style="background-color: #00AAB2;color: #fff; float:right;" onclick="javascript:location.href='${ path }/board/BoardWrite.do?board_type=${pm.board_type}';">글쓰기</button>
					</c:if>
				
			
		</div>
			<div class="mdiv"></div>
			</c:if>
	
		</form>

			

	
</div>

      <!-- 퀵메뉴 시작 -->
      <%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>         
      <!-- 퀵메뉴 종료 --> 

		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</div>
<script>
//스크롤 시 이벤트 처리

var board_type = $("#board_type").val();

if(board_type =='free'){ //board_type 이 free일때만 작동한다.
	
//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
let currentPage = 1;
//현재 페이지가 로딩중인지 여부를 저장할 변수
let isLoding=false;

$(function(){
	
//웹브라우저의 창을 스크롤할 때마다  호출되는 함수 등록
   $("#main").on("scroll",function(){
	   
var scrollTop = $(this).scrollTop();
var innerHeight = $(this).innerHeight();
var scrollHeight = $(this).prop('scrollHeight');

        
       if((scrollTop + innerHeight)+1 >= scrollHeight){
          
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
	
		url : "ajax_board.do",
		method : "GET",
		//검색 기능이 있는 경우 seachType과 seachVal를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른 것들이 덧붙여져 나온다.
		data : "board_type=${pm.board_type}&pagenumber="+currentPage+"&SearchVal=${pm.searchVal}&searchUidx=${pm.searchUidx}&location_auth=${pm.location_auth}",
		//FreeBoard.jsp의 내용이 data로 들어온다. 
		success:function(data){
			 //console.log(data.appendList);
		
			let appendList = data.appendList;
	         let html = "";
	         
	         for(let i = 0; i < appendList.length; i++){
	            //console.log(appendList[i].uidx);
	            html += '<li class="gall_li col-gn-4 gallWST">';
	            html += '<div class="gall_box">';
	            html += '<div class="gall_con">';
	            html += '<div class="gall_boxa">';
	            html += '<a href="viewBoard.do?Bidx='+appendList[i].bidx+'&board_type='+appendList[i].board_type+'">';
	            html += '<em class="iconPs bo_tit"></em>';
	            html += '<i class="imgAr">';
	            html += '<img src="<%=request.getContextPath()%>/resources/upload/t-'+appendList[i].Image1+'"alt="없어요"onerror=this.src="../images/no_imgborder.jpg" style="width :200px; height : 200px"></i>';
	            html += '<em class="gall_info">';
	            html += '<span>조회 </span>';
	            html += '<i class="fa fa-eye" aria-hidden="true"></i>';
	            html += ''+appendList[i].hit+'';
	            html += '<span class="gall_date">';
	            html += '<span>작성일</span>';
	            html += '<i class="fa fa-clock-o" aria-hidden="true"></i>';
	            html += ''+appendList[i].wdate+'</span>';
	            html += '<u><span>작성자 </span>'+appendList[i].nickName+'</u>';
	            html += '</em></a></div>';
	            html += '<div class="gall_text_href bo_tit">';
	            html += '<a href="viewBoard.do?Bidx='+appendList[i].bidx+'&board_type='+appendList[i].board_type+'" style="float:left;">'
	            
	            if(appendList[i].title.length >= 10){
	            	 html += ''+appendList[i].title+'</a>'
				}else{
					 html += ''+appendList[i].title+'</a>'
				}
	           
	            html += '<span style="float:right;"><img src="../images/icon_comment.png" style="margin-top: -1px; margin-right: 3px; height: 15px;">'+appendList[i].ccount+'</span>';
	            html += '<span style="float:right;"><img src="../images/icon_like.png" height="23px" style="margin-top:-4px;">'+appendList[i].cntLike+'</span>';
	         	html += '</div></div></div></li>';
	         }

			//console.log(data);
			//응답된 문자열은 html형식이다. 
			//해당 문자열은 .card-list-container div에 html로 해석하라고 추가한다.
			$("#gall_ul").append(html);
			//로딩바를 숨긴다.
			$(".back-drop").hide();
			//로딩중이 아니라고 표시한다.
			isLoding=false;
			//console.log("ajax"); 
		}	
	});
  }
}

</script>
<script>

$(".view").mouseover(function(){
	$(".viewimg").css("display","block")
	
	});

$(".view").mouseout(function(){
	$(".viewimg").css("display","none")
	
});

$("input[name='tab_btn']").change(function(){
	

	if($("input[name='tab_btn']:checked").val() == 'free'){
	
		
	}

});

</script>




</body>
</html>