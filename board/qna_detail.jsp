<%@page import="dto.MemberDto"%>
<%@page import="dto.ReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.blistDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
	String id = mem.getId();
	int auth = mem.getAuth();
	//MemberDto mem = new MemberDto("a",1);
%>
	<script type="text/javascript">
	let id ="<%=mem.getId()%>";
	if(id == null || id==""){
		alert("로그인 해주십시오");
		//console.log("로그인해주세요");
		//location.href = "login.jsp";
	}
	</script>
<%
	blistDto dto = (blistDto) request.getAttribute("sdto");
	//String id = (String) session.getAttribute("id");
	//session.removeAttribute("dto");
	
	List<ReplyDto> list = (List<ReplyDto>) request.getAttribute("list");
	//System.out.println(dto.getSeq());
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

  <title>Q&A 작성</title>
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


</style>
</head>
<body>


      <!-- 헤더 -->
      <header class="header_section">
        <div class="container-fluid">
        <!-- 네비게이션 바 -->
          <nav class="navbar navbar-expand-lg custom_nav-container ">
            <a class="navbar-brand" href="index.jsp">
              Simple Five
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            	<span class=""></span>
            </button>
            <div class="collapse navbar-collapse " id="navbarSupportedContent">
              <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                  <a class="nav-link" href="index.jsp">Main<span class="sr-only"></span></a>
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



    
    <!-- 게시판 시작 -->

   <section class="bbs_section layout_padding">
      <div class="container_padding">


		<h2>Q&A 상세 페이지</h2>
		
		<div class="grp" align="center">
			<table id="tb" border="1">
				<tr>
					<td colspan="2">
						<input type="hidden" id="seq" value="<%=dto.getSeq()%>">
					</td>
				</tr>
				<tr>
					<td class="table-header">제목 </td>
					<td><%=dto.getTitle() %></td> 
				</tr>
				<tr>
					<td class="table-header">아이디  </td>
					<td><input type="text" id="id" value="<%=dto.getId() %>" style="border:none; text-align:left;" readonly></td> 
				</tr>
					<td class="table-header">구분</td>
					<td><%=dto.getPart_name() %></td> 
				</tr>
				<!-- 상품문의 일 경우 상품 선택 가능할 수 있도록 하기 -->
				<tr>
					<td class="table-header">내용  </td>
					<td><textarea id="contents" class="form-area" value="<%=dto.getContents() %>" readonly><%=dto.getContents() %></textarea></td> 
				</tr>
			</table>
		</div>
		
		
		
		<!-- 댓글 작성 -->
			<div id="replycontainer" class="grp" align="center">
			
			<!-- 댓글 가져오기 -->
			<div id="dlist" class="grp">
			<table id="dtb">
			<col width="150"><col width="520"><col width="100">
			<tr id="reptitle">
			<th class="table-header" >아이디</th>
			<th class="table-header">내용</th>
			<th class="table-header">작성일</th>
			<th class="table-header"></th>
			<th class="table-header"></th>
			</tr>
			<% 
				if(list.size()==0){%>
				<tr class="replist">
				<td colspan="4" style="text-align:center;">작성된 댓글이 없습니다</td>
				</tr>
			<%	}else{
				for(int i=0; i<list.size(); i++){ 
				ReplyDto rd = list.get(i);
			%>
				<tr class="replist">
				<td><%=rd.getId() %></td>
				<td><%=rd.getContents() %></td>
				<td><%=rd.getWdate() %></td>
			<% 
			
			if(rd.getId().equals(id)){ %>
				<td><input type="button" id="<%=rd.getQna_seq()%>/<%=rd.getSeq() %>/<%=rd.getId() %>/<%=rd.getContents() %> " value="수정" onclick="upfunc(this.id)" class="btn_qna"></td>
				<td><input type="button" id="<%=rd.getSeq() %>/<%=rd.getQna_seq() %> " value="삭제" onclick="delfunc(this.id)" class="btn_qna"></td>
			<%} %>	
				</tr>
			<%} }%>
			</table>
			</div>
			
			<!-- 댓글 추가 부분 -->
			<% if( mem != null && !mem.getId().equals("") ){ %>
			<div id="mine" class="grp" align="center">
			<table id="minetb">
			<col width="20"><col width="200"><col width="100">
			<tr>
			<td style="display:none;"><input type="text" id="repid" value="<%=id %>" size="5" style="border:none; text-align:left;" ></td>
			<td><textarea id="repcontents" rows="5" cols="110" placeholder="댓글 내용을 입력해주시기 바랍니다"></textarea></td>
			
			</tr>
			</table>
			</div>
			<%} %>
			</div>
			
			<div id="btngrp" class="grp" align="center">
			<%if(!mem.getId().equals("") && mem != null && mem.getId().equals(dto.getId()) ){ %>
			<input type="button" value="수정" onclick="upbtn(<%=dto.getSeq()%>)" class="btn_qna">
			<%} %>
			<input type="button" value="돌아가기" onclick="backbtn()" style="margin-top:50px;" class="btn_qna">
			<input type="button" id="repbtn" value="댓글 쓰기" class="btn_qna">
			</div>



		</div>
	</section>



