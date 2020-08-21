<%@page import="dto.MemberDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.cartDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
List<cartDto> cartlist = (List<cartDto>)request.getAttribute("cartlist");
if(cartlist == null){
	cartlist = new ArrayList<cartDto>();
}
ProductDto dto = null;
String color = "";
String size ="";
String count ="";
int buy_count = 0; 
int totalPrice = 0;
String item_seq = "";
if(dto == null){
	dto = new ProductDto();
	dto.setP_name("Simple FIVE");
}

if(cartlist == null || cartlist.size()==0){
	dto = (ProductDto)request.getAttribute("product");
	color = request.getParameter("color");
	size = request.getParameter("size");
	count = request.getParameter("buy_count");
	buy_count = Integer.parseInt(count);
}


String id = null; int auth = 3;
String name = "";
MemberDto login_Dto = null;
if(session.getAttribute("login_Dto") != null){
	   login_Dto = (MemberDto)session.getAttribute("login_Dto");
	   id = login_Dto.getId(); auth = login_Dto.getAuth();
	   name = login_Dto.getName();
} 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- bootstrap core css -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<!--slick slider stylesheet -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick-theme.min.css" />
<!-- font awesome style -->
<link href="css/font-awesome.min.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="css/style.css" rel="stylesheet" />
<!-- 결제 라이브러리 -->
 <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <style type="text/css">
  .pay_section .btn_area{
	width: 200px;
	height: 60px;
	margin-left: 400px;
	
}
  </style>
</head>
<body class="sub_page">
  <div class="main_body_content">
    <div class="hero_area">

			<!-- 헤더 -->
			<header class="header_section">
				<div class="container-fluid">
					<!-- 네비게이션 바 -->
					<nav class="navbar navbar-expand-lg custom_nav-container ">
						<a class="navbar-brand" href="addPro?work=main"> Simple Five </a>
						<button class="navbar-toggler" type="button"
							data-toggle="collapse" data-target="#navbarSupportedContent"
							aria-controls="navbarSupportedContent" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class=""></span>
						</button>
						<div class="collapse navbar-collapse " id="navbarSupportedContent">
							<ul class="navbar-nav ml-auto">
								<li class="nav-item active"><a class="nav-link"
									href="index.jsp">Main<span class="sr-only"></span></a></li>
								<li class="nav-item"><a class="nav-link"
									href="addPro?work=list">카테고리</a></li>
								<!-- 일단 임시로 만들었어요 수정필요  게시판 이동-->
								<li class="nav-item">
									<div class="dropdown">
										<p class="dropdown-p">고객센터</p>
										<div class="dropdown-content">
											<a href="<%=request.getContextPath()%>/board/qna_main.jsp">Q
												& A</a> <a href="infomain?work=move">공지사항</a> <a
												href="suggest?work=suggest&detailwork=suggest_main">건의사항</a>
											<a href="<%=request.getContextPath()%>/calendar/cal_main.jsp">일정확인</a>
										</div>
									</div>
								</li>
								<!-- 게시판 이동 끝 -->

								<!--로그인을 하면 세션에 저장 -> 세션값이 없으면 로그인/회원가입  있으면 마이페이지/로그아웃 -->
								<%
									if (id != null) {
									if (auth == 1) {
								%>
								<li class="nav-item"><a class="nav-link"
									href="<%=request.getContextPath()%>/admin/admin_main.jsp">관리자페이지</a>
								</li>
								<%
									} else {
								%>
								<li class="nav-item"><a class="nav-link"
									href="login?work=MyPage&id=<%=id%>">My Page</a></li>
								<%
									}
								%>
								<li class="nav-item"><a class="nav-link"
									href="login?work=logout">로그아웃</a></li>
								<%
									} else {
								%>
								<li class="nav-item"><a class="nav-link"
									href="<%=request.getContextPath()%>/main/login.jsp">로그인</a></li>
								<li class="nav-item"><a class="nav-link"
									href="<%=request.getContextPath()%>/main/register_agree.jsp">회원가입</a>
								</li>
								<%
									}
								%>
								<!-- 로그인 메뉴 끝  -->
								<li class="nav-item"><a class="nav-link"
									onclick="cookieRemove()">테스트용 쿠키삭제 </a></li>
							</ul>
						</div>
					</nav>
				</div>
			</header>
			<!-- 헤더 끝 -->
			
			
			
			
			
			
			
			
			
<!-- 결제페이지 시작 -->		
<section class="pay_section layout_padding">
   <div class="container_padding">
			
			


