<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>

</head>
<body>

제목 : ${bv.title} 작성자 :${bv.nickName }
<br>
내용 : ${bv.contents}

<br>

	
	<c:if test="${bv.image1 != null}">
	<input type="image" src="../resources/upload/${bv.image1}" alt ="안되는데요?"><br>
	</c:if>
	
	<c:if test="${bv.image2 != null}">
	<input type="image" src="../resources/upload/${bv.image2}" alt ="안되는데요?"><br>
	</c:if>
	
	<c:if test="${bv.image3 != null}">
	<input type="image" src="../resources/upload/${bv.image3}" alt ="안되는데요?"><br>
    </c:if>
    
    <c:if test="${bv.image4 != null}">
	<input type="image" src="../resources/upload/${bv.image4}" alt ="안되는데요?"><br>
    </c:if>
    
    <c:if test="${bv.image5 != null}">
	<input type="image" src="../resources/upload/${bv.image5}" alt ="안되는데요?"><br>
    </c:if>
    
                    <div class="comment-box">
   		                 <div class="comment-count">댓글 <span id="count">0</span></div>
 
   		                 	   <!-- <span class="c-icon"><i class="fa-solid fa-user"></i>  -->
   		                 <div class="comment-name">
	                        <span class="anonym">작성자 : 
	                    	   	<input type="text" class="form-control" id="nickName" placeholder="이름" name ="nickName" value='${nickName }' readonly  style="width: 100px; border:none;">
	                        	<input type="hidden" name="uidx" value="${uidx}">
	                        </span>
	                      </div>   
	                        	
	                        <!-- </span> -->
                     <!--<img src="/익명.jpg" width ="50px" alt="My Image"><!-->
                    <div class="comment-sbox">
                    	<input type="text" value="${bv.bidx}" name="Bidx" id="Bidx">
                        <textarea class="comment-input" id="Contents" cols="80" rows="2" name="Contents" ></textarea>
                        <!-- <span class="com-function-btn" type="hidden">
                            
                            <a href="#"><i class="fa-solid fa-pen-to-square"></i></a>
                            <a href="#"><i class="fa-solid fa-trash-can"></i></a>
                         </span> -->
                    </div>
                    	<div class="Reply_btn"><!-- regBtn -->
                    		<button id="commentwrite">댓글등록</button>
                    		
                    	 </div>
    			   </div>
    			   
    			    <div class="comment_Box" style="border:1px solid gray;"> <!-- 댓글이 들어갈 박스 -->

	                </div>
<script type="text/javascript">
$(function(){
	$('#commentwrite').click(function() {
		
		alert("이거맞나요?");
		
			//Json으로 전달할 파라미터 변수선언
			const Bidx = ${bv.bidx};
			const nickName = $('#nickName').val();
			const Contents = $('#Contents').val();
			const Uidx = ${uidx};
			
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
				data:"Bidx="+Bidx+"&nickName="+nickName+"&Contents="+Contents+"&Uidx="Uidx,
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
	const nickName = $('#nickName').val();
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
					var writer = list[i].nickName;
					comment_html += "<div><span id='nickName'><strong>" + nickName + "</strong></span><br/>";
					comment_html += "<span id='Contents'>" + Contents + "</span><br>";
					if(writer === $("#nickName").val()){
						 comment_html += "<span id='delete' style='cursor:pointer;' data-id ="+Contents+">[삭제]</span><br></div><hr>";
						 
					}
					else{
						comment_html += "</div><hr>";
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

</script>
</body>
</html>