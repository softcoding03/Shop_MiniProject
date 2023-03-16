<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
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
	   
	 <!-- jQuery UI toolTip ��� CSS-->
	 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	 <!-- jQuery UI toolTip ��� JS-->
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
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			$('#golist').on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('Ȯ��')" ).html() );
					self.location = "/product/listProduct?menu=manage"
			});
			
			$( "td.ct_btn01:contains('�߰����')").on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('����')" ).html() );
					self.location = "/product/addProduct"
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

</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
		<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<h2 class="bg-primary text-center" style="background-color:#FDCEE2;">���� ��� �Ϸ�</h2>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
	
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�����</label>
		    <div class="col-sm-4">
		      <div>${product.prodName}</div>
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">���� ������</label>
		    <div class="col-sm-4">
		      <div>${product.prodDetail}</div>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <div>${product.manuDate}</div>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <div>${product.price}</div>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ �̹���</label>
		    <div class="col-sm-4">
		      <div id="a">��ǰ �̹����� ���÷��� Ŭ�����ּ���.
		      <input type="hidden" id = "name" value="${product.prodNo}"/>
		      	<img src="/images/newjeans/bunny2.gif" id="button" width="50">
		      	
		      </div>
		    </div>
		  </div>
		  
		 
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" id="golist" class="btn btn-primary" >Ȯ&nbsp;��</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
	
	
	
</body>
</html>
