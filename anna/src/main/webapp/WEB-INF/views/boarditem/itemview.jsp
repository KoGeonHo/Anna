<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<link href="${path}/css/bootstrap.css" rel="stylesheet" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>item view 페이지</title>

<style>



.outer {
  border: 6px solid royalblue;
  width: 500px;
  height: 500px;
  margin: 0 auto;
  overflow-x: hidden;
  display:none;
}

.inner-list {
  display: flex;
  height: 100%;
  transition: .3s ease-out;
}

.inner {
}








.slider{
    width: 700px;
    height: 480px;
    position: relative;
    margin: 0 auto;
    overflow: hidden; /* 현재 슬라이드 오른쪽에 위치한 나머지 슬라이드 들이 보이지 않도록 가림 */
	display:block
}
.slider input[type=radio]{
    display: none;
}

ul.imgs{
    padding: 0;
    margin: 0;
    list-style: none;    
}
ul.imgs li{
    position: absolute;
    left: 700px;
    transition-delay: 1s; /* 새 슬라이드가 이동해 오는 동안 이전 슬라이드 이미지가 배경이 보이도록 지연 */

    padding: 0;
    margin: 0;
}

.bullets{
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    bottom: 20px;
    z-index: 2;
}
.bullets label{
    display: inline-block;
    border-radius: 50%;
    background-color: rgba(0,0,0,0.55);
    width: 20px;
    height: 20px;
    cursor: pointer;
}

img{
	width:700px;
	height:450px;
}

@media ( max-width: 400px ) {
	img{
	width:288px;
	height:250px;
	}

	
.slider{
    width: 300x;
    height: 250px;
    position: relative;
    margin: 0 auto;
    overflow: hidden; /* 현재 슬라이드 오른쪽에 위치한 나머지 슬라이드 들이 보이지 않도록 가림 */
	display : none;
}

.bullets label{
    display: inline-block;
    border-radius: 50%;
    background-color: rgba(0,0,0,0.55);
    width: 4px;
    height: 4px;
    cursor: pointer;
}



body {
  /* 글자 드래그 방지 */
  -ms-user-select: none; 
  -moz-user-select: -moz-none; 
  -webkit-user-select: none; 
  -khtml-user-select: none; 
  user-select: none;
}

.outer {
  border: 6px solid royalblue;
  width: 300px;
  height: 250px;
  margin: 0 auto;
  overflow-x: hidden;
  display:block
}

.inner-list {
  display: flex;
  width:300px;
  height: 250px;
  transition: .3s ease-out;
}

.inner {
  padding: auto;
}





}

