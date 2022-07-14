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
<title>Insert title here</title>
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
					<!-- 
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="#">사기</a></li>
            <li><a class="dropdown-item" href="#">팔기</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">뭘봐</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled">Disabled</a>
        </li> -->
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
<br>
<hr>
<br>

		
			
			
			
	<div class="container">
		<div class="row">
		
		<c:if test="${list.size() > 0}">
		<c:forEach var="vo" items="${list}">
			<div class="col-lg-4">
				<div class="card">
				<img src="" alt="...">
					<div class="card-body">
					<input type="hidden" value=">${vo.uidx}">
						<h5 class="card-title"><a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h5>
						<p class="card-text">팀 포맨의 프로젝트</p>
						<p class="card-text">${vo.nickname}</p>
						<p class="card-text">팀 포맨의 프로젝트</p>
						<p class="card-text">${vo.wdate}</p>
					</div>
				</div>
			</div>
					</c:forEach>
		</c:if>
		
			
			
		</div>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>