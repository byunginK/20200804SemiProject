<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = null; int auth = 3;
	List<ProductDto> list = (List<ProductDto>) request.getAttribute("list");
	int len = (int) request.getAttribute("len");
	MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
	//MemberDto mem = new MemberDto("a",1); 
	
	if(mem==null){
%>
	<script type="text/javascript">
		alert("로그인 해주십시오");
		location.href = "<%=request.getContextPath()%>/main/login.jsp";
	</script>
<%		
	}else{
		id=mem.getId(); auth = mem.getAuth();
	}
%>
<%
	int pageNumber = 0;
	String spageNumber = (request.getParameter("pageNumber")==null)?"0":request.getParameter("pageNumber");
	if(!spageNumber.equals("0")) pageNumber = Integer.parseInt(spageNumber);
	
	String need = (request.getParameter("need")==null)?"":request.getParameter("need");
	String fneed = (request.getParameter("fneed")==null)?"":request.getParameter("fneed");
	
	int tpage = len / 10;	//page 총 갯수
	if(len%10 >0 ) tpage++;
	
	int blockCount = (tpage%5==0)?(tpage / 5)-1:(tpage / 5); // block의 총 갯수
	int thisBlock = pageNumber / 5; // block 현재 위치
	
	int startBlock = thisBlock*5;
	int endBlock = thisBlock*5+5;
	
	//System.out.println("list = "+list.size()+", len ="+len);
	//System.out.println("엥? "+ pageNumber + "len ="+len+" tpage ="+tpage+" blockCount =" + blockCount);
	//System.out.println("엥? "+thisBlock+ " start = "+startBlock +" end = "+endBlock);
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
 
<title>(관리자용)제품 삭제</title>
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
    
    
    
    
    
    
    <!-- 제품삭제 시작 -->
    <div class="delcontainer">
		<input type="button" value="삭제" onclick="delBtn()" class="btn1">
		<input type="button" value="돌아가기" onclick="backBtn()" class="btn1">
	</div>
<hr>
    
   <section class="bbs_section layout_padding">
      <div class="container_padding" align="center">
	
<!-- 삭제 버튼 부분 -->


<!--리스트 테이블 부분  -->
<div id="deltbcontainer">

<table id="bigtb" >
<col width="800"><col width="300">
<tr>

<!--게시판 테이블  -->
<td>

<table id="tblist" >
<col width="100"><col width="400"><col width="150"><col width="200">
<tr class="thtitle">
<td class="table-header"><input type="checkbox" id="allchk" ></td>
<th class="table-header">이름</th>
<th class="table-header">분류</th>
<th class="table-header">파일명</th>
</tr>
<% if(list.size()==0 || list == null){%>
	<tr class='listtr'><td colspan="4">작성된 글이 없습니다</td></tr>
<%
	}else{
	for(int i=0; i<list.size(); i++){ 

	ProductDto dto = list.get(i); %>
	<tr class='listtr'>
		<td class="chkinput"><input type="checkbox" name="delchk" value='<%=dto.getSeq() %>' ></td>
		<td><%=dto.getP_name() %></td>
		<td><%=dto.getP_category() %></td>
		<td onclick="showimg('<%=dto.getFilename()%>')"><%=dto.getFilename() %></td>
	</tr>
<% } } %>
</table>

</td>

<!-- 이미지 보여지는 부분 -->
<td id="forimg">
<img src="<%=request.getContextPath() %>/img/defimg.png" alt="파일명을 클릭해주세요">
<!-- 파일명을 클릭하면 <br>
사진을 볼 수 있습니다 -->
</td>
</tr>

</table>
</div>

