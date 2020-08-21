<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
        String work = null;
         if(request.getParameter("work")!=null){
        	work = request.getParameter("work");	 
         }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<%
if(work.equals("id")){
	%>
<h3 class="text-center" style="color: #b9ac92">아이디 찾기</h3>

<input type="text" placeholder="이메일 " name="email" id="email" onkeyup="enterkey('id')">
<button type="button" id="btn" onclick="find_id()" >찾기</button>
	
<%}else{
%>
<h3 class="text-center" style="color: #b9ac92">비밀번호  찾기</h3>
<input type="text" placeholder="이메일 " name="email" id="email" onkeyup="enterkey('pwd')">
<input type="text" placeholder="아이디 " name="id" id="id" onkeyup="enterkey('pwd')">
<button type="button" id="btn" onclick="find_pwd()">찾기</button>
<%} %>
</div>
<br>
<div id="result" align="center">

</div>
 <!-- ajax -->
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<!-- jQery -->
  <script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
  <!-- cookie 아이디저장 -->
  <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.js"></script>
  <!-- slick slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
  <!-- Google Map -->
  
<script>

function find_id() {
	 
	$("#result").empty();
	let email = $("#email").val();
	if(email ==""){
		alert("공백 없이 입력해주세요");
	}else{
	$.ajax({
		url:"../member?work=id_Find&email="+email,
		type:"get",
		datatype:"json",
		success:(function(datas){
		let f_email = datas.map.f_email;
		let app ="";
		if(f_email == "no"){
		 app = "<span style='color: #a6dcef'>일치하는 아이디가 없습니다</span>"	
		}else{
		 app = " <h3 class='text-center' style='color: #a6dcef'>찾으시는 아이디는</h3> "
		      +" <span style:'color=pink;'>"+ f_email +"</span>"	 
		}
		    $("#result").html(app);
		})
	})
	}	
	 
}
function find_pwd() {
	
	$("#result").empty();
	let email = $("#email").val();
	let id = $("#id").val();
	
	if(email =="" || id ==""){
		alert("공백 없이 입력해주세요");
	}else{
	$.ajax({
		url:"../member?work=pwd_Find&email="+ email +"&id="+ id,
		type:"get",
		datatype:"json",
		success:(function(datas){
		let f_pwd = datas.map.f_pwd;
		let app ="";
		if(f_pwd == "no"){
		 app = "<span style='color: #a6dcef'>일치하는 비밀번호가 없습니다</span>"	
		}else{
		 app = " <h3 class='text-center' style='color: #a6dcef'>찾으시는 비밀번호는</h3> "
		      +" <span style:'color=pink;'>"+ f_pwd +"</span>"	 
		}
		    $("#result").html(app);
		})
	})
	}
	
}

function enterkey(work) {
	if (window.event.keyCode == 13 && work == "id") {
		find_id();
	}else if(window.event.keyCode == 13 && work == "pwd"){
		find_pwd();
	}
}

</script>
</body>
</html>


























