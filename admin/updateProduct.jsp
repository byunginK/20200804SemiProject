<%@page import="dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
ProductDto dto = (ProductDto)request.getAttribute("product");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(관리자용)제품 수정</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
body {
	background: white;
}
.form-control {
	min-height: 41px;
	background: #f2f2f2;
	box-shadow: none !important;
	border: transparent;
	text-align: center;
	padding-left:20px;
}
.write-form {
		width: 900px;
		height: 700px;
		margin: 30px auto;
		border-radius: 100px;
}
.write-form h3 {
    margin: 10px 0 25px;
}
.write-form form {
	color: #7a7a7a;
	border-radius: 3px;
	margin-bottom: 15px;
    background: #fff;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.5);
    padding: 30px;
}
.form-area {
	min-height: 700px;
	min-width: 830px;
	background: #f2f2f2;
	box-shadow: none !important;
	border: transparent;
	text-align: center;
	padding-left:20px;
	padding-top:20px;
	padding-right:20px;
	pading-bottom:20px;
}
.write-form .btn {        
	width: 150px;
	color : white;
    font-size: 16px;
    font-weight: bold;
	background: black;
	border: none;
    outline: none !important;
}
#secret{
	color : black;
	margin-top:10px;
	margin-bottom:30px;
}
.write-form .btn:hover, .write-form .btn:focus .form-area {
	background: #2389cd;
}
ul{
	list-style-type:none;
}
.btnup {        
    font-size: 16px;
    font-weight: bold;
	background: gray;
	border: none;
    color: white;
    border-radius: 2px;
}
</style>
</head>
<body>

<div class="write-form">
<h3 class="text-center">제품 수정</h1>
	<form action="updatePro" method="post" enctype="multipart/form-data">
<div class="form-group">
	<img src="productimg/<%=dto.getFilename()%>" width="300px" height="400px">
</div>
	

	<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
	
	<div class="form-group">
	제품명 : <input type="text" name="p_name" value="<%=dto.getP_name()%>" class="form-control" style="text-align:left;">
	</div>
	
	<div class="form-group">
	원단(재료) : <input type="text" name="p_material" value="<%=dto.getP_material()%>" class="form-control" style="text-align:left;">
	</div>
	
	<div class="form-group">
	제조 국가 : <input type="text" name="p_madeIn" value="<%=dto.getP_madeIn()%>" class="form-control" style="text-align:left;">
	</div>
	
	<div class="form-group">
	가격 : <input type="number" name="price" value="<%=dto.getP_price()%>" class="form-control" style="text-align:left;">
	</div>
	
	<div class="form-group">
	카테고리 분류 : <select id="selbig" name="selbig" class="form-control">
				<option>대분류</option>
				<option value="top">상의</option>
				<option value="bottom">하의</option>
				<option value="shoes">신발</option>
				<option value="accessary">악세사리</option>
			</select>
			<select id="selsmall" name="selsmall" class="form-control">
				<option>소분류</option>
			</select>
	</div>
	
	<div class="form-group">
	이미지 파일 : <input type="text" name="oldfile" value="<%=dto.getFilename()%>" readonly="readonly" class="form-control" style="text-align:left;">
	</div>
	
	<div class="form-group">
	이미지 수정 : <input type="file" name="fileload" class="btnup" id="fid">
	</div>
	
	<div class="form-group">
	제품 정보 : <textarea rows="10" cols="100" name="p_info" class="form-area" style="text-align:left;"><%=dto.getP_info() %></textarea>
	</div>
	<%-- 
	<ul>
		<li>제품명<br><input type="text" name="p_name" value="<%=dto.getP_name()%>"></li>
		<li>원단(재료)<br><input type="text" name="p_material" value="<%=dto.getP_material()%>"></li>
		<li>제조 국가<br><input type="text" name="p_madeIn" value="<%=dto.getP_madeIn()%>"></li>
		<li>가격<br><input type="number" name="price" value="<%=dto.getP_price()%>"></li>
		<li>카테고리 분류<br>
			<select id="selbig" name="selbig">
				<option>대분류</option>
				<option value="top">상의</option>
				<option value="bottom">하의</option>
				<option value="shoes">신발</option>
				<option value="accessary">악세사리</option>
			</select>
			<select id="selsmall" name="selsmall">
				<option>소분류</option>
			</select>
		</li>
		<li>이미지 파일<br><input type="text" name="oldfile" value="<%=dto.getFilename()%>" readonly="readonly"></li><br>
		<li>변경할 파일 : <input type="file" name="fileload" ></li>
		<li>제품 정보<br><textarea rows="10" cols="100" name="p_info"><%=dto.getP_info() %></textarea></li>
	</ul>
	<input type="submit" value="제품 수정">
	--%>
	<div class="form-group">
	<input type="submit" value="제품 수정" class="btn btn-primary btn-lg btn-block">
	<input type="button" value="목록으로 돌아가기" class="btn btn-primary btn-lg btn-block" onclick="backbtn()">
	</div>
	
	</form>
	

