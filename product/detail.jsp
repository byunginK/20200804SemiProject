<%@page import="java.util.HashMap"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>

<%
HashMap map = (HashMap)request.getAttribute("map");
List<ProductDto> list2 = (List<ProductDto>)map.get("listtop");
List<ProductDto> list3 = (List<ProductDto>)map.get("listbottom"); 
List<ProductDto> list4 = (List<ProductDto>)map.get("listshoes");
List<ProductDto> list5 = (List<ProductDto>)map.get("listac");
List<ProductDto> list6 = (List<ProductDto>)map.get("listsell");

System.out.println(list2.get(0).toString());

ProductDto dto = new ProductDto();

%>
<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>Detail</title>


  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <!--slick slider stylesheet -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick-theme.min.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet" />
  <!-- slick slider -->
  <!-- <link rel="stylesheet" href="css/slick-theme.css" /> -->
  <!-- font awesome style -->
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <!-- <link href="css/responsive.css" rel="stylesheet" /> -->

</head>
<body class="sub_page">
<!-- 바디 셋팅 -->
  <div class="main_body_content">
    <div class="hero_area">
    
     <!-- 헤더 -->
      <header class="header_section">
        <div class="container-fluid">
        <!-- 네비게이션 바 -->
          <nav class="navbar navbar-expand-lg custom_nav-container ">
            <a class="navbar-brand" href="index.jsp">
              Simple Five
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
               <span class=""> </span>
            </button>

            <div class="collapse navbar-collapse " id="navbarSupportedContent">
              <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                  <a class="nav-link" href="index.jsp">Main<span class="sr-only"></span></a>
                </li>
                <li class="nav-item">
                 <a class="nav-link" href="addPro?work=list">카테고리</a>
                </li>
                 <li class="nav-item">
                  <a class="nav-link" href="addPro?work=add">제품 추가(임시)</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="CScenter.jsp">고객센터</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="login.jsp">로그인</a>
                </li>
   				<li class="nav-item">
                  <a class="nav-link" href="register.jsp">회원가입</a>
                </li>
              </ul>
            </div>
          </nav>
        </div>
      </header>
      <!-- 헤더 끝 -->
    </div>





    <!-- Best Product 5개 -->
    <section class="chocolate_section ">
      <div class="container">
        <div class="heading_container">
          <h2><br><br>
            Weekly Best Item(판매량순)
          </h2>
        </div>
      </div>
      <div class="container">
        <div class="chocolate_container">
        
        <%
          for(int i = 0; i < list6.size(); i++){
        	  dto = list6.get(i);
        	  %>
        	  <div class="box">
              <div class="img-box">
                <a href="productDetail?work=product&seq=<%=dto.getSeq()%>"><img src="productimg/<%=dto.getFilename() %>" alt=""></a>
              </div>
              <div class="detail-box">
                <h6>
                 <span><%=dto.getP_name() %></span>
                </h6>
                <h5>
                  <%=dto.getP_price() %>
                </h5>
              </div>
            </div>
            <%
          }
          %>
          
         
          
        </div>
      </div>
    </section>
    <!-- Best 끝 -->
            
            
            
            
            
              
<!-- 카테고리별 디테일 -->
     
<!-- 상의 -->
	<section class="category_section">
		<div class="container">
		          <div class="row some-cards">
		          
		             <div class="container">
		       			<div class="heading_container">
		          			<h2>
			           			Top & Outer
		          			</h2>
		        		</div>
		      		 </div>
			      		
			      	<%
			      	
			      	for(int i = 0; i < list2.size(); i++){
			      		dto = list2.get(i);
			      		%>
			      		
			      	 <div class="box" style="box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.3);">
		                <a href="productDetail?work=product&seq=<%=dto.getSeq()%>">
	           				<div class="img-box">
		                       	<img src="productimg/<%=dto.getFilename() %>" alt="">
		                    </div>
		                 </a>
		                 	<%=dto.getP_price() %>원<br><%=dto.getP_name() %>
		             </div>
		             <span id="dp"></span>
			      		<%
			      	}
			      	%>	
			      	
	        	</div>
	        	<!-- <div align="center" id="dp">
		             <button type="button" onclick="display(1)" style="background: none; border: none; outline: none;">◀</button>
		             <button type="button" onclick="display(2)"  style="background: none; border: none; outline: none;">▶</button>
		            </div> -->
		            
		            
		            
			</div> 
	</section> 
	
