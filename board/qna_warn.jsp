<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 비밀글</title>
<style type="text/css">
.btn {        
    font-size: 16px;
    font-weight: bold;
	background: gray;
	border: none;
    color: white;
    border-radius: 2px;
    
}
body{
	background-image:url("../img/key.jpg");
	background-repeat:no-repeat;
	background-size:cover;
}
#check{
	margin-top:400px;
}
</style>
</head>
<body>

<div align="center" id="check">
<h2>작성자와 관리자만이 확인 할 수 있습니다</h2>

<input type="button" value="돌아가기" onclick="backbtn()" class="btn">
</div>

<script type="text/javascript">
function backbtn(){
	location.href="qna_main.jsp";
}
</script>


</body>
</html>