<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>


			<c:if test="${list.size() > 0}">
				<c:forEach var="vo" items="${list}">
					<div class="col-lg-4">
						<div class="card">
							<img src="../resources/upload/${vo.image1}" alt="...">
							<div class="card-body">
								<input type="hidden" value=">${vo.uidx}">
									<h5 class="card-title">
								<a href="itemview.do?item_idx=${vo.item_idx}">${vo.title}</a>
								</h5>
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





</body>
</html>