<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(function(){
	$('#commentwrite').click(function() {
		
		alert("이거맞나요?");
		
			//Json으로 전달할 파라미터 변수선언
			const Bidx = ${bv.bidx};
			const com_writer = $('#com_writer').val();
			const Contents = $('#Contents').val();
			
			console.log(Bidx);
			console.log(com_writer);
			console.log(Contents);
		
			/* if(com_writer == ''){
				alert('로그인 후 이용해주세요');
				return;
			}else if(com_content == '') {
				alert('내용을 입력하세요');
			} */
			
			$.ajax({
				type:'post',
				url:'<c:url value="/board/InsertComment"/>',
				data: JSON.stringify(
					{
						"Bidx":Bidx,
						"com_writer":com_writer,
						"Contents":Contents
					}		
				),
				contentType: 'application/json',
				success:function(data){
					console.log('통신성공' + data);
					if(data === 'InsertSuccess') {
						alert('댓글 등록이 완료되었습니다.');
						console.log('댓글 등록 완료');
						$('#com_writer').val(com_writer);
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
	const com_writer = $('#com_writer').val();
	const com_content = $('#Contents').val();
		/* const com_no = ${com}; */
	$.getJSON(
		"<c:url value='/board/CommentList/'/>"+Bidx,
		function(data) {
			if(data.total > 0){
				var list = data.list;
				
				var comment_html = "<div>";
				
				$('#count').html(data.total);
				for(i = 0;i < list.length;i++){
					var contents = list[i].Contents;
					var writer = list[i].com_writer;
					comment_html += "<div><span id='com_writer'><strong>" + writer + "</strong></span><br/>";
					comment_html += "<span id='Contents'>" + Contents + "</span><br>";
					if(writer === $("#com_writer").val()){
						 comment_html += "<span id='delete' style='cursor:pointer;' data-id ="+Contents+">[삭제]</span><br></div><hr>";
						 
					}
					else{
						comment_html += "</div><hr>";
					}
				}
				
				$(".comment_Box").html(comment_html);
				
				
			}
			else{
				var comment_html = "<div>등록된 댓글이 없습니다.</div>";
				$(".comment_Box").html(comment_html);
			}
	
		
		}
		);//getJson
		
};

</script>
</head>
<body>

제목 : ${bv.title}
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
    

    댓글안써짐
                    <div class="comment-box">
   		                 <div class="comment-count">댓글 <span id="count">0</span></div>

   		                 	   <!-- <span class="c-icon"><i class="fa-solid fa-user"></i>  -->
   		                 <div class="comment-name">
	                        <span class="anonym">작성자 : 
	                    	   	<input type="text" class="form-control" id="com_writer" placeholder="이름" name ="com_writer" value='아직 안넣을거임' readonly  style="width: 100px; border:none;">
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
</body>
</html>