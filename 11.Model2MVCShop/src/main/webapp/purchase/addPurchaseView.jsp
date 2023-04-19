<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%-- AddPurchaseViewAction에서 product(prodNo에 일치하는 정보들), user(userId에 일치하는 정보들) set해둠 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>구매 등록</title>
		<meta charset="EUC-KR">
		
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
   
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
   
   <!--  다음 주소 api -->
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
		
		//다음 주소 api 사용
		$('#bt3').on("click" , function() {
			new daum.Postcode({
		        oncomplete: function(data) {
		            
		        	var addr = ''; // 주소 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
		        	
		        	console.log(addr);
		        	
	                $("#addr1").val(addr);
	                
	                // 커서를 상세주소 필드로 이동한다.
	                $('#addr2').focus();
		        }
		 	}).open();
		});
		
		
		//기본 user.addr 값 바로 넣어주기
		$('#bt4').on("click", function() {
			$('#addr1').val('${user.addr}');
		})
	
	
	})
	

 		const IMP = window.IMP; // 생략 가능
 		IMP.init("imp13567041"); // 예: imp00000000a
 		
 		var UID = new Date().getTime().toString(20);
		
 		console.log(UID);
 		
 		
 		function requestPay() {
 			console.log("pay시작")
 			
 		    IMP.request_pay({
 		      pg: "html5_inicis",
 		      pay_method: "card",
 		      merchant_uid: UID,   // 주문번호
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
 		             	imp_uid: rsp.imp_uid,            // 결제 고유번호
 		             	merchant_uid: rsp.merchant_uid   // 주문번호
 		            }
 		    		 
 		    	 }).done(
	    			alert("결제성공입니다.");
	 		        fncAddPurchase();	 
 		    	 )   	  
 		        
 		      } else {
 		    	 alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
 		      }
 		    });
 			console.log("pay끝")
 		} 

	$(function() {
		
		$('#bt1').on("click" , function() {
			requestPay();
		});
	});	
	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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
		good.html(price+'원');
	 	console.log(price);
	 	//$('#price').val(price);
 	})
 	
 	
</script>
</head>


<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
		<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">주문/결제</h1>
		
		
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
		<th scope="col">상품명</th>
		<th scope="col">상품상세정보</th>
	    <th scope="col">배송비</th>
	    <th scope="col">수량</th>
	    
	    <th scope="col" class="col_price">상품금액</th>
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
	            	<span class="deli_fee">무료</span>
            </td>

			<td>1개</td>
			
			<td class="col_price">
			    <span id="prodprice" value=""> </span>
			</td>
		</tr>


	    </tbody>
	</table>
</div>
		
		
		
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
			<h2 class="bg-primary text-center">배송 정보 입력</h2>
		  
<%-- 		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodNo" value="${product.prodNo}" readonly>
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" value="${product.manuDate}" readonly>
		    </div>
		  </div> 
		  
		  
		등록일자 및 구매자아이디는 구매 시 알 필요 없음	
		  <div class="form-group">
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="regDate" value="${product.regDate}" readonly>
		    </div>
		  </div> 
		  
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" value="${user.userId}" readonly>
		    </div>
		  </div>
		  
		  
		    아임포트 사용할 것이라 필요없지만 테이블에 Null Point Exception 뜨므로 일단 놔두기 
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">결제 방법</label>
		    <select name="paymentOption"	class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20">
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			</select>
		  </div>
		  --%>
		  
		  	

		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">배송받을분 이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">배송받을분 연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="addr" class="col-sm-offset-1 col-sm-3 control-label">배송받을 주소</label>
		    <div class="col-sm-6">
		    	<button type="button" class="btn btn-default" id="bt3" role="button">새로운 주소 검색</button>&nbsp;&nbsp;&nbsp;&nbsp;
		    	<button type="button" class="btn btn-default" id="bt4" role="button">내 기본주소 입력</button>
		    	
		      <input type="text" class="form-control" id="addr1" name="dlvyAddr1" value="">
		      <input type="text" class="form-control" id="addr2" name="dlvyAddr2" value="" placeholder="상세주소 입력">
		      <strong class="text-danger">새로운 주소 검색 시 상세주소를 추가 입력 바랍니다.</strong>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">배송요청사항</label>
		    <div class="col-sm-6">
		      <input type="text" class="form-control" id="dlvyRequest" name="dlvyRequest" >
		    </div>
		  </div>
		 
		 
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <!--  <button type="button" id="add" class="btn-primary" >구&nbsp;매</button>-->
		      
		      <a class="btn btn-primary" href="#" id="bt1" role="button">결&nbsp;제</a>
			  <a class="btn btn-primary" href="#" id="bt2" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
	
	
	
</body>
</html>