<!-- 주문상품 -->
<!-- <main style="margin-left: 200px"> -->
	<div class="h2_padding">
		<h2>주문 상품</h2>
	</div>
	
	<div>
		<table class="pay_table">
		<col width="150px"><col width="300px"><col width="100px"><col width="150px"><col width="150px">
			<tr>
				<th>상품 이미지</th><th>상품정보</th><th>수량</th><th>상품금액</th><th>총 상품금액</th>		
			</tr>		
			<%
			if(cartlist.size()==0 || cartlist==null){
			%>
			<tr>
				<td><img alt="이미지 없음" src="productimg/<%=dto.getFilename()%>"></td>
				<td>
							<%=dto.getP_name() %><br>
							사이즈 : <%=size %> / 색상 : <%=color %>
				</td>
				<td><%=buy_count %>개</td>
				<td><%=dto.getP_price() %></td>
				<td><%=buy_count *dto.getP_price() %></td>
			</tr>
			<%
			item_seq = dto.getSeq()+"";
			totalPrice = buy_count *dto.getP_price();
			count = buy_count+"";
			}else{
			%>
				<%for(int i = 0; i <cartlist.size(); i++){
					cartDto cart = cartlist.get(i);
					%>
					<tr>
						<td><img alt="이미지 없음" src="productimg/<%=cart.getFilename()%>"></td>
						<td>
							<%=cart.getItem_name() %><br>
							사이즈 : <%=cart.getSize() %> / 색상 : <%=cart.getColor() %>
						</td>
						<td><%=cart.getQty() %> 개</td><td><%=cart.getItem_price() %>원</td><td><%=cart.getQty()*cart.getItem_price() %> 원</td>
					</tr>
					<% 	
					totalPrice = totalPrice + (cart.getQty()*cart.getItem_price());
					item_seq = item_seq + cart.getItem_seq()+",";
					count = count+ cart.getQty()+",";
					size = size + cart.getSize()+",";
					color = color + cart.getColor()+",";
					
				}
			}	
			%>
		</table>
	</div>
	
	
	
	
	
	
	
	
	
	
	<!-- 주문자 정보 -->
	<div class="h2_padding">
		<h2>주문자 정보</h2>
	</div>
	<div>
		<table class="payadd_table"> 
		<col width="250px"><col width="450px"><col width="150px">
			<tr>
				<th>주문 하시는분</th><td colspan="2">
				<%
				if(login_Dto != null){
					%>
					<input type="text" size="50" class="form-area" name="recName" value="<%=name%>">
					<%
				}else{
					%>
					<input type="text" size="50" class="form-area" name="recName">
					<%
				}
				%>
				</td>
			</tr>		
			<tr class="pay_tr">
				<th>연락처</th><td colspan="2"><select name="phoNum1" class="form-area-call">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="017">017</option>
									<option value="019">019</option>
								</select>
				
				-
				<%
				if(login_Dto != null)
				%>
				<input type="text" name="phoNum2" maxlength="4" class="form-area-call"> - <input type="text" name="phoNum3" maxlength="4" class="form-area-call"></td>
				
				
			</tr>
			<tr class="pay_tr">
				<th>이메일</th><td><input type="text" id="email1" class="form-area-email"> @ <input type="text" size="10" id="emailaddr" class="form-area-email"></td>
																	<td><select id="selemail" class="form-area-call">
																	<option value="">직접 입력</option>
																	<option value="gmail.com">gmail.com</option>
																	<option value="naver.com">naver.com</option>
																	<option value="daum.net">daum.net</option>
																	<option value="hotmail.com">hotmail.com</option>
																</select></td>
			</tr>
		</table>
	</div>
	
	
	
	
	
	<div class="h2_padding">
		<h2>배송지 정보 입력</h2>
	</div>
	<div>
		<input type="checkbox" name="same" id="_same">주문자와 동일
	</div>
	
	
	<div>
		<table class="payadd_table">
		<col width="150px"><col width="300px"><col width="100px"><col width="150px"><col width="150px">
			<tr class="pay_tr">
				<td colspan="5"><input type="radio" name="sendwhere" value="do" checked="checked">국내배송 <input type="radio" name="sendwhere" value="ov">해외배송</td>
			</tr>		
			<tr class="pay_tr">
				<th>받으시는 분</th><td colspan="4"><input type="text" name="receiveName" class="form-area"></td>				
			</tr>
			<tr class="pay_tr">
				<th>연락처</th><td colspan="4"><select name="phoneNum1" class="form-area-call">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="017">017</option>
									<option value="019">019</option>
								</select>
				
				-<input type="text" name="phoneNum2" maxlength="4" class="form-area-call"> - <input type="text" name="phoneNum3" maxlength="4" class="form-area-call"></td>
			</tr>
			<tr class="pay_tr">
				<th>배송 주소</th>
				<td colspan="4"><input type="text" id="sample4_postcode" placeholder="우편번호" class="form-area-email">
				<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="s_btn"><br>
				<input type="text" id="sample4_roadAddress" placeholder="도로명주소" size="40" class="form-area-address"><br>
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text" id="sample4_detailAddress" placeholder="상세주소" class="form-area-address">
				</td>
			</tr>
			<tr class="pay_tr">
				<th>배송 메세지</th><td colspan=4"><select class="form-area-address">
										<option>배송 메세지를 선택해주세요</option>
										<option>배송 전 미리 연락 바랍니다</option>
										<option>부재시 경비실에 맡겨주세요</option>
										<option>부재시 문앞에 놓아주세요</option>
										<option>택배함에 보관해 주세요</option>
									</select><textarea rows="10" cols="100" class="form-area"></textarea></td>
			</tr>
		</table>
		<p>*주문관련 요청사항은 고객센터 또는 Q&A 게시판을 이용해주세요</p>
	</div>
	<div class="h2_padding">
		<h2>결제 선택</h2>
	</div>
	<div>
		<input type="radio"name="payway" checked="checked" class="pay_way">신용 카드
	</div>
	<div class="h2_padding">
		<h2>주문자 동의</h2>
		<input type="checkbox" name="checkpay">상기 결제정보를 확인하였으며, 구매진행에 동의합니다.
	</div>		
	
