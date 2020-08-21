<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%=request.getContextPath() %>
    <%
       String id = request.getParameter("id");
       String title = request.getParameter("title");
       String content = request.getParameter("content");
       String sseq = request.getParameter("seq");
       int seq = Integer.parseInt(sseq);
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
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>

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
<body>










<!---------------- 글 수정하기 시작 -------------->

    <section class="bbs_section layout_padding">
      <div class="container_padding">
      
      
      
	      
		<h2>수정하기</h2>   
			
	   	<form method="post" id="frm">
	    <input type="hidden" value="suggest" name="work">
	    <input type="hidden" value="suggest_update" name="detailwork">
	    <input type="hidden" value="<%=seq %>" name="seq">
	        
	        <div align="center" class="container">
	        	<table border="1">
					<tr>
			       		<th class="table-header" name="id">작성자</th><td><%=id %></td> 
			        </tr> 
					<tr>
			            <th class="table-header">작성일</th><td><textarea type="text" id="title" name="title" cols="85" rows="1" style="border: none"><%=title %></textarea></td>
			        </tr>   
			          
			        <tr>
			         	<th class="table-header">내용</th><td><textarea class="form-area" id="area" name="content" required="required"><%=content%></textarea></td>
			        </tr> 
			          
		        </table>
		          <button type="submit" class="btn1" id="add">작성 완료</button>
			      <button type="button" class="btn1" onclick="location.href ='suggest?work=suggest&detailwork=suggest_main'">목록으로 돌아가기</button>
		        
	        </div>
		        
		</form>
      




	  </div>
    </section>
<!-------------- 글수정하기   끝 --------------->


 

<!-- 글 수정 시 빈칸여부 확인 -->
<script>
$(document).ready(function() {
	$("#add").click(function() {
		let title = $("#title").val(); let content = $("#content").val()
		if( title =="" || content ==""){
			alert("빈칸없이 입력해주세요");
		}else{
			let result = confirm("수정하시겠습니까?"); if(result){$("#frm").attr("action","../suggest").submit();}else{}
		}
	});	
});
</script>
</body>
</html>





















