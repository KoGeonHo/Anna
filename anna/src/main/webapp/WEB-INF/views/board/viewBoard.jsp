<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<!-- 지도 API - 필요없으면 지워도 됨 -->
<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f&libraries=services"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 지도 API -->

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<!-- path는 request.getContextPath()를 가져온것. -->

<style>

.th {
	background:#eee;
	text-align:center;
	vertical-align:middle;
}
.th, .td{
	padding:10px;
}

.tr{
	display:table; 
	width:100%;
}


#commentstyle{

    border-top: #dee2e6 solid 1px;

}



#state td{
text-align:center;
width : 341px;

}

.LikeBtn{
	height:25px;
	vertical-align: middle;
	display:inline-block;
}

.comment-box{

}

.comment_Box{

display:block;
}

.img {

width : 50%;
height: 500px;
margin: 0px auto;

}

.board_img{

width : 75%;
margin : 0px auto;
text-align : center;
}

a{

text-decoration: none;
color : black;

}

.Reply_btn{
float: right;
height : 54px;

}

#Contents{
	width: 83%;
	}

#report_contents{


	border: 1px solid black;
	box-shadow: 3px 3px 7px 1px grey;
	background-color: white;
	z-index: 9999;
	display: none;
	position: fixed;
	margin-left: 35%;
	margin-top: 13%;
	padding:20px;
	

}



.report_back{



	position: fixed;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 99;
	display: none;
}

.userview{

	position: fixed;
	width: 120px;
	height: 55px;
	margin-left: -307px;
    margin-top: 33px;
	background: white;
	z-index: 99;
	display: none;

}
@media(577px <= width <= 767px){
	.comment-box{
			width:100%;
		}
		.comment-input{
			width: 83%;
		}
		.comment_box{
			width: 100%;
		}
		.m-none{
	
	display: none;
	
	}
}

#carouselExampleControls{
	width:500px;
	height:500px;
}
#slide-img{
	height:500px;
}

@media(max-width:767px){
	.col-2 {
		width:33.33333333%
	}
	.col-4 {
		width:66.66666666%
	}
	.col-1 {
		width:16.5%;	
	}
	
	.tabs{
	display:none;
	}
	
	#Contents{
	width: 66.66666667%;
	}
	
	#carouselExampleControls{
		width:90%;
		height:300px;
	}
	#slide-img{
		height:300px;
	}
	
}

@media(max-width: 576px){
	.comment-box{
		width:100%;
	}
	.comment-input{
		width: 83%;
	}
	.comment_box{
		width: 100%;
	}
	
	.Reply_btn{
		width : 16%;
	}
	
	.m-none{
	
	display: none;
	
	}
}

/*탭*/


