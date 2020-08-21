<%@page import="dto.cartDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
boolean isS = (boolean)request.getAttribute("incart");
String id = null;   if(session.getAttribute("login_Id") != null){ id = (String)session.getAttribute("login_Id"); }
%>   
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if(isS){
	%>
	<script type="text/javascript">
	let result = confirm('장바구니에 담겼습니다.  장바구니 페이지로 이동하시겠습니까?'); 
	if(result){
		location.href = 'cartcont?work=cmove&id='+'<%=id%>';
	} 
	else{
		alert('카테고리 페이지로 이동합니다'); 
		location.href = 'addPro?work=list';
	}
	</script>
	<%
}
%>

</body>
</html>