<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일상&amp;소통</title>
</head>
<body>


<nav class="navbar">
	<ul class="navbar_menu">
		<li>중고거래</li>
		<li>커뮤니티</li> <!-- 호버  -->
		<li>고객센터</li>
		<li>마이페이지</li>
	</ul>
</nav>
<main>
	<form method="get" action="FreeBoard.do">

		<select name="SearchType">
			<option value="All" <c:if test="${!empty svo.searchType and svo.searchType eq 'All'} ">selected</c:if>>전체</option>
			<option value="title" <c:if test="${!empty svo.searchType and svo.searchType eq 'title' }">selected</c:if>>제목</option>
			<option value="contentWriter" <c:if test="${!empty svo.searchType and svo.searchType eq 'contentWriter' }">selected</c:if>>내용+작성자</option>
		</select>
		<input type="text" name="SearchVal" <c:if test="${!empty svo.searchVal}">value="${svo.searchVal}"</c:if>>
		<input type="submit" value="검색">
	</form>
	
	<a href="BoardWrite.do">쓰기</a>
	
	<hr>
	<form>
		
		<c:if test="${freeboard.size() ==0}">
			
			<h3>등록된 게시물이 없습니다.</h3>
		</c:if>
		
		<c:if test="${freeboard.size()>0 }">
			<c:forEach var="vo" items="${freeboard}">
			<c:if test = "${vo.board_type eq 'free' }">
		<div>
			<img src="../resources/upload/t-${vo.image1}" alt="없어요 없어">
			<h4> <a href="viewBoard.do?Bidx=${vo.bidx}">${vo.title}</a> </h4>
			${vo.nickName}  좋아요 112 댓글 1
		</div>
		<br>
		</c:if>
			</c:forEach>
		</c:if>
		
	</form>
</main>

</body>
</html>