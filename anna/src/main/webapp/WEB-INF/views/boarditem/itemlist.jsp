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
<script>
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
      data : "pagenumber="+currentPage,
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
         console.log("ajax"); 
      }
      
      
      
   });
   

}




</script>
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
				<img src="../resources/upload/${vo.image1}" alt="...">
					<div class="card-body">
					<input type="hidden" value=">${vo.uidx}">
						<h5 class="card-title"><a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a></h5>
						<p class="card-text">팀 포맨의 프로젝트</p>
						<p class="card-text">${vo.nickname}</p>
						<p class="card-text">팀 포맨의 프로젝트</p>
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
<div class="back-drop">
	<img src="" alt="안됨">
</div> 


    <div class="col-sm-4 col-md-4"></div>
    <div class="col-sm-4 col-md-4">
        <ul class="btn-group pagination" style="margin-left: 50%;">
            <c:if test="${pagenation.prev }">
                <li>
                    <a href='<c:url value="/boarditem/itemlist.do?page=${pagenation.startPage-1 }"/>'><i class="fa fa-chevron-left"></i></a>
                </li>
            </c:if>
             <c:forEach begin="${pagenation.startPage }" end="${pagenation.endPage }" var="pageNum">
                 <li>
                    <a href='<c:url value="/boarditem/itemlist.do?page=${pageNum}"/>'><i class="fa">${pageNum}</i></a>
                </li>
            </c:forEach>
            <c:if test="${pagenation.next && pagenation.endPage >0 }">
                <li>
                     <a href='<c:url value="/boarditem/itemlist.do?page=${pagenation.endPage+1 }"/>'><i class="fa fa-chevron-right"></i></a>
                </li>
             </c:if>
        </ul>
    </div>

	

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>