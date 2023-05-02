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
			$('button').on("click" , function() {
				alert("Ȯ�� Ŭ��");
				self.location = "/product/listProduct?menu=search"
			});
		});
		
		
	
	//�ڷΰ��� ���� ����(���ΰ�ħ�� redirect�� �ذ�)
		history.pushState(null, null, document.URL);
		
		window.addEventListener('popstate', function () {
			
			    history.pushState(null, null, document.URL);
			    alert("�ڷΰ��Ⱑ ������ �������Դϴ�. ��ǰ��Ϻ���� �̵��մϴ�.")
			    self.location = "/product/listProduct?menu=search";
		});

		
	</script>

</head>

<body>
<jsp:include page="/layout/toolbar.jsp" />


<div class="container">
	
		<h2 class="bg-primary text-center" style="background-color:#FDCEE2;">���� ���� �Ϸ�</h2>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
				<div> 
				${purchase}
				</div>
	 		  
	 		  <div class="form-group">
			    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">�ֹ� ��ȣ</label>
			    <div class="col-sm-4">
			      <div>${purchase.tranNo}</div>
			    </div>
			  </div>
	 		  
			  <div class="form-group">
			    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">�����</label>
			    <div class="col-sm-4">
			      <div>${purchase.purchaseProd.prodName}</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�����</label>
			    <div class="col-sm-4">
			      <div>${purchase.purchaseProd.price} ��</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">��۹����� �̸�</label>
			    <div class="col-sm-4">
			      <div>${purchase.receiverName}</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">��۹����� ����ó</label>
			    <div class="col-sm-4">
			      <div>${purchase.receiverPhone}</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="dlvyAddr" class="col-sm-offset-1 col-sm-3 control-label">��۹��� �ּ�</label>
			    <div class="col-sm-4">
			      <div>${purchase.dlvyAddr}</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">��ۿ�û����</label>
			    <div class="col-sm-4">
			      <div>${purchase.dlvyRequest}</div>
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
</body>
</html>