<!-- 게시판 메인 끝 -->



<script type="text/javascript">
function backbtn() {
	location.href="./board/qna_main.jsp";
}
$("#repbtn").click(function(){
	let id = $("#repid").val();
	let repcontents = $("#repcontents").val();
	let seq = $("#seq").val();
	//console.log(id + " "+repcontents+" "+seq);
	if(repcontents.trim()==""){
		alert("댓글을 작성해주시기 바랍니다");
	}else if(repcontents.length > 120){
		alert("댓글의 최대 길이를 넘기셨습니다");
		$("#repcontents").focus();
	}else{
	 $.ajax({
			url:"./qnacont",
			type:"get", 
			datatype:"text",
			data:"work=adddetail&id="+id+"&repcontents="+repcontents+"&seq="+seq, 
			success:function(obj){
				//console.log(obj);
				//console.log(obj.ar.id);
				
				let str = "<tr class='replist'><td>"+obj.ar.id+"</td><td>"+obj.ar.contents+"</td>"
						+ "<td>"+obj.ar.wdate+"</td>";
				if(obj.ar.id == '<%=id%>' ){
					//console.log("동일");
					str += "<td><input type='button' id='"+obj.ar.qna_seq+"/"+obj.ar.seq+"/"+obj.ar.id+"/"+obj.ar.contents+"' value='수정' onclick='upfunc(this.id)' class='btn_qna'></td>";
					str += "<td><input type='button' id='"+obj.ar.seq+"/"+obj.ar.qna_seq+"' value='삭제' onclick='delfunc(this.id)' class='btn_qna'></td>"; 
				} 	
				str+= "</tr>";	
				
				if($(".replist").length >0){
					$(".replist").eq(-1).after(str);
				}else{
					$("#reptitle").eq(-1).after(str);
				}		
				$("#repcontents").val("");
						
			},
			error:function(){
				alert("error");
			}
		});	 
	}
});

function upfunc(data) {
	//let bfdata= data;
	data = data.split("/");
	let qnaseq = data[0];
	let rpseq = data[1]
	let id = data[2];
	let contents = data[3];
	//console.log(qnaseq +", "+rpseq+", "+id+", "+contents);
	
	window.open('./board/qna_reply_update.jsp?qnaseq='+qnaseq+"&rpseq="+rpseq+"&id="+id+"&contents="+contents,'repUpdate','width=400,height=200,left=500,top=300');
}
function delfunc(data) {
	data = data.split("/");
	let seq = data[0];
	let qnaseq = data[1];
	 $.ajax({
			url:"./qnacont",
			type:"get", 
			datatype:"text",
			data:"work=delRepOne&seq="+seq+"&qnaseq="+qnaseq, 
			success:function(obj){
				if(obj.b){
					alert("정상적으로 삭제 되었습니다");
					
					if($(".replist").length>0) {
						$(".replist").remove();
					}
					let str = "";
					for(var i=0; i<obj.list.length; i++){
						str += "<tr class='replist'><td>"+obj.list[i].id+"</td><td>"+obj.list[i].contents+"</td>"
						+ "<td>"+obj.list[i].wdate+"</td>";
						if(obj.list[i].id == '<%=id%>' ){
							str += "<td><input type='button' id='"+obj.list[i].qna_seq+"/"+obj.list[i].seq+"/"+obj.list[i].id+"/"+obj.list[i].contents+"' value='수정' onclick='upfunc(this.id)' class='btn'></td>";
							str += "<td><input type='button' id='"+obj.list[i].seq+"/"+obj.list[i].qna_seq+"' value='삭제' onclick='delfunc(this.id)' class='btn'></td>"; 
						} 	
						str+= "</tr>";
					}
					//console.log(str);
					$("#reptitle").eq(-1).after(str);
				}
						
			},
			error:function(){
				alert("error");
			}
		});	 
}
function upbtn(data) {
	//console.log(data);
	location.href="./qnacont?work=dupmove&seq="+data;
}
</script>





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
                <a href="index.jsp">
                  Home
                </a>
                <a href="detail.jsp">
                  	카테고리
                </a>
                <a href="contact.jsp">
                  	고객센터
                </a>
                <a href="login.jsp">
                  	로그인
                </a>
                <a href="register.jsp">
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


  <!-- cookie 아이디저장 -->
  <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.js"></script>
  <!-- slick slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>

<!-- 바디 끝 -->
</body>
</html>