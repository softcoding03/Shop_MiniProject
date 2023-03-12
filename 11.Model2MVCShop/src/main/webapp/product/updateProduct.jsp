<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

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
    </style>
<script type="text/javascript">

$(function() {
	
	$("button:contains('확인')").on("click",function(){
		alert("확인 버튼클릭");
		self.location ="/product/listProduct?menu=manage";
	});
	
	$('#button').on("click" , function() {
		//Debug..
		alert($('#name').val().trim());
		
		var prodName = $('#name').val().trim();
		
		$.ajax({
			
			url:"/product/json/getFileName/"+prodName,
			method: "GET",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			
			success : function(JSONData, status) {
				
				alert(JSONData.fileName);
				console.info(status);
		
				console.info(JSONData.fileName);
				
				var displayImage ="<br>"
								+"<img src=\"/images/uploadFiles/"
								+JSONData.fileName+"\"/>";
										
				console.log(displayImage);
				
				$('#button').remove();
				$('#a').append(displayImage);
			}

		});

});
});

</script>



<title>굿즈 정보수정완료</title>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">굿즈 정보 수정완료</h3>
	      <!--   <h5 class="text-muted">내 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>-->
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>굿즈 상품 번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		<hr/>
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
			<div id="a" class="col-xs-8 col-md-4">상품 이미지를 보시려면 클릭해주세요.
		      <input type="hidden" id = "name" value="${product.prodName}"/>
		      	<img src="/images/newjeans/bunny2.gif" id="button" width="50">
		      	
		     </div>
		</div>
		
		<hr/>
		
		<div class="row">
			
		  		<div class="col-md-12 text-center ">
		  			<button type="button" class="btn btn-primary">확인</button>
		  		</div>
		  	
		</div>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</body>
</html>