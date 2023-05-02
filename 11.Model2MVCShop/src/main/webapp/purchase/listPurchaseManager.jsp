	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<html>
	<head>
	<title>�Ǹ� �Ϸ� ���</title>
	
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
		<!-- jQuery UI toolTip ��� CSS-->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<!-- jQuery UI toolTip ��� JS-->
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
		  
		</style>
	
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	  	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<script type="text/javascript">
	
		function fncGetPurchaseList(currentPage){
			$("#currentPage").val(currentPage)
			$("form").attr("method" ,"POST").attr("action" , "/purchase/listPurchaseManager").submit();
		}
		
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetPurchaseList(1);
			});
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
				
		
			//purchase ���� �����ϰ� ��ȸ ...
			$('button').on("click",function() {
				var tranNo = $(this).find('#tranNo').val().trim();
				var prodNo = $(this).find('#prodNo').val().trim();
				//alert(tranNo +"/"+ prodNo);
				
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
								$('#p2').html(Data.product.prodDetail);
								$('#p3').html(Data.product.price+"��");
								$('#img').attr('src', '/images/uploadFiles/'+Data.product.fileName);
							}
				}); 
				fncShow();
			});
			//ajax���� �� �� �±׿� �������ְ� ���â ����ϱ� ����
			function fncShow(){
				$('#myModal').on('shown.bs.modal');
			}
			//purchase ���� �����ϰ� ��ȸ �� ///
			
			//��۽��� �� sendSMS
			$('a[name="deliStart"]').on("click", function() {
				alert("SMS API ����")
				var tranNumber = $(this).find('#tranNo').val().trim();
					$.ajax({				
				    	url: "/purchase/json/sendSMS/"+tranNumber,
			         method: "GET",
			         dataType : "text",
			         headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(Data, status) {
							alert("�����?"+status);
				 		}
				  });
			})
		});
	</script>
	</head>
	
<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<div class="page-header text-info">
	       <h3>�Ǹ� �Ϸ�� ��ǰ ���</h3>
	   </div>

      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">�ֹ� ��ȣ</th>
            <th align="left">������</th>
            <th align="left">������ �ּ�</th>
            <th align="left">���� ����</th>
            <th align="left">�����Ȳ</th>
          </tr>
        </thead>
     
		<tbody>
			<form>
			<!-- PageNavigation ���� ������ ���� ������ �κ� -->
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			  <c:set var="i" value="0" />
			  <c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${i+1}"/>
				<tr>
				  <td align="center">${ i }</td>
				  <td align="left"  title="Click : �������� Ȯ��">
				  		${purchase.tranNo}
						<button type="button" id="button" class="btn btn-info" data-toggle="modal" data-target="#myModal">
						  ����ȸ
						   <input type="hidden" id="tranNo" value="${purchase.tranNo}"/> <!-- ajax ���� �� hidden -->
				  			<input type="hidden" id="prodNo" value="${purchase.purchaseProd.prodNo}"/>
						</button>	
				  </td>
				  <td align="left">${purchase.buyer.userId}</td>
				  <td align="left">${purchase.dlvyAddr}</td>
				  <td align="left">${purchase.orderDate}</td>
				  <td align="left">
				  		<c:set var="code" value="${purchase.tranCode}"/>
			         <c:choose>
			         	<c:when test="${code.trim() eq '1'}"> 
			         		�ǸſϷ�(��� ��)
			         		<a name="deliStart" href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=2">
			                  ��۽���
			                  <input type="hidden" id="tranNo" value="${purchase.tranNo}"/> <!-- ajax ���� �� hidden -->
			               </a>
			         	</c:when>
			         	<c:when test="${code.trim() eq '2'}"> �����
			         	</c:when>
			         	<c:when test="${code.trim() eq '3'}"> ��ۿϷ� 
			         	</c:when>
			         	<c:otherwise>�ش����</c:otherwise>
			         </c:choose>   
				  </td>
				</tr>
	         </c:forEach>
	        	 
			  </form>	  
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
		
	<!-- ����ȸ ��� ///////////////////////////////////////////-->
		<div class="modal fade " id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">��ǰ ������</h4>
		      </div>
		      <div class="modal-body"> <!-- �ٵ� ���� -->
			       <div class="product_area">
					    <table cellspacing="0" class="tb_products">
						    <colgroup>
						        <col width="200">
						        <col width="150">
						        <col width="150">
						        <col width="80">
						        <col width="100">
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
						            <span class="deli_fee" id="p2"></span>
					         </td>
								<td rowspan="1">
						           	<span class="deli_fee">����</span>
					         </td>
								<td>1��</td>
								<td class="col_price">
								    	<span id="p3"></span>
								</td>
							</tr>
						   </tbody>
						</table>
					</div>
		      </div> <!-- �ٵ� �� -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- ����ȸ ��� ��/////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp">
		<jsp:param name="id" value="purchase" />
	</jsp:include>
	<!-- PageNavigation End... -->
	
</body>
</html>
