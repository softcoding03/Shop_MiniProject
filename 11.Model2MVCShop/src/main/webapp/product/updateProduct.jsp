<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
	   
	  <!-- jQuery UI toolTip ��� CSS-->
	  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  <!-- jQuery UI toolTip ��� JS-->
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

$(function() {
	
	$("button:contains('Ȯ��')").on("click",function(){
		alert("Ȯ�� ��ưŬ��");
		self.location ="/product/listProduct?menu=manage";
	});
	
	$('#button').on("click" , function() {
		//Debug..
		alert($('#name').val().trim());
		
		var prodNo = $('#name').val().trim();
		
		$.ajax({
			
			url:"/product/json/getFileName/"+prodNo,
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



<title>���� ���������Ϸ�</title>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">���� ���� �����Ϸ�</h3>
	      <!--   <h5 class="text-muted">�� ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>-->
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>���� ��ǰ ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�� �� ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���� �� ����</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���� �̹���</strong></div>
			<div id="a" class="col-xs-8 col-md-4">��ǰ �̹����� ���÷��� Ŭ�����ּ���.
		      <input type="hidden" id = "name" value="${product.prodNo}"/>
		      	<img src="/images/newjeans/bunny2.gif" id="button" width="50">
		      	
		     </div>
		</div>
		
		<hr/>
	
		<div class="row">
			
		  		<div class="col-md-12 text-center ">
		  			<button type="button" class="btn btn-primary">Ȯ��</button>
		  		</div>
		  	
		</div>
		
		<br/>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>
</html>