<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = null; int auth = 3;
	MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
 	//MemberDto mem = new MemberDto("a",1); 
	if(mem==null){ 
%>
	<script type="text/javascript">
		alert("로그인 해주십시오");
		//로그인 페이지로 이동
		location.href = "<%=request.getContextPath()%>/main/login.jsp";
	</script>
<%		
	 }else{
		 if(mem.getAuth()!=1){
			 %>
		<script type="text/javascript">
			alert("로그인 해주십시오");
			location.href = "<%=request.getContextPath()%>/main/login.jsp";
		</script> 
			 <%
		 }
		id=mem.getId(); auth = mem.getAuth();
	 }
%>    

<!DOCTYPE html>
<html>
<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>(관리자용) 메인게시판</title>


  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="../css/bootstrap.css" />
  <!--slick slider stylesheet -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick-theme.min.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet" />
  <!-- slick slider -->
  <!-- <link rel="stylesheet" href="css/slick-theme.css" /> --> 
  <!-- font awesome style -->
  <link href="../css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="../css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <!-- <link href="css/responsive.css" rel="stylesheet" /> -->
</head>

<!-- 바디 셋팅 -->
<body class="sub_page">
  <div class="main_body_content">
    <div class="hero_area">
    
     <!-- 헤더 -->
      <header class="header_section">
        <div class="container-fluid">
        <!-- 네비게이션 바 -->
          <nav class="navbar navbar-expand-lg custom_nav-container ">
            <a class="navbar-brand" href="../addPro?work=main">
              Simple Five
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            	<span class=""></span>
            </button>
            <div class="collapse navbar-collapse " id="navbarSupportedContent">
              <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                	<a class="nav-link" href="../addPro?work=main">Main<span class="sr-only"></span></a>
                </li>
                <li class="nav-item">
                	<a class="nav-link" href="../addPro?work=list">카테고리</a>
                </li>
                <li class="nav-item">
                	<div class="dropdown">
						<p class="dropdown-p">고객센터</p>
						<div class="dropdown-content">
							<a href="<%=request.getContextPath()%>/board/qna_main.jsp">Q & A</a>
							<a href="../infomain?work=move">공지사항</a>
							<a href="../suggest?work=suggest&detailwork=suggest_main" >건의사항</a>
							<a href="<%=request.getContextPath()%>/calendar/cal_main.jsp">일정확인</a>
						</div>
					</div>
                </li>
		<!--로그인을 하면 세션에 저장 -> 세션값이 없으면 로그인/회원가입  있으면 마이페이지/로그아웃 -->
             <% if(id != null){ 
                     if(auth == 1){%>
                <li class="nav-item">
                  <a class="nav-link" href="<%=request.getContextPath()%>/admin/admin_main.jsp">관리자페이지</a>
                </li>
             <%} else{%>
             <li class="nav-item">
                  <a class="nav-link" href="../login?work=MyPage&id=<%=id%>">My Page</a>
                </li>
                <%} %>
   				<li class="nav-item">
                  <a class="nav-link" href="../login?work=logout">로그아웃</a>
                </li>      
              <%
             }else{ %>
                <li class="nav-item">
                  <a class="nav-link" href="<%=request.getContextPath()%>/main/login.jsp">로그인</a>
                </li>
   				<li class="nav-item">
                  <a class="nav-link" href="<%=request.getContextPath()%>/main/register_agree.jsp">회원가입</a>
                </li>
                <%} %>
                 <!-- 로그인 메뉴 끝  -->
              </ul>
            </div>
          </nav>
        </div>
      </header>
      <!-- 헤더 끝 -->
    </div>
    
    
    
    
    <!-- 백엔드 추가 -->
    <section class="contact_section layout_padding">
      <div class="container-fluid">
        <div class="row">
			<div class="login-form">
				<form method="post">
					<h3 class="text-center">게시판 관리(관리자)</h3>
<hr>
				 	<dl>
<dt>
카테고리 관리
</dt>
<dd>
<a href="../addPro?work=add" >제품 추가</a>
<!-- 나중에 병인님이랑 체크,, -->
</dd>
<dd>
<a href="../admincont?work=proup_moveQnadel&pageNumber=0" >제품 수정</a>
</dd>
<dd>
<a href="../admincont?work=pro_moveQnadel&pageNumber=0" >제품 삭제</a>
</dd>
<hr>
<dt>
게시판 관리
</dt>
<dd>
 <a href="../admincont?work=moveQnadel&pageNumber=0&how=10">Q&A 게시글 삭제</a>
