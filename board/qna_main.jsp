<%@page import="dto.MemberDto"%>
<%@page import="db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//DBConnection.initConnection();
	String id = null; int auth = 3;
	if(session.getAttribute("dto")!=null) session.removeAttribute("dto");

	MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
	//MemberDto mem = new MemberDto("bitcamp12",3);
	//MemberDto mem = new MemberDto("a",1);
/* 	MemberDto mem = new MemberDto("aaa",1); */

	
%>    
	<script type="text/javascript">
	let id = "";
<%	if(mem==null || mem.getId().equals("")){%>
		alert("로그인 해주십시오");
		//console.log("로그인해주세요");
		location.href = "<%=request.getContextPath()%>/main/login.jsp";
<%	}else{
	  id = mem.getId(); auth = mem.getAuth();
%>
		id ="<%=mem.getId()%>";
<%	}%>
	</script>

<%
	String spageNumber = (request.getParameter("pageNumber")==null)?"0":request.getParameter("pageNumber");
	//System.out.println("spageNumber = "+spageNumber);	
	int pageNumber = 0;

	if(!(spageNumber.equals("0"))){
		pageNumber = Integer.parseInt(spageNumber);
	}else{
		pageNumber = 0;
	}
	//System.out.println("pageNumber = "+pageNumber);

	String need = (request.getParameter("need")==null)?"":request.getParameter("need");
	String fneed= (request.getParameter("fneed")==null)?"":request.getParameter("fneed");
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

<title>Q&A</title>
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
    
    
    
    
    
    
    
    
    <!-- 게시판 시작 -->