<!-- 상의 끝 -->
	
	
	
	
<!-- 하의 -->
	<section class="category_section">
		<div class="container">
		          <div class="row some-cards">
		          
		             <div class="container">
		       			<div class="heading_container">
		          			<h2>
			           			Pants & Skirts
		          			</h2>
		        		</div>
		      		 </div>
			      		
		            <%
			      	
			      	for(int i = 0; i < list3.size(); i++){
			      		dto = list3.get(i);
			      		%>
			      	 <div class="box" style="box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.3);">
		                <a href="productDetail?work=product&seq=<%=dto.getSeq()%>">
	           				<div class="img-box">
		                       	<img src="productimg/<%=dto.getFilename() %>" alt="">
		                    </div>
		                 </a>
		                 	<%=dto.getP_price() %>원<br><%=dto.getP_name() %>
		             </div>
			      		<%
			      	}
			      	%>	
		               
		             
	        	</div>
	        	<!-- <div align="center">
		             <button type="button" onclick="display(3)" style="background: none; border: none; outline: none;">◀</button>
		             <button type="button" onclick="display(4)" id="dp" style="background: none; border: none; outline: none;">▶</button>
		            </div> -->
			</div> 
	</section>
<!-- 하의 끝 -->	
	
	
	
	
	
<!-- 신발 -->
	<section class="category_section">
		<div class="container">
		          <div class="row some-cards">
		          
		             <div class="container">
		       			<div class="heading_container">
		          			<h2>
			           			Shoes
		          			</h2>
		        		</div>
		      		 </div>
			      		
			      		
		           <%
			      	
			      	for(int i = 0; i < list4.size(); i++){
			      		dto = list4.get(i);
			      		%>
			      	 <div class="box" style="box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.3);">
		                <a href="productDetail?work=product&seq=<%=dto.getSeq()%>">
	           				<div class="img-box">
		                       	<img src="productimg/<%=dto.getFilename() %>" alt="">
		                    </div>
		                 </a>
		                 	<%=dto.getP_price() %>원<br><%=dto.getP_name() %>
		             </div>
			      		<%
			      	}
			      	%>	
		             
		             
	        	</div>
	        <!-- 	<div align="center">
		             <button type="button" onclick="display(5)" style="background: none; border: none; outline: none;">◀</button>
		             <button type="button" onclick="display(6)" id="dp" style="background: none; border: none; outline: none;">▶</button>
		            </div> -->
			</div> 
	</section>
<!-- 신발 끝 -->	
	
	
	
	
	
	


<!-- 악세서리 -->
	<section class="category_section">
		<div class="container">
		          <div class="row some-cards">
		          
		             <div class="container">
		       			<div class="heading_container">
		          			<h2>
			           			Accesary
		          			</h2>
		        		</div>
		      		 </div>
			      		
			      		
		            <%
			      	
			      	for(int i = 0; i < list5.size(); i++){
			      		dto = list5.get(i);
			      		%>
			      	 <div class="box" style="box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.3);">
		                <a href="productDetail?work=product&seq=<%=dto.getSeq()%>">
	           				<div class="img-box">
		                       	<img src="productimg/<%=dto.getFilename() %>" alt="">
		                    </div>
		                 </a>
		                 	<%=dto.getP_price() %>원<br><%=dto.getP_name() %>
		             </div>
			      		<%
			      	}
			      	%>	
		             
		             
		             
	        	</div>
	        	<!-- <div align="center">
		             <button type="button" onclick="display(7)" style="background: none; border: none; outline: none;">◀</button>
		             <button type="button" onclick="display(8)" id="dp" style="background: none; border: none; outline: none;">▶</button>
		            </div> -->
			</div> 
	</section>
