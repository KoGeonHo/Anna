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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 지도 API -->

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<!-- path는 request.getContextPath()를 가져온것. -->

<style>

#commentstyle{

border-width: 1px 0px 0px 0px ;
  border-style: solid;

}



#state td{
text-align:center;
width : 341px;

}

.LikeBtn{
margin:auto;
display:block;
}

.comment-box{
width : 700px;
margin:auto;
display:block;
}

.comment_Box{

width : 700px;
margin:auto;
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

#report_contents{

	height: 610px;
	width: 503px;
	border: 1px solid black;
	box-shadow: 3px 3px 7px 1px grey;
	background-color: white;
	z-index: 9999;
	display: none;
	position: fixed;
	margin-left: 35%;
	margin-top: 13%;
	

}

#report_contents div{
width : 400px;
text-align : center;
margin : 0px auto;

}

.report_back{



	position: fixed;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
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
}

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
				<input type="text" name= "bidx" value="${bv.bidx}" id="bidx">
				<input type="text" name="evidence"value="2" id="evidence">
	    		<div>
	    			신고유형 : <select name="report_type" id="report_type">
	    						<option value="2">게시물 규칙위반</option>
	    						<option value="4">기타</option>
	    					</select>
	    		</div>   	   
	    		<div>신고닉네임 : ${bv.nickName}<input type="text" value="${bv.uidx}" name="target"></div>
	    		<div>상세설명 <textarea name="contents" id="contents"></textarea></div>
	    		<div>신고자: ${userLoginInfo.nickName}<input type="text" name="repoter" value="${userLoginInfo.uidx}"></div>
	    		첨부파일 <input type="file" name="file2" id="file">
	    	
	    		<div>
	    			<button  id="report_btn">접수하기</button>
	    			<button type="button" id="close_button">닫기</button>
	    		</div>
    		</form>
    	</div>
		<div class="wrapper">
			<div class="container main">
				<h4 class="border-bottom" style="padding:1rem; margin:0px;">
					<c:if test="${bv.board_type eq 'free'}">
						<a href="FreeBoard.do">일상소통</a>
					</c:if>
					<c:if test="${bv.board_type eq 'job'}">
						구인구직
					</c:if>
				> ${bv.title}
				</h4>
				<input type="hidden" value="${bv.bidx}" name="Bidx" id="Bidx">
				<input type="hidden" name="uidx" value="${uidx}">
				<table id="state">
					<tr>
						<td>${bv.nickName}</td>
						<td>${bv.wdate}</td>
						<td>조회수 :${bv.hit} 추천 :${bv.cntLike}</td>
					</tr>
				
				</table>
				<br>
					
				
					<div><h2><span id="title">  </span></h2></div>
				
					<div>${bv.contents}</div>
				
				
				
					
					<c:if test="${bv.image1 != null}">
					<div class="board_img"><img src="../resources/upload/${bv.image1}" alt ="불러올 수 없는 이미지입니다." class="img"></div>
					</c:if>
					
					<c:if test="${bv.image2 != null}">
					<div class="board_img"><img src="../resources/upload/${bv.image2}" alt ="불러올 수 없는 이미지입니다." class="img"></div>
					</c:if>
					
					<c:if test="${bv.image3 != null}">
					<div class="board_img"><img src="../resources/upload/${bv.image3}" alt ="불러올 수 없는 이미지입니다." class="img"></div>
				    </c:if>
				    
				    <c:if test="${bv.image4 != null}">
					<div class="board_img"><img src="../resources/upload/${bv.image4}" alt ="불러올 수 없는 이미지입니다." class="img"></div>
				    </c:if>
				    
				    <c:if test="${bv.image5 != null}">
					<div class="board_img"><img src="../resources/upload/${bv.image5}" alt ="불러올 수 없는 이미지입니다." class="img"></div>
				    </c:if>
					<c:if test="${bv.uidx == uidx}"> 
				    	<a href="BoardModify.do?Bidx=${bv.bidx }">수정</a>
				    	<a href="BoardDelete.do?Bidx=${bv.bidx}">삭제</a>
				    </c:if>
				    <c:if test="${bv.uidx != uidx }">
				    	<span id="report"><a class="report" style="cursor:pointer;">신고</a></span>
				    </c:if>
				    	
				    
				    <input type="image" src="../images/icon_unlike.png" class="LikeBtn">
    

                    <div class="comment-box">
   		                 <div class="comment-count">댓글 <span id="count">0</span></div>
 
   		                <form method='post' id="commentForm">
   		                 	   <!-- <span class="c-icon"><i class="fa-solid fa-user"></i>  -->
   		                 <div class="comment-name">
	                        <span class="anonym">
	                       		<input type="hidden" class="form-control" id="nickName" name ="nickName" value='${userInfo.nickName}'>
	                        	<input type="hidden" name="uidx" value="${uidx}">
	                        </span>
	                      </div>   
	                        	
	                        <!-- </span> -->
                     
                    <div class="comment-sbox">
                    	<input type="hidden" value="${bv.bidx}" name="Bidx" id="Bidx">
                        <textarea class="comment-input" id="Contents" cols="80" rows="2" style="resize: none;" name="Contents"></textarea>
                     	<button class="Reply_btn" id="commentwrite">댓글등록</button>
                    </div>
                    </form>
                    	
    			   </div>
    			   
    			    <div class="comment_Box"> <!-- 댓글이 들어갈 박스 -->

	                </div>
	                
	                
	                

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
					
					
					$(function(){
						$('#commentwrite').click(function() {
							
							
							
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
										alert('통신실패');
									}
								});// 댓글 비동기 끝 
								
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
									
									var comment_html = "<div>";
									
									$('#count').html(data.total);
									for(i = 0;i < list.length;i++){
										var Contents = list[i].contents;
										var nickName = list[i].nickName;
										comment_html += "<div id='commentstyle'><span id='nickName'><strong>" + nickName + "</strong></span><br/>";
										comment_html += "<span id='Contents'>" + Contents + "</span><br>";
										if(nickName=== $("#nickName").val()){
											 comment_html += "<span id='delete' style='cursor:pointer;' data-id ="+Contents+">[삭제]</span><br></div>";
										}
										else{
											comment_html += "</div>";
										}
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
									alert('취소 성공');
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
									alert('성공염');
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
					
					</script>
</body>
</html>