<!-- </main> -->
	<div class="btn_area">
		<button type="button" id="p_btn" class="p_btn">결제 하기</button>
	</div>	
	
	
	
	
	
	
	
	
	
	</div>
</section>
	
	<!-- 결제페이지 끝 -->
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- 바닥 글 -->
	<div style="margin-top: 70px">
		<section class="info_section layout_padding2">
			<div class="container">
				<div class="row info_main_row">
					<!-- Menu -->
					<div class="col-md-6 col-lg-3">
						<div class="info_links">
							<h4>Menu</h4>
							<div class="info_links_menu">
								<a href="index.jsp"> Home </a> <a href="detail.jsp"> 카테고리 </a> <a
									href="contact.jsp"> 고객센터 </a> <a href="login.jsp"> 로그인 </a> <a
									href="register.jsp"> 회원가입 </a>
							</div>
						</div>
					</div>

					<!-- 회사 -->
					<div class="col-md-6 col-lg-3">
						<div class="info_detail">
							<h4>Company</h4>
							<p>
								(주)Simple Five<br>대표자: 오조<br>
								<br> 사업자 등록번호:520-02-55555<br>
								<!-- 	통신판매업 등록번호 : <br> -->
								서울특별시 강남구 테헤란로<br> 64번길2 서영빌딩1층
							</p>
						</div>
					</div>
					<!-- 고객센터 -->
					<div class="col-md-6 col-lg-3">
						<div class="info_detail">
							<h4>CS Center</h4>
							<p>
								이용약관<br> 개인정보 취급방침<br> Q&A
							</p>
						</div>
					</div>
					<!-- 고객센터 -->
					<div class="col-md-6 col-lg-3">
						<h4>Contect Us</h4>
						<div class="info_contact">
							<a href=""> <i class="fa fa-map-marker" aria-hidden="true"></i>
								<span> T. 02-223-5555 </span>
							</a> <a href=""> <i class="fa fa-phone" aria-hidden="true"></i> <span>
									M. 010-5555-5555 </span>
							</a> <a href=""> <i class="fa fa-envelope"></i> <span>
									simplefive@gmail.com </span>
							</a> <span> 평일 : am 09:00 - pm 18:00 <br> 주말 : pm 12:00 -
								pm 13:00
							</span>
						</div>
					</div>
					<!-- 고객센터 끝 -->
				</div>
			</div>
		</section>
	</div>
	<!-- 바닥글 끝-->



	<!-- 밑창 -->
	<footer class="container-fluid footer_section">
		<div class="container">
			<div class="col-md-11 col-lg-8 mx-auto">
				<p>
					&copy; <span id="displayYear"></span> (주)심플파이브
				</p>
			</div>
		</div>
	</footer>	
	</div>
	</div>
	</body>	
<script type="text/javascript">