.tabs > input{display:none; font-size: 0;}  /* 라디오버튼 안보이게 */
.tabs > input:checked + label{color:#191919;} /* 선택된 라디오 버튼의 폰트색을 변경 */
.tabs > input:checked + label::after{transform: translateY(8px); background:#00AAB2;}

.tabs > label{
        display: inline-block; text-align: center; cursor: pointer;
        font-size:17px; color:#999; padding:0 20px;
    }
.tabs > label::after{content:''; display:block; width:100%; height:3px; background:transtrent; transition:all .2s ease-in-out; }
.line{display:block; width:100%; height:3px; background-color:#ececec; margin:5px 0 50px 0;}
/*탭 끝*/

</style>
</head>
<body>

	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		<div class="report_back">
		</div>
		
		<div id="report_contents">
			<form id="reportFrm" action="report.do" enctype="multipart/form-data" method="post">		    
				<input type="hidden" name= "bidx" value="${bv.bidx}" id="bidx">
				<input type="hidden" name="evidence"value="2" id="evidence">
	    		<div class="row border-bottom tr">
	    			<div class="col-4 th" style="display:table-cell;">신고유형</div> 
	    			<div class="col-8 td" style="display:table-cell;">
		    			<select name="report_type" id="report_type">
		    				<option value="2">게시물 규칙위반</option>
		    				<option value="4">기타</option>
		    			</select>
		    		</div>	
	    		</div>
	    		<div class="row border-bottom tr">
	    			<div class="col-4 th" style="display:table-cell;">신고닉네임</div>
	    			<div class="col-8 td" style="display:table-cell;">${bv.nickName}<input type="hidden" value="${bv.uidx}" name="target"></div>
	    		</div>
	    		<div class="row border-bottom tr">
	    			<div class="col-4 th" style="display:table-cell;">상세설명</div>
	    			<div class="col-8 td" style="display:table-cell;"><textarea name="contents" id="contents" style="height: 150px;width: 100%;resize: none;"></textarea></div>
	    		</div>
	    		<div class="row border-bottom tr">
	    			<div class="col-4 th" style="display:table-cell;">신고자</div>
	    			<div class="col-8 td" style="display:table-cell;">${userLoginInfo.nickName}<input type="hidden" name="repoter" value="${userLoginInfo.uidx}"></div>
	    		</div>
	    		<div class="row border-bottom tr">
	    			<div class="col-4 th" style="display:table-cell;">첨부파일</div>
	    			<div class="col-8 td" style="display:table-cell;"><input type="file" class="form-control" name="file2" id="file" accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'></div>
	    		</div>
	    		
	    		<div style="float:right;">
	    			<button  id="report_btn">접수하기</button>
	    			<button type="button" id="close_button">닫기</button>
	    		</div>
    		</form>
    	</div>
		<div class="wrapper main">
			<img alt="" src="../images/board_bn.jpg" style="width:100%; margin-bottom: 34px;" class="m-none">
			<div class="container">
			<c:if test="${bv.board_type ne 'notice' }">
				<div class="tabs" style="text-align: center; padding-left: 30px; padding-right: 30px;">
					<input id="tab1" type="radio" name="tab_btn" onclick='location.href="${path}/board/boardlist.do?board_type=free";'<c:if test="${ bv.board_type eq 'free' }">checked</c:if>  />
					<label for="tab1">일상&amp;소통</label>
					<input id="tab2" type="radio" name="tab_btn" onclick='location.href="${path}/board/boardlist.do?board_type=job";'<c:if test="${ bv.board_type eq 'job' }">checked</c:if>/>
					<label for="tab2">구인&amp;구직</label>
					<input id="tab3" type="radio" name="tab_btn" onclick='location.href="${path}/board/boardlist.do?board_type=meeting";'<c:if test="${ bv.board_type eq 'meeting' }">checked</c:if>/>
					<label for="tab3">모임</label>
					<input id="tab4" type="radio" name="tab_btn" onclick='location.href="${path}/board/boardlist.do?board_type=hotplace";'<c:if test="${ bv.board_type eq 'hotplace' }">checked</c:if>/>
					<label for="tab4">핫플레이스</label>
					<div class="line"></div>
				</div>
			</c:if>
			
			
				<h4  class="border-bottom" style="padding:5px; margin:0; text-decoration-thickness: 1px; text-underline-offset: 8px;">
						<c:if test="${bv.board_type eq 'free'}">
							<a href="boardlist.do?board_type=free">일상&소통</a>
						</c:if>
						<c:if test="${bv.board_type eq 'job'}">
							<a href="boardlist.do?board_type=job">구인구직</a>
						</c:if>
						<c:if test="${bv.board_type eq 'meeting'}">
							<a href="boardlist.do?board_type=meeting">모임</a>
						</c:if>
						<c:if test="${bv.board_type eq 'hotplace'}">
							<a href="boardlist.do?board_type=hotplace">핫플레이스</a>
						</c:if>
						<c:if test="${bv.board_type eq 'notice'}">
							<a href="boardlist.do?board_type=notice">공지사항</a>
						</c:if>
					</h4>
		
				<form style="margin: 0px auto;">
					
					<div class="row">
						<div class="col-2 th border-bottom" style="display:table-cell;">제목</div>
						<div class="col-4 td border-bottom" style="display:table-cell;">
							${bv.title}
							
						</div>
						<div class="col-2 th border-bottom" style="display:table-cell;">작성일</div>
						<div class="col-4 td border-bottom" style="display:table-cell;">${bv.wdate}</div>				
					</div>
					<div class="row ">
						<div class="col-2 th border-bottom" style="display:table-cell;">작성자</div>
						<div class="col-4 td border-bottom" style="display:table-cell;">
							<c:if test="${ bv.board_type eq 'notice' }">
								관리자
							</c:if>
							<c:if test="${ bv.board_type ne 'notice' }">
								<div><a class="user" onclick="view()">${bv.nickName}</a></div>
							</c:if>
						</div>
						<div class="userview">
									<a class="" onclick="ready()">이웃추가</a> <br>
									<a class="" onclick="ready()">유저 정보보기</a>
						</div>
						<div class="col-2 th border-bottom" style="display:table-cell;">조회수</div>
						<div class="col-1 td border-bottom" style="display:table-cell;">${bv.hit}</div>
						<div class="col-2 th border-bottom" style="display:table-cell;">추천</div>
						<div class="col-1 td border-bottom" style="display:table-cell;">${bv.cntLike}
							<c:if test="${ bv.board_type ne 'notice' }">
								<input type="image" src="../images/icon_unlike.png" class="LikeBtn" style="margin: -5px 0 0 0">
							</c:if>
						
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-12 td">
							<div id="carouselExampleControls" class="carousel slide" style="margin:auto;" data-bs-ride="carousel">
								  <div class="carousel-inner">
								  <c:if test="${bv.board_type != 'free' and bv.place_location != null}">
								    <div class="carousel-item active">
								      <div id="map" style="width:100%; height:500px;" onclick="window.open('https://map.kakao.com/?q=${bv.place_name}&urlLevel=5')"></div>
								    </div>
							 	 </c:if>
								  <c:if test="${bv.image1 != null}">
								    <div class="carousel-item active">
								    	<div id="slide-img" style="width:100%; background:url('${ path }/resources/upload/${bv.image1}'),url('${path}/images/no_image.gif'); background-position:center; background-repeat:no-repeat; background-size:cover;"></div>
								      	<%-- <img src="../resources/upload/${bv.image1}" class="d-block w-100" alt="..." style="width:100%;height:500px;"> --%>
								    </div>
							 	 </c:if>
							 	  <c:if test="${bv.image2 != null}">
								    <div class="carousel-item">
								      <img src="../resources/upload/${bv.image2}" class="d-block w-100" alt="..." style="width:100%;height:500px;">
								    </div>
								  </c:if>
								  <c:if test="${bv.image3 != null}">
								    <div class="carousel-item">
								      <img src="../resources/upload/${bv.image3}" class="d-block w-100" alt="..." style="width:100%;height:500px;">
								    </div>
								  </c:if>
								  <c:if test="${bv.image4 != null}">
								    <div class="carousel-item">
								      <img src="../resources/upload/${bv.image4}" class="d-block w-100" alt="..." style="width:100%;height:500px;">
								    </div>
								  </c:if>
								  <c:if test="${bv.image5 != null}">
								    <div class="carousel-item">
								      <img src="../resources/upload/${bv.image5}" class="d-block w-100" alt="..." style="width:100%;height:500px;">
								    </div>
								  </c:if>  
								  </div>
								  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
								    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
								    <span class="visually-hidden">Prev</span>
								  </button>
								  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
								    <span class="carousel-control-next-icon"  aria-hidden="true"></span>
								    <span class="visually-hidden">Next</span>
								  </button>
							</div>
						</div>
					</div>
					
					<div class="row border-bottom tr" style="height:auto;">
						<div class="col-2 th" style="display:table-cell; ">내용</div>
						<div class="col-10 td" style="display:table-cell; ">
							${bv.contents }
						</div>
					</div>
					<c:if test="${bv.uidx == uidx}">
					<div style="text-align: right;">
				    	<a href="BoardModify.do?Bidx=${bv.bidx }" >수정</a>&nbsp;<a class="" onclick="delCheck()" >삭제</a>
				    </div>
				    </c:if>
				    <c:if test="${bv.uidx != uidx and bv.board_type != 'notice'}">
				    	<div style="margin: auto; height: 25px" id="report"><a class="report" style="cursor:pointer; float:right; ">신고</a></div>
				    </c:if>
				</form>


				<c:if test="${ bv.board_type ne 'notice' }">
                    <div class="comment-box" style="margin-top: 18px;">
                    	<div class="row  tr">
	   		            	<div class="comment-count col-2 th">댓글 <span id="count"></span></div>
	   		                <form method='post' id="commentForm" style="margin: auto;">
		   		                 <div class="comment-name">
			                        <span class="anonym">
			                       		<input type="hidden" class="form-control" id="nickName" name ="nickName" value='${userLoginInfo.nickName}'>
			                        	<input type="hidden" name="uidx" value="${uidx}">
			                        </span>
			                      </div>   
		                        	
		                        <!-- </span> -->
	                     
	                    <div class="comment-sbox  d-flex">
	                    	<input type="hidden" value="${bv.bidx}" name="Bidx" id="Bidx">
	                    	<div style="flex:1; padding: 0px 10px 0 0px;">
	                    		<textarea class="comment-input" id="Contents" style="resize: none; width:100%; height:100%;" name="Contents"></textarea>
	                    	</div>
	                    	<div>
	                    		<button class="Reply_btn" id="commentwrite" style="width:auto;">등록</button>
	                    	</div>                    	
	                    </div>
	                    </form>
                    	</div>
    			   </div>
    			   
    			    <div class="comment_Box" style="margin-top:15px;"> <!-- 댓글이 들어갈 박스 -->

	                </div>
				</c:if>
	                <div style="height: 150px"></div>
	                
	                

			</div>
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>

<script type="text/javascript">
					
 $(".report").click(function() { //신고하기 레이아웃
        $("#report_contents").fadeIn();
 		$(".report_back").fadeIn();
        
    });

    $("#close_button").click(function(){
        $("#report_contents").fadeOut();
        $(".report_back").fadeOut();
        
    });

    function view(){
	    if($(".userview").css("display") == "block"){
		        $(".userview").fadeOut();
	    }else{
	    	$(".userview").fadeIn();
	    	
	    }
    	
    }
    
    function ready(){
	    
    	alert("서비스 준비중입니다.");
    }

$(function(){
	$('#commentwrite').click(function() {
		
		if(${uidx == null}){
			alert("로그인 이후 이용해주세요");
			location.href="/anna/user/login.do";
			return false;
		}else{
		const Bidx = ${bv.bidx};
		const nickName = $('#nickName').val();
		const Contents = $('#Contents').val();
	  	
	  	if (Contents == ""){
	  		alert("내용을 입력하세요");
	  		$('#Contents').focus();
	  		return;
	  	}
			//Json으로 전달할 파라미터 변수선언

			console.log(Bidx);
			console.log(nickName);
			console.log(Contents);
		
			/* if(com_writer == ''){
				alert('로그인 후 이용해주세요');
				return;
			}else if(com_content == '') {
				alert('내용을 입력하세요');
			} */
			
			 $.ajax({
				url:'InsertComment',
				data:$("#commentForm").serialize(),
				success:function(data){
					console.log('통신성공' + data);
					if(data === 'InsertSuccess') {
						alert('댓글 등록이 완료되었습니다.');
						console.log('댓글 등록 완료');
						$('#nickName').val(nickName);
	  					$('#Contents').val('');
	  					getList();
					} else {
						alert('로그인 이후 이용해주시기 바랍니다.');
						console.log('댓글 등록 실패');
					}
				},
				error:function(){
					
				}
			});// 댓글 비동기 끝 
		}	
	});// 댓글등록 이벤트 끝

	getList();
});


function getList() {
	
	const Bidx = ${bv.bidx};

	const Contents = $('#Contents').val();
		/* const com_no = ${com}; */
	$.ajax({
		url : "CommentList",
		data : "Bidx="+Bidx,
		success : function(data) {
			
			
			if(data.total > 0){
				var list = data.list;
				
				var comment_html = "<div class='row' id='commentstyle'>";
				
				$('#count').html(data.total);
				for(i = 0;i < list.length;i++){
					var Contents = list[i].contents;
					var nickName = list[i].nickName;
					var wdate = list[i].wdate;
					
					comment_html += "<div class='row border-bottom' style='padding: 8px 0; '>"
					
					comment_html += "<div class='col-2 td' style='border-right: #dee2e6 solid 1px; text-align:center;'><span id='nickName'><strong>" + nickName + "</strong></span></div>";
					comment_html += "<div class='td' id='Contents' style='display:flex;'>";
					comment_html += "<div style='flex:1;'>"+Contents+"<p style='margin: 10px 0 0 0;'>"+wdate+"";
					
					if(nickName=== $("#nickName").val()){
						 comment_html += "&nbsp;<a class=''>수정</a>&nbsp;"
						 comment_html += "<a class=''>삭제</a></p></div>";
					}
			
					comment_html += "</div>";
					
					
					comment_html += "</div>"
					
				}
				
				console.log(comment_html);
				
				$(".comment_Box").html(comment_html);
				
				
			}
			else{
				var comment_html = "<div>등록된 댓글이 없습니다.</div>";
				$(".comment_Box").html(comment_html);
			}
	
		
		}
	});//ajax
		
};

function Like(){

	var likeval = ${like}; //컨트롤러에서 선언한 like 인듯
	
	let Bidx = ${bv.bidx};
	<c:if test="${ not empty uidx}">
	let Uidx = ${uidx};
	
	if(likeval == 1){
		console.log(likeval + "좋아요 누름");
		$('.LikeBtn').attr("src", "../images/icon_like.png")
		$('.LikeBtn').click(function() {
			$.ajax({
				type :'post',
				url : 'likeDown',
				data : "Bidx="+Bidx+"&Uidx="+Uidx,
				success : function(data) {
					alert('추천 취소');
					location.reload();
				}
			})// 아작스 끝
		})
	
	
	}else if(likeval == 0){
		console.log(likeval + "좋아요 안누름")
		console.log(Uidx);
		$('.LikeBtn').attr("src", "../images/icon_unlike.png");
		$('.LikeBtn').click(function() {
			$.ajax({
				type :'post',
				url : 'likeUp',
				data : "Bidx="+Bidx+"&Uidx="+Uidx,
				success : function(data) {
					alert('추천');
					location.reload();
				}
			})// 아작스 끝
		});
	
	}
	</c:if>

}

Like();

</script>
<script>
	
	$('#report_btn').click(function() {
		
		var formData = new FormData($("#reportFrm")[0]);
	
	
		$.ajax({
			type : 'POST',
			url : 'report.do',
			processData:false,
			contentType: false,
		    data: formData,
			success : function(json){
				alert("등록되었습니다.");
				
			},
			error: function(xhr, status, error){
				alert("실패."+error);
			}
		});
	});




	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(${bv.place_location}), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };
	
	console.log(mapOption);
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	
	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	
	map.setDraggable(false);
	map.setZoomable(false);
	

	
	
	var iwContent = '<div style="padding:5px;">'+'${bv.place_name}'+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker);
	    
	    
//파일
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

//댓글

$("#delete").click(function(){
	
	location.href="";
	
	
	
});


$("#modify").click(function(){
	
	
	
	
});

//삭제확인

function delCheck(){
	if(confirm("삭제하시겠습니까?")== true){
		
		location.href='BoardDelete.do?Bidx='+${bv.bidx}+'&board_type=${bv.board_type}';
	}else{
		
		return false;
	}
	
}


</script>
					
					
					
</body>
</html>