<%@page import="dto.suggestDto"%>
<%@page import="dao.suggestDao"%>
<%@page import="dto.sug_AnswerDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
    <%
        String id = null; int seq = 0;
        List<sug_AnswerDto> list = null;
        if(request.getParameter("id") != null && request.getParameter("seq") == null){
        	id = request.getParameter("id");	
        	 suggestDao dao = suggestDao.getInstance();
              list = dao.getMyAnswerList(id);
        }
        if(request.getParameter("seq") != null && request.getParameter("id") == null){
        	seq = Integer.parseInt(request.getParameter("seq"));
        	suggestDao dao = suggestDao.getInstance();
        	list = dao.getSu_AnswerList(seq);
        }
       
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
if(list.size()==0){
	%>
	<div align="center" style="margin-top: 200px"><span style="color: #ffa36c">작성한 댓글이 없습니다</span></div>
<%}else{
for(int i = 0; i<list.size(); i++ ){
    sug_AnswerDto a_dto = list.get(i);
    if(a_dto.getDel() == 0){
%>
<div style="background-color: #99CCCC; font-size: 13px" ><a>(<%=a_dto.getAnswer_Wdate() %>)</a></div>
 <div><a href='#' id="a_delete" style="float: right;">삭제</a></div>
<div style="background-color: #f7f2e7; height: 45px"><span><%=a_dto.getContent() %></span></div>
    	
        
        <input type="hidden" name="a_seq" value="<%=a_dto.getAnswer_Seq()%>"><input type="hidden" class="s_seq" value="<%=a_dto.getSuggest_Seq()%>">
<%
    }else{%>
    <div style="background-color: #99CCCC"><a>(<%=a_dto.getAnswer_Wdate() %>)</a></div>
				   <div style="background-color: #f7f2e7; height: 45px"><a>삭제된 댓글입니다</a></div>    	
  <%   }
}
}
%>
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




</body>
</html>