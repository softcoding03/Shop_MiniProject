<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>


<title>굿즈상세조회</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
        
        img {
			  height: 300px;
			  object-fit: cover;
		}
    </style>
	
	
	<script type="text/javascript">
		
		//==> 추가된부분 : "수정" "확인"  Event 연결 및 처리
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "button:contains('구매')" ).on("click" , function() {
					self.location = "/product/addPurchase?prodNo=${product.prodNo}"
				});
			
			 $( "button:contains('수정')" ).on("click" , function() {
					alert("수정버튼 클릭");
					self.location = "/product/updateProduct?prodNo=${product.prodNo}"
				});
			 
			 $( "button:contains('이전')" ).on("click" , function() {
				 	history.go(-1);
				});
		});
		
	</script>


</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">굿즈상세조회</h3>
	      <!--   <h5 class="text-muted">내 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>-->
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>굿 즈 명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>굿즈 상세 정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>굿즈 이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<img src="/images/uploadFiles/${product.fileName}"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<c:if test="${user.userId == 'admin'}">	  	
		  		<div class="col-md-12 text-center ">
		  			<button type="button" class="btn btn-primary">수정</button>
		  		</div>
		  	</c:if>
		  	<c:if test="${user.userId != 'admin'} "> <!--추가하기 && ${product.TranCode == '0' }  -->
		  		<div class="col-md-12 text-center ">
		  		<!-- 만약 이미 판매완료된 상품이라면 품절 버튼(클릭못함) 만들기 -->
		  			<button type="button" class="btn btn-primary">구매</button>
		  		</div>
		  	</c:if>	
		  	<c:if test="${user.userId != 'admin'}"> <!--추가하기 && ${product.TranCode != '0' }  -->
		  		<div class="col-md-12 text-center ">
		  			<button type="button" class="btn btn-primary" disabled>품절</button>
		  		</div>
		  	</c:if>	
		  		<div class="col-md-12 text-center ">
		  			<button type="button" class="btn btn-primary">이전</button>
		  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</body>
</html>