<section class="bbs_section layout_padding">
    <div class="container_padding">
    

		<h1>Q&A 게시판</h1>
		
		
		<!-- 글 쓰기 이동 -->
		<div id="write" align="right">
			<%
			int count = (mem==null)?0:1;
			if( count ==1 ){
				%>
				<a href="../qnacont?work=wmove&id=<%=mem.getId() %>" style="color:purple;">글 작성</a>
			<%} %>
		</div>
		<hr>
		
		<!-- 탭 부분 -->
		<div id ="tabcontainer">
			<ul class="tab">
				<li class="qnatab" id="tab1" value="1" onclick="tabclick(this)">상품문의</li>
				<li class="qnatab" id="tab2" value="2" onclick="tabclick(this)">배송문의</li>
				<li class="qnatab" id="tab3" value="3" onclick="tabclick(this)">기타문의</li>
			</ul>
		</div>
		
		<!-- 게시판 목록 -->
				<div id="listcontainer" class="grp" align="center">
					<table id="listtb">
					<!-- <col width="50"><col width="50"> -->
					<col width="80">
					<!-- <col width="50"> -->
					<col width="300">
					<col width="800"><col width="150"><col width="150"><col width="100">
						<tr id="list_title" class="table-header">
							<th style="display:none;">선택</th>
							<th style="display:none;">seq</th>
							<th>순서</th>
							<th style="display:none;">구분seq</th>
							<th>구분</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th></th>
						</tr>
						<!-- 리스트 내용 추가 -->
					</table>
				</div>
		
		<!-- 페이지  -->
		<div id="pagecontainer" class="grp" align="center">
		
		</div>
		
		
		
		
		
		
		
		<script type="text/javascript">
		//let pstr = "";
		let pNum = <%=pageNumber%>;
		let blockCount = 0;
		let thisBlock = 0;// 현재 페이지가 속한 블럭
		let startNum =0;// 블럭의 시작
		let endNum =0;// 블럭의 끝
		let pstr = "";
		
		function showPage(len, clen, blockCount) {
			//console.log(pNum);
			pstr = "";
			
			thisBlock = parseInt(pNum/5); 
			
			startNum = thisBlock * 5; 
			endNum = (thisBlock * 5)+5;  
			
			pstr+="<div id='pagelist'> ";
			pstr += "<a href='#' value='<<' onclick='fPage()' style='text-decoration:none;'><<</a>&nbsp;&nbsp;&nbsp;&nbsp;";
			//console.log("thisBlock = " + thisBlock + " startNum = "+startNum+" endNum = "+endNum);
			if(thisBlock > 0){
				pstr += "<a href='#' value='<' onclick='prevPage(this.id)' id='"+thisBlock+"' style='text-decoration:none;'><</a>&nbsp;&nbsp;"	
			}
			if(endNum > clen){
				endNum = clen;
			}
			for(var i=startNum; i<endNum; i++){		
				if(i== pNum){
					pstr += "<span class='page_here'>"+(i+1)+"</span>&nbsp;&nbsp;";
				}else{		
					pstr += "<a href='#' onclick='goPage(this.id)' style='font-size:12pt; color:black; text-decoration:none;' id='"+i+"'>"+(i+1)+"</a>&nbsp;&nbsp;";	
				}
			}
			if(blockCount > thisBlock){
				//console.log("안나타남?");
				pstr += "<a href='#' value='>' onclick='nextPage(this.id)' id='"+thisBlock+"' style='text-decoration:none;'>></a>&nbsp;&nbsp;"	
			}
			pstr += "<a href='#' value='>>' onclick='lPage(clen)' style='text-decoration:none;'>>></a>&nbsp;&nbsp;&nbsp;&nbsp;";
			pstr += "</div>";
			//console.log(pstr);
			/* append로 하면 옆으로 너무 늘어나서 그냥 html로 해야지 바꿔지는걸로 된다 */
			$("#pagecontainer").html(pstr);
			//console.log("show "+$("#pagelist").length);
		}
		function fPage() {
			goPage(0);
		}
		function lPage(last) {
			goPage(last-1);
			//console.log(last);
		}
		function prevPage(obj){
			thisBlock = parseInt(obj)-1; 
			//console.log("this = "+thisBlock);
			startNum = thisBlock * 5; 
			//console.log("prevPage pnum== "+pNum);
			goPage(startNum);
		}
		function nextPage(obj){
			//console.log(obj);
			thisBlock = parseInt(obj)+1; // 0 받아와서 1로 만들었음
			startNum = thisBlock * 5; 
			
			goPage(startNum);
		}
		
		function goPage(obj) {
			//console.log("obj = "+ obj);
			let clickPage = obj;
		<%-- 	<%if( !fneed.equals("")){%> --%>
				//alert("!need.equals");
			 	//location.href="../qnacont?work=getlist&pageNumber="+clickPage+"&need='<%=need%>'&fneed='<%=fneed%>'"; 
			 	
				 $.ajax({
					url:"../qnacont",
					type:"get", 
					datatype:"text",
					data:"work=getlist&pageNumber=" + clickPage + "&need=<%=need%>&fneed=<%=fneed%>", 
					success:function(obj){
						len = obj.len;
					//	alert("len:" + len);
						clen = parseInt(len/10);
					//	alert("clen:" + clen);
						
						blockCount = parseInt(clen/5) ; // 12345(0) 678910(1) 11(2)	
						
						if(clen%5==0){
							blockCount = blockCount -1;
						}
						
						pNum = clickPage;
						
						if(len%10>0){
							clen = clen + 1;
						}
						let liststr = "";
						let list = obj.list;
						//console.log(list[1]);
						//console.log(list[1].id);
						
						if(list.length<=0) {
							liststr += "<tr><td colspan='6'>작성한 글이 없습니다</td></tr>";
						}else {
							for(var i=0; i<list.length; i++) {
								liststr += "<tr class='list_data' >";
								liststr += "<td style='display:none'><input type='checkbox' name='lc' class='lc'></td> ";
								liststr += "<td id='"+list[i].seq+"' style='display:none;'>"+list[i].seq+"</td>";
								liststr += "<td>"+(i+1)+"</td>";
								liststr += "<td id='"+list[i].part_seq+"' style='display:none;'>"+list[i].part_seq+"</td>";
								liststr += "<td>"+list[i].part_name+"</td>";
								
								if(list[i].secret==1 && (<%=mem.getAuth()%> != 1 || '<%=mem.getId()%>' !=list[i].id) ){
									list[i].title = '작성자와 관리자만 확인 할 수 있는 글입니다';
								}
								liststr += "<td><input type='text' id='t"+list[i].seq+"' value='"+list[i].title+"' style='border:none; text-align:left;' onclick='dmove(this)'size='60'></td>";
								liststr += "<td>"+list[i].id+"</td>";
								liststr += "<td>"+list[i].wdate+"</td>";
								
								if(<%=mem.getAuth()%> == 1 || list[i].id=='<%=mem.getId()%>'){
									liststr+="<td><input type='button' id='"+list[i].seq+"' onclick='delbtn(this.id)' value='삭제' class='btn'></td>";
								}else{
									liststr+="<td></td>";
								}
								
								liststr += "</tr>";
							}
						}
						//console.log(liststr);
						
						//console.log("len = "+len + ", clen =  "+ clen);
						showPage(len, clen, blockCount);
						//$("#list_title").attr("style","background-color:pink");
						$(".list_data").remove();
						
						$("#list_title").eq(-1).after(liststr);			
					},
					error:function(){
						alert("error");
					}
				});	 
		<%-- 	<%}else{%>
				//alert("need else");
				location.href="qna_main.jsp?pageNumber="+clickPage; 		
			<%}%> --%>
		}	
		</script>
		
		<!-- 검색 -->
		<div id="scontainer" class="grp" align="center">
			<select id="_need" name="need">
				<option value="TITLE" selected>제목</option>
				<option value="CONTENTS">내용</option>
				<option value="ID">작성자</option>
				<option value="PART_SEQ" style="display:none;">문의</option>
			</select>
			<input type="text" size="20" id="text_search" name="search">
			<input type="button" value="검색" id="searchbtn" class="btn">
		</div>

	</div>
