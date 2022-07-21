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

@media all and (min-width:1001px){
	body{
		background:#fff;
	}
}

@media all and (max-width:1000px){
	body{
		background:#000;
	}
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
	let isBottom = scrollTop + windowHeight + 10 >= documentHeight;
	
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
	<c:if test="${!empty svo.searchVal}">
			${totalRow}개의 자료가 검색되었습니다.
	</c:if>
	<form>
		
		<c:if test="${freeboard.size() ==0}">
			
			<h3>등록된 게시물이 없습니다.</h3>
		</c:if>
<div class="container">
	<div class="row">		
		<c:if test="${freeboard.size()>0 }">
			<c:forEach var="vo" items="${freeboard}">
			<c:if test = "${vo.board_type eq 'free' }">
		<div class="card col-3">
			<img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}" alt="없어요 없어">
			<h4> <a href="viewBoard.do?Bidx=${vo.bidx}">${vo.title}</a> </h4>
			${vo.nickName}  좋아요 112 댓글 1
		</div>
		<br>
		</c:if>
			</c:forEach>
		</c:if>
	</div>
</div>
	</form>
<section id="card-list" class="card-list"><!-- 무한스크롤부분 -->
	<div class="container">
		<div class="row card-list-container thumbnails">
		
		</div>
	</div>
</section>
	<div class="back-drop"> <!-- 로딩 이미지 -->
		<img src="../" alt="안되는데여?" />
	
	</div>
</main>

</body>
</html>