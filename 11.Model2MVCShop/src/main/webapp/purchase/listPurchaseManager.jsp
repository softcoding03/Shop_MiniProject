	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<html>
	<head>
	<title>판매 완료 목록</title>
	
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	
		<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
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
		  .ui-autocomplete {
		    max-height: 100px;
		    overflow-y: auto;
		    /* prevent horizontal scrollbar */
		    overflow-x: hidden;
		  }
		  /* IE 6 doesn't support max-height
		   * we use height instead, but this forces the menu to always be this tall
		   */
		  * html .ui-autocomplete {
		    height: 50px;
		  }
		  
		  body {
            padding-top : 50px;
          }
		  .button {
			  display: inline-block;
			  padding: 10px 20px;
			  background-color: #f1f1f1;
			  border: 1px solid #ccc;
			  text-decoration: none;
			  color: #333;
			  font-weight: bold;
			  cursor: pointer;
			}
			
			.button:hover {
			  background-color: #ddd;
			}
		</style>
	
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	  	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<script type="text/javascript">
	
		function fncGetPurchaseList(currentPage){
			$("#currentPage").val(currentPage)
			$("form").attr("method" ,"POST").attr("action" , "/purchase/listPurchaseManager").submit();
		}
		
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetPurchaseList(1);
			});
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
				
		
			//purchase 정보 간략하게 조회 ...
			$('button').on("click",function() {
				var tranNo = $(this).find('#tranNo').val();
				var prodNo = $(this).find('#prodNo').val();
				alert(tranNo +"/"+ prodNo);
				
				$.ajax({
							url:"/purchase/json/getPurchase/"+tranNo+"/"+prodNo ,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(Data, status) {
								console.log(Data);
								$('#p1').html(Data.product.prodName);
								$('#p2').html(Data.purchase.merchantUid);
								$('#p3').html(Data.product.price+"원");
								$('#p4').html(Data.purchase.tranNo);
								$('#img').attr('src', '/images/uploadFiles/'+Data.product.fileName);
							}
				}); 
				fncShow();
			});
			//ajax수행 후 값 태그에 저장해주고 모달창 출력하기 위함
			function fncShow(){
				$('#myModal').on('shown.bs.modal');
			}
			//purchase 정보 간략하게 조회 끝 ///
			
			//배송시작 시 sendSMS
			$('a[name="deliStart"]').on("click", function() {
				alert("SMS API 실행")
				var tranNumber = $(this).find('#tranNo').val();
				var receiverPhone = $(this).find('#receiverPhone').val();
				var receiverName = $(this).find('#receiverName').val();
					$.ajax({				
				    	url: "/purchase/json/sendSMS/"+tranNumber+"/"+receiverPhone+"/"+receiverName,
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
			})
			//배송시작 SMS 끝///
			
			//환불요청시 아임포트 환불 + 환불 메세지 sendSMS
			$('#refund').on("click", function() {
				alert("환불요청 실행")
				var merUid = $('#p2').html();
				var tranNo = $('#p4').html();
					$.ajax({				
				    	url: "/purchase/json/importRefund/"+merUid+"/"+tranNo,
			         method: "GET",
			         dataType : "json",
			         headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(Data, status) {
							alert("결과는?"+status+"&"+Data);
							//SMS 발송 ajax
			 		        $.ajax({				
			 				    	url: "/purchase/json/sendSMS/0/"+Data.receiverPhone+"/"+Data.receiverName,
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
				 		}
				  });
			})
			//환불요청시 아임포트 환불 + 환불 메세지 sendSMS
			
			
		});
	</script>
	</head>
	
<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<div class="page-header text-info">
	       <h3>판매 완료된 상품 목록</h3>
	   </div>

      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">결제번호</th>
            <th align="left">주문번호</th>
            <th align="left">구매자ID</th>
            <th align="left">베송지 주소</th>
            <th align="left">구매 일자</th>
            <th align="left">배송현황</th>
          </tr>
        </thead>
     
		<tbody>
			<form>
			<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			  <c:set var="i" value="0" />
			  <c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${i+1}"/>
				<tr>
				  <td align="center">${purchase.impUid}</td>
				  <td align="left">${purchase.tranNo}</td>
				  <td align="left">${purchase.buyer.userId}</td>
				  <td align="left">${purchase.dlvyAddr}</td>
				  <td align="left">${purchase.orderDate}</td>
				  <td align="left">
				  		<c:set var="code" value="${purchase.tranCode}"/>
				  		<c:set var="r" value="${purchase.refund}"/>
			         <c:choose>
			         	<c:when test="${code.trim() eq '1' and r eq '0'}"> 
			         		판매완료(배송 전)
			         		<a name="deliStart" href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=2">
			                  배송시작
			                  <input type="hidden" id="tranNo" value="${purchase.tranNo}"/> <!-- ajax 위한 값 hidden -->
			                  <input type="hidden" id="receiverPhone" value="${purchase.receiverPhone}"/> <!-- ajax 위한 값 hidden -->
			               	<input type="hidden" id="receiverName" value="${purchase.receiverName}"/> <!-- ajax 위한 값 hidden -->
			               </a>
			         	</c:when>
			         	<c:when test="${code.trim() eq '2' and r eq '0'}"> 배송중
			         	</c:when>
			         	<c:when test="${code.trim() eq '3' and r eq '0'}"> 배송완료 
			         	</c:when>
			         	<c:when test="${r eq '2'}"> 취소완료 
			         	</c:when>
			         	<c:otherwise>
			         		<button type="button" id="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">
								  환불요청
								   <input type="hidden" id="tranNo" value="${purchase.tranNo}"/> <!-- ajax 위한 값 hidden -->
						  			<input type="hidden" id="prodNo" value="${purchase.purchaseProd.prodNo}"/>
								</button>
			         	</c:otherwise>
			         </c:choose>   
				  </td>
				</tr>
	         </c:forEach>
	        	 
			  </form>	  
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
		
	<!-- 상세조회 모달 ///////////////////////////////////////////-->
		<div class="modal fade " id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">결제 정보</h4>
		      </div>
		      <div class="modal-body"> <!-- 바디 시작 -->
			       <div class="product_area">
					    <table cellspacing="0" class="tb_products">
						    <colgroup>
						        <col align="center" width="200">
						        <col align="center" width="130">
						        <col align="center" width="100">
						        <col align="center" width="120">
						        <col align="center" width="100">
						        <col align="center" width="100">
						    </colgroup>
						    <thead class="point_plus">
						    <tr>
							    <th align="center" scope="col"></th>
								 <th align="center" scope="col">상품명</th>
								 <th align="center" scope="col">구매번호</th>
								 <th align="center" scope="col">주문번호ID</th>
							    <th align="center" scope="col">배송비</th>
							    <th align="center" scope="col">수량</th>
							    <th align="center" scope="col" class="col_price">결제금액</th>
						    </tr>
						    </thead>
						    
						    <tbody>
							 <tr >
								<td>
								    <span class="bdr"></span>
								    <div class="product_info">
										<a class="product_thmb" target="_blank" >
						        			<span class="mask"></span><img id="img" src="" width="240" height="240">
						        		</a> 
								    </div>
								</td>
								<td rowspan="1">
						           	<span class="deli_fee" id="p1"></span> 
						      </td>    	
						      </br></br></br>
						      <td rowspan="1">
						           	<span class="deli_fee" id="p4"></span> 
						      </td> 
						      <td rowspan="1">    	
						            <span class="deli_fee" id="p2"></span>
					         </td>
								<td rowspan="1">
						           	<span class="deli_fee">  무료</span>
					         </td>
								<td>1개</td>
								<td class="col_price">
								    	<span id="p3"></span>
								</td>
							</tr>
						   </tbody>	
						</table>
					</div>
		      </div> <!-- 바디 끝 -->
		      <div class="modal-footer">
		        <a href="#" class="button" id="refund">환불 하기</a>
		        <a href="#" class="button" data-dismiss="modal">Close</a>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- 상세조회 모달 끝/////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp">
		<jsp:param name="id" value="purchase" />
	</jsp:include>
	<!-- PageNavigation End... -->
	
</body>
</html>
