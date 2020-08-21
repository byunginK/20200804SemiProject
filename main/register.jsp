<%@page import="dto.MemberDto"%>
<%@page import="dto.loginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- <%=request.getContextPath() %> --%>
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

<%if(id != null){ %>
<script>
	alert("이미 회원이시네용~");
	location.href = "../FirstOpen.jsp";

</script>
<%} %>


  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>Register</title>


    <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/bootstrap.css" />
  <!--slick slider stylesheet -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick-theme.min.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet" />
  <!-- slick slider -->
  <!-- <link rel="stylesheet" href="css/slick-theme.css" /> --> 
  <!-- font awesome style -->
  <link href="<%=request.getContextPath() %>/css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" />
  <!-- responsive style -->

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
    </div>

  <!---------- 회원가입창 시작 ----------->
<section class="contact_section_regi layout_padding">
        	<div class="regi-form2">
					<form id="frm" method="post">
					<input type="hidden" name="work" value="addMem">
							<h2>회원 가입</h2>
					   <!-- 아이디  -->
						<div class="form-group">
							<input type="text" class="form-control" name="id" placeholder="아이디" maxlength="20" id="id" required="required">
							<!-- 중복체크 -->
							<input type="button" class="btn1" id="btn" value="중복체크">
						</div>
						<!-- 비밀번호  -->
						<div class="form-group">
							<input type="text" class="form-control" name="pwd" placeholder="비밀번호" maxlength="25" id="pwd" required="required">
							<div id="ptext" style="color: #ffa931"></div>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="pwd" placeholder="비밀번호 확인" maxlength="25" id="pwdCheck" required="required">
							<div id="ptext2" style="color: #ff847c"></div>
						</div>
						<!-- 이름 -->
						<div class="form-group">
					     	<input type="text" class="form-control" name="name" placeholder="이름" id="name" required="required">
					     	<div id="ptext4" style="color: #ffa931"></div>
						</div>	
							
						<!-- 휴대폰 번호 -->
						<div class="form-group">
						<input type="text" class="form-control" name="phone" placeholder="휴대폰번호" maxlength="11" id="number">
						<div id="ptext3" style="color: #ffa931"></div>
						</div>
							
						<div class="form-group">
						</div>
						<!-- 이메일 -->
						<div class="form-group">
							<input type="text" class="form-control" name="email" placeholder="이메일 ex)aaaa@aaa.com" id="email">
						</div>
						<!-- 회원가입 버튼 // ajax로 각각의 조건의 맞게 체크 후 이동 -->
						<div class="form-group">
							<button type="button" class="btn btn-primary btn-lg btn-block" id="regi">회원가입</button>
						</div>
					</form>
				</div>
    </section>
   
    <!-------- 회원가입 끝 ----------->



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
  
   <!-- ajax -->
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<!-- jQery -->
  <script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
  <!-- cookie 아이디저장 -->
  <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.js"></script>
  <!-- slick slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
  <!-- Google Map -->


<!-- 회원가입 관련 체크시작 -->
<script type="text/javascript">
document.getElementById('pwd').onkeyup = function() {
	   
	var msg = '',   val = this.value;
 
	 val_Check = document.getElementById('pwdCheck').value;
	 let num = val.search(/[0-9]/g);   let eng = val.search(/[a-z]/ig);
	 let spe = val.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	 
    if( val.length < 8 || val.length > 20){
    	msg = '비밀번호는 8자리이상 20자리 이내로 입력해주세요'
    }else if(val.search(/\s/) != -1){
    	msg ="비밀번호는 공백 없이 입력해주세요.";}
    else if(num < 0 || eng < 0 || spe < 0 ){
		 msg ="비밀번호에 영문,숫자, 특수문자를 혼합하여 입력해주세요.";     }	
    
    document.getElementById('ptext').textContent = msg; 
}
document.getElementById('pwdCheck').onkeyup = function() {
	var msg = '',
	val = this.value;
	val_Check = document.getElementById('pwd').value;
	if(val != val_Check){
		 msg ="비밀번호가 다릅니다. 다시 한번 확인해주세요"; }
	
	document.getElementById('ptext2').textContent = msg;
}

