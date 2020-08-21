<%@page import="dto.loginDto"%>
<%@page import="dto.sug_AnswerDto"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.suggestDao"%>
<%@page import="dto.suggestDto"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%request.setCharacterEncoding("utf-8"); %>
     <%-- <%=request.getContextPath() %> --%>
      <%
      String id = null; int auth = 3;
      MemberDto login_Dto = null;
       if(session.getAttribute("login_Dto") != null){
    	   login_Dto = (MemberDto)session.getAttribute("login_Dto");
    	   id = login_Dto.getId(); auth = login_Dto.getAuth();
       }
String text = request.getParameter("text")==null?"":request.getParameter("text");
int pageNumber = (Integer)request.getAttribute("pageNumbers"); int pagingBlock = (Integer)request.getAttribute("pagingBlock");
int allPage =(Integer)request.getAttribute("allPage"); int endPage =(Integer)request.getAttribute("endPage");
suggestDao dao = suggestDao.getInstance(); List<suggestDto> list = (List<suggestDto>)request.getAttribute("suggestList");
 int stpn = (Integer)request.getAttribute("stpn");           
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

  <title>Login</title>


  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <!--slick slider stylesheet -->

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet" />
  <!-- slick slider -->

  <link rel="stylesheet" href="css/slick-theme.css" />
  <!-- font awesome style -->
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />
<style type="text/css">
table{
	border-collapse: collapse; 
	/* max-width: 100%; */
}
h3{
	background-color: #f0f0f0;
	text-align: center !import;
}
.tab {
	list-style:none;
}
.qnatab{
	margin-left:30px;
	float :left;
}
#list_title{
	height:50px;
	background-color: #95A5A6;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.03em;
}
#listcontainer{
	clear:both;
	margin-top:80px;
	margin-left:28px;
}
/*
#scontainer{
	margin-top : 20px;
	margin-left: 60px;
} */
.table-header {
    background-color: #95A5A6;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.03em;
}

#pagecontainer{
	margin-top:30px;
	margin-bottom:30px;
}
.list_data{
	height:50px;
	background-color: #ffffff;
    box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.3);
}
#listtb{
	text-align:center;
}
.btn {        
    font-size: 16px;
    font-weight: bold;
	background: gray;
	border: none;
    color: white;
    border-radius: 2px;
}

</style>
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
    
    
    
    
    
<!--------- 건의사항 시작 ------------>
<section class="bbs_section layout_padding"> 
      <div class="container_padding">
      
      
			<h2>건의사항</h2><hr>
			<!-- 건의사항 리스트 시작 -->
			<div id="listcontainer" align="center"  class="grp">
			
			
				<table id="listtb">
				<col width="80" >
				<col width="800">
				<col width="150"><col width="80"><col width="100"><col width="150"><col width="100">
				<tr id="list_title" class="table-header">
				<th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th>
				</tr>
					<tbody id="suggest">
					
						<%
						if(list.size() == 0){
							%>
						<tr class="list_data"><td colspan="5"><b>작성된 글이 없습니다</b></td></tr>
						<% 
						}else{
							for(int i = 0; i < list.size(); i++){
								suggestDto bbs = list.get(i);
					
						%>
					    <tr class="list_data">
					    	<th><%=i+1 %></th>
							<td>
								<%
								if(bbs.getDel() == 0 && bbs.getStep()== 0){
									%>		
									<a href="suggest?work=suggest&detailwork=suggest_detail&seq=<%=bbs.getSeq() %>"><%=bbs.getTitle() %></a>
											
								<%}else if(bbs.getStep()== 0 && bbs.getDel()!=0){%>		
								<font color="#CC0000">관리자에 의해서 삭제되었습니다</font> 
							<%}%>
							</td>  
							<td align="center"><%=bbs.getId() %></td>
							<td><%=bbs.getReadcount() %></td>
							<td><%=bbs.getWdate() %></td>
						</tr>
						<%} }%>
					</tbody>
				</table>
				
			</div>
<!-- 건의사항 리스트 끝 -->






<!-- 페이징 번호 시작 -->
		<div id="pagecontainer" class="grp" align="center">
			&nbsp;<a href="#" onclick="paging(<%=0%>)" style='text-decoration:none;'>[<<]</a>&nbsp;
				<%if(endPage > allPage ){ endPage = allPage;}
				 if( allPage == 1 ){
				%>
			<span id="paging"><%=1 %></span>
				<% }else{   
				     for( int i = stpn; i < endPage; i++ ){ 
				    	 if(i == pageNumber){
				%>  
			<span style='font-size:18pt; color:#9d6b53; font-weight:bold;'><%=pageNumber+1 %></span>
				<%}else{ %>  
				    <a onclick="paging(<%=i%>)" style='font-size:12pt; color:black; text-decoration:none;'><%=i+1 %></a>&nbsp;&nbsp; 
				<%}
				}
				}if(pagingBlock > 1){%>
			&nbsp;<a href="#" onclick="pagingNext()" style='text-decoration:none;'>></a>&nbsp;
			
				 <%}%>
			 <a href="#" onclick="paging(<%=endPage-1%>)" style='text-decoration:none;'>[>>]</a>
			 <!-- 페이징 번호 끝 -->
			 
			 <!-- 글쓰기로 이동버튼 -->
			<a href="suggest?work=suggest&detailwork=writeIdcheck">글쓰기</a>
		</div>

