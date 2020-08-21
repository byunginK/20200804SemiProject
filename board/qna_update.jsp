<%@page import="dto.blistDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = null; int auth = 3;
	MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
	//MemberDto mem = new MemberDto("a",1);
	if(mem != null || !mem.getId().equals("")){
		id = mem.getId(); auth = mem.getAuth();
	}
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 수정 </title>
<script type="text/javascript" src ="<%=request.getContextPath() %>/jquery/jquery-3.5.1.min.js"></script>
<style type="text/css">
table{
	border-collapse: collapse;
}
h3{
	background-color: #f0f0f0;
	 text-align: center;
}
#tb{
	border : 1px solid grey;
	collapse:collapse;
}
 .table-header {
    background-color: #95A5A6;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.03em;
    height: 40px;
    font-size: 16px;
}
.btn {        
    font-size: 16px;
    font-weight: bold;
	background: gray;
	border: none;
    color: white;
    border-radius: 2px;
    
}
#secret{
	margin-top:30px;
	margin-bottom:30px;
}
.itext{
	/* border: 0.2px solid grey; */
	border:none;
	box-shadow: 0px 0px 2px 0px grey;
}
</style>
</head>
<body>

<h3>Q&A 수정</h3>

<div class="grp" align="center">
<table id="tb">
<col width="100"><col width="400">
	<tr>
	<th class="table-header">제목 </th>
	<td><input type="text" id="title" size="200" class="itext" value="<%=dto.getTitle() %>"></td> 
	</tr>
	<tr>
	<th class="table-header">아이디  </th>
	<td><input type="text" id="id" size="200" value='<%=dto.getId() %>' class="itext" readonly></td> 
	</tr>
	<th class="table-header">구분</th>
	<td>
	<select id="sel" style="width:250px;">
		<option value="1">상품문의</option>
		<option value="2">배송문의</option>
		<option value="3">기타문의</option>
	</select>
	</td> 
	</tr>
	<!-- 상품문의 일 경우 상품 선택 가능할 수 있도록 하기 -->
	<tr>
	<th class="table-header">내용  </th>
	<td>
	<textarea id="contents" class="itext" rows="30" cols="200"><%=dto.getContents() %></textarea>
	</td> 
	</tr>
</table>
</div>


<div class="grp" align="center">
<input type="checkbox" id="secret" style="margin-left:50px;">비밀글로 등록<br>
<input type="button" value="수정" onclick="wclick(<%=dto.getSeq() %>)" style="margin-left:50px;" class="btn">
<input type="button" value="삭제" onclick="dclick(<%=dto.getSeq() %>)" style="margin-left:50px;" class="btn">
</div>

<script type="text/javascript">
$(document).ready(function(){
	let senum = <%=dto.getSecret()%>;
	if(senum==1) $("#secret").attr("checked","checked");

	$("#sel").val('<%=dto.getPart_seq()%>').prop("selected","selcted");
});

function wclick(data) {
	let title = $("#title").val();
	let contents = $("#contents").val();
	let part = $("#sel option:selected").val();
	let secret = $("#secret").prop("checked");
	
	if(title=="" || title==null){
		alert("제목을 입력해주세요");
		$("#title").focus();
	}else if(contents=="" || contents==null){
		alert("내용을 입력해주세요");
		$("#contents").focus();
	}else{
		$.ajax({
			url:"<%=request.getContextPath() %>/qnacont",
			type:"get", 
			datatype:"text",
			data:"work=upQna&seq="+data+"&title="+title+"&contents="+contents+"&part="+part+"&secret="+secret, 
			success:function(obj){
				if(obj.b){
					alert("정상적으로 수정 되었습니다");
					location.href="qnacont?work=dmove&seq="+data+"&id=<%=dto.getId()%>&auth=<%=auth%>";
				}else{
					alert("정상적으로 수정되지 않았습니다");
					window.location.reload;
				}
			},
			error:function(){
				alert("error");
			}
		});	
	}
}
function dclick(data) {
	location.href="./qnacont?work=delQna&seq="+data;
}
</script>


</body>
</html>