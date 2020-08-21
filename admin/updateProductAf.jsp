<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
boolean update = (boolean)request.getAttribute("updateP");
if(update){
	%>
	<script type="text/javascript">
		alert("수정 되었습니다.");
		//location.href="addPro?work=list";
		location.href ="./admincont?work=proup_moveQnadel&pageNumber=0";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
		alert("수정 실패");
		location.href ="./admincont?work=proup_moveQnadel&pageNumber=0";
		//location.href="addPro?work=list";
	</script>
	<%
}
%>

</body>
</html>