</dd>
<dd>
 <a href="../admincont?work=rep_moveQnadel&pageNumber=0&how=10" >Q&A 댓글 삭제</a>
</dd>
<dd>
<a href="../infomain?work=write&id=<%=mem.getId() %>">공지사항 추가</a>
</dd>
<dd>
<a href="../admincont?work=info_moveQnadel&pageNumber=0&how=10" >공지사항 삭제</a>
</dd>
<dd>
 <a href="../admincont?work=sug_moveQnadel&pageNumber=0&how=10">건의사항 삭제</a>
</dd>
<dd>
<a href="../admincont?work=sugrep_moveQnadel&pageNumber=0&how=10" >건의사항 게시판 댓글 삭제</a>
</dd>
</dl>
				 
				 
				 
				<!-- 		<button type="button" class="btn btn-primary btn-lg btn-block" id="btn" onclick="location.href ='register.jsp'">회원가입</button></td></tr>
				 -->	
				</form>
			</div>
		  </div>
       </div>
    </section>




	<!-- 바닥글 창 -->
    <section class="info_section layout_padding2">
      <div class="container">
        <div class="row info_main_row">
<!-- Menu -->
          <div class="col-md-6 col-lg-3">
            <div class="info_links">
              <h4>
              	Menu
              </h4>
              <div class="info_links_menu">
                <a href="../addPro?work=main">
                  Home
                </a>
                <a href="../addPro?work=list">
                  	카테고리
                </a>
                <a href="../infomain?work=move">
                  	고객센터
                </a>
                <a href="<%=request.getContextPath()%>/main/login.jsp">
                  	로그인
                </a>
                <a href="<%=request.getContextPath()%>/main/register.jsp">
                  	회원가입
                </a>
              </div>
            </div>
          </div>

<!-- 회사 -->          
          <div class="col-md-6 col-lg-3">
            <div class="info_detail">
              <h4>
                Company
              </h4>
              <p>
              	(주)Simple Five<br>대표자: 오조<br><br>
              	사업자 등록번호:520-02-55555<br>
              <!-- 	통신판매업 등록번호 : <br> -->
              	서울특별시 강남구 테헤란로<br> 64번길2 서영빌딩1층
              </p>
            </div>
          </div>
<!-- 고객센터 -->
          <div class="col-md-6 col-lg-3">
            <div class="info_detail">
              <h4>
                CS Center
              </h4>
              <p>
              	이용약관<br>
              	개인정보 취급방침<br>
              	Q & A
              </p>
            </div>
          </div>
<!-- 연락방법 -->
          <div class="col-md-6 col-lg-3">
            <h4>
              	Contect Us
            </h4>
            <div class="info_contact">
              <a href="">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span>
                  	T. 02-223-5555
                </span>
              </a>
              <a href="">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>
                  M. 010-5555-5555
                </span>
              </a>
              <a href="">
                <i class="fa fa-envelope"></i>
                <span>
                  simplefive@gmail.com
                </span>
              </a>
          	    <span>
                  	평일 : am 09:00 - pm 18:00 <br> 주말 : pm 12:00 - pm 13:00
                </span>
            </div>
          </div>
          <!-- 고객센터 끝 -->
        </div>
      </div>
    </section>
	<!-- 바닥글 끝-->

  </div>




  <!-- 밑창-->
  <footer class="container-fluid footer_section">
    <div class="container">
      <div class="col-md-11 col-lg-8 mx-auto">
        <p>
          &copy; <span id="displayYear"></span> (주)심플파이브
        </p>
      </div>
    </div>
  </footer>
  <!-- 밑창 끝 -->


  <!-- jQery -->
  <!-- <script src="../js/jquery-3.4.1.min.js"></script> -->
  <script type="text/javascript" src ="<%=request.getContextPath() %>/jquery/jquery-3.5.1.min.js"></script>
  
  <!-- bootstrap js -->
  <script src="../js/bootstrap.js"></script>
  <!-- slick slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.js"></script>
  <!-- custom js -->
  <script src="../js/custom.js"></script>



</body>
</html>