<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	//System.out.println("wirte = "+id);
%>
<%
	MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
	if(mem==null){
%>
	<script type="text/javascript">
		//alert("로그인 해주십시오");
		//로그인 페이지로 이동
	</script>
<%		
	}
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
</head>
<body>




    <!-- 작성 시작 -->

   <section class="bbs_section layout_padding">
      <div class="container_padding">


	
			<div class="write-form">
			<h2 class="text-center">Q&A 작성</h2>
				<form>
					<div class="form-group">
						제목 :<input type="text" id="title" class="form-control" placeholder="글 제목을 입력해주세요" style="text-align: left;">
					</div>
					
					<div class="form-group has-error">
						ID : <p class="form-control" id="id" style="text-align: left;"><%=id %></p>
					</div>
					
					<div class="form-group">
						구분 : <select id="sel" class="form-control">
							<option value="1">상품문의</option>
							<option value="2">배송문의</option>
							<option value="3">기타문의</option>
						</select>
					</div>
					
					<div class="form-group">
						내용 : <textarea class="form-area-bbs" id="contents" placeholder="내용을 입력해주세요" style="text-align: left;"></textarea>
					</div>
					
					
					<div class="form-group" >
						<input type="checkbox" id="secret">비밀글로 등록<br>
						<input type="button" value="등록" onclick="wclick()" class="btn btn-primary btn-lg btn-block"><br>
						<input type="button" value="목록으로 돌아가기" onclick="backbtn()" class="btn btn-primary btn-lg btn-block">
					</div>
				</form>
			
			</div>
		
		
		</div>
	</section>
<!-- 게시판 끝 -->

<script type="text/javascript">
function wclick(){
	let title = $("#title").val();
	let contents = $("#contents").val();
	let part = $("#sel option:selected").val();
	let secret = $("#secret").prop("checked");
	//console.log(title+" "+contents+" "+part+" "+secret);
	if(title.trim()=="" || title==null){
		alert("제목을 입력해주세요");
		$("#title").focus();
	}else if(contents.trim()=="" || contents==null){
		alert("내용을 입력해주세요");
		$("#contents").focus();
	}else{
		$.ajax({
			url:"../qnacont",
			type:"get", 
			datatype:"text",
			data:"work=addone&id=<%=id%>&title="+title+"&contents="+contents+"&part="+part+"&secret="+secret, 
			success:function(obj){
				if(obj.b){
					alert("정상적으로 추가 되었습니다");
					location.href="qna_main.jsp";
				}else{
					alert("정상적으로 추가되지 않았습니다");
					window.location.reload;
				}
			},
			error:function(){
				alert("error");
			}
		});	
	}
}
function backbtn() {
	location.href="<%=request.getContextPath()%>/board/qna_main.jsp";
}
</script>

</body>
</html>










