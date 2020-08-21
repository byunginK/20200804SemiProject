<%@page import="dto.cartDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
//MemberDto mem = new MemberDto("a",1); 
	if(mem==null){
%>
	<script type="text/javascript">
		alert("로그인 해주십시오");
		location.href = "<%=request.getContextPath()%>/main/login.jsp";
	</script>
<%		
	}
	String id = null; int auth = 3;
	if(mem !=null || !mem.getId().equals("")) {
		id = mem.getId(); auth = mem.getAuth();
	}
	List<cartDto> list = (List<cartDto>) request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
 
<title>장바구니</title>
<script type="text/javascript" src ="<%=request.getContextPath() %>/jquery/jquery-3.5.1.min.js"></script>

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
<style type="text/css">
.imggrp{
	margin-left:60px;
	margin-top: 10px;
	margin-bottom:10px;
}
.carttext{
	text-align:center;
}
.paycontainer{
	margin-left:20px;
	margin-top:30px;
	margin-bottom:30px;
	width: 850px;
	/* margin: 30px auto; */
	border-radius: 100px;
	opacity: 0.95;
}
.paycontainer form {
color: #7a7a7a;
border-radius: 3px;
  	margin-bottom: 15px;
      background: #fff;
      box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
      padding: 30px;
      text-align:right;
}
.totid{
	margin-left:-500px;
}
.cart-table-header{
	background-color: #e8dec6;
	text-align:center;
	height:50px;
}
</style>
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
    
    <!-- 게시판 시작 -->

   <section class="bbs_section layout_padding">
      <div class="container_padding" align="center">
	
			<h2>장바구니</h2>
			
			<!-- 리스트 뽑는 부분 -->
			<div id="listcontainer">
				<table id="tb">
					<col width="100"><col width="250"><col width="250">
					<col width="50"><col width="80"><col width="50"><col width="120">
						<tr class="thtitle">
							<th class="cart-table-header"><input type="checkbox" id="allchk"></th>
							<th class="cart-table-header">이미지</th>
							<th class="cart-table-header">상품정보</th>
							<th class="cart-table-header"></th>
							<th class="cart-table-header">수량</th>
							<th class="cart-table-header"></th>
							<th class="cart-table-header">가격</th>
						</tr>
							<% if(list.size()==0){ %>
						<tr class='listtr'>
							<td colspan="7">장바구니가 비어있습니다</td>
						</tr>
							<% }else{ 
								for(int i=0; i<list.size(); i++){
									cartDto dto = list.get(i);	
							%>
						<tr class='listtr'>
							<td class="chkinput">
								<input type="checkbox" name="delchk" id="chk<%=dto.getSeq() %>"
								onclick="chkbox(<%=dto.getSeq() %>)" value="<%=dto.getSeq()%>">
							</td>
							<td class="cartimg"><img alt="이미지 없음" src="productimg/<%=dto.getFilename() %>" class="imggrp" width="100" height="100"></td>
							<td id="name">
								<dl>
									<dt><%=dto.getItem_name() %></dt>
									<dd>색상 : <%=(dto.getColor()==null)?"랜덤":dto.getColor() %></dd>
									<dd>사이즈 : <%=(dto.getSize()==null)?"랜덤":dto.getSize() %></dd>
								</dl>
							</td>
							<td class="carttext"><input type="button" class="btn_qna" onclick="minqty(<%=dto.getSeq()%>)" value="-"></td>
							<td id="qty<%=dto.getSeq()%>" class="carttext"><%=dto.getQty() %></td>
							<td class="carttext"><input type="button" class="btn_qna" onclick="pluqty(<%=dto.getSeq()%>)" value="+"></td>
							<td id="price<%=dto.getSeq()%>" class="carttext"><%=dto.getQty()*dto.getItem_price() %></td>
						</tr>
					<%}} %>
				</table>
			
			</div>
			
			<!-- 결제 넘기기 -->
			<div class="paycontainer">
			<form>
			<h3 class="totid">총 합계 &nbsp;&nbsp;&nbsp;&nbsp;
			<span id="tot" style="text-align:right;">0</span>
			</h3>
			</form>
			</div>
			
			<div id="btncontainer" >
			<input type="button" class="btn_qna" onclick="delbtn()" value="선택 상품 삭제">
			<input type="button" class="btn_qna" onclick="payfun()" value="결제하기">
			<input type="button" value="돌아가기" onClick="history.go(-1)" class="btn_qna"> 
			</div>
			
			<!-- 게시판 메인 끝 -->
	
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
 <!-- <script type="text/javascript" src ="<%=request.getContextPath() %>/jquery/jquery-3.5.1.min.js"></script>-->
  <!-- bootstrap js -->
  <script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
  <!-- slick slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.js"></script>
  <!-- custom js -->
  <script src="<%=request.getContextPath() %>/js/custom.js"></script>
  
  
