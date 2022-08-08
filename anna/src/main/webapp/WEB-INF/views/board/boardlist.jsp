<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용하겠다는 뜻 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
										<li><a href="">일상&amp;소통</a></li>
										<li><a href="JobBoard.do">구인구직</a></li>
										<li><a href="">모임</a></li>
										<li><a href="">우리동네 핫플레이스</a></li>
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
			

	<input type="text" value="${vo.board_type}">
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
						<div class="card col-md-3">
						<img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}"  onerror=this.src="../images/noimg.jpg" width="100%" height="225" >	
						<h4> <a href="viewBoard.do?Bidx=${vo.bidx}">${vo.title}</a> </h4>
							${vo.nickName}  좋아요${vo.cntLike} 댓글 ${vo.ccount} 조회수 ${vo.hit}
						</div>
						
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
			
</body>
</html>