/* 현재 선택된 불릿 배경 흰색으로 구분 표시 */
.slider input[type=radio]:nth-child(1):checked~.bullets>label:nth-child(1){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(2):checked~.bullets>label:nth-child(2){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(3):checked~.bullets>label:nth-child(3){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(4):checked~.bullets>label:nth-child(4){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(5):checked~.bullets>label:nth-child(5){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(6):checked~.bullets>label:nth-child(6){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(7):checked~.bullets>label:nth-child(7){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(8):checked~.bullets>label:nth-child(8){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(9):checked~.bullets>label:nth-child(9){
    background-color: #fff;
}
.slider input[type=radio]:nth-child(10):checked~.bullets>label:nth-child(10){
    background-color: #fff;
}



.slider input[type=radio]:nth-child(1):checked~ul.imgs>li:nth-child(1){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(2):checked~ul.imgs>li:nth-child(2){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(3):checked~ul.imgs>li:nth-child(3){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(4):checked~ul.imgs>li:nth-child(4){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(5):checked~ul.imgs>li:nth-child(5){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(6):checked~ul.imgs>li:nth-child(6){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(7):checked~ul.imgs>li:nth-child(7){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(8):checked~ul.imgs>li:nth-child(8){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(9):checked~ul.imgs>li:nth-child(9){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
.slider input[type=radio]:nth-child(10):checked~ul.imgs>li:nth-child(10){
    left: 0;
    transition: 0.5s;
    z-index:1;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="itemlist.do">AnnA</a>
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
	
<form  method="post" enctype="multipart/form-data" name="frm">
	<div class="row">
			<div class="col-lg-10">
				<div class="card">
					<div class="outer">
					  <div class="inner-list">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image1}">
					    </div>
					    <div class="inner">
					      <img src="../resources/upload/${vo.image2}">
					    </div>
					    <c:if test="${vo.image3 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image3}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image4 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image4}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image5 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image5}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image6 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image6}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image7 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image7}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image8 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image8}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image9 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image9}">
					    </div>
					    </c:if>
					    <c:if test="${vo.image10 != null }">
					    <div class="inner">
					      <img src="../resources/upload/${vo.image10}">
					    </div>
					    </c:if>
					  </div>
					  </div>
					<div class="slider">
					    <input type="radio" name="slide" id="slide1" checked>
					    <input type="radio" name="slide" id="slide2">
					    <input type="radio" name="slide" id="slide3">
					    <input type="radio" name="slide" id="slide4">
					    <input type="radio" name="slide" id="slide5">
					    <input type="radio" name="slide" id="slide6">
					    <input type="radio" name="slide" id="slide7">
					    <input type="radio" name="slide" id="slide8">
					    <input type="radio" name="slide" id="slide9">
					    <input type="radio" name="slide" id="slide10">
				    
				    <ul id="imgholder" class="imgs">
				    
				        <li><img src="../resources/upload/${vo.image1}"></li>
						
				        <li><img src="../resources/upload/${vo.image2}"></li>
				        
				        <li><img src="../resources/upload/${vo.image3}"></li>
				        
				        <li><img src="../resources/upload/${vo.image4}"></li>
				        
				        <li><img src="../resources/upload/${vo.image5}"></li>
				        
				        <li><img src="../resources/upload/${vo.image6}"></li>
				        
				        <li><img src="../resources/upload/${vo.image7}"></li>
				        
				        <li><img src="../resources/upload/${vo.image8}"></li>
				        
				        <li><img src="../resources/upload/${vo.image9}"></li>
				        
				        <li><img src="../resources/upload/${vo.image10}"></li>
				       
				       
				        <div class="bullets">
				        	<c:if test="${vo.image1 != null }">
					        <label for="slide1">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image2 != null }">
					        <label for="slide2">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image3 != null }">
					        <label for="slide3">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image4 != null }">
					        <label for="slide4">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image5 != null }">
					        <label for="slide5">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image6 != null }">
					        <label for="slide6">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image7 != null }">
					        <label for="slide7">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image8 != null }">
					        <label for="slide8">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image9 != null }">
					        <label for="slide9">&nbsp;</label>
					        </c:if>
					        <c:if test="${vo.image10 != null }">
					        <label for="slide10">&nbsp;</label>
					        </c:if>
				   		 </div>
				    </ul>
				    
					</div>
				    
					
					</div>
				    
				
				
					<input type="hidden" value="${vo.uidx} asd"> 
					<input type="hidden" value="${vo.item_idx} asd">
					
					<div class="card-body">
						<h5 class="card-title">${vo.title}</h5>
							<c:if test="${vo.cate_idx == 1}">
						상품카테고리 > 가전 
							</c:if>
							<c:if test="${vo.cate_idx == 2}">
							주방
							</c:if>
						<p class="card-text">${vo.content}</p>
						<p class="card-text">판매가격 : ${vo.price}</p>
						<p class="card-text">거래지역 : ${vo.addr2}</p>
						<p class="card-text">팀 포맨의 프로젝트</p>
					</div>
				</div>
			</div>
</form>
					
					


제목 , 카테고리, 사진, 가격, 판매자이름, 거래장소, 조회수, 이웃추가 버튼,
	 신고하기, 연락하기, 판매자의 다른상품, 키워드 보여주는공간
	
	
	
	
	
	
	
	
	
	
	
	
	
	<script src ="../js/boarditem.js"></script>
</body>
</html>