<!-- 악세서리 끝 -->


	
	
	
	
    
<!-- 디테일 끝 -->

   
 <!-- 바닥글 창 -->
    <section class="info_section layout_padding2">
      <div class="container">
        <div class="row info_main_row">
 			<!-- Menu -->
          <div class="col-md-6 col-lg-3">
            <div class="info_links">
              <h4>
              	Menu
              </h4>
              <div class="info_links_menu">
                <a href="index.jsp">
                  Home
                </a>
                <a href="detail.jsp">
                  	카테고리
                </a>
                <a href="contact.jsp">
                  	고객센터
                </a>
                <a href="login.jsp">
                  	로그인
                </a>
                <a href="register.jsp">
                  	회원가입
                </a>
              </div>
            </div>
          </div>

<!-- 회사 -->          
          <div class="col-md-6 col-lg-3">
            <div class="info_detail">
              <h4>
                Company
              </h4>
              <p>
              	(주)Simple Five<br>대표자: 오조<br><br>
              	사업자 등록번호:520-02-55555<br>
              <!-- 	통신판매업 등록번호 : <br> -->
              	서울특별시 강남구 테헤란로<br> 64번길2 서영빌딩1층
              </p>
            </div>
          </div>
<!-- 고객센터 -->
          <div class="col-md-6 col-lg-3">
            <div class="info_detail">
              <h4>
                CS Center
              </h4>
              <p>
              	이용약관<br>
              	개인정보 취급방침<br>
              	Q & A
              </p>
            </div>
          </div>
<!-- 연락방법 -->
          <div class="col-md-6 col-lg-3">
            <h4>
              	Contect Us
            </h4>
            <div class="info_contact">
              <a href="">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span>
                  	T. 02-223-5555
                </span>
              </a>
              <a href="">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>
                  M. 010-5555-5555
                </span>
              </a>
              <a href="">
                <i class="fa fa-envelope"></i>
                <span>
                  simplefive@gmail.com
                </span>
              </a>
          	    <span>
                  	평일 : am 09:00 - pm 18:00 <br> 주말 : pm 12:00 - pm 13:00
                </span>
            </div>
          </div>
          <!-- 고객센터 끝 -->
        </div>
      </div>
    </section>
<!-- 바닥글 끝-->

  </div>

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
  <!-- 밑창 끝 -->

  <!-- jQery -->
  <script src="js/jquery-3.4.1.min.js"></script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.js"></script>
  <!-- slick slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
<!-- <script type="text/javascript">
let listNum = 1;
let category = "";
function display(num) {
	if(num==1){
		listNum--;
		category = "top";
		if(listNum < 1){
			listNum = 1;
		}
		
	}else if(num ==2){
		category = "top";
		listNum ++;
	}else if(num ==3){
		listNum--;
		category = "bottom";
		if(listNum < 1){
			listNum = 1;
		}
	}else if(num ==4){
		category = "bottom";
		listNum ++;
	}else if(num ==5){
		listNum--;
		category = "shoes";
		if(listNum < 1){
			listNum = 1;
		}
	}else if(num ==6){
		category = "shoes";
		listNum ++;
	}else if(num ==7){
		listNum--;
		category = "accessary";
		if(listNum < 1){
			listNum = 1;
		}
	}else if(num ==8){
		category = "accessary";
		listNum ++;
	}
		$.ajax({
			url:"addPro",
			type:"get",
			datatype:"json",
			data:"work=display"+"&ln="+listNum+"&category="+category,
			success:function(datas){
				let displayList = datas.map.display;
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

</script> -->
</body>
</html>
