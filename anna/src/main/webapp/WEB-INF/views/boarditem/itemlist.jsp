<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${path}/css/bootstrap.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script> 

<style>

.col-lg-3 .card img {

width:100%;
height:250px;
}


@media ( max-width: 400px ) {

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
</style>
<script>

$(window).on("scroll", function() {
	var scrollHeight = $(document).height();
	var scrollPosition = $(window).height() + $(window).scrollTop();		

	$("#scrollHeight").text(scrollHeight);
	$("#scrollPosition").text(scrollPosition);
	$("#bottom").text(scrollHeight - scrollPosition);

	if (scrollPosition > scrollHeight - 500) {			
		//todo
		$("body").append('<div id="content"></div>');
	}
});

</script>
</head>
<body>
<a href="itemwrite.do">중고거래글 작성하기</a>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">AnnA</a>
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">중고거래</a></li>
					<li class="nav-item"><a class="nav-link" href="#">커뮤니티</a></li>
					<li class="nav-item"><a class="nav-link" href="#">고객센터</a></li>
					<li class="nav-item"><a class="nav-link" href="#">마이페이지</a></li>
				</ul>
				<form class="d-flex">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>
<br>
<hr>
<br>

	<form method="get" action="itemlist.do">
		<select name="searchType">
			<option value="title" <c:if test="${!empty svo.searchType and svo.searchType eq 'title'}">selected</c:if>>제목</option>
			<option value="contentWriter" <c:if test="${!empty svo.searchType and svo.searchType eq 'contentWriter'}">selected</c:if>>내용+작성자</option>
		</select>
		<input type="text" name="searchVal" <c:if test="${!empty svo.searchVal}">value="${svo.searchVal}"</c:if>>
		<input type="submit" value="검색">
		
		
	</form>
	<c:if test="">
	<h1>검색된 상품중 최저가 상품입니다.</h1>
	<div class="row">
		<div class="col-md-3 col-lg-3">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title"> <a href="itemview.do">안녕나야</a></h5>
					<p class="card-text">팀 포맨의 프로젝트</p>
				</div>
			</div>
		</div>
	</div>
	</c:if>
<br>
<hr>
<br>

		
			
			
			
	<div class="container">
		<div class="row">
		<ul>
			<li><a href="itemlist.do">전체</a></li>
			<li><a href="itemlist.do?cate_idx=1">가전</a></li>
			<li><a href="itemlist.do?cate_idx=2">취미</a></li>
			<li><a href=""></a></li>
			<li><a href=""></a></li>
		</ul>
		<c:if test="${list.size() > 0}">
		<c:forEach var="vo" items="${list}">
		
			<div class="col-lg-3">
				<div class="card">
				<img src="../resources/upload/${vo.image1}" >
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

<div id="container">
	<div id="log">
		<span>scrollHeight: <b id="scrollHeight">0</b></span><br>
		<span>scrollPosition: <b id="scrollPosition">0</b></span><br>
		<span>from bottom :  <b id="bottom"></b></span><br>
		<span id="b">scroll < 500px</span>
	</div>
</div>



	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>