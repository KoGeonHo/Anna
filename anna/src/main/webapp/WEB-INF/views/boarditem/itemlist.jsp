<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/bootstrap.css">
<head>

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
	//웹브라우저 창의 높이
	let windowHeight = $(window).height();
	//문서 전체의 높이
	let documentHeight = $(document).height();
	//바닥까지 스크롤 되었는지 여부를 알아낸다.
	let isBottom = scrollTop + windowHeight + 10 >= documentHeight;
	
	if(isBottom){
		console.log(isLoding);
		//만일 현재 마지막 페이지라면
		if(currentPage == ${totalPageCount} || isLoding){
			console.log(currentPage);
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
	
		url : "ajax_item.do",
		method : "GET",
		//검색 기능이 있는 경우 seachType과 seachVal를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른 것들이 덧붙여져 나온다.
		data : "pagenumber="+currentPage+"&SearchType=${searchType}&SearchVal=${searchVal}",
		//FreeBoard.jsp의 내용이 data로 들어온다. 
		success:function(data){
			console.log(data);
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
<style>

.col-lg-3 .card img {

width:100%;
height:250px;

}




ul{
	list-style:none;
}
li{
	float:left;
	margin-right:20px;
}

@media ( max-width: 400px ) {

.container.row.col-lg-12.card.card-body{
	width:100%;


}


.col-lg-3 .card img {

width:293px;
height:250px;
}



}
</style>


<meta charset="utf-8">
<title>Insert title here</title>
<style>
#container{
	height:5000px;
}
#content{
	color:gray;
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

.box {float:left; overflow: hidden; background: #f0e68c;}
.box-inner {width: 800px; padding: 10px;}
</style>

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${path}/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/bootstrap.css" rel="stylesheet" />


<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script> 
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		
		<div class="container main">
						<!-- 카테고리 -->
						<div style="width:100px; background-color:grey;"class="slide-toggle">
							카테고리
						</div>
						<div style=" height:70px;">
							<div class="box">
							    <div class="box-inner">
							    	<ul>
										<li><a href="itemlist.do" class="cate_menu">전체</a></li>
										<li><a href="itemlist.do?cate_idx=1" class="cate_gory">가전</a></li>
										<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
										<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
										<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
										<li><a href="itemlist.do?cate_idx=2" class="cate_gory">취미</a></li>
										<li><a href="itemwrite.do" class="cate_gory">글작성</a></li>
									</ul>
							    </div>
							</div>
						</div>		
						<!-- 카테고리 끝 -->
						<form method="get" action="itemlist.do">
							<select name="searchType">
								<option value="title" <c:if test="${!empty svo.searchType and svo.searchType eq 'title'}">selected</c:if>>제목</option>
							</select>
							<input type="text" name="searchVal" 
									<c:if test="${!empty svo.searchVal}">
									value=${svo.searchVal}
									</c:if>>
							<input type="submit" value="검색">
						</form>
					<div>
						<c:if test="${!empty pm.searchVal}">	
						<h1>니가 검색한 ${pm.searchVal} 의 최저가 상품이란다</h1>
							<div class="col-lg-3">
								<div class="card">
								<a href="itemview.do?item_idx=${ssang.item_idx}"><img src="../resources/upload/${ssang.image1}" ></a>
									<div class="card-body">
									<input type="hidden" value=">${ssang.uidx}">
										<h5 class="card-title"><a href="itemview.do?item_idx=${ssang.item_idx}">${ssang.title}</a></h5>
										<p class="card-text">${ssang.price}원</p>
										<p class="card-text">${ssang.nickName}</p>
										<p class="card-text">${ssang.wdate}</p>
									</div>
								</div>
									<br>
							</div>
			
						</c:if>
					</div>
<br>
<hr>
<br>


<hr>

					<div class="container">
						<div class="row">
						<c:if test="${list.size() > 0}">
						<c:forEach var="vo" items="${list}">
						
							<div class="col-lg-3">
								<div class="card">
								<a href="itemview.do?item_idx=${vo.item_idx}"><img src="../resources/upload/${vo.image1}" ></a>
				
									<div class="card-body">
									<input type="hidden" value=">${vo.uidx}">
										<h5 class="card-title"><a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h5>
										<p class="card-text">${vo.price}원</p>
										<p class="card-text">${vo.nickName}</p>
										<p class="card-text">${vo.wdate}</p>
									</div>
								</div>
									<br>
							</div>
									</c:forEach>
						</c:if>
						</div>
					</div>
					
	
						<section id="card-list" class="card-list">
							<div class="container">
								<div class="row card-list-container thumbnails"></div>
							</div>
						</section>




						<section id="card-list" class="card-list"><!-- 무한스크롤부분 -->
							<div class="container">
								<div class="row card-list-container thumbnails">
								
								</div>
							</div>
						</section>
				<script src ="../js/boardlist.js"></script>
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
			</div>
		
		<!-- 푸터는 나중에 추가될거니까 일단 주석처리 해놨음 -->
		<%-- <!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		 --%>
	</div>
</body>
</html>