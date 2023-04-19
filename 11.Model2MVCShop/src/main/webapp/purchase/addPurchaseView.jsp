<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%-- AddPurchaseViewAction���� product(prodNo�� ��ġ�ϴ� ������), user(userId�� ��ġ�ϴ� ������) set�ص� --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>���� ���</title>
		<meta charset="EUC-KR">
		
		<!-- ���� : http://getbootstrap.com/css/   ���� -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
   
   <!--  ���� �ּ� api -->
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	
	<!-- Datepicker CDN -->
	<style>
        body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        } 
        
        body {
           padding-top : 50px;
      	}
    </style>
	
	
	<script type="text/javascript">
	
	$(function() {
		
		//���� �ּ� api ���
		$('#bt3').on("click" , function() {
			new daum.Postcode({
		        oncomplete: function(data) {
		            
		        	var addr = ''; // �ּ� ����

	                //����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
	                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
	                    addr = data.roadAddress;
	                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
	                    addr = data.jibunAddress;
	                }
		        	
		        	console.log(addr);
		        	
	                $("#addr1").val(addr);
	                
	                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
	                $('#addr2').focus();
		        }
		 	}).open();
		});
		
		
		//�⺻ user.addr �� �ٷ� �־��ֱ�
		$('#bt4').on("click", function() {
			$('#addr1').val('${user.addr}');
		})
	
	
	})
	

 		const IMP = window.IMP; // ���� ����
 		IMP.init("imp13567041"); // ��: imp00000000a
 		
 		var UID = new Date().getTime().toString(20);
		
 		console.log(UID);
 		
 		
 		function requestPay() {
 			console.log("pay����")
 			
 		    IMP.request_pay({
 		      pg: "html5_inicis",
 		      pay_method: "card",
 		      merchant_uid: UID,   // �ֹ���ȣ
 		      name: "${product.prodName}",
 		      amount: "${product.price}",
 		      buyer_email: "${user.email}",
 		      buyer_name: "${user.userName}",
 		      buyer_tel: "${user.phone}",
 		      buyer_addr: "addr"
 		    },
 		    
 		    function (rsp) { // callback
 		      if (rsp.success) {
 		    	 $.ajax({
 		    		 
 		    		url: "/purchase/json/", 
 		            method: "POST",
 		            headers: { "Content-Type": "application/json" },
 		            data: {
 		             	imp_uid: rsp.imp_uid,            // ���� ������ȣ
 		             	merchant_uid: rsp.merchant_uid   // �ֹ���ȣ
 		            }
 		    		 
 		    	 }).done(
	    			alert("���������Դϴ�.");
	 		        fncAddPurchase();	 
 		    	 )   	  
 		        
 		      } else {
 		    	 alert("������ �����Ͽ����ϴ�. ���� ����: " + rsp.error_msg);
 		      }
 		    });
 			console.log("pay��")
 		} 

	$(function() {
		
		$('#bt1').on("click" , function() {
			requestPay();
		});
	});	
	
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$('#bt2').on("click" , function() {
			$("form")[0].reset();
		});
	});	
	
	
 	function fncAddPurchase() {
	$("form").attr("method" ,"POST").attr("action" , "addPurchase?prodNo=${product.prodNo}&userId=${user.userId}").submit();
	} 
	
 	
 	var price = ${product.price}; 
 	price = Number(price).toLocaleString();	
 	
 	$(document).ready(function() {
		var good = $('#prodprice');
		good.html(price+'��');
	 	console.log(price);
	 	//$('#price').val(price);
 	})
 	
 	
</script>
</head>


<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
		<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">�ֹ�/����</h1>
		
		
<div class="product_area">
    
    <table cellspacing="0" class="tb_products">
	    
	    <colgroup>
	        <col width="300">
	        <col width="220">
	        <col width="220">
	        <col width="120">
	        <col width="110">
	        <col>
	    </colgroup>
	    <thead class="point_plus">
	    <tr>
	    <th scope="col"></th>
		<th scope="col">��ǰ��</th>
		<th scope="col">��ǰ������</th>
	    <th scope="col">��ۺ�</th>
	    <th scope="col">����</th>
	    
	    <th scope="col" class="col_price">��ǰ�ݾ�</th>
	    </tr>
	    </thead>
	    <tbody>

		<tr >
			<td>
			    <span class="bdr"></span>
			    <div class="product_info">
					<a href="/product/getProduct?prodNo=${product.prodNo}" class="product_thmb" target="_blank" >
	        			<span class="mask"></span><img src="/images/uploadFiles/${product.fileName}" width="240" height="240">
	        		</a>
			        
			    </div>
			</td>
			
			<td rowspan="1">
	            	<span class="deli_fee">[${product.prodName}]</span> 
	        </td>    	
	            	</br></br></br>
	            	
	        <td rowspan="1">    	
	            	<span class="deli_fee">${product.prodDetail}</span>
            </td>
			
			<td rowspan="1">
	            	<span class="deli_fee">����</span>
            </td>

			<td>1��</td>
			
			<td class="col_price">
			    <span id="prodprice" value=""> </span>
			</td>
		</tr>


	    </tbody>
	</table>
</div>
		
		
		
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
			<h2 class="bg-primary text-center">��� ���� �Է�</h2>
		  
<%-- 		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodNo" value="${product.prodNo}" readonly>
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" value="${product.manuDate}" readonly>
		    </div>
		  </div> 
		  
		  
		������� �� �����ھ��̵�� ���� �� �� �ʿ� ����	
		  <div class="form-group">
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="regDate" value="${product.regDate}" readonly>
		    </div>
		  </div> 
		  
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">������ ���̵�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" value="${user.userId}" readonly>
		    </div>
		  </div>
		  
		  
		    ������Ʈ ����� ���̶� �ʿ������ ���̺� Null Point Exception �߹Ƿ� �ϴ� ���α� 
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���� ���</label>
		    <select name="paymentOption"	class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20">
				<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
			</select>
		  </div>
		  --%>
		  
		  	

		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">��۹����� �̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">��۹����� ����ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="addr" class="col-sm-offset-1 col-sm-3 control-label">��۹��� �ּ�</label>
		    <div class="col-sm-6">
		    	<button type="button" class="btn btn-default" id="bt3" role="button">���ο� �ּ� �˻�</button>&nbsp;&nbsp;&nbsp;&nbsp;
		    	<button type="button" class="btn btn-default" id="bt4" role="button">�� �⺻�ּ� �Է�</button>
		    	
		      <input type="text" class="form-control" id="addr1" name="dlvyAddr1" value="">
		      <input type="text" class="form-control" id="addr2" name="dlvyAddr2" value="" placeholder="���ּ� �Է�">
		      <strong class="text-danger">���ο� �ּ� �˻� �� ���ּҸ� �߰� �Է� �ٶ��ϴ�.</strong>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">��ۿ�û����</label>
		    <div class="col-sm-6">
		      <input type="text" class="form-control" id="dlvyRequest" name="dlvyRequest" >
		    </div>
		  </div>
		 
		 
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <!--  <button type="button" id="add" class="btn-primary" >��&nbsp;��</button>-->
		      
		      <a class="btn btn-primary" href="#" id="bt1" role="button">��&nbsp;��</a>
			  <a class="btn btn-primary" href="#" id="bt2" role="button">��&nbsp;��</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
	
	
	
</body>
</html>