<script type="text/javascript">
let tot = 0;
$("#allchk").change(function() {
	let a = $("#allchk").is(":checked");
	//console.log(a);

	$("input:checkbox[name=delchk]").each(function() {
		let pid ="#price"+this.value
		let price = $(pid).html();
		//console.log(this.checked+","+this.value);
		if(this.checked){
			//console.log(this.value);
			if(!a){ //현재 선택인데 전체선택 해제일 경우
				tot = parseInt(tot)-parseInt(price);
			}
			/*
			else{ // 현재 true인데 전체선택 일 경우
				
			}*/
			//전체 선택했느데 true라면 또 더해줄 필요 없음
			
		}else{
			if(a){ //현재 노 체크 인데, 전체선택이 될 경우
				tot = parseInt(tot)+parseInt(price);
			}/*
			else{ // 현재 false인데, 전체선택 해제 될 경우
			}*/
				//tot = parseInt(tot)-parseInt(price);
		}
			$("#tot").html(tot);
	});
	
	if(a){
		$("input[name=delchk]").prop("checked",true);
	}else{
		$("input[name=delchk]").prop("checked",false);
	}
	
});

function chkbox(data) {
	//console.log(data);
	let cid = "#chk"+data;
	let ischk = $(cid).prop("checked");
	//console.log("ischk = "+ischk);
	let pid = "#price"+data;
	let price = $(pid).html();
	//console.log(price);
	
	if(ischk){
		tot = parseInt(tot)+parseInt(price);
	}else{
		tot = parseInt(tot)-parseInt(price);
	}
	$("#tot").html(tot);
}

function minqty(data) {
	//console.log(data);
	let qtseq = "#qty"+data;
	let prseq = "#price"+data;
	let price = parseInt($(prseq).html());
	let num = $(qtseq).html();
	let itemprice = parseInt(price)/parseInt(num);
	if(num>1){
		num= parseInt(num)-1;
		price = price-itemprice;
	
	 	$.ajax({
			url:"./cartcont",
			type:"get", 
			datatype:"text",
			data:"work=chgqty&seq="+data+"&qty="+num, 
			success:function(obj){
				if(!obj.b){
					alert("정상적으로 수량이 수정되지 않았습니다");
				}else{
					$(qtseq).html(num);
					$(prseq).html(price);
				}
			},
			error:function(){
				alert("error");
			}
		});
	}
	
}
function pluqty(data) {
	//console.log(data);
	let qtseq = "#qty"+data;
	let num = $(qtseq).html();
	let prseq = "#price"+data;
	let price = parseInt($(prseq).html());
	let itemprice = parseInt(price)/parseInt(num);
	num = parseInt(num) +1;
	price = parseInt(price)+itemprice;
	//console.log(data+" , "+num);
	$.ajax({
		url:"./cartcont",
		type:"get", 
		datatype:"text",
		data:"work=chgqty&seq="+data+"&qty="+num, 
		success:function(obj){
			if(!obj.b){
				alert("정상적으로 수량이 수정되지 않았습니다");
			}else{
				$(qtseq).html(num);
				$(prseq).html(price);
			}
		},
		error:function(){
			alert("error");
		}
	});
	
}
function delbtn() {
	let dseq = "";
	$("input:checkbox[name=delchk]").each(function() {
		if(this.checked){
		//console.log(this.value);
			if(dseq==""){
				dseq= dseq+ this.value;
			}else{
				dseq = dseq+","+this.value;
			}
		}
	});
	//console.log("dseq = "+dseq);
	if(dseq==""){
		alert("상품 선택 후 삭제를 해주시기 바랍니다");
	}else{
		$.ajax({
			url:"./cartcont",
			type:"get", 
			datatype:"text",
			data:"work=delitem&seq="+dseq, 
			success:function(obj){
				if(!obj.b){
					alert("정상적으로 선택 상품이 삭제되지 않았습니다");
				}else{
					alert("정상적으로 삭제 되었습니다");
					location.href="./cartcont?work=cmove&id=<%=mem.getId()%>";
				}
			},
			error:function(){
				alert("error");
			}
		});
	}
}

function payfun() {
	let dseq = "";
	$("input:checkbox[name=delchk]").each(function() {
		if(this.checked){
		//console.log(this.value);
			if(dseq==""){
				dseq= dseq+ this.value;
			}else{
				dseq = dseq+","+this.value;
			}
		}
	});
	
	if(dseq==""){
		alert("상품 선택 후 결제 해주시기 바랍니다");
	}else{
	//결제하기 링크 추가
	//console.log(dseq);
		location.href = "purchaseCon?work=buylist&item_seq="+dseq;
	}
}
</script>

</body>
</html>