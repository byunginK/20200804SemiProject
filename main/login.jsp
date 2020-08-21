<%@page import="dto.MemberDto"%>
<%@page import="dto.loginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- <%=request.getContextPath() %> --%>
    <%
    /* 세션에서 아이디 받아옴 로그인을 안할시 null */
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
	alert("이미 로그인 하셨네용~");
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
  
  <title>Login</title>
<%--경로설정 <%=request.getContextPath()%> --%>
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  

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
    
    
    
    <!-- 로그인 창 추가 -->
    <section class="contact_section_login layout_padding">
      <div class="container-fluid">
        <div class="row">
              
				<div class="login-form">
				    <form method="post">
					<h2 class="text-center">로그인</h2>
				<div class="form-group has-error">
					<input type="text" class="form-control" name="id" placeholder="아이디" id="id" onkeyup="enterkey()">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name="pwd" placeholder="비밀번호" id="pwd" onkeyup="enterkey()">
				</div>
				<div class="form-group">
				<!-- 클릭시 아이디 비밀번호 체크(ajax) -->
					<button type="button" class="btn btn-primary btn-lg btn-block" id="btn">로그인</button>
	
			<br>
			<!-- 회원가입 이동 -->
			<a href="#" onclick="find('f_id')">아이디가 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" onclick="find('f_pwd')">비밀번호 찾기</a><br><a href="register_agree.jsp">아이디가 없으신가요?</a><br>
			<!-- 아이디 저장 쿠키(ajax)-->
			<a style="float: right;">아이디 저장</a><input type="checkbox" id="chk_save_id" style="float: right; margin-top: 5px; margin-right: 3px"></div>
		</div>
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


		
<!-- 로그인체크 -->
<script>
/* 엔터키 */
function enterkey() {
    if (window.event.keyCode == 13) {

    	let id = $("#id").val();  let pwd =$("#pwd").val();
		if(id== ""||id.search(/\s/) != -1 ||pwd=="" ||pwd.search(/\s/) != -1){
			alert("공백없이 입력해주세요")
		}else{
			$.ajax({
				type:"post",
				
				url:"../login",
			
				data:{ "id":$("#id").val(), "pwd":$("#pwd").val() },
				
				success:function( data ){

					let isS = data.map.isS;
					let name = data.map.name;
					
					if( isS == "YES"){
					alert("환영합니다 "+name +" 님");
					location.href = "../addPro?work=main";
					
					}else if(isS == "NO"){
		
					alert("아이디나 비밀번호를 다시한번 확인해주세요");
							}			
				},
				error:function(){
					alert("error");
				}
			});
		}
    }
}
		$(document).ready(function() {
			/* 로그인 아이디 비번 확인 */
				$("#btn").click(function () {
					//	alert("btn click");
					let id = $("#id").val();  let pwd =$("#pwd").val();
					if(id== ""||id.search(/\s/) != -1 ||pwd=="" ||pwd.search(/\s/) != -1){
						alert("공백없이 입력해주세요")
					}else{
						$.ajax({
							type:"post",
							
							url:"../login",
						
							data:{ "id":$("#id").val(), "pwd":$("#pwd").val() },
							
							success:function( data ){
	                     
								let isS = data.map.isS;
					            let name = data.map.name;
					           
								if( isS == "YES"){
								alert("환영합니다 "+ name +" 님");
								location.href = "../addPro?work=main";
								
								}else if(isS == "NO"){
					
								alert("아이디나 비밀번호를 다시한번 확인해주세요");
										}			
							},
							error:function(){
								alert("error");
							}
						});
					}
					});	
				/* 아이디 저장 */
				   let user_id = $.cookie("user_id");  
				   if(user_id != null){               
				    $('#id').val( user_id);
				    $('#chk_save_id').attr("checked", "checked");
				    }     
				    $("#chk_save_id").click(function(){
				    	if($('#chk_save_id').is(":checked")){   
				    	if($('#id').val().trim()==""){
				    		alert('아이디를 입력해주세요');
				    			$('#chk_save_id').prop("checked", false);
				    		}else{
				    		$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'/'}) 
				    		}
				    	}
				    	else{
				    		    $.removeCookie("user_id",{path:'/'})
				    	}
				    });

			});
		
          function find( work ) {
			if(work == 'f_id'){
				 window.open('find.jsp?work=id', 'newWindow', 'width=500, height=500');
			}else{
				window.open('find.jsp?work=pwd', 'newWindow', 'width=500, height=500');
			}
		}
          </script>  
</body>

</html>