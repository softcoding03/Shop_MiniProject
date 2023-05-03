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
	
	
//다음 주소 api
		var addr = ''; // 주소 변수
		
		$(function() {
			$('#bt3').on("click" , function() {
				new daum.Postcode({
			   	oncomplete: function(data) {
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
//다음 주소 api 끝


//아임포트 + NAVER SENS

		// Naver SENS 변수
		var n = '${user.phone}';
	   var p1 = n.substr(0,3);
	   var p2 = n.substr(4,4);
	   var p3 = n.substr(9,4);
	   var phoneNumber = p1 + p2 + p3; //SENS APi 요청시 필요한 유저 전화번호는 -제외하고 숫자만 들어가야함.	
		
	   //아임포트 변수
		var UID = new Date().getTime().toString(20)+${product.prodNo}; //유니크한 값 + 제품 번호
 		console.log(UID);
		
 		const IMP = window.IMP; 
 		IMP.init("imp13567041"); 
 		
 		function requestPay() {
 		   console.log("pay시작");
 		   
 		   var finaladdr = $('#addr1').val()+" "+$('#addr2').val()
	 		var finalPhone = $('#receiverPhone').val();
	 		var finalName = $('#receiverName').val();
	 		alert(finaladdr+"&"+finalPhone+"&"+finalName)
 		   
 		   IMP.request_pay({  // 요청객체
	 		      pg: "html5_inicis",
	 		      merchant_uid: UID,   // 주문번호
	 		      name: "${product.prodName}",
	 		      amount: "${product.price}",
	 		      buyer_email: "${user.email}",
	 		      buyer_name: finalName, //고객이 입력한 이름
	 		      buyer_tel:  finalPhone, //고객이 입력한 번호
	 		      buyer_addr: finaladdr //고객이 입력한 주소 
 		   },
	 		   function (rsp) { // callback객체
	 		      if (rsp.success) {	// 결제 성공 시 로지
	 		    	  console.log(rsp);
	 		    	  console.log(rsp.imp_uid);
	 		    	  console.log(rsp.merchant_uid);
	 		    	  $('#impUid').val(rsp.imp_uid);			//controller의 purchase객체에 imp,mer의 uid값 넘겨주기위함.
	 		    	  $('#merchantUid').val(rsp.merchant_uid);
	 		    	  
		    	     $.ajax({				// 결제 후 검증 로직
		 		    		url: "/purchase/json/price/"+rsp.merchant_uid+"/"+rsp.paid_amount,
	 		            method: "GET",
	 		            dataType : "text",
	 		            headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
							},
							success : function(Data, status) {
								
								if (Data == "검증성공") {
									  alert("결제성공입니다.");
					 		        fncAddPurchase(); //db 저장할 때 결제번호라든지 결제 정보도 추가 저장해주기 (컬럼만들고)
		
					 		        //SMS 발송 ajax
					 		        $.ajax({				
					 				    	url: "/purchase/json/sendSMS/"+rsp.merchant_uid+"/"+finalPhone+"/"+finalName,
					 			         method: "GET",
					 			         dataType : "text",
					 			         headers : {
					 							"Accept" : "application/json",
					 							"Content-Type" : "application/json"
					 						},
					 						success : function(Data, status) {
					 							alert("결과는?"+status);
					 				 		}
					 				  });
								} else {
								  alert("결제 실패 : 가격이 위조 되었습니다.");
								}
							}
	 		    	 }) //결제 후 검증 끝
	 		      } else {
		 		    	alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
		 		   }
	 		    });
 		} 
//아임포트 + NAVER SENS 끝


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
	
 	
 //가격 서식 변경하는 코드	
 	var price = ${product.price}; 
 	price = Number(price).toLocaleString();	 //30000 -> 30,000
 	
 	//$(document).ready(function() {
	$(function() { //동일한 코드
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
		    	<strong class="text-danger">번호 입력 시 '-'를 포함하여 입력해주세요.</strong>
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
		 <!-- controller에 값 넘겨주기위한 hidden -->
		 <input type="hidden" id="impUid" name="impUid" value=""/>
		 <input type="hidden" id="merchantUid" name="merchantUid" value=""/>
		 		  
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