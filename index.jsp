<%@page import="dto.MemberDto"%>
<%@page import="dto.loginDto"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>    

<%
/* 세션에서 아이디 받아옴 로그인을 안할시 null */
    String id = null; int auth = 3;
    MemberDto login_Dto = null;
    if(session.getAttribute("login_Dto") != null){
 	   login_Dto = (MemberDto)session.getAttribute("login_Dto");
 	   id = login_Dto.getId(); auth = login_Dto.getAuth();
    }  
     HashMap map = (HashMap)request.getAttribute("map");
    List<ProductDto> list = (List<ProductDto>)map.get("listall");
    List<ProductDto> list2 = (List<ProductDto>)map.get("listsellMain");
    ProductDto dto = new ProductDto();   
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


<%-- <%=request.getContextPath()%>/ --%>
  
  
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
  
  <!-- 팝업 하루안보기 쿠키 -->
  <script> 
function setCookie( name, value, expiredays ) { 
    var todayDate = new Date(); 
        todayDate.setDate( todayDate.getDate() + expiredays ); 
        document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
    }
function closeWin( value ) { 
    if ( document.notice_form.chkbox.checked ){ 
        setCookie( "maindiv", "done" , 1 ); 
    } 
    if( document.notice_form2.chkbox2.checked ){ 
        setCookie( "maindiv2", "done" , 1 ); 
    }
    if(value == "event"){
    	document.all['divpop'].style.visibility = "hidden"; 
    }else{
    	 document.all['divpop2'].style.visibility = "hidden"; 
    }   
} 
</script> 
  
</head>
 
<body>
<!-- 바디 셋팅 -->
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
      
      
    <!-- 메인 슬라이드 -->
    <section class="slider_section ">
        <div id="customCarousel1" class="carousel slide" data-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <div class="container">
                <div class="row">
                  <div class="col-md-6">
                    <div class="detail_box">
                      <h1>
                         Simple Five <br>Best Product<br> 
                      </h1>
                      <a href="#">
                        <span>
                          	상세보기
                        </span>
                        <img src="img/white-arrow.png" alt="">
                      </a>
                    </div>
                  </div>
                  <div class="col-md-4 ml-auto">
                    <div class="img-box">
                      <img src="img/sk1.jpg" alt="">
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="container">
                <div class="row">
                  <div class="col-md-6">
                    <div class="detail_box">
                      <h1>
                         	Shoes<br>Best Product<br> 
                        <!-- <span>
                          Yummy
                        </span> -->
                      </h1>
                      <a href="#">
                        <span>
                         	상세보기
                        </span>
                        <img src="img/white-arrow.png" alt="">
                      </a>
                    </div>
                  </div>
                  <div class="col-md-4 ml-auto">
                    <div class="img-box">
                      <img src="img/mg2.jpg" alt="">
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="carousel-item ">
              <div class="container">
                <div class="row">
                  <div class="col-md-6">
                    <div class="detail_box">
                      <h1>
                        	Acc<br>Best Product<br> 
                      </h1>
                      <a href="#">
                        <span>
                          	상세보기
                        </span>
                        <img src="img/white-arrow.png" alt="">
                      </a>
                    </div>
                  </div>
                  <div class="col-md-4 ml-auto">
                    <div class="img-box">
                      <img src="img/mg3.jpg" alt="">
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel_btn-box">
          <a class="carousel-control-prev" href="#customCarousel1" role="button" data-slide="prev">
            <i class="fa fa-arrow-left" aria-hidden="true"></i>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#customCarousel1" role="button" data-slide="next">
            <i class="fa fa-arrow-right" aria-hidden="true"></i>
            <span class="sr-only">Next</span>
          </a>
        </div>
      </section>
	<!-- 슬라이드 끝 -->
    </div>
	<!-- hero_area 끝 -->
	
	
	
	<!-- POPUP 시작--> 
<div id="divpop" style="position:absolute;left:1200px;top:240px;z-index:200;visibility:hidden;"> 
	<table style="width: 300; height:400; cellpadding:2; cellspacing:0;"> 
		<tr> 
		    <td style="border:1px #666666 solid" height=360 align=center bgcolor=white> 
		    <img alt="" src="img/PopUp2.jpg" onclick="location.href='productDetail?work=product&seq=67'" style="border:0px;">
		    </td> 
		</tr> 
		<tr> 
		        <form name="notice_form"> 
		    <td align=right bgcolor=#2d4059 > 
		        <input type="checkbox" name="chkbox" value="checkbox"><span style="color: white">오늘 하루 이 창을 열지 않음</span> 
		        <a href="javascript:closeWin('event');"><B>[닫기]</B></a> 
		    </td> 
		</tr> 
		        </form> 
	</table> 
