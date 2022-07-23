<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:if test="${freeboard.size()>0 }">
			<c:forEach var="vo" items="${freeboard}">
			<c:if test = "${vo.board_type eq 'free' }">
		<div class="card col-md-3">
			<img src="<%=request.getContextPath()%>/resources/upload/t-${vo.image1}"  onerror=this.src="../images/noimg.jpg" width="100%" height="225" >
			<h4> <a href="viewBoard.do?Bidx=${vo.bidx}">${vo.title}</a> </h4>
			${vo.nickName}  좋아요${vo.cntLike} 댓글 ${vo.ccount}
		</div>
		<br>
		</c:if>
			</c:forEach>
		</c:if>

</body>
</html>