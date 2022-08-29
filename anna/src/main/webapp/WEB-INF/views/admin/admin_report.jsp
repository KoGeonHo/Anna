<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@page session="true" %>

<head>
<meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
<title>신고리스트</title>

		<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="<%=request.getContextPath()%>/css/admin_user.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        
        <style>
           .col-md-10 {
            padding-top: 90px;
            margin-bottom: 60px;
           }
           
           tbody > tr > th {
           font-size : 14px;
           	font-weight : normal;
           	text-align: center;           		
           
           }
           
           .btn {
           		line-height: 0.65;
           		font-size: 0.85rem;
           }
           
           .card-body {
					padding-left: 50px;
					padding-right: 50px;
				}
				
			#imgView{
			
			display:none;
			position: fixed;
			margin-left: 15%;
    		margin-top: -11%;
			
			}

        </style>
        
        
        <!-- 관리자 정보 메뉴  -->
<style type="text/css">

			.modal {
				position: fixed;
				width: 100%;
				height: 100%;
				background: rgba(0, 0, 0, 0.5);
				top: 0;
				left: 0;
				z-index: 99;
				display: none;
			}

			.banner_online {
 				width: 650px;
				border: 1px solid black;
				box-shadow: 3px 3px 7px 1px grey;
				background-color: white;
				z-index: 9999;
				margin-left: 22%;
    			margin-top: -9%;
				display: none;
				position: fixed;
			}
			
			.banner_online h1 {
			    font-weight: bold;
				text-align: center;
				font-size: 20px;
				margin: 43px -12px 28px auto;
			}
			
			.banner_online p .second {
				margin-left: 6px;
			}
			
			.pop_content {
				font-size: 13px;
				margin-left: 80px;
  				margin-right: 80px;
				text-align: center;
			}
			
			.banner_online_how {
				height: 78px;
				width: 444px;
				margin-left: 28px;
				border: 1px solid #82bf77;
				margin-top: 22px;
			}
			
			.banner_online_how h3 {
				font-size: 12px;
				margin-left: 6px;
				margin-top: 16px;
			}
			
			.p_bottom {
				margin-left: 30px;
			}
			
			
			.modal_list > table > tr > td{
				width : 30px;			
				border-bottom: 1px solid #cdd0d4;	
			}
			
			#td_line {
			border-bottom: 1px solid #cdd0d4;	
			}
			
			.form-select-sm {

			    width: 83px;
			}
			
			#menu_box {
				display: flex;
				padding : ;
				position: relative;
  				left: 52px;
  				margin : 30 0 10 31;
  				

			}
			#close_button {
				width: 83px;
				height : 31px;				
			}
			
			#test_button {
				width: 95px;
				height : 31px;				
			}
			
			.form-select form-select-sm{
				border:1px solid #3881B4;
			}
			
</style>

<script>
let myMap = new Map();
	/* alert("준비중입니다.");
	history.back(); */
</script>
 

</head>
<body>


