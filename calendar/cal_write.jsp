<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
//MemberDto mem = new MemberDto("a",1); 
    if(mem == null || mem.getId().equals("") || mem.getAuth() == 3){
%>
<script type="text/javascript">
    alert("로그인 후 이용 해주시기 바랍니다(관리자용)");
    // 로그인 이동
</script>
<%}
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String date = request.getParameter("date");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>일정 추가</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<script type="text/javascript" src ="<%=request.getContextPath() %>/jquery/jquery-3.5.1.min.js"></script>
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
		/* opacity: 0.95; */
	}
.write-form h2 {
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
.write-form .btn:hover, .write-form .btn:focus .form-area {
	background: #2389cd;
}
</style>
</head>
<body>

<div class="write-form">
<h2 class="text-center">(관리자용)일정 추가</h2>
<form>
<div class="form-group">
날짜 : <p class="form-control"><%=year+"."+month+"."+date%></p>
</div>

<div class="form-group">
내용 : <textarea class="form-area" id="contents" cols="80" rows="40" placeholder="내용을 입력해주세요" style="text-align: left;"></textarea>
</div>
<%-- 
    <table id="wtb">
        <tr>
            <th>날짜</th>
            <td class="form-control">
                <%=year+"."+month+"."+date%>
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <input type="text" id="contents" class="form-control">
            </td>
        </tr>
    </table>
--%>

<div class="form-group">
<input type="button" value="등록" id="wbtn" class="btn btn-primary btn-lg btn-block"><br>
<input type="button" value="목록으로 돌아가기" onclick="backbtn()" class="btn btn-primary btn-lg btn-block">

</div>

</form>
</div>

<script type="text/javascript">
    $("#wbtn").click(function(){
       let cont = $("#contents").val();
       //ajax로 추가하고 성공이면 cal_main.jsp로이동
       if(cont.trim()!=""){
		$.ajax({
			url:"./calcont",
			type:"get", 
			datatype:"text",
			data:"work=addCal&year=<%=year%>&month=<%=month%>&date=<%=date%>&contents="+cont, 
			success:function(obj){
				if(!obj.b){
					alert("정상적으로 수정되지 않았습니다");
				}else{
					location.href="./calendar/cal_main.jsp?year=<%=year%>&month=<%=month%>";
				}
			},
			error:function(){
				alert("error");
			}
		});	 
       }else{
    	   alert("내용을 입력해주시기 바랍니다");
       }
    });

    function backbtn() {
		location.href="<%=request.getContextPath()%>/calendar/cal_main.jsp";
	}
</script>

</body>
</html>