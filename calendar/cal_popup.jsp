<%@page import="dto.MemberDto"%>
<%@page import="dto.calendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.calendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto) session.getAttribute("login_Dto");
//MemberDto mem = new MemberDto("a",1);

    if(mem == null || mem.getId().equals("")){
%>
    <script type="text/javascript">
        alert("로그인 후 이용 해주시기 바랍니다");
        // 로그인 이동
    </script>
<%}

    String totdate = (String) request.getParameter("totdate");
    
    //System.out.println("여긴ㄴ = "+totdate.substring(0,4)+ " , "+ totdate.substring(4,6)+" , "+totdate.substring(6));
    String year = totdate.substring(0,4);
    String month = totdate.substring(4,6);
    String date = totdate.substring(6);
    //System.out.println("date = "+date);

    String mon = Integer.parseInt(month) +1 +"" ;
    if(mon.length()<2) mon = "0"+mon;
    
    calendarDao dao = calendarDao.getInstance();
    List<calendarDto> list = dao.getdeAllList(totdate);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 관리 상세 페이지</title>
<script type="text/javascript" src ="<%=request.getContextPath() %>/jquery/jquery-3.5.1.min.js"></script>
<style type="text/css">
.btn {        
    font-size: 16px;
    font-weight: bold;
	background: gray;
	border: none;
    color: white;
    border-radius: 2px;
}
</style>
</head>
<!-- <body onresize="parent.resizeTo(300,300)" onload="parent.resizeTo(300,300)">
 -->
 <body>
<div id="allcontainer">
<table id="tblist" >
<col width="100px"><col width="50px"><col width="100px">
    <tr>
        <% if(mem.getAuth() ==1){ %>
	        <td id="sdate" style="font-align:left; font-weight:950;"><%=mon%>.<%=date%></td>
	        <td style="font-align:right;">&nbsp;&nbsp;
	        <a href="#none" style="text-decoration:none; font-weight:900;" onclick="wmove()">+</a>
	        </td>
        <%}else{%>
        	<td colspan="2" id="sdate" style="font-align:left; font-weight:950;"><%=mon%>.<%=date%></td>
        <%}%>
    </tr>
        <% for(int i=0; i<list.size(); i++){%>
        <tr>
        	<% if(mem.getAuth() ==1){ %>
        <td>
            <input type="text" style="border-right: none; border-left:none; border-top:none;" onchange="plusmap(this)"
                   id="t<%=list.get(i).getSeq()%>" value="<%=list.get(i).getContents()%>">
        </td>
        <td>
            <input type="button" value="삭제" id="b<%=list.get(i).getSeq()%>" onclick="delbtn(this.id)" class="btn">
        </td>
        <%}else{ %>
        <td colspan="2">
            <input type="text" style="border-right: none; border-left:none; border-top:none;" onchange="plusmap(this)"
                   id="t<%=list.get(i).getSeq()%>" value="<%=list.get(i).getContents()%>" readonly>
        </td>
        <%}%>
        </tr>
        <% }%>

</table>
</div>

<%if(mem.getAuth()==1){ %>
<input type="button" value="수정" onclick="upbtn()" style="margin-top:50px;" class="btn">
<%} %>

<p id="test"></p>

<script type="text/javascript">
let upstr = "";
function delbtn(data) {
    data = data.replace("b","");
    $("#test").html(data);
    // 여기에 ajax
    $.ajax({
		url:"../calcont",
		type:"get", 
		datatype:"text",
		data:"work=delCal&seq="+data, 
		success:function(obj){
			if(!obj.b){
				alert("정상적으로 삭제되지 않았습니다");
			}else{
				opener.location.reload();
				self.close();
			}
		},
		error:function(){
			alert("error");
		}
	});	 
}
function plusmap(obj) {
    let k = obj.id.replace("t","");
    let v = obj.value;

    if(upstr ==""){
    	upstr += k+","+v;
    }else{
    	upstr += "/"+k+","+v;
    }
    //$("#test").html(k+", "+v);
}
function upbtn() {

	$.ajax({
			url:"../calcont",
			type:"get", 
			datatype:"text",
			data:{"work":"upCal", "upstr":upstr}, 
			success:function(obj){
				if(!obj.b){
					alert("정상적으로 수정되지 않았습니다");
				}else{
					opener.location.reload();
					self.close();
				}
			},
			error:function(){
				alert("error");
			}
		});
}
function wmove(){	
	opener.location.href="<%=request.getContextPath() %>/calcont?work=wmove&year=<%=year%>&month=<%=month%>&date=<%=date%>";
	self.close();
}
</script>

</body>
</html>