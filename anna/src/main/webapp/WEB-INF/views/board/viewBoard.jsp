<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
</head>
<body>

제목 ${bv.title}

내용 ${bv.contents }

아래에 이미지가 나옵니다.<br>

	
	<c:if test="${bv.image1 != null}">
	<input type="image" src="../resources/upload/${bv.image1}" alt ="안되는데요?">
	</c:if>
	
	<c:if test="${bv.image2 != null}">
	<input type="image" src="../resources/upload/${bv.image2}" alt ="안되는데요?">
	</c:if>
	
	<c:if test="${bv.image3 != null}">
	<input type="image" src="../resources/upload/${bv.image3}" alt ="안되는데요?">
    </c:if>
    
    <c:if test="${bv.image4 != null}">
	<input type="image" src="../resources/upload/${bv.image4}" alt ="안되는데요?">
    </c:if>
    
    <c:if test="${bv.image5 != null}">
	<input type="image" src="../resources/upload/${bv.image5}" alt ="안되는데요?">
    </c:if>
    
</body>
</html>