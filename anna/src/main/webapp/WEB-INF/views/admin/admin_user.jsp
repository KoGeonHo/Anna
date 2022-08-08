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
<title>회원 관리</title>

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
           
           

        </style>
        
        
        <!-- 관리자 정보 메뉴  -->
<style type="text/css">
			#banner_online {
			    height: 610px;
  			    width: 503px;
				border: 1px solid black;]
				box-shadow: 3px 3px 7px 1px grey;
				background-color: white;
				z-index: 9999;
				margin-left: -50%;
				margin-top: -15%;
				display: none;
				position: fixed;
			}
			
			#banner_online h1 {
			    font-weight: bold;
				text-align: center;
				font-size: 20px;
				margin: 43px -12px 28px auto;
			}
			
			#banner_online p .second {
				margin-left: 6px;
			}
			
			.pop_content {
				font-size: 13px;
				margin-left: 82px;
				text-align: center;
			}
			
			#banner_online_how {
				height: 78px;
				width: 444px;
				margin-left: 28px;
				border: 1px solid #82bf77;
				margin-top: 22px;
			}
			
			#banner_online_how h3 {
				font-size: 12px;
				margin-left: 6px;
				margin-top: 16px;
			}
			
			.p_bottom {
				margin-left: 30px;
			}
			
			#modal {
				position: fixed;
				width: 100%;
				height: 100%;
				background: rgba(0, 0, 0, 0.5);
				top: 0;
				left: 0;
				z-index: 99;
				display: none;
			}
			#modal_list > table > tr > td{
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
  				left: 165px;
  				margin : 3 0 10 0;
  				

			}
			#close_button {
				width: 83px;
				height : 31px;
				
			}
			.form-select form-select-sm{
				border:1px solid #3881B4;
			}
			
</style>

</head>
<body>


</head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">관리자페이지</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>

            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                   
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="fas fa-user-friends"><i class=" "></i></div>
                                회원관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="layout-static.html">회원 리스트</a>
                                    <a class="nav-link" href="layout-sidenav-light.html">신고리스트</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                사이트 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        거래목록                                        
                                    </a>  
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        문의사항                                        
                                    </a> 
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        공지사항                                        
                                    </a> 
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        커뮤니티                                        
                                    </a> 
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        이벤트 배너 설정                                        
                                    </a> 
                                    
                                </nav>
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
                                <h6 style="font-weight:bold">⚫️회원 검색</h6>
                                <br>
					            <form class="d-flex ">
                                    
						          <input class="form-control me-6 vh-20" type="search" placeholder="검색어를 입력하세요" aria-label="Search">
						          <button class="btn btn-outline-primary" type="submit">Search</button>
						        </form>
					        
					        </div>
					        <div class="col-md-1 col-sm-0"></div>
					    </div>
					    </div>
					    </div>	
                        </div>
				  	<!-- 검색 -->


                      
                   
                       
                            <div class="card mb-4">
                                <div class="card-body">
                                    <table id="datatablesSimple">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>아이디</th>
                                                <th>비밀번호</th>
                                                <th>이름</th>
                                                <th>이메일</th>
                                                <th>가입일</th>
                                                <th>노쇼</th>
                                                <th>거래온도</th>
                                                <th>관리</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th>1</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" id="openModalPop" class="btn " style="background-color: #00AAB2; color: #fff;"  style="font-size: 14px;">관리</button>
                                              
															<div id= "modal"> 
															</div>
															    <div id = "banner_online">
															        
															        <h1>회원 상세정보</h1><br>
															        <div class="pop_content">
															             <table border="0" name="modal_list" style="text-align:  left; border-bottom: 1px solid #cdd0d4;">
															             <tr>
																				<td id="td_line" width="130px;" height= "40px;" >이름</td>
																				<td id="td_line">홍길동</td>
																			</tr>
																			<tr>
																			    <td id="td_line" width="130px;" height= "40px;">닉네임</td>
																			    <td id="td_line">anna</td>
																			</tr>
																			<tr>
																			    <td id="td_line" width="130px;" height= "40px;">성별</td>
																			    <td id="td_line">남</td>
																			</tr>
																			<tr>
																			    <td id="td_line" width="130px;" height= "40px;">아이디</td>
																			    <td id="td_line">test1111</td>
																			</tr>
																			<tr>
																			    <td id="td_line"  width="130px;" height= "40px;">비밀번호</td>
																			    <td id="td_line">test1111</td>
																			</tr>
																			<tr>
																			    <td id="td_line" width="130px;" height= "40px;">이메일</td>
																			    <td id="td_line">abcdefg@naver.com</td>
																			</tr>
																			<tr>
																			    <td id="td_line" width="130px;" height= "40px;">전화번호</td>
																			    <td id="td_line">010-1234-5678</td>
																			</tr>
																			<tr >
																			    <td id="td_line" width="130px;" height= "40px;">주소</td>
																			    <td id="td_line">전라북도 전주시 덕진구 금암동</td>
																			</tr>
																			<tr id="td_line" >
																			    <td  width="130px;" height= "40px;">제재횟수</td>
																			    <td >1회</td>
																			</tr>
																		    </table>
																		    <br>
																		    																		         
															        </div>
															        <div id="menu_box">
															        <select class="form-select form-select-sm" aria-label=".form-select-sm example">
																				  <option selected>권한</option>
																				  <option value="1">유저</option>
																				  <option value="2">관리자</option>
																				</select>&nbsp;
																				<button type="button"  id="close_button" class="btn " style="background-color: #3881B4; color: #fff; cursor: pointer;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">닫기</button>
															       			</div>
															       			<button type="button"  id="close_button" class="btn " style="background-color: #4A4A48; color: #fff; cursor: pointer;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">설정</button>
															       			<button type="button"  id="close_button" class="btn " style="background-color: #00AAB2; color: #fff; cursor: pointer;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">수정</button>
															        </div>
															        </div>
															
															
															
															<script type="text/javascript">
															$(document).ready(function() {
															    $("#openPop").click(function() {
															        $("#banner_online").show();
															    });
															
															    $("#openModalPop").click(function() {
															        $("#banner_online").fadeIn();
															        $("#modal").fadeIn();
															    });
															
															    $("#close_button").click(function(){
															        $("#banner_online").fadeOut();
															        $("#modal").fadeOut();
															    });
															});
															</script>
                                                </th>
                                                
                                            </tr>
                                            <tr>
                                                <th>2</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>3</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>4</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>5</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>6</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>7</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>8</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>9</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>10</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>11</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            <tr>
                                                <th>12</th>
                                                <th>test111</th>
                                                <th>1234</th>
                                                <th>홍길동</th>
                                                <th>test@naver.com</th>
                                                <th>2022-07-25</th>
                                                <th>0</th>
                                                <th>36.5°</th>
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
                                            </tr>
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </main>
                    </div>




           entries
                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/js/admin_user.js"></script>
        <script src="<%=request.getContextPath()%>/js/simple-datatables@latest.js"></script>

        <script src="<%=request.getContextPath()%>/js/admin_user2.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        
    </body>
</html>