<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = null;
int auth = 3;
MemberDto login_Dto = null;
if (session.getAttribute("login_Dto") != null) {
	login_Dto = (MemberDto) session.getAttribute("login_Dto");
	id = login_Dto.getId();
	auth = login_Dto.getAuth();
}  
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- bootstrap core css -->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css" />
<!--slick slider stylesheet -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick-theme.min.css" />
<!-- font awesome style -->
<link href="../css/font-awesome.min.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="../css/style.css" rel="stylesheet" />
<title>paycomp</title>
</head>
<body>
<div class="main_body_content">
		<div class="hero_area">

			<!-- 헤더 -->
			<header class="header_section">
				<div class="container-fluid">
					<!-- 네비게이션 바 -->
					<nav class="navbar navbar-expand-lg custom_nav-container ">
						<a class="navbar-brand" href="addPro?work=main"> Simple Five </a>
						<button class="navbar-toggler" type="button"
							data-toggle="collapse" data-target="#navbarSupportedContent"
							aria-controls="navbarSupportedContent" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class=""></span>
						</button>
						<div class="collapse navbar-collapse " id="navbarSupportedContent">
							<ul class="navbar-nav ml-auto">
								<li class="nav-item active"><a class="nav-link"
									href="index.jsp">Main<span class="sr-only"></span></a></li>
								<li class="nav-item"><a class="nav-link"
									href="addPro?work=list">카테고리</a></li>
								<!-- 일단 임시로 만들었어요 수정필요  게시판 이동-->
								<li class="nav-item">
									<div class="dropdown">
										<p class="dropdown-p">고객센터</p>
										<div class="dropdown-content">
											<a href="<%=request.getContextPath()%>/board/qna_main.jsp">Q
												& A</a> <a href="infomain?work=move">공지사항</a> <a
												href="suggest?work=suggest&detailwork=suggest_main">건의사항</a>
											<a href="<%=request.getContextPath()%>/calendar/cal_main.jsp">일정확인</a>
										</div>
									</div>
								</li>
								<!-- 게시판 이동 끝 -->

								<!--로그인을 하면 세션에 저장 -> 세션값이 없으면 로그인/회원가입  있으면 마이페이지/로그아웃 -->
								<%
									if (id != null) {
									if (auth == 1) {
								%>
								<li class="nav-item"><a class="nav-link"
									href="<%=request.getContextPath()%>/admin/admin_main.jsp">관리자페이지</a>
								</li>
								<%
									} else {
								%>
								<li class="nav-item"><a class="nav-link"
									href="login?work=MyPage&id=<%=id%>">My Page</a></li>
								<%
									}
								%>
								<li class="nav-item"><a class="nav-link"
									href="login?work=logout">로그아웃</a></li>
								<%
									} else {
								%>
								<li class="nav-item"><a class="nav-link"
									href="<%=request.getContextPath()%>/main/login.jsp">로그인</a></li>
								<li class="nav-item"><a class="nav-link"
									href="<%=request.getContextPath()%>/main/register_agree.jsp">회원가입</a>
								</li>
								<%
									}
								%>
								<!-- 로그인 메뉴 끝  -->
								<li class="nav-item"><a class="nav-link"
									onclick="cookieRemove()">테스트용 쿠키삭제 </a></li>
							</ul>
						</div>
					</nav>
				</div>
			</header>
<main>
	<div align="center" style="width: 100%; height: 700px; padding-top: 150px">
		<img alt="" src="../img/chkcomp.PNG">
		<br><br>
		<h1 style="color: orange;">결제가 완료 되었습니다.</h1>
		<h1 style="color: orange;">이용해 주셔서 감사합니다.</h1><br><br>
		<p>결제 관련 궁금하신 점은 <br><b>고객센터 Q&A 게시판</b>에 글을 남겨주시기 바랍니다.</p>
		<br><br>
		
		<button type="button" onclick="location.href='../addPro?work=main'" style="background: #000000; color: white; border: none; width: 100px; height: 47px;">확인</button>
	</div>

</main>
<div style="margin-top: 70px">
		<section class="info_section layout_padding2">
			<div class="container">
				<div class="row info_main_row">
					<!-- Menu -->
					<div class="col-md-6 col-lg-3">
						<div class="info_links">
							<h4>Menu</h4>
							<div class="info_links_menu">
								<a href="index.jsp"> Home </a> <a href="detail.jsp"> 카테고리 </a> <a
									href="contact.jsp"> 고객센터 </a> <a href="login.jsp"> 로그인 </a> <a
									href="register.jsp"> 회원가입 </a>
							</div>
						</div>
					</div>

					<!-- 회사 -->
					<div class="col-md-6 col-lg-3">
						<div class="info_detail">
							<h4>Company</h4>
							<p>
								(주)Simple Five<br>대표자: 오조<br>
								<br> 사업자 등록번호:520-02-55555<br>
								<!-- 	통신판매업 등록번호 : <br> -->
								서울특별시 강남구 테헤란로<br> 64번길2 서영빌딩1층
							</p>
						</div>
					</div>
					<!-- 고객센터 -->
					<div class="col-md-6 col-lg-3">
						<div class="info_detail">
							<h4>CS Center</h4>
							<p>
								이용약관<br> 개인정보 취급방침<br> Q&A
							</p>
						</div>
					</div>
					<!-- 고객센터 -->
					<div class="col-md-6 col-lg-3">
						<h4>Contect Us</h4>
						<div class="info_contact">
							<a href=""> <i class="fa fa-map-marker" aria-hidden="true"></i>
								<span> T. 02-223-5555 </span>
							</a> <a href=""> <i class="fa fa-phone" aria-hidden="true"></i> <span>
									M. 010-5555-5555 </span>
							</a> <a href=""> <i class="fa fa-envelope"></i> <span>
									simplefive@gmail.com </span>
							</a> <span> 평일 : am 09:00 - pm 18:00 <br> 주말 : pm 12:00 -
								pm 13:00
							</span>
						</div>
					</div>
					<!-- 고객센터 끝 -->
				</div>
			</div>
		</section>
	</div>
	<!-- 바닥글 끝-->



	<!-- 밑창 -->
	<footer class="container-fluid footer_section">
		<div class="container">
			<div class="col-md-11 col-lg-8 mx-auto">
				<p>
					&copy; <span id="displayYear"></span> (주)심플파이브
				</p>
			</div>
		</div>
	</footer>			
	</div>
</div>

</body>
</html>