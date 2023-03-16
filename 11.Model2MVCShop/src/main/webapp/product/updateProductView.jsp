	<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	
	<html>
	<head>
	<title>굿즈 정보수정</title>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
	  
	  <script src="//code.jquery.com/jquery-1.12.4.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
		
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
		body {
            padding-top : 50px;
        }
        
        img {
  			  max-height: 300px;  
  			  width: 300px; 
  			  object-fit: scale-down; 
		  }
    </style>
	
	<script type="text/javascript">
	
		function fncUpdateProduct(){
			//Form 유효성 검증
// 		 	var name = document.detailForm.prodName.value;
			var name = $("input[name='prodName']").val();
// 			var detail = document.detailForm.prodDetail.value;
			var detail = $("input[name='prodDetail']").val();
// 			var manuDate = document.detailForm.manuDate.value;
			var manuDate = $("input[name='manuDate']").val();
// 			var price = document.detailForm.price.value;
			var price = $("input[name='price']").val();
			
			if(name == null || name.length<1){
				alert("굿즈명은 반드시 입력하여야 합니다.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("상품상세정보는 반드시 입력하여야 합니다.");
				return;
			}
			if(manuDate == null || manuDate.length<1){
				alert("제조일자는 반드시 입력하셔야 합니다.");
				return;
			}
			if(price == null || price.length<1){
				alert("가격은 반드시 입력하셔야 합니다.");
				return;
			}
		
			//document.detailForm.action='/updateProduct.do?prodNo=${product.prodNo}';
// 			document.detailForm.action='/product/updateProduct?prodNo=${product.prodNo}';
//			document.detailForm.submit(); 
			$("form").attr("method" ,"POST").attr("action" , "/product/updateProduct?prodNo=${product.prodNo}").attr("enctype", "multipart/form-data").submit();

			
		}
		
		
		$(function() {
			//============= "수정"  Event 연결 =============
			 $(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "button.btn.btn-primary" ).on("click" , function() {
					fncUpdateProduct();
				});
			});	
			
			
			//============= "취소"  Event 처리 및  연결 =============
			$(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$("a[href='#' ]").on("click" , function() {
					$("form")[0].reset();
				});
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
	
		<div class="page-header text-center">
	       <h3 class=" text-info">굿즈정보수정</h3>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form name="detailForm" class="form-horizontal">
		
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">굿즈명 *</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}" placeholder="변경할 상품명을 입력해주세요.">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">굿즈 상세정보 *</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}" placeholder="변경할 상세정보 입력해주세요.">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자 *</label>
		    <div class="col-sm-4">
		      <input type="date" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}" placeholder="변경할 제조일자를 입력해주세요.">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격 *</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" value="${product.price}" placeholder="변경할 가격을 입력해주세요.">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품 이미지</label>
		    <div class="col-sm-4">
		      <img src="/images/uploadFiles/${product.fileName}"/>
		      <input type="hidden" name="fileName" value="${product.fileName}"/>
		      <br><br><br>
		      	상품 이미지를 변경할 수 있습니다.
		      <input type="file" name="file" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13"/>
		    </div>
		  </div>
		  
		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
			  <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->
 	
</body>


</html>