<%@page import="dto.loginDto"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("utf-8"); %>
    <%=request.getContextPath() %>
   <%
   String id = null; int auth = 3;
   MemberDto login_Dto = null;
   if(session.getAttribute("login_Dto") != null){
	   login_Dto = (MemberDto)session.getAttribute("login_Dto");
	   id = login_Dto.getId(); auth = login_Dto.getAuth();
   }  
   String GetId = request.getParameter("id");
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

  <title>WriteSuggest</title>
 

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <!--slick slider stylesheet -->

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet" />
  <!-- slick slider -->
  <!-- <link rel="stylesheet" href="css/slick-theme.css" /> -->
  <!-- font awesome style -->
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <!-- <link href="css/responsive.css" rel="stylesheet" /> -->

</head>

<!-- 바디 셋팅 -->

 <body>
    
<!----------- 건의사항 글쓰기 시작 --------------->
<section class="bbs_section layout_padding">
	<div class="container_padding">

		<div class="write-form">
			<h2 class="text-center">건의사항 작성</h2> 
			<form method="post" id="frm">
				<!-- 컨트롤러로 보내는 값 -->
			<input type="hidden" name="work" value="suggest"><input type="hidden" value="suggest_write" name="detailwork"><input type="hidden" value="<%=id %>" name="id">
			
			
				<!-- 건의 사항 글쓰기 테이블 시작 -->
			<div class="form-group">
	                     제목 : <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해주세요" required="required">
	        </div>	
				
			<div class="form-group has-error">
				ID:<p class="form-control"><%=id %> 
	        </div> 
			
   
			
			<div class="for-group">
	         	내용:<textarea class="form-area-bbs" id="content" name="content"  placeholder="내용을 입력해주세요" required="required"></textarea>
	        </div> 
	        
	        <div class="form-group">
	            <button type="submit" class="btn btn-primary btn-lg btn-block" id="btn" value="작성">작성 완료</button>
	            <button type="button" class="btn btn-primary btn-lg btn-block" onclick="location.href ='suggest?work=suggest&detailwork=suggest_main'">목록으로 돌아가기</button>
	        </div>
			

			
			</form>
		</div>
	</div>
</section>
<!--  건의사항 글쓰기 테이블 끝 -->


<!------------ 건의사항 글쓰기 끝 ------------>

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



 
 <!-- 글 작성시 빈칸 여부 확인 --> 
<script>
$(document).ready(function() {
	$("#btn").click(function() {
		let title = $("#title").val();  let content = $("#content").val();
		if( title == "" || content == ""){
			alert("모두 작성해주세요");
		}else{
			$("#frm").attr("action", "suggest").submit();
		}	
	});
});

</script> 
 
</body>
</html>





