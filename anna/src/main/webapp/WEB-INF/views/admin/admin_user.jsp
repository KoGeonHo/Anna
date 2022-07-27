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
<title>Insert title here</title>

		<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="<%=request.getContextPath()%>/css/admin_user.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

        
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
                                                <th><button type="button" class="btn " style="background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/" style="font-size: 14px;">관리</button></th>
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