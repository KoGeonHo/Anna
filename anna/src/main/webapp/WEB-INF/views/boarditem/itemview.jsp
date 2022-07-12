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
<title>item view 페이지</title>
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
	
	
	<div class="row">
			<div class="col-lg-4">
				<div class="card">
				<img src="${path}/images/logo.png" class="card-img-top" alt="...">
				<input type="hidden" value="${vo.uidx}">
				<input type="hidden" value="${vo.item_idx}">
					
					<div class="card-body">
						<h5 class="card-title">${vo.title}</h5>
						<p class="card-text">${vo.cate_idx}</p>
						<p class="card-text">${vo.Content}</p>
						<p class="card-text">${vo.Price}</p>
						<p class="card-text">${vo.addr2}</p>
						<p class="card-text">팀 포맨의 프로젝트</p>
					</div>
				</div>
			</div>
	</div>
	
	제목 , 카테고리, 사진, 가격, 판매자이름, 거래장소, 조회수, 이웃추가 버튼,
	 신고하기, 연락하기, 판매자의 다른상품, 키워드 보여주는공간
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>