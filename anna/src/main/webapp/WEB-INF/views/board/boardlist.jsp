<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용하겠다는 뜻 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/bootstrap.css">

	<script src="<%= request.getContextPath()%>/js/bootstrap.js"></script>
	<link href="<%= request.getContextPath()%>/css/offcanvas.css" rel="stylesheet" type="text/css" />
<style>

/* 
아주 작은(Extra small)	xs	576px 미만	스마트폰 세로
작은(Small)	sm	576px 이상	스마트폰 가로
중간(Medium)	md	768px 이상	타블렛
큰(Large)	lg	992px 이상	데스크탑
아주 큰(Extra large)	xl	1200px 이상	큰 데스크탑
 */
 
.body {
	padding-top: -56px;
}

.row {
	padding: 0px;
	margin: 0px;
}

.container {
	justify-content: center;
	align-items: center;
}


.bottom_menu {
	position: fixed;
	bottom: 0px;
	left: 0px;
	width: 100%;
	height: 130px;
	z-index: 100;
	border-top: 1px solid black;
	background-color: white
}

.bottom_menu>div {
	float: left;
	width: 20%;
	height: 100%;
	text-align: center;
	padding-top: 20px;
}

@media ( min-width : 576px) {
	.col-md-2 {
		width: 30%;
	}
}

@media ( min-width : 1200px) {
	.col-md-2 {
		width: 16.66666667%;
	}
}

.navbar {
	height: 150;
}

.offcanvas-collapse {
	top: 150px;
}

.navbar-toggler-icon {
	width: 4.5em;
	height: 5.5em;
}

.navbar-brand {
	margin-left: 2rem;
}

.navbar-dark .navbar-toggler-icon {
	margin: 0 1rem;
}

.logo {
	padding-left: 2.5rem;
}

.menu li ul{

	display:none;

}

.menu li:hover ul{

	display:block;

}

.card img{
height : 300px;


}


</style>
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
</head>
<body>

			<div class="b-example-divider ">
				<div class="container ">
					<div class="d-md-none d-lg-block d-xl-block">
		
						<header class="d-flex  align-items-center justify-content-center justify-content-sm-between py-3 mb-1 ">
						<div class="logo">
							<a href="/" class="d-flex align-items-center col-md-3 mb-1 col-sm-3 mb-md-0 text-dark text-decoration-none ">		
									<img src="images/logo.png" width="70%">
							</a>
							</div>
						<div class="menu">
							<ul class="nav col-12 col-md-auto  col-sm-0 mb-1 justify-content-center mb-md-0">
								<li><a href="boarditem/itemlist.do" class="nav-link px-3 link-dark ">중고거래</a></li>
								<li><a href="FreeBoard.do" class="nav-link px-3 link-dark">커뮤니티</a>
									<ul>
										<li><a href="boardlist.do?board_type=free">일상&amp;소통</a></li>
										<li><a href="boardlist.do?board_type=job">구인구직</a></li>
										<li><a href="boardlist.do?board_type=meeting">모임</a></li>
										<li><a href="boardlist.do?board_type=hotplace">우리동네 핫플레이스</a></li>
									</ul>
								</li>
								<li><a href="#" class="nav-link px-3 link-dark ">고객센터</a></li>
								<li><a href="#" class="nav-link px-3 link-dark">마이페이지</a></li>
							</ul>
						</div>
							<div class="col-md-3 text-end">
								<c:if test="${uidx == null }">
		
									<button type="button" class="btn" style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/user/login.do';">로그인</button>
									<button type="button" class="btn" style="background-color: #BBCE53; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/user/join.do';">회원가입</button>
								</c:if>
								<c:if test="${uidx != null }">
									<button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/user/logout.do';">로그아웃</button>
									<button type="button" class="btn " style="background-color: #BBCE53; color: #fff;">물음표</button>
								</c:if>
							</div>
						</header>
					</div>
				</div>
			</div>
			

	
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
				<c:if test="${board.size() ==0}">		
					<h3>등록된 게시물이 없습니다.</h3>
				</c:if>
				<div class="container">
					<div class="row">		
						<c:if test="${board.size()>0}">
							<c:forEach var="vo" items="${board}">
							
						<div class="card col-md-3">
						<img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}"  onerror=this.src="../images/noimg.jpg" width="100%" height="225" >	
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
	
</body>
</html>