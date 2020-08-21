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
boolean isS = (boolean)request.getAttribute("insert");
if(isS){
	%>
	<script type="text/javascript">
		alert("등록되었습니다");
		//location.href="addPro?work=list";
		location.href="./admin/admin_main.jsp";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
		alert("등록 실패");
		//location.href="addProduct.jsp";
		location.href="./admin/admin_main.jsp";
	</script>	
	<%
}
%>
</body>
</html>