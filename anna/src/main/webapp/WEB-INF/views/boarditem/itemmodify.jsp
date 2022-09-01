<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
 <!-- include libraries(jQuery, bootstrap) -->
        <!-- include libraries(jQuery, bootstrap) -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
    <!-- include summernote css/js-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
	<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/mfb.css" rel="stylesheet">
	<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 
	<!-- path는 request.getContextPath()를 가져온것. -->
	<!-- 지도 API - 필요없으면 지워도 됨 -->
	<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script>	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<!-- 지도 API -->
	
	<!-- 해시태그 구현 -->
	<script>
	    $(document).ready(function () {
	        var tag = {};
	        var counter = 0;
	
	        // 입력한 값을 태그로 생성한다.
	        function addTag (value) {
	            tag[counter] = value;
	            counter++; // del-btn 의 고유 id 가 된다.
	        }
	
	        // tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
	        function marginTag () {
	            return Object.values(tag).filter(function (word) {
	                return word !== "";
	            });
	        }
	    
	        // 서버에 제공
	        $("#tag-form").on("submit", function (e) {
	            var value = marginTag(); // return array
	            $("#rdTag").val(value); 
	
	            $(this).submit();
	        });
	
	        $("#tag").on("keypress", function (e) {
	            var self = $(this);
	
	            //엔터나 스페이스바 눌렀을때 실행
	            if (e.key === "Enter" || e.keyCode == 32) {
	
	                var tagValue = self.val(); // 값 가져오기
	
	                // 해시태그 값 없으면 실행X
	                if (tagValue !== "") {
	
	                    // 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
	                    var result = Object.values(tag).filter(function (word) {
	                        return word === tagValue;
	                    })
	              
	                    // 해시태그가 중복되었는지 확인
	                    if (result.length == 0) { 
	                       // $("#tag-list").append("<li class='tag-item' name='keyword'>"+tagValue+"<span class='del-btn' idx='"+counter+"'>x</span></li>");
	                        $("#tag-list").append("<input type='text' class='tag-item' name='keyword'value="+tagValue+"><span class='del-btn' idx='"+counter+"'>x</span>");
	                        addTag(tagValue);
	                        self.val("");
	                    } else {
	                        alert("태그값이 중복됩니다.");
	                    }
	                }
	                e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
	            }
	        });
	
	        // 삭제 버튼 
	        // 인덱스 검사 후 삭제
	        $(document).on("click", ".del-btn", function (e) {
	            var index = $(this).attr("idx");
	            tag[index] = "";
	            $(this).parent().remove();
				})
	    });
	</script>
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div class="wrapper main">
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="container">
		

				<h3 class="border-bottom" style="padding:1rem; margin:0px;">판매글 하기</h3>
				<form method="POST" action="itemmodify.do" enctype="multipart/form-data" name="frm" id="joinFrm">
					
					<input type="hidden" name="uidx" value="${uidx}">
					<input type="hidden" name="addr_code" value="${userLoginInfo.location_auth}" readonly="readonly">
					<input type="hidden" name="item_idx" value="${vo.item_idx}">
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">제목</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" name="title" id="title" value="${vo.title}">
						</div>
					</div>
					
			
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">카테고리</div>
						<div class="col-8 td" style="display:table-cell;">
							<select name="cate_idx">
								<option value="1">가전제품</option>
								<option value="2">생활용품</option>
								<option value="3">완구&취미</option>
								<option value="4">패션&의류</option>
								<option value="5">인테리어</option>
								<option value="6">반려동물용품</option>
								<option value="7">뷰티&악세</option>
								<option value="8">자동차용품</option>
								<option value="9">스포츠&레저용품</option>
						    </select>
						</div>
					</div>
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">가격제안</div>
						<div class="col-8 td" style="display:table-cell;">
							<select name="offer">
								<c:if test="${vo.offer == 0}">
									<option value="0" selected>불가능</option>
									<option value="1"  >가능</option>
								</c:if>
								<c:if test="${vo.offer == 1 }">
									<option value="0">불가능</option>
									<option value="1" selected >가능</option>
								</c:if>
						    </select>
						</div>
					</div>
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">가격</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="number" class="form-control" name="price" id="price" value="${vo.price}"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">내용</div>
						<div class="col-8 td" style="display:table-cell;">
							<textarea  class="form-control" id="summernote" name="contents" rows="10" cols="25">${vo.contents}</textarea>
								<div class="contet_count" style="float:right;"></div>
						</div>
						<script>
						/* 	
						$(document).ready(function() {
			        		$('.contet_count').html("("+$(this).val().length+" / 500)"); //클래스 안에 0 / 500 출력
				        		$('#contents').on('keyup', function() { // 안에 키 누르면 이벤트시작
							        $('.contet_count').html("("+$(this).val().length+" / 500)"); //내용 입력시 안에 ? / 500 출력
							    	
							    	
							        if($(this).val().length > 500) {
							            $(this).val($(this).val().substring(0, 500)); //500자가 넘으면 500자 까지 잘라냄
							            alert("내용은 최대 500자 까지 입력 가능합니다.");
							            $('.contet_count').html("(500 / 500)"); //500자 라고 출력
							        }
							    });
						}); */
						</script>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">키워드</div>
						<div class="col-8 td" style="display:table-cell;">
			           		<div class="form-group">
			              	  <input type="hidden" value="" name="tag" id="rdTag" />
			          		</div>
			          		${vo.keyword}
			             <div id="tag-list" ></div>
				           	 <div class="form-group">
				            	<input type="text" id="tag" size="7" placeholder="입력후 엔터를 눌러주세요." style="width: 200px;"/>
				          	 </div>
						</div>
					</div>
					
					
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">첨부 파일</div>
						<div class="col-8 td" style="display:table-cell;">
						기존 이미지 
						${vo.image1}
						${vo.image2}
						${vo.image3}
						${vo.image4}
						${vo.image5}
						${vo.image6}
						${vo.image7}
						${vo.image8}
						${vo.image9}
						${vo.image10}
							<div id="fileDiv">
								<input type="file" style="width:200px;"id="file" name="file1" accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)' >
							</div>
								<br/><br/>
							<a href="#this" class="btn" id="addFile">파일 추가</a>
							</div>
					</div>
					
					<div class="text-end tr">
						<div class="td">
							<button class="btn" style="background:#00AAB2; color:#fff;">등록</button>
							<button class="btn" style="background:#00AAB2; color:#fff;" type="button"onclick="loaction.href='itemlist.do'" >취소</button>
						</div>
					</div>
					
					
					
				</form>

