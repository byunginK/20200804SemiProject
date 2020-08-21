<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int qna_seq = Integer.parseInt(request.getParameter("qnaseq"));
	int seq = Integer.parseInt(request.getParameter("rpseq"));
	String id= request.getParameter("id");
	String contents = request.getParameter("contents");
	
	//System.out.println("pop up = "+ id +" "+contents+" "+qna_seq+" "+seq);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정</title>
<script type="text/javascript" src ="<%=request.getContextPath() %>/jquery/jquery-3.5.1.min.js"></script>
<style type="text/css">
table{
	border-collapse: collapse;
}
.grp{
	padding-left: 20px;
}
.btn {        
    font-size: 16px;
    font-weight: bold;
	background: gray;
	border: none;
    color: white;
    border-radius: 2px;
    margin-left: 20px;
    
}
 .table-header {
    background-color: #95A5A6;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.03em;
    height: 40px;
    font-size: 16px;
}
.itext{
	/* border: 0.2px solid grey; */
	border:none;
	box-shadow: 0px 0px 2px 0px grey;
}
</style>

</head>
<body>

<div class="grp">
	<table id="tb">
		<col width="150px"><col width="300px">
		<tr class="table-header">
			<th>아이디</th><th>내용</th>
		</tr>
		<tr>
			<td><%=id %></td>
			<td><input type="text" id="upcont" class="itext" value="<%=contents %>"></td>
		</tr>
	</table>
</div>

<input type="button" id="upbtn" value="수정" style="margin-top:50px;" class="btn">

<script type="text/javascript">
$("#upbtn").click(function () {
	let cont = $("#upcont").val();
	
	if(cont.trim()!="" || cont!=null){
	
	 $.ajax({
			url:"../qnacont",
			type:"get", 
			datatype:"text",
			data:"work=updateReply&id=<%=id%>&seq=<%=seq%>&qna_seq=<%=qna_seq%>&contents="+cont, 
			success:function(obj){
				if(!obj.b){
					alert("정상적으로 수정되지 않았습니다");
				}else{
					opener.location.href="../qnacont?work=dmove&id=<%=id%>&seq=<%=qna_seq%>";
					self.close();
				}
						
			},
			error:function(){
				alert("error");
			}
		});	
	}
});
</script>


</body>
</html>