<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- 세션사용하겠다는 뜻 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일상&amp;소통</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/bootstrap.css">
<style>

/* 
아주 작은(Extra small)	xs	576px 미만	스마트폰 세로
작은(Small)	sm	576px 이상	스마트폰 가로
중간(Medium)	md	768px 이상	타블렛
큰(Large)	lg	992px 이상	데스크탑
아주 큰(Extra large)	xl	1200px 이상	큰 데스크탑
 */
 
.card img{

width : 100%;
height : 250px;

}

.card{



}

a{

text-decoration-line: none;

}

ui{

text-align:center;
margin : 0px auto;

}

li{
list-style: none;
display : inline-block;

}

.navbar{
 
text-align:center

}

@media all and (max-width:576px){ /*최대 576까지 */
	body{
		background:#000;
	}
}

@media all and (min-width:1001px){ 1001
	body{
		background:#fff;
	}
}


</style>
</head>
<body>


<nav class="navbar">
	<ul class="navbar_menu">
		<li>중고거래</li>
		<li>커뮤니티</li> <!-- 호버  -->
		<li>고객센터</li>
		<li>마이페이지</li>
	</ul>
	
	<div>
	<c:if test="${nickName != null}">
	${nickName}님 환영합니다 | <a href="../user/logout.do">로그아웃</a>
	</c:if>
	<c:if test="${nickName == null}">
	<a href="../user/login.do">로그인</a> | <a href="../user/join.do">회원가입</a>
	</c:if>
	</div>
</nav>
<main>
	<form method="get" action="FreeBoard.do">

		<select name="SearchType">
			<option value="All" <c:if test="${!empty pm.searchType and pm.searchType eq 'All'} ">selected</c:if>>전체</option>
			<option value="title" <c:if test="${!empty pm.searchType and pm.searchType eq 'title' }">selected</c:if>>제목</option>
			<option value="contentWriter" <c:if test="${!empty pm.searchType and pm.searchType eq 'contentWriter' }">selected</c:if>>내용+작성자</option>
		</select>
		<input type="text" name="SearchVal" <c:if test="${!empty pm.searchVal}">value="${pm.searchVal}"</c:if> placeholder="검색어를 입력해주세요">
		<input type="submit" value="검색">
	</form>
	
	<a href="BoardWrite.do">쓰기</a>
	
	<hr>
	
	<form>
		
		<c:if test="${jobboard.size() ==0}">
			
			<h3>등록된 게시물이 없습니다.</h3>
		</c:if>
<div class="container">
	<div class="row">		
		<c:if test="${jobboard.size()>0 }">
			<c:forEach var="vo" items="${jobboard}">
			<c:if test = "${vo.board_type eq 'job' }">
		<div class="card col-md-3">
		<img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}"  onerror=this.src="../images/noimg.jpg" width="100%" height="225" >	
		<h4> <a href="viewBoard.do?Bidx=${vo.bidx}">${vo.title}</a> </h4>
			${vo.nickName}  좋아요${vo.cntLike} 댓글 ${vo.ccount}
			
		</div>
		<br>
		</c:if>
			</c:forEach>
		</c:if>
	</div>
</div>
	</form>
	</main>
</body>
</html>