<script>
$("#joinFrm").submit(function(){
    var price = $("#price").val();
    var contents = $("#contents").val();
    var title = $("#title").val();
    var addr = $("#addr_code").val();
    	
    
    	/* function addr_code(){
    		$('#addr_code').load(location.href+' #addr_code');
    	} */
    
    
    
		    if(title == ""){
		    	alert("제목을 입력해주세요");
		    	return false;
		    }else if(addr == 0 ){
		        alert("거래지역을 설정해주세요");
			       return false;
		    }else if(price.length > 10 ){
		        alert("가격은 최대 10자리 까지 입니다.");
			       return false;
		    }else if(price.length == 0 ){
		        alert("판매 가격을 작성해주세요.");
			       return false;
		    }else if(contents == ""	){
		    	alert("내용을 입력해주세요");
		    	return false;
			}
    });
</script>
	<script type="text/javascript">
	
	$('#summernote').summernote({
		height : 400, // set editor height
		minHeight : null, // set minimum height of editor
		maxHeight : null, // set maximum height of editor
		maxWidth : 840,
		focus : true,
		lang : 'ko-KR', // 기본 메뉴언어 US->KR로 변경
		popover: {         //팝오버 설정
	         image: [], //이미지 삭제
	         link: [],  //링크 삭제
	         air: []
	         },	
		
		
		
		
		
		callbacks: {
             onChange: function(contents, $editable) {
               console.log('onChange:', contents, $editable);
               console.log(contents.length+"글자수");
               
               $('.contet_count').html("("+contents.length+" / 500)"); //클래스 안에 0 / 500 출력
              
	               if($(this).val().length > 500) {
						            $(this).val($(this).val().substring(0, 500)); //500자가 넘으면 500자 까지 잘라냄
						            $('.contet_count').html("(500 / 500)"); //500자 라고 출력
						            alert("내용은 최대 500자 까지 입력 가능합니다.");
			              $('#summernote').keydown(function(e){ 
			              		});
			        		}
           				}
        		 }
		});
	
	
	
	
		var gfv_count = 2;
	
		$(document).ready(function(){
			$("#list").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openBoardList();
			});
			
			$("#write").on("click", function(e){ //작성하기 버튼
				e.preventDefault();
				fn_insertBoard();
			});
			
			
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteFile($(this));
			});
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/boarditem/itemlist.do' />");
			comSubmit.submit();
		}
		
		function fn_insertBoard(){
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/boarditem/itemwrtie.do' />");
			comSubmit.submit();
		}
		
		$(document).ready(function() {
			var i=2; // 변수설정은 함수의 바깥에 설정!
		  $("#addFile").click(function() {
		    if(i<=10){
		    	
		    	$("#fileDiv").append("<p style='margin:auto;'><input type='file' style='width:200px;' name='file"+i+"'><a href='#this' class='btn' name='delete'>삭제</a></p>");
		    }
		    
		    i++;
		    
		    if(i==11){
		    	$("#addFile").css("display","none");
		    }
		   
		    

		  });
		});
		
		function fn_deleteFile(obj){
			obj.parent().remove();
		}
	</script>
	</div>
	</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>