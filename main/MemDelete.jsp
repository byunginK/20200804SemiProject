<%@page import="dto.MemberDto"%>
<%@page import="dto.loginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
    <%
    String id = null; int auth = 3;
    MemberDto login_Dto = null;
     if(session.getAttribute("login_Dto") != null){
  	   login_Dto = (MemberDto)session.getAttribute("login_Dto");
  	   id = login_Dto.getId(); auth = login_Dto.getAuth();
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

  <title>Main Page</title>


  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <!--slick slider stylesheet -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick-theme.min.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet" />
  <!-- slick slider -->
<!--   <link rel="stylesheet" href="css/slick-theme.css" /> --> 
  <!-- font awesome style -->
 <link href="css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <!-- <link href="css/responsive.css" rel="stylesheet" /> -->
</head>

<body>
<!-- 바디 셋팅 -->
  <div class="main_body_content">
    
    
       <!-- 헤더 -->
      <header class="header_section">
        <div class="container-fluid">
        <!-- 네비게이션 바 -->
          <nav class="navbar navbar-expand-lg custom_nav-container ">
            <a class="navbar-brand" href="addPro?work=main">
              Simple Five
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            	<span class=""></span>
            </button>
            <div class="collapse navbar-collapse " id="navbarSupportedContent">
              <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                  <a class="nav-link" href="addPro?work=main">Main<span class="sr-only"></span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="addPro?work=list">카테고리</a>
                </li>
                 <!-- 일단 임시로 만들었어요 수정필요  게시판 이동-->
                <li class="nav-item">
                	<div class="dropdown">
						<p class="dropdown-p">고객센터</p>
						<div class="dropdown-content">
							<a href="<%=request.getContextPath()%>/board/qna_main.jsp">Q & A</a>
							<a href="infomain?work=move">공지사항</a>
							<a href="suggest?work=suggest&detailwork=suggest_main" >건의사항</a>
							<a href="<%=request.getContextPath()%>/calendar/cal_main.jsp">일정확인</a>
						</div>
					</div>
                </li>
                 <!-- 게시판 이동 끝 -->
         
          <!--로그인을 하면 세션에 저장 -> 세션값이 없으면 로그인/회원가입  있으면 마이페이지/로그아웃 -->
             <% if(id != null){ 
                     if(auth == 1){%>
                <li class="nav-item">
                  <a class="nav-link" href="<%=request.getContextPath()%>/admin/admin_main.jsp">관리자페이지</a>
                </li>
             <%} else{%>
             <li class="nav-item">
                  <a class="nav-link" href="login?work=MyPage&id=<%=id%>">My Page</a>
                </li>
                <%} %>
   				<li class="nav-item">
                  <a class="nav-link" href="login?work=logout">로그아웃</a>
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







   <section class="delId_section layout_padding">
      <div class="container_padding">


<h2>회원탈퇴</h2>
<hr>

<div class="Cs-form">
	
			<b>
			저희 심플파이브는 고객센터(<span>T.02-223-5555</span>)를 365일 24시간 운영하고 있습니다.
			서비스 이용 중 불편사항은 언제든지 연락주시면, 최선을 다해 해결 되도록 노력하겠습니다.</b>
</div>

<div class="info-form">
			<hr>
			<p>회원탈퇴 안내</p>
			<pre>
회원 탈퇴 시 회원님께서 보유하셨던 <h6>'비현금성 포인트와 마일리지, 회원정보, 거래정보 등은 모두 삭제됩니다.'</h6>
회원 탈퇴 후 재가입 시에는 신규 회원 가입으로 처리되며, <h6>'탈퇴 전의 회원정보와 거래정보 및 포인트 , 마일리지, 칩, 쿠폰 정보등은 복구되지 않습니다.'</h6>
<h6>※구매 중인 상품이 있으면 탈퇴가 되지않습니다.</h6>
			</pre>
			<hr>
</div>		
	
<div class="select-form">
			<h4>심플파이브 서비스 이용 중 불편사항을 선택해주세요.(<span style="color: orange;">※복수선택가능</span>)</h4><br>
			
		<div>
			<table>
				<col width="400"><col width="400"><col width="400">
				<tr><td><input type="checkbox">상품 다양성/가격품질 불만</td><td><input type="checkbox">교환/환불/품질불만</td><td><input type="checkbox">배송지연</td></tr>
				<tr><td><input type="checkbox">이용빈도 낮음</td><td><input type="checkbox">개인정보 유출</td><td><input type="checkbox">회원특혜/쇼핑혜택 부족</td></tr>
				<tr><td><input type="checkbox">A/S불만</td><td><input type="checkbox">쇼핑몰 속도 불만</td><td><input type="checkbox">기타</td></tr>
			</table>
		</div>
			<hr>
		<div>
			<h4 style="color: #0f4c75">그 이외에 심플파이브에게 남기고 싶으신 의견이 있으시면 기재해주세요.</h4>
			<br>
			<textarea class="form-area-del"></textarea>
		</div>
			
		<div>
			<form method="post" id="frm">
			<input type="hidden" name="work" value="deleteMem"><input type="hidden" name="id" value="<%=id%>">
			<div align="center"><button type="submit" id="delete">회원 탈퇴하기</button>&nbsp;&nbsp;<button type="button" id="cancle" onclick="location.href='./FirstOpen.jsp'">조금만 더 이용해볼게요!</button> </div>
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
                <a href="addPro?work=main">
                  Home
                </a>
                <a href="addPro?work=list">
                  	카테고리
                </a>
                <a href="infomain?work=move">
                  	공지사항
                </a>
                <a href="login?work=MyPage&id=<%=id%>">
                  	로그인
                </a>
                <a href="<%=request.getContextPath()%>/main/register_agree.jsp">
                  	회원가입
                </a>
              </div>
            </div>
          </div>

<!-- 회사 -->          
          <div class="col-md-6 col-lg-3">
            <div class="info_detail">
              <h4>
                SimpleFive
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
                  M. 010-3976-0000
                </span>
              </a>
              <a href="">
                <i class="fa fa-envelope"></i>
                <span>
                  bitcamp5j0@gmail.com
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
<!-- 밑창끝 -->

   <!-- jQery -->
  <script src="js/jquery-3.4.1.min.js"></script>
  <!-- cookie 아이디저장 -->
  <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.js"></script>
  <!-- slick slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
  <!-- Google Map -->
</div>
<script>
/* history.replaceState({}, null, location.pathname); */
$(document).ready(function () {
	
	$("#delete").click(function () {
		let result = confirm("탈퇴처리되면 복구가 되지 않습니다. 정말 탈퇴하시겠습니까?");
		if(result){
			$("#frm").attr("action", "member").submit();
			}
		else{
			
		}
		
	});
	
	
});

</script>
</body>
</html>