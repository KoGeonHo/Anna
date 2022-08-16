<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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





		    

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->

<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/mfb.css" rel="stylesheet">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 
<link rel="stylesheet" href="${ path }/css/boardlist1.css" type="text/css" />


		
<!--   Slick Slider -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>	
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!--   Slick Slider -->
	
	
<!-- path는 request.getContextPath()를 가져온것. -->	


	
<style>

/*
반응형 기준 기록
	아주작은(xs)  576px 미만	  스마트폰 세로
	작은(sm) 	  576px 이상	  스마트폰 가로
	중간(md)	  768px 이상	  타블렛
	큰(lg)   	  992px 이상	  데스크탑
	아주큰(xl)	  1200px 이상	  큰 데스크탑
*/


  
</style>





</head>
<body>

<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		
		
		
			<div class="main" id="main" style="overflow: auto;">

		
			<img alt="" src="../images/board_bn.jpg" style="width:100%; margin-bottom: 34px;">
			
	<div class="container">
		<div class="col-md-12  col-sm-12 d-flex">
			<form method="get" action="boardlist.do?" class="d-flex ">
				<input type="hidden" value="${pm.board_type}" name="board_type" id="board_type">
				<c:if test="${pm.board_type != 'free'}">
				<input type="hidden" value="1" name="page">
				</c:if>
				<%-- <select name="SearchType" class="border rounded-2">
					<option value="All" <c:if test="${!empty pm.searchType and pm.searchType eq 'All'} ">selected</c:if>>전체</option>
					<option value="title" <c:if test="${!empty pm.searchType and pm.searchType eq 'title' }">selected</c:if>>제목</option>
					<option value="contentWriter" <c:if test="${!empty pm.searchType and pm.searchType eq 'contentWriter' }">selected</c:if>>내용+작성자</option>
				</select> --%>
				<input type="text" name="SearchVal" class="search-control" <c:if test="${!empty pm.searchVal}">value="${pm.searchVal}"</c:if> placeholder="검색어를 입력해주세요">
				<input type="submit" value="검색" class="btn btn-outline-primary">
			</form>
			
			
			<button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='${ path }/board/BoardWrite.do';">글쓰기</button>
		</div>
			
			<form>
			
			<c:if test="${board.size() ==0}">		
				<h3>등록된 게시물이 없습니다.</h3>
			</c:if>
		<c:if test="${pm.board_type eq 'free'}">	
			<div id="bo_gall" style="width:100%">
				<ul id="gall_ul" class="gall_row">
			
			<c:if test="${board.size()>0}">
				<c:forEach var="vo" items="${board}">
					
					<li class="gall_li col-gn-4 gallWST" style="margin-bottom:5px;">
            			<div class="gall_box" >
                			<div class="gall_con">
                    			<div class="gall_boxa">
                        			<a href="viewBoard.do?Bidx=${vo.bidx}&board_type=${vo.board_type}">
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
			                    	<a href="viewBoard.do?Bidx=${vo.bidx}&board_type=${vo.board_type}" style="float:left;">
			                            ${vo.title }
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
		<div class="list">
				
						<div class="tr border-bottom">
							<div class="th" style="width:50%;">제목</div>
				
							<div class="th" style="width:20%;">작성자</div>
							<div class="th" style="width:20%;">작성일</div>
							<div class="th" style="width:10%;">조회수</div>
						</div>
						<c:if test="${ not empty board }">
							<c:forEach var="i" items="${ board }">
								<div class="tr border-bottom">
									<div class="td text-center" style="width:50%;"><a href="<%=request.getContextPath()%>/board/test.do?Bidx=${i.bidx}&board_type=${i.board_type}">${ i.title }</a></div>
									<div class="td text-center" style="width:20%;">${ i.nickName }</div>
									<div class="td text-center" style="width:20%;">${ i.wdate }</div>
									<div class="td text-center" style="width:10%;">${ i.hit }</div>
								</div>
							</c:forEach>
						</c:if>
			</div>
			
			<table style="width:800px;text-align:center;">
				<tr>
					
			<c:if test="${pm.isPrev() == true}">
				<td style="width:300px;text-align:right;">
				<a href="${ path }/board/boardlist.do?board_type=${pm.board_type}&page=${pm.getStartPage()-1}&SearchVal=${pm.searchVal}">◀</a>
					</td>
			</c:if>
					
			

					
			<c:forEach var="i" begin="${pm.getStartPage()}" end="${pm.getEndPage()}">
				<td>
    			<span><a href="${ path }/board/boardlist.do?board_type=${pm.board_type}&page=${i}&SearchVal=${pm.searchVal}">${i}</a></span>
				</td>
			</c:forEach>
				
				
			<c:if test="${pm.isNext() && pm.getEndPage() >0}" >
				<td style="width:300px;text-align:left;">
					<a href="${ path }/board/boardlist.do?board_type=${pm.board_type}&page=${pm.getEndPage()+1}&SearchVal=${pm.searchVal}">▶</a>
				</td>
			</c:if>
			
				</tr>
			</table>
			</c:if>
			
		
				
				
			</form>

			

	</div>
</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
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
          console.log(isLoding+"겁나찍힘");
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
		data : "board_type=${pm.board_type}&pagenumber="+currentPage+"&SearchType=${searchType}&SearchVal=${searchVal}",
		//FreeBoard.jsp의 내용이 data로 들어온다. 
		success:function(data){
			 console.log(data.appendList);
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
	            html += '<img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}"alt="없어요"onerror=this.src="../images/no_imgborder.jpg" style="width :200px; height : 200px"></i>';
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
	            html += '<a href="viewBoard.do?Bidx='+appendList[i].bidx+'&board_type='+appendList[i].board_type+'" style="float:left;">'+appendList[i].title+'</a>'
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



</script>




</body>
</html>