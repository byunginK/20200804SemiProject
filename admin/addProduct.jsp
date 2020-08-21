<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(관리자용) 제품 추가</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
  <link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" />

</head>
<body>




<!-- 글쓰기 시작 -->

    <section class="bbs_section layout_padding">
      <div class="container_padding">
      

<div class="write-form">
<h3 class="text-center">제품 추가</h3>
	<form action="../addPro" method="post" enctype="multipart/form-data" name="addForm">
	<div class="form-group">
	 제품명:<input type="text" name="p_name" class="form-control" placeholder="제품명을 입력해주세요" style="text-align:left;">
	</div>
	
	<div class="form-group">
	원단(재료):<input type="text" name="p_material" class="form-control" placeholder="원단(재료)를 입력해주세요" style="text-align:left;">
	</div>
	
	<div class="form-group">
	제조 국가:<input type="text" name="p_madeIn" class="form-control" placeholder="제조 국가를 입력해주세요" style="text-align:left;">
	</div>
	
	<div class="form-group">
	가격:<input type="text" name="price" class="form-control" placeholder="가격을 입력해주세요" style="text-align:left;">
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
	이미지 파일:<input type="file" name="fileload" class="btn_qna" id="fid">
	</div>
	
	<div class="form-group">
	제품 정보 : <textarea name="p_info" class="form-area-bbs" ></textarea>
	</div>
	<div class="form-group">
	<input type="button" value="제품 추가" id="smbtn" class="btn btn-primary btn-lg btn-block">
	<input type="button" value="목록으로 돌아가기" class="btn btn-primary btn-lg btn-block" onclick="backbtn()">
	</div>
	<%-- 
	<ul>
		<li>제품명<br><input type="text" name="p_name"></li>
		<li>원단(재료)<br><input type="text" name="p_material"></li>
		<li>제조 국가<br><input type="text" name="p_madeIn"></li>
		<li>가격<br><input type="number" name="price"></li>
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
		<li>이미지 파일<br><input type="file" name="fileload"></li>
		<li>제품 정보<br><textarea rows="10" cols="100" name="p_info"></textarea></li>
	</ul>
	<input type="submit" value="제품 추가" id="smbtn">
	--%>
	</form>
</div>



</div>
</section>


<!-- 글쓰기 끝 -->




<script type="text/javascript">

/* 카테고리 선택시 펼쳐지는 목록 */
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
function backbtn() {
	location.href="./admin_main.jsp";
}
$("#smbtn").click(function() {
	let pn = $("input[name=p_name]").val();
	let pm = $("input[name=p_material]").val();
	let pi = $("input[name=p_madeIn]").val();
	let pr = $("input[name=price]").val();
	let prnum = pr.search(/[0-9]/g);
	let pb = $("select[name=selbig]").val();
	let ps = $("select[name=selsmall]").val();
	let pf = $("textarea[name=p_info]").val();
	let fn = $("#fid").val();
	
	if(pn==null || pn.trim()==""){
		alert("제품명을 입력해주세요");
	}else if(pm==null|| pm.trim()==""){
		alert("원단(재료)를 입력해주세요");
	}else if(pi==null|| pi.trim()==""){
		alert("제조 국가를 입력해주세요");
	}else if(pr==null || pr.trim()==""){
		alert("가격을 입력해주세요");
	}else if(prnum<0){
		alert("가격은 숫자만 입력해주시기 바랍니다");
	}else if(pb.trim()=="대분류" || ps.trim()=="소분류"){
		alert("카테고리 분류를 선택해주시기 바랍니다");
	}else if(pf.trim()=="" || pf==null){
		alert("상품 정보를 입력해주시기 바랍니다");	
	}else if(fn==""||fn==null){
		alert("상품 이미지를 선택해주세요");
	}else{
		document.addForm.submit();
	}
	
});

</script>

</body>
</html>