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
				alert("�� �����̷� ����� �Ѿ�ϴ�.");
				self.location = "/purchase/listPurchase"
			});
		});
		
		
// 		function NotReload(){
// 		    if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode == 116) ) {
// 		        event.keyCode = 0;
// 		        event.cancelBubble = true;
// 		        event.returnValue = false;
// 		    alert("���ΰ�ħ�� ������ �������Դϴ�. ��ǰ��Ϻ���� �̵��մϴ�.")
// 		    self.location = "/product/listProduct?menu=search";
		
// 		    } 
// 		}
// 		document.onkeydown = NotReload;
		
		
		
	</script>

</head>

<body>
<jsp:include page="/layout/toolbar.jsp" />


<div class="container">
	
		<h2 class="bg-primary text-center" style="background-color:#FDCEE2;">���� ���� �Ϸ�</h2>
		
		<!-- form Start /////////////////////////////////////-->
		<div>
			���� ���Ű� �Ϸ� �Ǿ����ϴ�. ������ ��ǰ�� ���÷��� '�� ���� �̷� ����'�� Ŭ�����ּ���.
		</div>
		<div>
			<button type="button" id="golist" class="btn btn-primary" >�� ���� �̷� ����</button>
		</div>
		
 	</div>
</body>
</html>