document.getElementById('number').onkeyup = function() {
	var msg = '',
	val = this.value;
	let num = val.search(/[a-z]/ig);
	let spe_number = val.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	if ( num != -1 || spe_number != -1){
		 msg ="휴대폰 번호는 숫자만 입력해주세요"; }
	document.getElementById('ptext3').textContent = msg;
}

document.getElementById('name').onkeyup = function() {
	var msg = '',
	val = this.value;
	let name = val.search(/[0-9]/g);
	let spe_name = val.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	if ( name != -1 || spe_name != -1){
		 msg ="이름에 숫자, 특수문자가 포함되어있습니다."; }
	document.getElementById('ptext4').textContent = msg;
}


$(document).ready(function () {
	
	/* 아이디 중복 체크 */
	 $("#btn").click(function () {
	//	alert("btn click");
	
	let id = $("#id").val();
	if(id == null || id == "" || id.search(/\s/) != -1){
		
		alert("공백없이 입력해주세요")
	}else{
		$.ajax({
			type:"get",
			
			url:"../member?work=id_Check",
		
			data:{ "id":$("#id").val() },
			
			success:function( data ){
	        
				let isS = data.map.isS;
	       
				if( isS == "YES"){
				
				alert("사용할 수 있는 id입니다");
				
				}else if(isS == "NO"){
	
				alert("사용할 수 없는 id입니다");
					
				}			
			},
			error:function(){	alert("error");  }
		});
	}
	}); 
	 /* 조건에 맞는지 체크 */
	 $.fn.CheckFunction = function() {
			
		 /* 비밀번호  */
		 let pwd = $("#pwd").val();
		 let pwdCheck = $("#pwdCheck").val();
		 let num = pwd.search(/[0-9]/g);
		 let eng = pwd.search(/[a-z]/ig);
		 let spe = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		 /* 이름 */
		 let name = $("#name").val(); 
		 let num_name = name.search(/[0-9]/g);
		 let spe_name = name.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		 /* 이메일 */
		 let email = $("#email").val(); 
		
		 /* 전화번호 */
		 let number = $("#number").val();
		 let num_number = number.search(/[a-z]/ig);
		// let spe_number = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		 

		 if(pwd.length < 8 || pwd.length > 20){
			 alert("비밀번호는 8자리 ~ 20자리 이내로 입력해주세요.");
		   }else if(pwd.search(/\s/) != -1){
		    alert("비밀번호는 공백 없이 입력해주세요.");
		 }else if(num < 0 || eng < 0 || spe < 0 ){
            alert("비밀번호에 영문,숫자, 특수문자를 혼합하여 입력해주세요.");
		 }else if(pwd != pwdCheck){
			 alert("비밀번호가 다릅니다. 다시 한번 확인해주세요");
		 }
		 else if(name == "" || name.search(/\s/)!= -1){ 
			 alert("이름을 공백 없이 입력해주세요.");
		 }else if(num_name != -1 || spe_name != -1){
			 alert("이름에 숫자, 특수문자가 포함되어있습니다.");
		 }
		 else if( number.search(/\s/) != -1 || number == ""){
			 alert("휴대폰 번호는 공백 없이 입력해주세요.");
		 }else if( num_number != -1 ){
			 alert("휴대폰 번호는 숫자만 입력해주세요");
		 }else {
			 if(email==""){
		let result = confirm("이메일이 없을 시 아이디 찾기 등 일정 부분 제약이 있을 수 있습니다. 이메일은 마이페이지->내 정보 수정에서  언제든지 수정및 추가가 가능합니다");
				if(result){
					alert("가입을 축하드립니다");
					 $("#frm").attr("action", "../member").submit();
				}else{
					
				}
			 }else{
				 alert("가입을 축하드립니다");
				 $("#frm").attr("action", "../member").submit();
			 }
		     
		 }

  }	
	 /* 클릭시 조건 확인 func 실행 */
$("#regi").click(function() {
	
      $.fn.CheckFunction();
});
	
});
</script>
<!-- 회원가입 체크 끝 -->

</body>

</html>