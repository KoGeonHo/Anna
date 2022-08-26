<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title> 상품 등록 페이지</title>
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
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="container main">
		
		
		<h3 class="border-bottom" style="padding:1rem; margin:0px;">판매글 작성하기</h3>
				<form method="POST" action="itemwrite.do" enctype="multipart/form-data" name="frm" id="joinFrm">
					
					<input type="hidden" name="uidx" value="${uidx}">
					<%-- <input type="hidden" name="addr_code" value="${userLoginInfo.location_auth}" readonly="readonly"> --%>
					<input type="hidden" name="addr1" value="1"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
					<input type="hidden" name="addr2" value="1"><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
					
					
					
					
					
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">제목</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" id="title"name="title">
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">거래지역</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" value="${userLoginInfo.location_auth }" id="addr_code" name="addr_code">
						</div>
							<!-- <select class="form-select" aria-label="Default select example" id="addr_code"name="addr_code" onchange="alert('해당 기능은 준비중입니다.')">
								<option value="0" id="addr">내 동네</option>
							</select>
 -->				    		<script>
					    		let locationList2 = [${ userLoginInfo.location_auth }];
					    		let html2 = '';
					    		$.ajax({
									url : "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json",
									data : "consumer_key=7b9a8af3d576479db243&consumer_secret=02e72ab8a0e046f9bf95",
									success : function(data){
										$(".spinner-border").css("display","none");
										for(let i = 0; i < locationList2.length; i++){
											$.ajax({
												url : "https://sgisapi.kostat.go.kr/OpenAPI3/boundary/hadmarea.geojson",
												async : false,
												data : "accessToken="+data.result.accessToken+"&year=2021&adm_cd="+locationList2[i]+"&low_search=0",
												success : function(geojson){
													let locationLevel = geojson.features[0].properties.adm_nm.split(" ");
													console.log(locationLevel[locationLevel.length-1]); // 이게 동까지만 자른거
													$('input[name=addr_code]').attr('value',locationLevel[locationLevel.length-1]);
													//dong.push(locationLevel[locationLevel.length-1]);
													//console.log(dong);
										/* 			html += '<option value="'+locationList[i]+'"';
													if(i == 0){
														html += " selected "
													}
													html += '>'+locationLevel[locationLevel.length-1]+'</option>'
													$(".form-select").append('<option value="'+locationList[i]+'">'+locationLevel[locationLevel.length-1]+'</option>'); */
												}
											});
										}
									},
									error: function(){
										console.log("error");
									}
								});
		    				</script>
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
								<option value="1">불가능</option>
								<option value="2">가능</option>
						    </select>
						</div>
					</div>
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">가격</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="number" class="form-control" id="price" name="price" ><!-- 임시로 uidx 1로 지정해놨으니 uservo 쪽 완성되면 바꿀것. -->
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">내용</div>
						<div class="col-8 td" style="display:table-cell;">
							<textarea class="form-control" id="contents" name="contents" rows="10" cols="25"></textarea>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">키워드</div>
						<div class="col-8 td" style="display:table-cell;">
			           		<div class="form-group">
			              	  <input type="hidden" value="" name="tag" id="rdTag" />
			          		</div>
			             <div id="tag-list" ></div>
				           	 <div class="form-group">
				            	<input type="text" id="tag" size="7" placeholder="엔터로 해시태그를 등록해주세요." style="width: 300px;"/>
				          	 </div>
						</div>
					</div>
					
					
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">첨부 파일</div>
						<div class="col-8 td" style="display:table-cell;">
							<div id="fileDiv">
								<input type="file" id="file" name="file1" accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)' >
							</div>
								<br/><br/>
							<a href="#this" class="btn" id="addFile">파일 추가</a>
							</div>
					</div>
					
					<div class="text-end tr">
						<div class="td">
							<button class="btn" style="background:#00AAB2; color:#fff;">작성</button>
							<button class="btn" style="background:#00AAB2; color:#fff;" type="button" onclick="location.href='itemlist.do'" >취소</button>
						</div>
					</div>
					
					
					
				</form>
		<script>
		    $(document).ready(function () {
		
			 
			    //위와 같이 값을 먼저 넣어준 후 초기화를 시킨다. 그럼 아래와 같이 입력이 된다.
			    //초기화
				$('#summernote').summernote({
					height : 400, // set editor height
					minHeight : null, // set minimum height of editor
					maxHeight : null, // set maximum height of editor
					focus : true,
					lang : 'ko-KR' // 기본 메뉴언어 US->KR로 변경
				});
			
			    //저장버튼 클릭
			    $(document).on('click', '#saveBtn', function () {
			        saveContent();
			        });
			        
			    });
			 function saveContent() {
		    	
		        //값 가져오기
		        var Content = $('#summernote').summernote('code');        //썸머노트(설명)
		        alert("content : " + content);
				
		    }
		
		</script>
			<script type="text/javascript">
				var gfv_count = 1
				
				$(document).ready(function(){
					$("#list").on("click", function(e){ //목록으로 버튼
						e.preventDefault();
						fn_openBoardList();
					});
					
					$("#write").on("click", function(e){ //작성하기 버튼
						e.preventDefault();
						fn_insertBoard();
					});
					
					$("#addFile").on("click", function(e){ //파일 추가 버튼
						e.preventDefault();
						fn_addFile();
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
				
				function fn_addFile(){
					var str = "<p><input type='file' name='file"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></p>";
					$("#fileDiv").append("<p style='margin:auto;'><input type='file' name='file"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></p>");
					$("a[name='delete']").on("click", function(e){ //삭제 버튼
						e.preventDefault();
						fn_deleteFile($(this));
					});
				}
				
				function fn_deleteFile(obj){
					obj.parent().remove();
				}
				
				
				function chk_file_type(obj) {
				    var file_kind = obj.value.lastIndexOf('.');
				    var file_name = obj.value.substring(file_kind+1,obj.length); 
				    var file_type = file_name.toLowerCase();
		
		
		
				   var check_file_type = new Array();
				    check_file_type=['jpg','gif','png','jpeg','bmp',];
		
		
		
				    if(check_file_type.indexOf(file_type)==-1){
				     alert('이미지 파일만 선택할 수 있습니다.');
				     var parent_Obj=obj.parentNode
				     var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);
				     return false;
				     
				     }
				    
				}
			</script>
			<script>
			$("#joinFrm").submit(function(){
			    var fileCheck = $("#file").val();
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
					    }else if(!fileCheck){
					        alert("사진을 한 장 이상 첨부해주세요");
						       return false;
						}
			    });
			</script> 

		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>
</body>
</html>