</head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="../admin/admin_user.do">관리자페이지</a>
            <!-- Sidebar Toggle-->
            <h5 style="color:#fff; text-align:right; margin-left:1550px; cursor:pointer;" onclick="javascript:location.href='<%=request.getContextPath()%>/main.do';">HOME</h5> 

            
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="fas fa-user-friends"><i class=" "></i></div>
                                &nbsp;회원관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link"  href="../admin/admin_user.do">회원리스트</a>
                                    <a class="nav-link" href="../admin/admin_report.do">신고리스트</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                사이트 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                   <a class="nav-link collapsed" href="../admin/admin_boarditem.do">판매글 관리</a>
                                   <a class="nav-link collapsed" href="../admin/admin_qna.do">문의사항</a>
                                   <a class="nav-link collapsed" href="../admin/admin_notice.do">공지사항</a>
                                   <a class="nav-link collapsed" href="../admin/admin_board.do">커뮤니티</a>
                                   <!-- <a class="nav-link collapsed" href="../admin/admin_slide.do">이벤트 배너 설정</a> -->
                                   <a class="nav-link collapsed" href="void(0);" onclick="alert('준비중입니다');return false;">이벤트 배너 설정</a>
                                </nav>
                            </div>
                    	</div>
                    </div>
                </nav>
            </div>



            <div id="layoutSidenav_content"> 
                <main>
                <div class="container-fluid px-4">
            <!-- 검색 -->
					<div class="container">
						<div class="d-md-none d-lg-block d-xl-block">
					    <div class="row">
					        <div class="col-md-1 col-sm-0"></div>
					        <div class="col-md-10  col-sm-12" >
                                <h6 style="font-weight:bold">⚫️ 신고목록 검색</h6>
                                <br>
					            <form class="d-flex ">
                                    
						          <input class="form-control me-6 vh-20" type="search" placeholder="검색어를 입력하세요" aria-label="Search">
						          <button class="btn btn-outline-primary" type="submit" href="void(0);" onclick="alert('준비중입니다');return false;">Search</button>
						        </form>
					        
					        </div>
					        <div class="col-md-1 col-sm-0"></div>
					    </div>
					    </div>
					    </div>	
                        </div>
				  	<!-- 검색 -->


                      <div class= "modal">
						</div>
						 <form action="admin_report.do" method="post">
						    <div class = "banner_online">
						        
						        <h1>신고 상세보기</h1><br>
						        <div class="pop_content">
						         			
						       
						             <table border="0" id="report_table" name="modal_list" style="text-align:  left; border-bottom: 1px solid #cdd0d4;">
							             	<tr>
							             		<td id="ridx">
							             			
							             		</td>
							             		<td id="evidence_td">
							             		
							             		</td>
							             		<td id="item_idx_td">
							             		
							             		</td>
							             		<td id="bidx_td">
							             		
							             		</td>
							             	</tr>
							             	
							             	<tr>
												<td id="td_line" width="130px;" height= "40px;" >신고유형</td>
												<td id="report_type"></td>
											</tr>
											<tr>
											    <td id="td_line" width="130px;" height= "40px;">신고닉네임</td>
											    <td id="target"></td>
											    
											</tr>
									
											<tr>
											    <td id="td_line" width="130px;" height= "200px;" style="vertical-align: top; padding-top: 10px;">상세설명</td>
											    <td id="contents" style="vertical-align: top; padding-top: 10px;"></td>
											</tr>
											<tr>
											    <td id="td_line"  width="130px;" height= "40px;">신고일</td>
											    <td id="date"></td>
											</tr>
											<tr>
											    <td id="td_line" width="130px;" height= "40px;">신고자</td>
											    <td id="repoter"></td>
											</tr>
											
											<tr>
											
											    <td id="td_line" width="130px;" height= "40px;">첨부파일</td>
											    <td id="attach_td"></td>				  
											</tr>
											
									</table>
								
									    <br>
								</div>
								 <script>
								 		
								 
								       function postCheck(){ //게시물 확인
								    	   
								    	   var bidx=$("#bidx").val();
								    	   var item_idx=$("#item_idx").val();
								    	   
				               					if($("#evidence").val() == 1){
				               						location.href="<%=request.getContextPath()%>/boarditem/itemview.do?item_idx="+item_idx
						                    			
				                    			}else if($("#evidence").val() == 2){
		
				                    						location.href="<%=request.getContextPath()%>/board/viewBoard.do?Bidx="+bidx
				                    			}
				                    	}
								       
								       $("#attach_td").mouseover(function(){
								    		$("#imgView").css("display","block")
								    		
								    		});
								       
								       $("#attach_td").mouseout(function(){
								    		$("#imgView").css("display","none")
								    		
								    	});
						       </script>
								
						        <div id="menu_box">
						          	<div id="menu_box">
										<button type="button"  id="test_button" class="btn " style="width :105px; background-color: #3881B4; color: #fff; cursor: pointer;" onclick="postCheck()" style="font-size: 14px;">거래글 확인</button>
						       			 &nbsp;
						       			<button id="test_button" class="btn " style="background-color: #E51D21; color: #fff; cursor: pointer;"  style="font-size: 14px;">신고 적용 </button>
						       			&nbsp;
						       			<button type="button"  id="close_button" class="btn" style="background-color: #00AAB2; color: #fff; cursor: pointer;" style="font-size: 14px;">닫기</button>
						        	</div>
						        </div>
						  	</div>
						       
						      
						       </form>
                   
                       
                            <div class="card mb-4">
                                <div class="card-body">
                                    <table id="datatablesSimple">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>신고유형</th>
                                                <th>신고대상</th>
                                                <!-- <th>신고명</th> -->
                                                <th>상세설명</th>
                                                <th>신고일</th>
                                                <th>신고자</th>
                                                <!-- <th>노쇼</th> -->
                                                <th>상세보기</th>
                                                <th>적용여부</th>
                                                <th>적용일자</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${ not empty ReportList }">
	                                        	<c:forEach var="i" items="${ReportList}">
	                                        		
	                                        		<tr> 
	                                        			<th>${ i.ridx } </th>
	                                        			<th>
	                                        				<c:if test="${i.report_type == 0}">
	                                        					노쇼
															</c:if>
															<c:if test="${i.report_type == 1}">
	                                        					비속어&비매너채팅
															</c:if>
															<c:if test="${i.report_type == 2}">
	                                        					게시물 규칙 위반
															</c:if>
															<c:if test="${i.report_type == 3}">
	                                        					허위매물
															</c:if>
															<c:if test="${i.report_type == 4}">
	                                        					기타
															</c:if>
	                                        			
	                                        			</th>
	                                        			<th>${ i.targetname }</th>
	                                        			<th>${ i.contents }</th>
	                                        			<th>${ i.report_date }</th>
	                                        			<th>${i.repotername }</th>
	                                        			<th>
	                                        			<button type="button" class="openModalPop btn"  style="background-color: #00AAB2; color: #fff;"  style="font-size: 14px;" onclick="check(${i.ridx})">상세보기</button>
	                                        			
	                                        			<script>
									               			function check(a){
									               				
									               				console.log(a);
									               				
									               				const ridx = a; // ridx를 함수에 넣음
									               				console.log(ridx);
									               				
									               				
									               				$.ajax({
									               					
									    							url : "reportview", //reportview라는 경로에
									    							data : "ridx="+ridx, //ridx를 넘김
									    							success : function(data) { //리턴받은 데이터로
									    								
									    								
									    								
									    									var list = data.list;
									    							
									    									console.log("여기까진옴");
									    									console.log(list[0].report_type);
									    									console.log(list[0].ridx)
									    									
									    								       if(list[0].report_type== 0){
									    									   		var report_type='노쇼'
									    									   }else if(list[0].report_type == 1){
									    										   
									    										   var report_type='비속어&비매너채팅'
									    									   }else if(list[0].report_type ==2){
									    										   var report_type='게시물 규칙위반'
									    									   }else if(list[0].report_type ==3){
									    										   var report_type='허위매물'
									    										   
									    									   }else if(list[0].report_type ==4){
									    										   
									    										   var report_type='기타'
									    									   }
									    								   
									    								   
									    								   var target = list[0].targetname
									    								   var content = list[0].contents
									    								   var report_date = list[0].report_date
									    								   var repoter = list[0].repotername
									    								   var attach = list[0].attach
									    								   var ridx = list[0].ridx
									    								   var evidence = list[0].evidence
									    								   var bidx = list[0].bidx
									    								   var item_idx = list[0].item_idx
									    								   
									    								   $("#report_type").html(report_type);
									    								   $("#target").html(target);
									    								   $("#contents").html(content);
									    								   $("#date").html(report_date);
									    								   $("#repoter").html(repoter);
									    								   $("#attach_td").html(attach + "<img id='imgView' src='../resources/upload/"+attach+"' alt ='안되는데요' style='width:400px'>");
									    								   $("#ridx").html("<input type='hidden' name='ridx' value='"+ridx+"'>"); 
									    								   $("#evidence_td").html("<input type='hidden' id='evidence' name='evidence' value='"+evidence+"'>");
									    								   $("#bidx_td").html("<input type='hidden' id='bidx' name='bidx' value='"+bidx+"'>");
									    								   $("#item_idx_td").html("<input type='hidden' id='item_idx' name='item_idx' value='"+item_idx+"'>");
									    								   /* </td>
									    									
									    									
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
									    								} */
									    						
									    							
									    							}
									    						});//ajax
									    						
									    						$(".banner_online").fadeIn();
							    						 		$(".modal").fadeIn();
									               			}
									    						
									               			$("#close_button").click(function(){
														        $(".banner_online").fadeOut();
														        $(".modal").fadeOut();
														        
														    });
									               			
									               			
									               			
									               			
									    						
									    						
									    						 
									               		</script>
	                                        			
	                                        			</th>
	                                        			<th>
	                                        				${i.ban}
														</th>	       
														<th>
															
															${i.ban_date}
															

														</th>	       
													
													</tr>      
	                                        	</c:forEach>
                                        	</c:if>

                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                         </main>
                      </div>
                    
                    </div>
                    
               		
               
                               
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/js/admin_user.js"></script>
        <script src="<%=request.getContextPath()%>/js/simple-datatables@latest.js"></script>

        <script src="<%=request.getContextPath()%>/js/admin_user2.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>