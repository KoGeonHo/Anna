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

<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/default.css?ver=1701">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/skin/board/gallery/style.css?ver=171222">
<link rel="stylesheet" href="http://sample.paged.kr/purewhite/theme/pagedtheme/css/board.common.css?ver=1701">

		
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
		
		<div class="wrapper">
			<div class="container main">

		
			

	
			<form method="get" action="boardlist.do?">
				<input type="text" value="${pm.board_type}" name="board_type">
				<select name="SearchType">
					<option value="All" <c:if test="${!empty pm.searchType and pm.searchType eq 'All'} ">selected</c:if>>전체</option>
					<option value="title" <c:if test="${!empty pm.searchType and pm.searchType eq 'title' }">selected</c:if>>제목</option>
					<option value="contentWriter" <c:if test="${!empty pm.searchType and pm.searchType eq 'contentWriter' }">selected</c:if>>내용+작성자</option>
				</select>
				<input type="text" name="SearchVal" <c:if test="${!empty pm.searchVal}">value="${pm.searchVal}"</c:if> placeholder="검색어를 입력해주세요">
				<input type="submit" value="검색">
			</form>
			<c:if test="${pm.board_type eq 'free'}">
				<a href="BoardWrite.do?board_type=free">쓰기</a>
			</c:if>
			<c:if test="${pm.board_type eq 'job'}">
				<a href="BoardWrite.do?board_type=job">쓰기</a>
			</c:if>
			<c:if test="${pm.board_type eq 'meeting'}">
				<a href="BoardWrite.do?board_type=meeting">쓰기</a>
			</c:if>
			<c:if test="${pm.board_type eq 'hotplace'}">
				<a href="BoardWrite.do?board_type=hotplace">쓰기</a>
			</c:if>
			<hr>
			
			<form>
			
			<div id="bo_gall" style="width:100%">
					<ul id="gall_ul" class="gall_row">
			
			<c:if test="${board.size()>0}">
							<c:forEach var="vo" items="${board}">
				
						<li class="gall_li col-gn-3 gallWST">
            				<div class="gall_box">
                				<div class="gall_chk">
                                	<span class="sound_only"></span>
                				</div>
                				<div class="gall_con">
                    			<div class="gall_boxa">
                        			<a href="http://sample.paged.kr/purewhite/bbs/board.php?bo_table=gallery&amp;wr_id=7">
                  					<em class="iconPs bo_tit">
                                             
                                                                   </em>
                  <i class="imgAr"><img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}" alt="없어요" onerror=this.src="../images/noimg.jpg" style="width :200px; height : 200px"></i>                  <em class="gall_info">
                     <span class="sound_only">조회 </span>
                     <i class="fa fa-eye" aria-hidden="true"></i>${vo.hit }<span class="gall_date"><span class="sound_only">작성일 </span><i class="fa fa-clock-o" aria-hidden="true"></i>${vo.wdate }</span>
                     <u><span class="sound_only">작성자 </span>${vo.nickName }</u>
                  </em>
                        </a>
                    </div>
                    <div class="gall_text_href">
                                                <a href="http://sample.paged.kr/purewhite/bbs/board.php?bo_table=gallery&amp;wr_id=7" class="bo_tit">
                            ${vo.title }                                                     </a>
                    </div>
                </div>
            </div>
        	</li>
			
			</c:forEach>
						</c:if>
			
		</ul>
			</div>	
			
				<c:if test="${board.size() ==0}">		
					<h3>등록된 게시물이 없습니다.</h3>
				</c:if>
				<div class="container">
					<div class="row">		
						<c:if test="${board.size()>0}">
							<c:forEach var="vo" items="${board}">
							
						<div class="card col-md-3">
						<img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}"  onerror=this.src="../images/noimg.jpg" width="100%" height="300" class="img">	
						<h4> <a href="viewBoard.do?Bidx=${vo.bidx}">${vo.title}</a> </h4>
							${vo.nickName}  좋아요${vo.cntLike} 댓글 ${vo.ccount} 조회수 ${vo.hit}
						</div>
						
					
							</c:forEach>
						</c:if>
						
					</div>
				</div>
			</form>
			<c:if test="${pm.board_type eq 'free'}">
			<section id="card-list" class="card-list"><!-- 무한스크롤부분 -->
					<div class="container">
						<div class="row card-list-container thumbnails">
						
						</div>
					</div>
				</section>
			</c:if>
	</div>
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
		<script>
//스크롤 시 이벤트 처리



//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
let currentPage = 1;
//현재 페이지가 로딩중인지 여부를 저장할 변수
let isLoding=false;

//웹브라우저의 창을 스크롤할 때마다  호출되는 함수 등록
$(window).on("scroll",function(){
	
	//위로 스크롤된 길이
	let scrollTop = $(window).scrollTop();
	console.log(scrollTop);
	//웹브라우저 창의 높이
	let windowHeight = $(window).height();
	//문서 전체의 높이
	let documentHeight = $(document).height();
	//바닥까지 스크롤 되었는지 여부를 알아낸다.
	let isBottom = scrollTop + windowHeight >= documentHeight;
	
	if(isBottom){
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
		GetList(currentPage);
	}
});

//카드 리스트를 가져오는 함수

const GetList = function(currentPage){
	//console.log("inGetList" + currentPage);
	
	//무한스크롤
	$.ajax({
	
		url : "ajax_board.do",
		method : "GET",
		//검색 기능이 있는 경우 seachType과 seachVal를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른 것들이 덧붙여져 나온다.
		data : "pagenumber="+currentPage+"&SearchType=${searchType}&SearchVal=${searchVal}",
		//FreeBoard.jsp의 내용이 data로 들어온다. 
		success:function(data){
			//console.log(data);
			//응답된 문자열은 html형식이다. 
			//해당 문자열은 .card-list-container div에 html로 해석하라고 추가한다.
			$(".card-list-container").append(data);
			//로딩바를 숨긴다.
			$(".back-drop").hide();
			//로딩중이 아니라고 표시한다.
			isLoding=false;
			//console.log("ajax"); 
		}	
	});
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