</div> 
		
<div id="divpop2" style="position:absolute;left:705px;top:150px;z-index:200;visibility:hidden;"> 
	<table style="width: 350; height:400; cellpadding:2; cellspacing:0;"> 
		<tr> 
		    <td style="border:1px #666666 solid" height=360 align=center bgcolor=white> 
		       <img alt="" src="img/popup.jpg" style="height: 650px; width: 520px; border:0px; " onclick="location.href='<%=request.getContextPath()%>/calendar/cal_main.jsp'">
		    </td> 
		</tr> 
		<tr> 
		    <form name="notice_form2"> 
		    <td align=right bgcolor=#2d4059> 
		        <input type="checkbox" name="chkbox2" value="checkbox2" ><span style="color: white">오늘 하루 이 창을 열지 않음</span> 
		        <a href="javascript:closeWin('send');"><B>[닫기]</B></a> 
		    </td> 
		</tr> 
	        </form> 
	</table> 
</div> 
	
	<!-- PopUp 끝 -->
	
	
	
	
	
    <!-- 메인창 중간 회사소개 -->
    <section class="about_section layout_padding ">
      <div class="container">
        <div class="row">
          <div class="col-md-6"> 
            <div class="detail-box">
              <div class="heading_container">
                <h2>
                  	"Simple Five"
                </h2>
              </div>
              <p>
               <br>
                	Simple Five는 단순한 심플함이 아닌, 에너제틱한 일상생활속 편하고 간편하게 입을 수 있는 의상을 추구합니다</p>
              <a href="#">
                <span>
                 	고객센터
                </span>
                <img src="img/color-arrow.png" alt="">
              </a>
            </div>
          </div>
          <div class="col-md-6">
            <div class="img-box">
              <img src="img/font.jpg" alt="">
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- 회사소개 끝 -->


    <!-- Best Product 5개 -->
    <section class="chocolate_section ">
      <div class="container">
        <div class="heading_container">
          <h2><br><br>
            Weekly Best Item
          </h2>
        </div>
      </div>
      <div class="container">
        <div class="chocolate_container">
        
          <%
          for(int i = 0; i < list2.size(); i++){
        	  dto = list2.get(i);
        	  %>
        	  <div class="box">
              <div class="img-box">
                <a href="productDetail?work=product&seq=<%=dto.getSeq()%>"><img src="productimg/<%=dto.getFilename() %>" alt=""></a>
              </div>
              <div class="detail-box">
                <h6>
                 <span><%=dto.getP_name() %></span>
                </h6>
                <h5>
                  <%=dto.getP_price() %>
                </h5>
              </div>
            </div>
            <%
          }
          %>
          
          
        </div>
      </div>
    </section>
    <!-- Best 끝 -->
    
    
    
    
    



 

	<!-- 카테고리별 제품 나눔 -->
	<section class="category_section">
		<div class="container">
		          <div class="row some-cards">
		          
			           <div class="container">
			       			<div class="heading_container">
			          			<h2>
				           			New Item
			          			</h2>
			        		</div>
			      		</div>
			      		
<!-- 제품 시작 -->
						<%
			             for(int i = 0; i < list.size(); i++){
			      		dto = list.get(i);
			      		%>
			      		
			      	 <div class="box" style="box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.3);">
		                <a href="productDetail?work=product&seq=<%=dto.getSeq()%>">
	           				<div class="img-box">
		                       	<img src="productimg/<%=dto.getFilename() %>" alt="">
		                    </div>
		                 </a>
		                 	<%=dto.getP_price() %>원<br><%=dto.getP_name() %>
		             </div>
		             <span id="dp"></span>
			      		<%
			      	}
			      	%>	
		               
		                 
		                 
		        	</div>
			</div> 
	</section>
	
	<!-- 카테고리별 끝 -->

	
	
	
	





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

<!-- 팝업 쿠키 -->
  <script>
  cookiedata = document.cookie;    
  if ( cookiedata.indexOf("maindiv=done") < 0 ){      
      document.all['divpop'].style.visibility = "visible"; 
      } 
      else { 
          document.all['divpop'].style.visibility = "hidden"; 
  } 
  if ( cookiedata.indexOf("maindiv2=done") < 0 ){      
      document.all['divpop2'].style.visibility = "visible"; 
      } 
      else { 
          document.all['divpop2'].style.visibility = "hidden"; 
  } 
  
  <!-- 쿠키 제거 테스트용 -->
  function cookieRemove() {

  	 setCookie("maindiv" ,"done", -1);
  	setCookie("maindiv2" ,"done", -1);
  }
   </script>
<!-- 바디 끝 -->
</body>
</html>
