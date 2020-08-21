<%@page import="dto.MemberDto"%>
<%@page import="dto.MyOrderDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String id = null; int auth = 3;
MemberDto login_Dto = null;
if(session.getAttribute("login_Dto") != null){
	   login_Dto = (MemberDto)session.getAttribute("login_Dto");
	   id = login_Dto.getId(); auth = login_Dto.getAuth();
}     
List<MyOrderDto> list = (List<MyOrderDto>)request.getAttribute("orderlist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- bootstrap core css -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<!--slick slider stylesheet -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick-theme.min.css" />
<!-- font awesome style -->
<link href="css/font-awesome.min.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" />
<style type="text/css">
.order_section .order_btn{
	font-size: 16px;
    font-weight: bold;
	background: gray;
	border: none;
    color: white;
    border-radius: 2px;
}

.order_section .order_b{
	 margin-left: auto;
  margin-right: auto;
  padding-left: 380px;
  padding-right: 10px;
  margin-top: 40px;
}

</style>
<title>buylist</title>
</head>
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
              <span class=""> </span>
            </button>
            <div class="collapse navbar-collapse " id="navbarSupportedContent">
              <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                  <a class="nav-link" href="index.jsp">Main<span class="sr-only"></span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="addPro?work=list">카테고리</a>
                </li>
                 <li class="nav-item">
                  <a class="nav-link" href="addPro?work=add">제품 추가(임시)</a>
                </li>
                
            <li><a href="#">게시판</a>
            <ul class="sub">
          <li><a href="#" >공지사항</a></li>
         <li><a href="#">Q&A</a></li>
          <li><a href="#" onclick="location.href ='suggest?work=suggest&detailwork=suggest_main'; return false;">건의사항</a></li>
        </ul>
        </li>
     
             
             <% if(id != null){ %>
             <li class="nav-item">
                  <a class="nav-link" href="myPageCheck.jsp?id=<%=id%>"><%=id %> 님</a>
                </li>
   				<li class="nav-item">
                  <a class="nav-link" href="login?work=logout">로그아웃</a>
                </li>
             <%}else{ %>
                <li class="nav-item">
                  <a class="nav-link" href="login.jsp">로그인</a>
                </li>
   				<li class="nav-item">
                  <a class="nav-link" href="register_agree.jsp">회원가입</a>
                </li>
                <%} %>
              </ul>
            </div>
          </nav>
        </div>
      
	</header>
	
	<!-- 헤더끝 -->
</div>
	
	
	
	
	
	
	<!-- 제품구매페이지 시작 -->		
	
<section class="order_section layout_padding">

   <div class="container_padding">
	
		
	
		<h1>주문 / 구매 내역</h1>  
	

		<div class="content_buy">
				<table class ="buylist_tb">
					<col width="150px"><col width="300px"><col width="100px"><col width="150px"><col width="150px">
						<tr class = "buylist_tr">
							<th>상품 이미지</th><th>상품정보</th><th>수량</th><th>상품금액</th><th>총 상품금액</th>		
						</tr>
						<%
						if(list.size()==0){
							%>
							<tr>
								<td colspan="5">구매 내역이 없습니다</td>
							</tr>
							<%							
						}
						%>
								
						<%for(int i = 0; i <list.size(); i++){
							MyOrderDto order = list.get(i);
						%>
						<tr class = "buylist_content">
							<td><img alt="이미지 없음" src="productimg/<%=order.getFilename()%>" width="50px" height="70px"></td>
							<td class ="detail_con" onclick="godetail(<%=order.getItem_seq()%>)">
								
									<%=order.getP_name() %><br>
									색상 : <%=order.getItem_size() %> / 사이즈 : <%=order.getColor() %>
								
							</td>
							<td><%=order.getQty() %> 개</td><td><%=order.getP_price() %> 원</td><td><%=order.getQty()*order.getP_price() %> 원</td>
						</tr>
						<% 	
						}
						%>
					
				</table>
			<div class="order_b">
				<button type="button" onclick="history.go(-1)" class="order_btn">돌아가기</button>
			</div>
			
		</div>
		 
		
	</div>
</section>
<!-- 구매 끝 -->







	<!-- 바닥 글 -->
	
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

<script type="text/javascript">
$(document).ready(function() {
	$("#checklist").click(function() {
		if($("#checklist").prop("checked")){
            $("input[name=chec]").prop("checked",true);
        }else{
            $("input[name=chec]").prop("checked",false);
        }

	});
});
function godetail(seq) {
	location.href="productDetail?work=product&seq="+seq;
}
</script>
</body>
</html>