<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/bootstrap.css">
</head>
<body>

<c:if test="${freeboard.size()>0 }">
			<c:forEach var="vo" items="${freeboard}">
			<c:if test = "${vo.board_type eq 'free' }">
		<div class="card col-3">
			<img src="../resources/upload/t-${vo.image1}" alt="없어요 없어">
			<h4> <a href="viewBoard.do?Bidx=${vo.bidx}">${vo.title}</a> </h4>
			${vo.nickName}  좋아요 112 댓글 1
		</div>
		
		</c:if>
			</c:forEach>
		</c:if>

</body>
</html>