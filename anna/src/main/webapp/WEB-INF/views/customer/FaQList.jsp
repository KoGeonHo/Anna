<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>안녕? 나야!</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>


<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/mfb.css" rel="stylesheet">
<!-- path는 request.getContextPath()를 가져온것. -->

<style>
@media all and (max-width: 767px) {
	#FqA_title {
		display: none;
	}
	
}

@media all and (min-width :768px) {
}


</style>

</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div id="FqA_title"><img src="${ path }/images/FqA_title.jpg" width="100%">	</div>
		<div class="wrapper">		
			<div class="container main">
				
				
<div class="accordion accordion-flush" id="accordionFlushExample" style="margin-top: 38px;">
  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
        회원정보 변경은 어디에서 하나요?
      </button>
    </h2>
    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">MY > 설정> [계정설정] 에서 변경<br>
<br>
 

회원정보 변경은 MY에서 직접 처리가 가능합니다.<br>

※ 변경가능한 정보 : 성별, 생년월일, 연락처, 이메일 등<br>

 

단, 연락처 변경은 본인 명의의 휴대폰번호 인증 시 자동 변경됩니다.</div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
       본인인증을 받는데 인증번호가 오지 않아요.
      </button>
    </h2>
    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">
본인인증 시 인증번호를 지속적으로 받지 못하시는 경우, 메일 내 스팸메일함을 확인해 주세요.<br>
스팸메일함에서도 확인되지 않는다면  고객센터로 문의를 부탁드립니다.</div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
        회원정보 변경은 어디에서 하나요?
      </button>
    </h2>
    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">마이페이지 > 내정보에서 변경<br>
<br>
회원정보 변경은 내정보에서 직접 처리가 가능합니다.<br>
※ 변경가능한 정보 : 닉네임, 내동네, 소개글, 키워드 등<br>
단, 연락처 변경은 본인 명의의 휴대폰번호 인증 시 자동 변경됩니다.</div>
    </div>
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingFour">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false" aria-controls="flush-collapseTwo">
       거래사기로 제재된 상점이 다시 번개장터를 이용 할 수 있나요?
      </button>
    </h2>
    <div id="flush-collapseFour" class="accordion-collapse collapse" aria-labelledby="flush-headingFour" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">
거래사기 해결 시 까지 서비스 이용 불가<br>
<br>
거래사기로 제재된 상점의 경우 탈퇴 후 재가입을 하더라도 서비스 이용이 제한됩니다.<br>
단, 상대방 상점과 문제가 해결된 경우 이용 가능합니다.</div>
    </div>
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingFive">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFive" aria-expanded="false" aria-controls="flush-collapseTwo">
       여러개의 계정을 만들 수 있나요?
      </button>
    </h2>
    <div id="flush-collapseFive" class="accordion-collapse collapse" aria-labelledby="flush-headingFive" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">
1인 1계정 원칙<br>
<br>
번개장터는 1인 1계정 사용을 원칙으로 하고 있습니다.<br>
여러 계정의 동일 사용자라 판단되는 경우 경고 및 제재조치가 될 수 있으니 유의해 주세요.</div>
    </div>
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingSix">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseSix" aria-expanded="false" aria-controls="flush-collapseTwo">
       회원탈퇴를 하고 싶어요.
      </button>
    </h2>
    <div id="flush-collapseSix" class="accordion-collapse collapse" aria-labelledby="flush-headingSix" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">
MY > 설정 > [계정설정]에서 직접 탈퇴 가능<br>
<br>
회원탈퇴는 'MY > 설정 > 계정설정 > 회원탈퇴' 버튼을 통해 가능하며<br>
탈퇴 전, 아래의 유의사항을 확인 부탁드립니다.</div>
    </div>
  </div>
  
</div>
				
				
				
				
				
			</div>
		</div>	
		<!-- 퀵메뉴 시작 -->
		<%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>			
		<!-- 퀵메뉴 종료 --> 
		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
	
</body>
</html>