<!-- pageNumber  -->
<div id="pagecontainer">
<ul class="pagelist">
<li class="page_li"><a href="#none" onclick="fPage()"> << &nbsp;&nbsp;</a></li>
<% if(thisBlock > 0){ %>
		<li class="page_li"><a href="#none" onclick="prevpage(<%=thisBlock %>)"> < &nbsp;&nbsp;</a></li>
<% }
   if(endBlock > tpage){
	   endBlock = tpage;
   }
	for(int i=startBlock; i<endBlock; i++){ 
	if(pageNumber == i){
%>
	<li class="page_li"><span class="page_here"><%=i+1 %>&nbsp;&nbsp;</span></li>
	<%}else{ %>
	<li class="page_li"><a href="#none" onclick="goPage(<%=i %>)"><%=i+1 %>&nbsp;&nbsp;</a></li>
<%	}
	} // for문 종료
	if(endBlock < tpage){%>
	<li class="page_li"><a href="#none" onclick="nextpage(<%=thisBlock %>)"> > &nbsp;&nbsp;</a></li>
<%	}%>
	<li class="page_li"><a href="#none" onclick="lpage(<%=len %>)"> >> &nbsp;&nbsp;</a></li>
</ul>
</div>

<br><br>

<!-- 검색 부분 -->
<div class="scontainer" >
<select id="need">
	<option value="P_NAME" selected>제목</option>
	<option value="P_CATEGORY">분류</option>
</select>
<input type="text" size="15" id="fneed">
<input type="button" id="schbtn" class="btn_qna" value="검색">
</div>
<% if(!need.equals("")){%>
	<script type="text/javascript">
		$("#need").val('<%=need%>').prop("selected","selcted");
	</script>
<% }
   if(!fneed.equals("")){
%>
	<script type="text/javascript">
		$("#fneed").val("<%=fneed%>");
	</script>
<% } %>

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
let pageNumber = 0;

$("#allchk").change(function() {
	let a = $("#allchk").is(":checked");
	//console.log(a);
	if(a){
		$("input[name=delchk]").prop("checked",true);
	}else{
		$("input[name=delchk]").prop("checked",false);
	}
});

$("#schbtn").click(function() {
	let need = $("#need option:selected").val();
	let fneed = $("#fneed").val();
	
	//console.log(need +" "+fneed);
	//console.log($(".listtr").length);
	
	location.href="admincont?work=pro_qsearch&need="+need+"&fneed="+fneed+"&pageNumber=0";
	
});

function goPage(data) {
	//console.log(data);
	if('<%=need%>'==""){
		location.href="admincont?work=pro_moveQnadel&pageNumber="+data;
	}else{
		location.href="admincont?work=pro_qsearch&need=<%=need%>&fneed=<%=fneed%>&pageNumber="+data;
	}
	
}
function fPage(){
	location.href="admincont?work=pro_moveQnadel&pageNumber="+0;
}
function lpage(){
	//console.log(<%=tpage%>);
	location.href="admincont?work=pro_moveQnadel&pageNumber=<%=tpage-1%>";
}
function prevpage(data) {
	location.href="admincont?work=pro_moveQnadel&pageNumber="+((data*5)-5);
}
function nextpage(data) {
	location.href="admincont?work=pro_moveQnadel&pageNumber="+((data*5)+5);
}
function delBtn() {
	let a = "";
	
	$("input:checkbox[name='delchk']").each(function(){
		if(this.checked){
			if(a==""){
				a+=this.value;
			}else{
				a+=","+this.value;
			}
		}
	});	
	if(a==""){
		alert("선택 후 삭제해주시기 바랍니다");
	}else{
	 $.ajax({
			url:"<%=request.getContextPath() %>/admincont",
			type:"get", 
			datatype:"text",
			data:"work=pro_delchklist&chklist="+a, 
			success:function(obj){
				if(obj.b){
					location.href="admincont?work=pro_moveQnadel&pageNumber=0";
				}
			},
			error:function(){
				alert("error");
			}
		});	 
	}
}
function backBtn() {
	location.href="<%=request.getContextPath() %>/admin/admin_main.jsp";
}
function showimg(data) {
	let s = "productimg/"+data;
	//console.log(s);
	let str = '<img alt="이미지 없음" src="'+s+'" width="300px" height="300px">';
	
	$("#forimg").html(str);
	//$("#forimg").append("data");
}
</script>

</body>
</html>