<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>

	<meta charset="UTF-8">
	<title>Home</title>
	

    <script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
	<script src="js/bootstrap.js"></script>
	<link href="css/offcanvas.css" rel="stylesheet" type="text/css" />
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
 -->	
 	<link href="${path}/css/bootstrap.css" rel="stylesheet"/> 
	
	<style>

/*
반응형 기준 기록
	아주작은(xs)  576px 미만	  스마트폰 세로
	작은(sm) 	  576px 이상	  스마트폰 가로
	중간(md)	  768px 이상	  타블렛
	큰(lg)   	  992px 이상	  데스크탑
	아주큰(xl)	  1200px 이상	  큰 데스크탑
*/
.body {
	padding-top: -56px;
}
a {
  color: #000;
  text-decoration: none;
}
	
}

.row {
	padding: 0px;
	margin: 0px;
}

.container {
	justify-content: center;
	align-items: center;
}

.card {
	margin-left: 3px;
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
</style>
	
	
	
</head>
<body>

				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">		
							
							<c:if test="${list.size() > 0}">
							<c:forEach var="vo" items="${list}">
							
		
								<div class="col-lg-3  col-md-12 ">
		
									<div class="card">
									<a href="boarditem/itemview.do?item_idx=${vo.item_idx}">
									<img src="<%=request.getContextPath()%>/resources/upload/${vo.image1}"  onerror=this.src="images/noimg_item.jpg" width="100%" height="255" >
									</a>
										
										<div class="card-body">
											<h6 class="card-title" ><a href="boarditem/itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h6>
											<p class="card-text">${vo.price}원</p>
											<button type="button" class="btn btn-sm btn-outline-secondary" 	style="float: right">view 5</button>
											<button type="button" class="btn btn-sm btn-outline-secondary"	style="float: right">♥2</button>
										</div>
									</div>
								</div>
								</c:forEach>
								</c:if>
							

								
			
			
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
 <script src="https://getbootstrap.kr/docs/5.1/examples/offcanvas-navbar/offcanvas.js"></script></body>
</html>	