</div>


<script type="text/javascript">

/* 처음 값을 받아 올때 카테고리 자동 셀렉 기능 */

$(document).ready(function() {
	if("<%=dto.getP_category()%>"=="top"){
		$("#selbig option:eq(1)").attr("selected", "selected");
		if("<%=dto.getP_kind()%>"=="1"){
			$("#selsmall").html("<option value='1'>긴팔</option>");
		}else if("<%=dto.getP_kind()%>"=="2"){
			$("#selsmall").html("<option value='2'>반팔</option>");
		}else if("<%=dto.getP_kind()%>"=="3"){
			$("#selsmall").html("<option value='3'>셔츠</option>");
		}else if("<%=dto.getP_kind()%>"=="4"){
			$("#selsmall").html("<option value='4'>니트</option>");
		}else if("<%=dto.getP_kind()%>"=="5"){
			$("#selsmall").html("<option value='5'>민소매</option>");
		}
	}else if("<%=dto.getP_category()%>"=="bottom"){
		$("#selbig option:eq(2)").attr("selected", "selected");
		if("<%=dto.getP_kind()%>"=="1"){
			$("#selsmall").html("<option value='1'>치마</option>");
		}else if("<%=dto.getP_kind()%>"=="2"){
			$("#selsmall").html("<option value='2'>긴바지</option>");
		}else if("<%=dto.getP_kind()%>"=="3"){
			$("#selsmall").html("<option value='3'>반바지</option>");
		}else if("<%=dto.getP_kind()%>"=="4"){
			$("#selsmall").html("<option value='4'>청바지</option>");
		}
	}else if("<%=dto.getP_category()%>"=="shoes"){
		$("#selbig option:eq(3)").attr("selected", "selected");
		if("<%=dto.getP_kind()%>"=="1"){
			$("#selsmall").html("<option value='1'>운동화</option>");
		}else if("<%=dto.getP_kind()%>"=="2"){
			$("#selsmall").html("<option value='2'>슬리퍼</option>");
		}else if("<%=dto.getP_kind()%>"=="3"){
			$("#selsmall").html("<option value='3'>구두</option>");
		}
	}else if("<%=dto.getP_category()%>"=="accessary"){
		$("#selbig option:eq(4)").attr("selected", "selected");
		if("<%=dto.getP_kind()%>"=="1"){
			$("#selsmall").html("<option value='1'>귀걸이</option>");
		}else if("<%=dto.getP_kind()%>"=="2"){
			$("#selsmall").html("<option value='2'>목걸이</option>");
		}else if("<%=dto.getP_kind()%>"=="3"){
			$("#selsmall").html("<option value='3'>팔찌</option>");
		}else if("<%=dto.getP_kind()%>"=="4"){
			$("#selsmall").html("<option value='4'>시계</option>");
		}else if("<%=dto.getP_kind()%>"=="5"){
			$("#selsmall").html("<option value='5'>기타</option>");
		}
	}
	
	
});

$(function() {
	
	$("#selbig").change(function() {
		if(this.value == "top"){
			$("#selsmall").html("<option value='1'>긴팔</option>"
								+"<option value='2'>반팔</option>"
								+"<option value='3'>셔츠</option>"
								+"<option value='4'>니트</option>"
								+"<option value='5'>민소매</option>");
		}else if(this.value == "bottom"){
			$("#selsmall").html("<option value='1'>치마</option>"
								+"<option value='2'>긴바지</option>"
								+"<option value='3'>반바지</option>"
								+"<option value='4'>청바지</option>");
		}else if(this.value == "shoes"){
			$("#selsmall").html("<option value='1'>운동화</option>"
								+"<option value='2'>슬리퍼</option>"
								+"<option value='3'>구두</option>");
		}else if(this.value == "accessary"){
			$("#selsmall").html("<option value='1'>귀걸이</option>"
								+"<option value='2'>목걸이</option>"
								+"<option value='3'>팔찌</option>"
								+"<option value='4'>시계</option>"
								+"<option value='5'>기타</option>");
		}
	});
	
	
});

//추가
$("#fid").change(function() {
	//console.log($("#fid")[0].files[0].name);
	let fn = $("#fid")[0].files[0].name;
	let bfn = $("input[name=oldfile]").val();
	if(fn==bfn){
		$("#fid").val("");
	}
});
function backbtn() {
	location.href ="./admincont?work=proup_moveQnadel&pageNumber=0";
}

</script>



</body>
</html>