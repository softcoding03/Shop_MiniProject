	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<html>
	<head>
	<title>�����̷���ȸ</title>
	
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
			$("form").attr("method" ,"POST").attr("action" , "/purchase/listPurchase").submit();
		}
		
		
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
			//ȯ�ҿ�û ���� (��->admin)
			$('button').on("click" , function() {
				var tranNo = $(this).find('#tranNo').val().trim();
				var a = $(this).find('#p');
				$.ajax({
					url:"/purchase/json/refund/"+tranNo ,
					method: "GET",
					dataType : "text",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(Data, status) {
						alert("ȯ�� ��û�� �Ϸ�Ǿ����ϴ�. ȯ���� �Ϸ�Ǹ� ���� ��ȣ�� ���ڰ� �߼۵˴ϴ�.");
						a.html("ȯ�ҿ�û�Ϸ�");
					}
				})
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
		
		<div class="page-header text-info">
	       <h3>���� ��� ��ȸ</h3>
	   </div>
	   
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="center">�ֹ� ��ȣ</th>
            <th align="center">��ǰ��</th>
            <th align="center">�����Ȳ</th>
            <th align="center">����Ȯ��</th>
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
				  <td align="left">${purchase.tranNo}</td>
				  <td align="left">${purchase.purchaseProd.prodName}</td>
				  <td align="left">
				  		<c:set var="code" value="${purchase.tranCode}"/>
				  		<c:set var="r" value="${purchase.refund}"/>
			         <c:choose>
			         	<c:when test="${code.trim() eq '1' and r eq '0'}"> ���ſϷ� (��� ��)
			         	</c:when>
			         	<c:when test="${code.trim() eq '2' and r eq '0'}"> �����
			         	</c:when>
			         	<c:when test="${code.trim() eq '3' and r eq '0'}"> ��ۿϷ�
			         	</c:when>
			         	<c:when test="${r eq '2'}"> 
			         		<div style="color:green;">
			         			ȯ�ҿϷ�
			         		</div>
			         	</c:when>
			         	<c:otherwise>
			    			     	<div style="color:red;">
										ȯ�ҿ�û�Ϸ�
									</div>
			         	</c:otherwise>
			         </c:choose>   
				  </td>
				  <td align="left">
				  		<c:set var="b" value="${purchase.tranCode}"/>
				  		<c:set var="r" value="${purchase.refund}"/>
							<c:if test="${b.trim() eq '3'}">
								���Ű� Ȯ�� �Ǿ����ϴ�.
							</c:if>
							<c:if test="${b.trim() eq '2'}">
								<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">��ǰ ����(����Ȯ��)</a>
							</c:if>
							<c:if test="${b.trim() eq '1' and r.trim() eq '0'}">
									<button type="button" id="refund" class="btn btn-danger">
										<div id="p">ȯ�� ��û(�������)</div>
										<input type="hidden" id="tranNo" value="${purchase.tranNo}"/> <!-- ajax ���� �� hidden -->
									</button>
							</c:if>
							<c:if test="${b.trim() eq '1' and r.trim() eq '1'}">
									<div style="color:red;">
										ȯ�ҿ�û�Ϸ�
									</div>
							</c:if>
							<c:if test="${r.trim() eq '2'}">
									<div style="color:green;">
										ȯ�ҿϷ�
									</div>
							</c:if>
							
				  </td>
				</tr>
	         </c:forEach>
	        	 
			  </form>	  
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp">
		<jsp:param name="id" value="purchase" />
	</jsp:include>
	<!-- PageNavigation End... -->
	
</body>
</html>
