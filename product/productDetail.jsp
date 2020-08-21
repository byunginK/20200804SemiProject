<%@page import="dto.ReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	/* servlet 에서 값 전달 받기 */
ProductDto product = (ProductDto) request.getAttribute("productDetail");
List<ProductDto> prolist = (List<ProductDto>) request.getAttribute("prolist");
List<ReplyDto> list = (List<ReplyDto>) request.getAttribute("list");
String sp = (String) request.getAttribute("startPage");
String ep = (String) request.getAttribute("endPage");
String tp = (String) request.getAttribute("totalPage");
int startPage = Integer.parseInt(sp);
int endPage = Integer.parseInt(ep);
int totalPage = Integer.parseInt(tp);
/* 세션 아이디 */
String id = null;
int auth = 3;
MemberDto login_Dto = null;
if (session.getAttribute("login_Dto") != null) {
	login_Dto = (MemberDto) session.getAttribute("login_Dto");
	id = login_Dto.getId();
	auth = login_Dto.getAuth();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ProductDetail</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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

</head>

<body onload="func()">
	<div class="main_body_content">
		<!-- <div class="hero_area"> -->

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
									href="addPro?work=main">Main<span class="sr-only"></span></a></li>
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











<!-- 제품상세 시작 -->
   <section class="detail_section layout_padding">
      <div class="container_padding">




	<main>
		<div align="center" style="margin-top: 100px" class="heading_detail">

			<!-- DB의 카테고리 값을 이용하여 분류 -->

			<%
				if (product.getP_category().equals("top")) {
			%>
			<h1>Top & Outer</h1>
			<%
				} else if (product.getP_category().equals("bottom")) {
			%>
			<h1>Pants & Skirts</h1>
			<%
				} else if (product.getP_category().equals("shoes")) {
			%>
			<h1>Shoes</h1>
			<%
				} else if (product.getP_category().equals("accessary")) {
			%>
			<h1>Accesary</h1>
			<%
				}
			%>
		</div>
		<hr>
		<div align="center" style="margin-top: 100px">

			<!-- 큰 이미지 -->
<div class="firstbox">
			<div class="img1">
				<img alt="이미지 없음" src="productimg/<%=product.getFilename()%>"
					width="400px" height="545px">
			</div>

			<!-- 상품 이름 -->

			<div class="div1" style="border-bottom: 1px solid lightgray; border-top: 1px solid lightgray;">
			<br>
				<h2><%=product.getP_name()%></h2>
				<%if(product.getP_readcount()>= 1){
				%>
				<p style="color: white; font-size: 13px; background: red; width: 200px"><b>주목 폭주</b></p>
				<%
			}
			 %>
			</div>
			
			<!-- 상품 소개 글 -->

			<div class="div2">

				<!-- 금액, 색상, 사이즈 선택, 수량, 결제금액 표기 테이블 -->
				<form id="selectFrm">
					<input type="hidden" name="seq" value="<%=product.getSeq()%>">
					<input type="hidden" name="work" value="purchasego"> <input
						type="hidden" name="id" value="<%=id%>">
					<table>
						<col width="200px">
						<col width="200px">
						<tr height="50px">
							<td>판매 가격</td>
							<td align="right"><%=product.getP_price()%>원</td>
						</tr>
						<tr height="50px">
							<td>색상</td>
							<td align="right"><select name="color">
									<option>색상 선택</option>
									<option>White</option>
									<option>Black</option>
							</select>
						</tr>
						<%
							if ((product.getP_category().equals("top")) || (product.getP_category().equals("bottom"))) {
						%>
						<tr height="50px">
							<td>사이즈</td>
							<td align="right"><select name="size">
									<option>사이즈 선택</option>
									<option>S</option>
									<option>M</option>
									<option>XL</option>
									<option>XXL</option>
							</select>
						</tr>
						<%
							} else if((product.getP_category().equals("shoes"))){
						%>
						<tr height="50px">
							<td>사이즈</td>
							<td align="right"><select name="size">
									<option>사이즈 선택</option>
									<option>220</option>
									<option>230</option>
									<option>240</option>
									<option>250</option>
									<option>260</option>
									<option>270</option>
									<option>280</option>
							</select>
						</tr>
						<%
							}else{
								%>
								<tr height="50px">
							<td>사이즈</td>
							<td align="right"><select name="size">
									<option>사이즈 선택</option>
									<option>Free</option>
							</select>
						</tr>
								<%
							}
						%>
						<tr height="50px">
							<td>배송 방법 / 배송료</td>
							<td align="right">국내 / 무료</td>
						</tr>
						<tr height="50px" style="border-bottom: 1px solid lightgray;">
							<td>수량 선택</td>
							<td align="right">
							<button type="button" id="min" style="background: none; border: none; outline: none;"><b>-</b></button>
							<input type="text" id="pcount"
								name="buy_count" readonly="readonly" value="1" size="6"
								style="text-align: center; border: none;">
								<button type="button" id="plus" style="background: none; border: none; outline: none;"><b>+</b></button>
								</td>
						</tr>
						<tr height="50px">
							<td>총 결제금액</td>
							<td align="right"><input type="text" id="totalprice"
								name="totalprice" readonly="readonly"
								style="text-align: right; border: none;">
							<td>
						</tr>
					</table>
				</form>
			</div>

			<!-- 구매 버튼 -->

			<div class="div2">
				<button type="button" style="width: 300px; height: 40px; background: #95A5A6; color: white; border: none;"
					id="purchase_btn"><b>구매하기</b></button>
			</div>

			<!-- 장바구니 버튼 -->

			<div class="div3" style="border-bottom: 1px solid lightgray;">
				<button type="button" style="width: 300px; height: 40px; background: #000000; color: white; border: none;"
					id="cart_btn"><b>장바구니</b></button>
			</div>
</div>				
			<!-- 카테고리별 전체 상품 리스트 출력 -->

			<section class="category_section">
				<div class="container">
				<div style="padding: 15px; margin-left: 50px;">
					<div class="row some-cards">
						<button type="button" onclick="display(1)"
							style="background: none; border: none; outline: none;">◀</button>
						<%
							for (int i = 0; i < prolist.size(); i++) {
							ProductDto dto = prolist.get(i);
						%>
						<div class="box">
							<a href="productDetail?work=product&seq=<%=dto.getSeq()%>">
								<div class="img-box">
									<img src="productimg/<%=dto.getFilename()%>" alt="">
								</div>
							</a>
							<%=dto.getP_price()%>원<br><%=dto.getP_name()%>
						</div>
						<%
							}
						%>
						<button type="button" onclick="display(2)" id="dp"
							style="background: none; border: none; outline: none;">▶</button>
					</div>
				  </div>
				</div>
			</section>

			<!-- 버튼을 누르면 해당 내용 표기-->

			<div style="width: 680px; height: 70px; margin-top: 30px; ">
				<ul class="detailInfo">
					<li><button type="button" id="product_d"><b>상품 상세 정보</b></button></li>
					<li><button type="button" id="review"><b>구매 후기</b></button></li>
					<li><button type="button" id="commonInfo"><b>상품 구매 안내</b></button></li>
				</ul>
			</div>
			<div id="product_Detail"
				style="width: 900px; margin-top: 50px; padding: 50px;">

				<!-- 상품의 소개 글 -->

				<div style="width: 400px;">
					<h3>COMMENT</h3>
					<span><%=product.getP_info()%></span>
				</div><br><br>
				<h2>PRODUCT INFO</h2>

				<!-- 작은 이미지 -->

				<div style="width: 200px; height: 300px; margin-top: 50px; box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.3)"  >
					<img alt="이미지 없음" src="productimg/<%=product.getFilename()%>"
						style="position: absolute; width: 200px; height: 300px; margin-left: -100px;">
				</div>

				<!-- 상품 상세 정보 -->

				<div style="margin-top: 50px;">
					<table class="tb2">
						<col width="120px">
						<col width="180px">
						<col width="120px">
						<col width="180px">
						<tr>
							<th>소재</th>
							<td><%=product.getP_material()%></td>
							<th>색상</th>
							<td>상세 참조</td>
						</tr>
						<tr>
							<th>제조국</th>
							<td><%=product.getP_madeIn()%></td>
							<th>제조년월</th>
							<td>판매일 2개월 이내</td>
						</tr>
						<tr>
							<th>품질보증기간</th>
							<td>교환/반품 안내 참조</td>
							<th>A/S[판매처]</th>
							<td>SIMPLE FIVE</td>
						</tr>
					</table>
				</div>
						<%
							if (product.getP_category().equals("top")) {
						%>
						<div style="margin-top: 50px;">
							<img alt="" src="./img/size1.png" width="700px">
						</div>
						<div style="margin-top: 50px;">
							<img alt="" src="./img/info.png" width="700px">
						</div>

						<%
							} else if (product.getP_category().equals("bottom")) {
						%>
						<div style="margin-top: 50px;">
							<img alt="" src="./img/size2.png" width="700px">
						</div >
							<div style="margin-top: 50px;">
							<img alt="" src="./img/info.png" width="700px">
						</div>
						<%
							}else if(product.getP_category().equals("shoes")){
								%>
								<div style="margin-top: 50px;">
									<img alt="" src="./img/size3.png" width="700px">
								</div>
								<%
							}else if(product.getP_category().equals("accessary")){
								%>
								<br><br>
								<h5 style="color: red"><b>Tip</b></h5>
								<ul style="list-style-type: none;">
									<li>① 비닐팩에 하나씩 밀봉하여 보관하시길 권장합니다.	</li>
									<li>② 금속의경우 융원단으로 닦아주면 약간의 변색을 방지 할 수 있습니다.	</li>
									<li>③ 직사광선, 영하권 온도와 같이 온도차가 심한 곳에서는 착용/보관에 유의해 주세요.</li>
									<li>④ 모든 액세서리류 제품은 피부에서 배출되는 땀, 물과 빛의 접촉, 장기간 착용 등 환경에 따른 자연스러운 변색의 요인이 될 수 있으니 착용/보관에 유의해 주세요.</li>
									<li>⑤ 알러지, 아토피 등 민감성 피부의 고객님들께선 구매 시 유의해 주세요.</li>
								</ul>
								<%
							}
						%>

					</div>

					<!-- 리뷰 테이블 -->

					<div id="review_detail"
						style="width: 900px; margin-top: 50px; padding: 50px;">
						<div align="left" style="padding-left : 70px; padding-bottom: 20px;">
						<h4>Review</h4>
						</div>
						<table id="reviewTb"">
							<col width="100px">
							<col width="500px">
							<col width="100px">
							<tr id="tableheader">
								<th colspan="2">Title</th>
								<th>Id</th>
							</tr>
							<%
								if (list.size() == 0 || list == null) {
							%>
							<tr class="rvf">
								<td colspan='3'>작성된 글이 없습니다.</td>
							</tr>

							<%
								} else {
								for (int i = 0; i < list.size(); i++) {
							%>
							<tr class="rvf">
								<td><img src="./img/star.png"></td>
								<td style="padding-left: 20px;"><%=list.get(i).getContents()%></td>
								<td align='center'><%=list.get(i).getId()%></td>
							</tr>
							<%
								}
							}
							%>

						</table>

						<!-- 리뷰 테이블 페이징 -->

						<div class="reviewPage">
							<ul class="paginglist">
								<%
									if (startPage == 1) {
								%>
								<li></li>
								<%
									} else {
								%>
								<li><button type="button" id="p_btn">Previous</button></li>
								<%
									}
								if (endPage > totalPage) {
									endPage = totalPage;
								}
								for (int i = startPage; i <= endPage; i++) {
									if (i == startPage) {
								%>
								<li><span
									style='font-size: 18pt; color: #9d6b53; font-weight: bold;'
									onclick="page(<%=i%>)"><%=i%></span>&nbsp;&nbsp;</li>
								<%
									} else {
								%>
								<li><a onclick="page(<%=i%>)"><%=i%></a>&nbsp;&nbsp;</li>
								<%
									}
								}
								if (totalPage == endPage) {
								%>
								<li></li>
								<%
									} else {
								%>
								<li><button type="button" id="n_btn">Next</button></li>
								<%
									}
								%>
							</ul>
						</div>

						<!-- 리뷰 쓰는 곳 -->

						<div>
							<br>
							<div align="left" style="padding-left : 70px; padding-bottom: 20px;">
							<h6><b>Review 등록</b></h6>
							</div>
							<table>
							<col width="600px">
								<tr>
									<td><textarea rows='3' cols='80' id='revContent'></textarea></td>
									<td><button type='button' id='review_btn'
									style="width: 60px; height: 75px">등록</button></td>
								</tr>
								
							</table>
							
						</div>
					</div>

					<!-- 정책 부분 -->

					<div id="common_Detail"
						style="width: 900px; margin-top: 50px; padding: 50px;">
						<div align="left" style="box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.3); padding: 40px;">
						<h2><b>교환 및 반품안내</b></h2><br>
							<ul>
								<li>상품 택(tag) 제거 또는 개봉으로 상품 가치 훼손 시에는 상품수령 후 7일 이내라도 교환 및
									반품이 불가능합니다.</li>
								<li>저단가 상품, 일부 특가 상품은 고객 변심에 의한 교환, 반품은 고객께서 배송비를 부담하셔야
									합니다. (제품의 하자,배송오류는 제외)</li>
								<li>일부 상품은 신모델 출시, 부품가격 변동 등 제조사 사정으로 가격이 변동될 수 있습니다.</li>
								<li>수입,명품 제품의 경우, 제품 및 본 상품의 박스 훼손, 분실 등으로 인한 상품 가치 훼손 시 교환
									및 반품이 불가능 하오니, 양해 바랍니다.</li>
								<li>일부 특가 상품의 경우, 인수 후에는 제품 하자나 오 배송의 경우를 제외한 고객님의 단순변심에 의한
									교환, 반품이 불가능할 수 있사오니, 각 상품의 상품상세정보를 꼭 참조하십시오.</li>
							</ul>
							<br> <br>
							<ul>
								<li>수령하신 제품의 불량 및 오배송이 확인 된 경우의 교환/반품은 전자상거래법에 의거하여
									배송완료일로부터 7일 이내에만 가능합니다.</li>
								<li>수령일로부터 3일 이내에 고객센터나 게시판으로 교환 및 반품 접수를 신청 부탁드립니다.</li>
								<li>상품 수령 즉시 불량이나 문제가 있을 경우 교환, 환불처리가 가능하지만 사용하시다 생긴 고장은
									A/S처리가 불가능합니다.</li>
								<li>상품을 수령 하신 후 발견하신 불량이나 문제는 즉시 고객센터로 연락하셔서 상담 부탁 드리겠습니다.</li>
								<li>상품불량 및 오배송인 경우 본인이 배송비를 부담하며 본인 의 귀책사유가 아닌것으로 판단 될 경우
									배송비가 청구 될 수 있습니다.</li>
								<li>무료배송으로 받으신 상품의 교환/반품의 경우 왕복택배비용 5,000원을 부담해 주셔야 합니다.</li>
								<li>교환 및 반품 접수 시 구매번호 및 고객님의 회원아이디를 알려 주시면 빠른 처리가 가능합니다.</li>
							</ul>
							
						</div>

						<div>
							<ul>

							</ul>
						</div>
					</div>
				</div>
			</main>

			<!-- 바닥 글 -->

			<div style="margin-top: 50px">
				<section class="info_section layout_padding2">
					<div class="container">
						<div class="row info_main_row">
							<!-- Menu -->
							<div class="col-md-6 col-lg-3">
								<div class="info_links">
									<h4>Menu</h4>
									<div class="info_links_menu">
										<a href="index.jsp"> Home </a> <a href="detail.jsp"> 카테고리
										</a> <a href="contact.jsp"> 고객센터 </a> <a href="login.jsp"> 로그인
										</a> <a href="register.jsp"> 회원가입 </a>
									</div>
								</div>
							</div>

							<!-- 회사 -->
							<div class="col-md-6 col-lg-3">
								<div class="info_detail">
									<h4>Company</h4>
									<p>
										(주)Simple Five<br>대표자: 오조<br> <br> 사업자
										등록번호:520-02-55555<br>
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
									</a> <a href=""> <i class="fa fa-phone" aria-hidden="true"></i>
										<span> M. 010-5555-5555 </span>
									</a> <a href=""> <i class="fa fa-envelope"></i> <span>
											simplefive@gmail.com </span>
									</a> <span> 평일 : am 09:00 - pm 18:00 <br> 주말 : pm 12:00
										- pm 13:00
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
	<!-- </div> -->
</body>
<!--  버튼 기능  -->

<script type="text/javascript">
let listNum = 1;
let count = 1;
/* 첫 화면 제품 상세 정보 만 표기를 위한 함수 */
function func() {
	$("#review_detail").hide();
	$("#common_Detail").hide();
}
/* 제품정보, 리뷰작성, 정책 버튼을 눌렀을때 표현해주는 함수 */
$(function() {
	$("#product_d").click(function() {
		$("#product_Detail").show();
		$("#review_detail").hide();
		$("#common_Detail").hide();
	});
	$("#review").click(function() {
		$("#review_detail").show();
		$("#product_Detail").hide();
		$("#common_Detail").hide();
		
	});
	$("#commonInfo").click(function() {
		$("#common_Detail").show();
		$("#product_Detail").hide();
		$("#review_detail").hide();
	});
	
	$("#product_d").hover(function() {
		$("#product_d").css("color","#2389cd");
		$("#product_d").css("text-decoration","underline");
	},function() {$("#product_d").css("color","#000000"); $("#product_d").css("text-decoration","none");
	});
	$("#review").hover(function() {
		$("#review").css("color","#2389cd");
		$("#review").css("text-decoration","underline");
	},function() {$("#review").css("color","#000000"); $("#review").css("text-decoration","none");
	});
	$("#commonInfo").hover(function() {
		$("#commonInfo").css("color","#2389cd");
		$("#commonInfo").css("text-decoration","underline");
	},function() {$("#commonInfo").css("color","#000000"); $("#commonInfo").css("text-decoration","none");
	});
	
	/* 수량 , 수량에 따른 금액 표기 */
	$("#plus").click(function() {
		count = count + 1;
		$("#pcount").val(count);
		$("#totalprice").val(<%=product.getP_price()%>*$("#pcount").val());
	});
	$("#min").click(function() {
		count = count - 1;
		$("#pcount").val(count);
		if($("#pcount").val()<=0){
			alert("최소 1개 이상 구매 하셔야합니다.");
			$("#pcount").val(1);
		}
		$("#totalprice").val(<%=product.getP_price()%>*$("#pcount").val());
	});
	$("#totalprice").val(<%=product.getP_price()%>*$("#pcount").val());
	
	/* 구매버튼 눌렀을때 값 넘겨주는 함수 */
	$("#purchase_btn").click(function() {
		if($("select[name='color']").val()=="색상 선택"){
			alert("색상을 선택해 주세요");
		}else if($("select[name='size']").val()=="사이즈 선택"){
			alert("사이즈를 선택해 주세요");
		}else{
			$("#selectFrm").attr("action","purchaseCon").submit();
		}
		
	});
	$("#purchase_btn").hover(function() {
		$("#purchase_btn").css("background","#2389cd");
	},function() {$("#purchase_btn").css("background","#95A5A6");
	});
	
	/* 장바구니 버튼 */
	$("#cart_btn").click(function() {
		if($("select[name='color']").val()=="색상 선택"){
			alert("색상을 선택해 주세요");
		}else if($("select[name='size']").val()=="사이즈 선택"){
			alert("사이즈를 선택해 주세요");
		}else{
		$("#selectFrm").attr("action","cartcont?work=purchasego").submit();
		}
	});
	$("#cart_btn").hover(function() {
		$("#cart_btn").css("background","#2389cd");
	},function() {$("#cart_btn").css("background","#000000");
	});
	
	
	/* 리뷰 작성 후 등록 버튼을 누르면 바로 리뷰 목록에 표기 및 페이징 처리 */
	$("#review_btn").click(function() {
		
		<%if (id == null) {%>
			alert("로그인이 필요한 서비스 입니다.");
		<%} else {%>
		
			let content = $("#revContent").val();
			if(content ==""){
				alert('내용을 입력하세요');
			}
			$.ajax({
				url:"productDetail",
				type:"get",
				datatype:"json",
				data:"work=writeReply&seq="+"<%=product.getSeq()%>"+"&contents="+content+"&id="+"<%=id%>" ,
				success:function(datas){
					let writeR = datas.map.writeR;
					let rlist = datas.map.rlist;
					let startPage = parseInt(datas.map.startPage);
					let endPage = parseInt(datas.map.endPage);
					let totalPage = parseInt(datas.map.totalPage);
					
					if(writeR==true){
						alert('등록 되었습니다');
					}
					$(".rvf").remove();
					$.each(rlist,function(i, val){
					let addlist = "";
						addlist = "<tr class='rvf'>"
									+	"<td><img src='./img/star.png'></td>"
									+	"<td style='padding-left: 20px;'>"
									+	val.contents
									+	"</td>"
									+	"<td align='center'>"+val.id+"</td>"
									+ "</tr>"
						
							$("#reviewTb tr").eq(-1).after(addlist);	
					});		
					
					$(".paginglist").remove();
					let addlist2 = "<ul class='paginglist'>";
					if(startPage == 1){
						addlist2 += "<li></li>";
				
					}else{
						addlist2 += "<li><button type='button' id='p_btn'>Previous</button></li>";
					}
					if(endPage>totalPage){
						endPage = totalPage;
					}	
					for(let i = startPage; i <= endPage; i++){
						
						if(i == startPage){
							
							addlist2 += "<li><span style='font-size:18pt; color:#9d6b53; font-weight:bold;' onclick='page("+i+")'>"+i+"</span>&nbsp;&nbsp;</li>";
							
						}else{
							
							addlist2 +=	"<li><a onclick='page("+i+")'>"+i+"</a>&nbsp;&nbsp;</li>";
							
						}
			
					}
						
					if(totalPage == endPage){
									
						addlist2 += "<li></li>";
					
					}else {
							 
						addlist2 += "<li><button type='button' id='n_btn'>Next</button></li>";
							
					}
						
						addlist2 += "</ul>";
						$(".reviewPage").eq(-1).after(addlist2);
						$("#revContent").val("");
									
				},
				error:function(){
					alert("리뷰에 특수문자를 사용할 수 없습니다");
				}
			});
		<%}%>
	});
	
});	
/* 상품 리스트 표기 버튼 */
function display(num) {
	if(num==1){
		listNum--;
		if(listNum < 1){
			listNum = 1;
		}
		
	}else{
		listNum++;
	}
		$.ajax({
			url:"productDetail",
			type:"get",
			datatype:"json",
			data:"work=display&seq="+"<%=product.getSeq()%>"+"&listNum="+listNum,
			success:function(datas){
				let displayList = datas.map.plist;
				if(listNum> displayList.length-1){
					listNum = 0;
				}
				
				$("div").remove(".box");
				for(let i =0; i< displayList.length; i++){
					let display = 
						"<div class='box'>"
					+"<a href='productDetail?work=product&seq="+displayList[i].seq+"'>"
						+"<div class='img-box'>"
							+"<img src='productimg/"+displayList[i].filename+"'>"
						+"</div>"
					+"</a>"
					+ displayList[i].p_price+"원<br>"+displayList[i].p_name
				+"</div>";
					$("#dp").before(display);
				}
				
			},
			error:function(){
				alert('error');
			}
		});
		
	
}
/* 리뷰 페이지 누르면 해당 페이지의 리뷰들 목록에 출력 */
function page(cp) {
	$.ajax({
		url:"productDetail",
		type:"get",
		datatype:"json",
		data:"work=writeReply&seq="+"<%=product.getSeq()%>"+"&pageNum="+cp,
		success:function(datas){
			//alert('success');
			let rlist = datas.map.rlist;
			let cpage = cp;
			let startPage = parseInt(datas.map.startPage);
			let endPage = parseInt(datas.map.endPage);
			let totalPage = parseInt(datas.map.totalPage);
			
			$(".rvf").remove();
			$.each(rlist,function(i, val){
			let addlist = "";
				addlist = "<tr class='rvf'>"
							+	"<td><img src='./img/star.png'></td>"
							+	"<td style='padding-left: 20px;'>"
							+	val.contents
							+	"</td>"
							+	"<td align='center'>"+val.id+"</td>"
							+ "</tr>"
				
					$("#reviewTb tr").eq(-1).after(addlist);	
			});	
			$(".paginglist").remove();
			let addlist2 = "<ul class='paginglist'>";
			if(startPage == 1){
				addlist2 += "<li></li>";
		
			}else if(startPage > 5){
				addlist2 += "<li><button type='button' id='p_btn'>Previous</button></li>";
			}
			if(endPage>totalPage){
				endPage = totalPage;
			}	
			for(let i = startPage; i <= endPage; i++){
				
				if(i == cpage){
					
					addlist2 += "<li><span style='font-size:18pt; color:#9d6b53; font-weight:bold;' onclick='page("+i+")'>"+i+"</span>&nbsp;&nbsp;</li>";
					
				}else{
					
					addlist2 +=	"<li><a onclick='page("+i+")'>"+i+"</a>&nbsp;&nbsp;</li>";
					
				}
	
			}
				
			if(totalPage == endPage){
							
				addlist2 += "<li></li>";
			
			}else {
					 
				addlist2 += "<li><button type='button' id='n_btn'>Next</button></li>";
					
			}
				
				addlist2 += "</ul>";
				$(".reviewPage").eq(-1).after(addlist2);
							
		},
		error:function(){
			alert("error");
		}
	});
}	
/* 리뷰 페이지 숫자 5개 이상이면 previous 버튼 생성 누르면 페이지 수 넘어가는 버튼  */
$(document).on("click", "#p_btn",function() {
	$.ajax({
		url:"productDetail",
		type:"get",
		datatype:"json",
		data:"work=writeReply&seq="+"<%=product.getSeq()%>"+"&contents="+""+"&id="+"<%=id%>"+"&pageNum="+"<%=endPage%>" ,
		success:function(datas){
		//	alert("success");
			let rlist = datas.map.rlist;
			let startPage = parseInt(datas.map.startPage);
			let endPage = parseInt(datas.map.endPage);
			let totalPage = parseInt(datas.map.totalPage);
			let pageNum = parseInt(datas.map.pageNum);
			$(".rvf").remove();
			$.each(rlist,function(i, val){
			let addlist = "";
				addlist = "<tr class='rvf'>"
							+	"<td><img src='./img/star.png'></td>"
							+	"<td style='padding-left: 20px;'>"
							+	val.contents
							+	"</td>"
							+	"<td align='center'>"+val.id+"</td>"
							+ "</tr>"
				
					$("#reviewTb tr").eq(-1).after(addlist);	
			});		
			
			$(".paginglist").remove();
			let addlist2 = "<ul class='paginglist'>";
			if(startPage == 1){
				addlist2 += "<li></li>";
		
			}else if(startPage > 5){
				addlist2 += "<li><button type='button' id='p_btn'>Previous</button></li>";
			}
			if(endPage>totalPage){
				endPage = totalPage;
			}	
			for(let i = startPage; i <= endPage; i++){
				
				if(i == pageNum){
					
					addlist2 += "<li><span style='font-size:18pt; color:#9d6b53; font-weight:bold;' onclick='page("+i+")'>"+i+"</span>&nbsp;&nbsp;</li>";
					
				}else{
					
					addlist2 +=	"<li><a onclick='page("+i+")'>"+i+"</a>&nbsp;&nbsp;</li>";
					
				}
	
			}
				
			if(totalPage == endPage){
							
				addlist2 += "<li></li>";
			
			}else {
					 
				addlist2 += "<li><button type='button' id='n_btn'>Next</button></li>";
					
			}
				
				addlist2 += "</ul>";
				$(".reviewPage").eq(-1).after(addlist2);
				$("#revContent").val("");
		},
		error:function(){
			alert("error");
		}
	});
	
})
/* 리뷰 페이지 숫자 5개 이상이면   next 버튼 생성 누르면 페이지 수 넘어가는 버튼  */
$(document).on("click", "#n_btn",function() {
	$.ajax({
		url:"productDetail",
		type:"get",
		datatype:"json",
		data:"work=writeReply&seq="+"<%=product.getSeq()%>"+"&contents="+""+"&id="+"<%=id%>"+"&pageNum="+"<%=endPage + 1%>" ,
		success:function(datas){
		//	alert("success");
			let rlist = datas.map.rlist;
			let startPage = parseInt(datas.map.startPage);
			let endPage = parseInt(datas.map.endPage);
			let totalPage = parseInt(datas.map.totalPage);
			let pageNum = parseInt(datas.map.pageNum);
			
			$(".rvf").remove();
			$.each(rlist,function(i, val){
			let addlist = "";
				addlist = "<tr class='rvf'>"
							+	"<td><img src='./img/star.png'></td>"
							+	"<td style='padding-left: 20px;'>"
							+	val.contents
							+	"</td>"
							+	"<td align='center'>"+val.id+"</td>"
							+ "</tr>"
				
					$("#reviewTb tr").eq(-1).after(addlist);	
			});		
			
			$(".paginglist").remove();
			let addlist2 = "<ul class='paginglist'>";
			if(startPage == 1){
				addlist2 += "<li></li>";
		
			}else{
				addlist2 += "<li><button type='button' id='p_btn'>Previous</button></li>";
			}
			if(endPage>totalPage){
				endPage = totalPage;
			}	
			for(let i = startPage; i <= endPage; i++){
				
				if(i == pageNum){
					
					addlist2 += "<li><span style='font-size:18pt; color:#9d6b53; font-weight:bold;' onclick='page("+i+")'>"+i+"</span>&nbsp;&nbsp;</li>";
					
				}else{
					if(pageNum == endPage-1){
						break;
					}
					addlist2 +=	"<li><a onclick='page("+i+")'>"+i+"</a>&nbsp;&nbsp;</li>";
					
				}
	
			}
				
			if(totalPage == endPage){
							
				addlist2 += "<li></li>";
			
			}else {
					 
				addlist2 += "<li><button type='button' id='n_btn'>Next</button></li>";
					
			}
				
				addlist2 += "</ul>";
				$(".reviewPage").eq(-1).after(addlist2);
				$("#revContent").val("");
		},
		error:function(){
			alert("error");
		}
	});
	
})
</script>
</body>
</html>