<!---------- 검색 시작 -------->
			<form action="./suggest" method="get">
			
			<!-- 컨트롤러로 보내는 값 -->
				<input type="hidden" value="suggest" name="work"><input type="hidden" value="suggest_main" name="detailwork">
				<div align="center">
			
			<!----------------- 검색 시작 ------------>
			<!-- 검색 옵션 -->
					<select name="option" id="option">
						<option value="all" class="all" >전체</option>
						<option value="title" class="title">제목</option>
						<option value="id" class="id">작성자</option>
						<option value="content" class="content">내용</option>
					</select>
			
			<!-- 검색입력&검색 버튼 -->
					<input type="text" name="text" placeholder="검색" value="<%=text%>" id="text">&nbsp;
					<button type="submit" id="search_btn" class="btn">검색</button>
				</div>
			</form>
<!--------- 검색 끝 -------->
		</div>
    </section>






<!------------ 건의사항 메인(리스트) 끝 ------------>

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
  <!-- Ajax -->   
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
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


<!-- 페이징 처리 -->
<script>
function paging( pageno ) {
	  $("#pagecontainer").empty();
	  $("#suggest").empty();
	  let option = $("#option").val();
	  let text = $("#text").val();
	$.ajax({
		url:"suggest?work=suggest&pageNumber=" + pageno +"&detailwork=paging&option="+option+"&text="+text,
		type:"get",
		datatype:"json",
		success:(function(datas){
		//alert(datas.map.suggestList);
			let suggestList = datas.map.suggestList;
            let bbspage = datas.map.bbsPage;
			let pagenumber = datas.map.pageNumber;
			let endPage = datas.map.endPage;
			let allPage = datas.map.allPage;
			let pagingBlock = datas.map.pagingBlock;
			let stpn = datas.map.stpn;
			//alert(endPage); alert(allPage); alert(pagingBlock); alert(stpn);
			$.each(suggestList, function (i, val) {          
				
				let app ="<tr class='list_data'>"   
				          +"<th>"+ i +"</th>";
				 if(val.del == 0 && val.step == 0){
					app	+=  "<td>" 		
						   +"<a href='suggest?work=suggest&detailwork=suggest_detail&seq="+ val.seq + "'>"
						   + val.title
						   + "</a>"
						   +"</td>"
				}
				 else if(val.step == 0 && val.del !=0){
				app +=	"<td>"
					+ "<font color='#CC0000'>관리자에 의해서 삭제되었습니다</font>";
			     	+"</td>";		
				       }
				app	+=  "<td>"+ val.id +"</td>"
				        +"<td>"+ val.readcount +"</td>" 
				        +"<td>"+ val.wdate +"</td>" 
					    + "</tr>";
					  	   
				$("#suggest").append(app);		
			}); 
			var pn = pageno + 1
		 let pageNum = "&nbsp;<a href='#' onclick='paging(0)' style='text-decoration:none;'>[<<]</a>&nbsp;";
			 if(endPage > allPage ){ endPage = allPage;}
			 if( allPage == 1 ){
			
			pageNum += "<span id='paging'>1 </span>";
			}else{   
			     for( var i = stpn; i < endPage; i++ ){ 
			    	
			    	 if(i != pageno){
			    		 var e = i + 1;
			    		 pageNum += "&nbsp;&nbsp;<a onclick='paging(" + i + ")' style='font-size:12pt; color:black; text-decoration:none;'>"+ e + "</a>&nbsp;&nbsp;"; 

			}else{ 
				pageNum += "&nbsp;&nbsp;<span style='font-size:18pt; color:#9d6b53; font-weight:bold;'>" + pn  +"</span>&nbsp;&nbsp;";
			}
			}
			}
			 var endp = endPage-1
			pageNum += "<a href='#' onclick='paging("+ endp + ")' style='text-decoration:none;'>[>>]</a>&nbsp;&nbsp;"
			  + "<a href='suggest?work=suggest&detailwork=writeIdcheck'>글쓰기</a>";
	                    
	                     
	       $("#pagecontainer").append(pageNum);
      })
   });

}

/*  
 function pagingNext( pageno ) {
	  $("#suggest").empty();
	  let option = $("#option").val();
	  let text = $("#text").val();
	$.ajax({
		url:"suggest?work=suggest&pageNumber=" + pageno +"&detailwork=paging&option="+option+"&text="+text,
		type:"get",
		datatype:"json",
		success:(function(datas){
		//alert(datas.map.suggestList);
			let suggestList = datas.map.suggestList;
			let bbspage = datas.map.bbsPage;
			let pagenumber = datas.map.pageNumber;
			$.each(suggestList, function (i, val) {
	 
				let app ="<tr class='list_data'>"   
				          +"<th>"+ val.seq +"</th>";
				 if(val.del == 0 && val.step == 0){
					app	+=  "<td>" 		
						   +"<a href='suggest?work=suggest&detailwork=suggest_detail&seq="+ val.seq + "'>"
						   + val.title
						   + "</a>"
						   +"</td>"
				}
				 else if(val.step == 0 && val.del !=0){
				app +=	"<td>"
					+ "<font color='#CC0000'>관리자에 의해서 삭제되었습니다</font>";
			     	+"</td>";		
				       }
				app	+=  "<td align='center'>"+ val.id +"</td>"
				         +"<td>"+ val.readcount +"</td>"
                         +"<td>"+ val.wdate +"</td>"
				         + "</tr>";
					  	   
				$("#suggest").append(app);		
			}); 	
    })
 });

} */

/* function answerView(seq) {
	
    window.open('AnswerList.jsp?seq='+seq, 'newWindow', 'width=500, height=500');
  

} */


</script>

<!-- 페이징 처리 끝 -->

</body>
</html>




