$(document).ready(function() {
	$("#_same").on("click", function() {
		if($("input[name='same']").prop("checked")){
			let name = $("input[name='recName']").val();
			let phNum1 = $("select[name='phoNum1']").val();
			let phNum2 = $("input[name='phoNum2']").val();
			let phNum3 = $("input[name='phoNum3']").val();
			
			$("input[name='receiveName']").val(name);
			$("select[name='phoneNum1']").val(phNum1);
			$("input[name='phoneNum2']").val(phNum2);
			$("input[name='phoneNum3']").val(phNum3);
			
		}else{
			$("input[name='receiveName']").val("");
			$("select[name='phoneNum1']").val("010");
			$("input[name='phoneNum2']").val("");
			$("input[name='phoneNum3']").val("");
		}
	});
	
	$("#p_btn").click(function() {
		if($("input[name='checkpay']").prop("checked")==false){
			alert("(주문자 동의) 확인이 필요 합니다.");
		}else if($("input[name='recName']").val() =="" || $("input[name='phoNum2']").val() =="" ||$("input[name='phoNum3']").val()==""){
			alert("(주문자 정보) 입력이 필요합니다.");
		}else if( $.isNumeric($("input[name='recName']").val())){
			alert("(주문자 정보) 이름이 정확하지 않습니다. 다시 입력해 주십시오");
		}else if(!($.isNumeric($("input[name='phoNum2']").val()) && $.isNumeric($("input[name='phoNum2']").val()))){
			alert("(주문자 정보) 연락처가 정확하지 않습니다. 다시 입력해 주십시오");
		}else if($("#emailaddr").val().indexOf(".") == -1){	
			alert("(주문자 정보) 이메일 주소가 정확하지 않습니다. 다시 입력해 주십시오");
		}else if($("input[name='receiveName']").val()=="" ||$("input[name='phoneNum2']").val()=="" || $("input[name='phoneNum3']").val()==""||
				$("#sample4_postcode").val()==""|| $("#sample4_detailAddress").val()==""){
			alert("배송지 정보를 정확하게 입력해 주십시오");
		}else if($.isNumeric($("input[name='receiveName']").val())){
			alert("(배송지 정보) 이름이 정확하지 않습니다. 다시 입력해 주십시오");
		}else if(!($.isNumeric($("input[name='phoneNum2']").val()) && $.isNumeric($("input[name='phoneNum3']").val()))){
			alert("(배송지 정보) 연락처가 정확하지 않습니다. 다시 입력해 주십시오");
		}else{
			let email = $('#email1').val()+"@"+$('#emailaddr').val()
			let name = $("input[name='recName']").val();
			let phoneNum = $("select[name='phoNum1']").val()+ $("input[name='phoNum2']").val()+$("input[name='phoNum3']").val();
			let addr = $("#sample4_roadAddress").val()+$("#sample4_detailAddress").val();
			let postcode = $("#sample4_postcode").val()
			var IMP = window.IMP; // 생략해도 괜찮습니다.
	  		IMP.init("imp80934065"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
	  		
	  	// IMP.request_pay(param, callback) 호출
	  	 	IMP.request_pay({ // param
	  	    pg: "html5_inicis",
	  	    pay_method: "card",
	  	    merchant_uid: 'merchant_' + new Date().getTime(),
	  	    name: "<%=dto.getP_name()%>",
	  	    amount: "<%=totalPrice %>",
	  	    buyer_email: email,
	  	    buyer_name: name,
	  	    buyer_tel: phoneNum,
	  	    buyer_addr: addr,
	  	    buyer_postcode: postcode
	  	  }, function (rsp) { // callback
	  	    if (rsp.success) {
	  	    	
	  	    		var msg = '결제가 완료되었습니다.';
	  	    		msg += '\n고유ID : ' + rsp.imp_uid;
	  	    		msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	  	    		msg += '\n결제 금액 : ' + rsp.paid_amount;
					var isS = true;
	  	   
	  	    } else {
	  	    	var msg = '결제에 실패하였습니다.';
	  	    	msg += '\n에러내용 : ' + rsp.error_msg;
	  	        var isS = false;
	  	       
	  	    }
	  	  alert(msg);
	  	  if(isS){
	  		location.href="purchaseCon?work=buy&id="+"<%=id%>"+"&seq="+"<%=item_seq%>"+"&size="+"<%=size%>"+"&color="+"<%=color%>"+"&count="+"<%=count%>";
	  	  }
	  	
	  	  });
	  	  
		}
		
	});
	
	$("#selemail").change(function() {
		let email =$("#selemail").val();
		
		$("#emailaddr").val(email);
		$("#emailaddr").attr("readonly","readonly");
	});
		
});


</script>		

<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
               /*  document.getElementById("sample4_jibunAddress").value = data.jibunAddress; */
                
               
            }
        }).open();
    }
</script>

</body>
</html>