</section>



<!-- 게시판 메인 끝 -->










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
 <!-- <script type="text/javascript" src ="<%=request.getContextPath() %>/jquery/jquery-3.5.1.min.js"></script>-->
  <!-- bootstrap js -->
  <script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
  <!-- slick slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.js"></script>
  <!-- custom js -->
  <script src="<%=request.getContextPath() %>/js/custom.js"></script>
  
  
<script type="text/javascript">
let len = -1;
let clen = -1;
$(document).ready(function () {

<%  
if(need.equals("")){
	need = "TITLE"; 
}%>

$("#_need").val('<%=need%>').prop("selected","selcted");
if("<%=need%>"=="PART_SEQ"){
	id = "#tab<%=fneed%>";
	$(id).attr("style","background-color:#95A5A6");
}else{
	$("#text_search").val('<%=fneed %>');
}
	 $.ajax({
		url:"../qnacont",
		type:"get", 
		datatype:"text",
		data:"work=getlist&pageNumber=<%=pageNumber%>&need=<%=need%>&fneed=<%=fneed%>", 
		success:function(obj){
			len = obj.len;
			clen = parseInt(len/10);
			blockCount = parseInt(clen/5) ; // 12345(0) 678910(1) 11(2)	
			
			if(clen%5==0){
				blockCount = blockCount -1;
			}
			
			if(len%10>0){
				clen = clen + 1;
			}
			let liststr = "";
			let list = obj.list;

			if(list.length<=0) {
				liststr += "<tr><td colspan='6'>작성한 글이 없습니다</td></tr>";
			}else {
				for(var i=0; i<list.length; i++) {
					liststr += "<tr class='list_data'>";
					liststr += "<td style='display:none'><input type='checkbox' name='lc' class='lc'></td> ";
					liststr += "<td id='"+list[i].seq+"' style='display:none;'>"+list[i].seq+"</td>";
					liststr += "<td>"+(i+1)+"</td>";
					liststr += "<td id='"+list[i].part_seq+"' style='display:none;'>"+list[i].part_seq+"</td>";
					liststr += "<td>"+list[i].part_name+"</td>";
					
					if(list[i].secret==1 && (<%=mem.getAuth()%> != 1 || '<%=mem.getId()%>' !=list[i].id) ){
						list[i].title = '작성자와 관리자만 확인 할 수 있는 글입니다';
					}
					liststr += "<td><input type='text' id='t"+list[i].seq+"' value='"+list[i].title+"' style='border:none; text-align:left;' onclick='dmove(this)' size='60'></td>";
					liststr += "<td>"+list[i].id+"</td>";
					liststr += "<td>"+list[i].wdate+"</td>";
					if(<%=mem.getAuth()%> == 1 || list[i].id=='<%=mem.getId()%>'){
						liststr+="<td><input type='button' id='"+list[i].seq+"' onclick='delbtn(this.id)' value='삭제' class='btn'> </td>";
					}else{
						liststr+="<td></td>";
					}
					liststr += "</tr>";
				}
			}
			//console.log(liststr);
			
			//console.log("len = "+len + ", clen =  "+ clen);
			showPage(len, clen,blockCount);
			$("#list_title").attr("style","background-color:#95A5A6");
		
			$("#list_title").eq(-1).after(liststr);			
		},
		error:function(){
			alert("error");
		}
	});	 
});
</script>

<script type="text/javascript">
let partval = 0;
let str = "TITLE";
function tabclick(data) {
	let id = "";
	//let text = data.textContent
	//console.log(data.textContent);
	
	if(partval != data.value){
		id = "#tab"+partval;
		$(id).attr("style","background-color:white");
		id = "#tab"+data.value;
		$(id).attr("style","background-color:grey");
		partval = data.value;
		
		$("#_need").val('PART_SEQ').prop("selected","selcted");
		//$("#text_search").val(text);
		
		location.href="./qna_main.jsp?need=PART_SEQ&fneed="+data.value;
	}
}
$("#_need").change(function(){
	str = $("#_need option:selected").val();
});
$("#searchbtn").click(function() {
	let nval = $("#text_search").val();
	location.href="./qna_main.jsp?need="+str+"&fneed="+nval;
	
});
function dmove(obj) {
	//console.log("dmove obj = " +obj.id);
	let mds = (obj.id).replace("t","");
	location.href="../qnacont?work=dmove&seq="+mds+"&id=<%=mem.getId()%>&auth=<%=mem.getAuth()%>";
}
function delbtn(data){
	//console.log(data);
	 $.ajax({
			url:"../qnacont",
			type:"get", 
			datatype:"text",
			data:"work=delQna&seq="+data, 
			success:function(obj){
				console.log(obj.b);
				if(obj.b){
					alert("정상적으로 삭제 되었습니다");
					goPage(0);
				}
			},
			error:function(){
				alert("error");
			}
		});	 
	
}
</script>

</body>
</html>