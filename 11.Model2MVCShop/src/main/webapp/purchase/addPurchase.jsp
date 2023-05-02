<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>


<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
	  

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  	
  	
  	<!-- Bootstrap Dropdown Hover CSS -->
 	 <link href="/css/animate.min.css" rel="stylesheet">
	 <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	   <!-- Bootstrap Dropdown Hover JS -->
	 <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	   
	 <!-- jQuery UI toolTip 사용 CSS-->
	 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	 <!-- jQuery UI toolTip 사용 JS-->
	 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
	
	
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
        
        body {
           padding-top : 50px;
      		 }
      		 
   		img {
  			  max-height: 400px;  
  			  width: 400px; 
  			  object-fit: scale-down; 
		  }
    </style>
	
	<script type="text/javascript">
		$(function() {
			$('button').on("click" , function() {
				alert("확인 클릭");
				self.location = "/product/listProduct?menu=search"
			});
		});
		
		
	
	//뒤로가기 금지 로직(새로고침은 redirect로 해결)
		history.pushState(null, null, document.URL);
		
		window.addEventListener('popstate', function () {
			
			    history.pushState(null, null, document.URL);
			    alert("뒤로가기가 금지된 페이지입니다. 상품목록보기로 이동합니다.")
			    self.location = "/product/listProduct?menu=search";
		});

		
	</script>

</head>

<body>
<jsp:include page="/layout/toolbar.jsp" />


<div class="container">
	
		<h2 class="bg-primary text-center" style="background-color:#FDCEE2;">굿즈 구매 완료</h2>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
				<div> 
				${purchase}
				</div>
	 		  
	 		  <div class="form-group">
			    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">주문 번호</label>
			    <div class="col-sm-4">
			      <div>${purchase.tranNo}</div>
			    </div>
			  </div>
	 		  
			  <div class="form-group">
			    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">굿즈명</label>
			    <div class="col-sm-4">
			      <div>${purchase.purchaseProd.prodName}</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">굿즈가격</label>
			    <div class="col-sm-4">
			      <div>${purchase.purchaseProd.price} 원</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">배송받을분 이름</label>
			    <div class="col-sm-4">
			      <div>${purchase.receiverName}</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">배송받을분 연락처</label>
			    <div class="col-sm-4">
			      <div>${purchase.receiverPhone}</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="dlvyAddr" class="col-sm-offset-1 col-sm-3 control-label">배송받을 주소</label>
			    <div class="col-sm-4">
			      <div>${purchase.dlvyAddr}</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">배송요청사항</label>
			    <div class="col-sm-4">
			      <div>${purchase.dlvyRequest}</div>
			    </div>
			  </div>
	
	
			  <div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" id="golist" class="btn btn-primary" >확&nbsp;인</button>
			    </div>
			  </div>
			  
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
</body>
</html>