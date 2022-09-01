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
<title>회원리스트</title>

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
           
           tbody > tr > td {
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
           

        </style>
        
        
       

<script>
	function toggleAdmin(e,nickName,uidx){
		if(e.value == 'Y'){
			if(confirm(nickName+"님을 권한을 관리자로 변경하시겠습니까?")){
				
			}else{
				e.value = 'N';
				return false;
			}
		}else{
			if(confirm(nickName+"님을 권한을 회원으로 변경하시겠습니까?")){
				
			}else{
				e.value = 'Y';
				return false;
			}
		}
		
		$.ajax({
			url : "toggleAdmin.do",
			data : "isAdmin="+e.value+"&uidx="+uidx,
			success : function(){
				console.log("success");
			}
		});
	}
</script>

  


</head>

     <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="../admin/admin_user.do">관리자페이지</a>
            <!-- Sidebar Toggle-->
           <h5 style="color:#fff; text-align:right; margin-left:1550px; cursor:pointer;" onclick="javascript:location.href='<%=request.getContextPath()%>/';">HOME</h5> 

            
        </nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#collapseLayouts" aria-expanded="false"
							aria-controls="collapseLayouts">
							<div class="fas fa-user-friends">
								<i class=" "></i>
							</div> &nbsp;회원관리
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="collapseLayouts"
							aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
							<nav class="sb-sidenav-menu-nested nav">
								<a class="nav-link" href="../admin/admin_user.do">회원리스트</a> <a
									class="nav-link" href="../admin/admin_report.do">신고리스트</a>
							</nav>
						</div>
						<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#collapsePages" aria-expanded="false"
							aria-controls="collapsePages">
							<div class="sb-nav-link-icon">
								<i class="fas fa-book-open"></i>
							</div> 사이트 관리
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="collapsePages"
							aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
							<nav class="sb-sidenav-menu-nested nav accordion"
								id="sidenavAccordionPages">
								<a class="nav-link collapsed" href="../admin/admin_boarditem.do">판매글 관리</a>
								<a class="nav-link collapsed" href="../admin/admin_qna.do">문의사항</a>
								<a class="nav-link collapsed" href="../admin/admin_notice.do">공지사항</a>
								<a class="nav-link collapsed" href="../admin/admin_board.do">커뮤니티</a>
							</nav>
						</div>
			</nav>
		</div>


		<!-- 검색 -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<!-- 검색 -->
					<div class="container">
						<div class="d-md-none d-lg-block d-xl-block">
							<div class="row">
								<div class="col-md-1 col-sm-0"></div>
								<div class="col-md-10  col-sm-12">
									<h6 style="font-weight: bold">⚫️ 회원 검색</h6>
									<br>
									<form class="d-flex ">
										<input class="form-control me-6 vh-20" type="search"
											placeholder="검색어를 입력하세요" aria-label="Search">
										<button class="btn btn-outline-primary" type="submit" href="void(0);" onclick="alert('준비중입니다');return false;">Search</button>
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
									<th>닉네임</th>
									<th>이메일</th>
									<th>가입일</th>
									<!--    <th>노쇼</th>
                                    th>거래온도</th> -->
									<th>권한</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${UserList.size()>0 }">
									<c:forEach var="vo" items="${UserList}">
										<tr>
											<td>${vo.uidx}</td>
											<td>${vo.nickName}</td>
											<td>${vo.user_email}</td>
											<td>${vo.jdate}</td>
											<td><select class="form-select form-select-sm"aria-label=".form-select-sm example" onchange="toggleAdmin(this,'${ vo.nickName }',${vo.uidx})">
													<option value="N"<c:if test="${ vo.isAdmin == 'N' }"> selected</c:if>>유저</option>
													<option value="Y"<c:if test="${ vo.isAdmin == 'Y' }"> selected</c:if>>관리자</option>
											</select></td>
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