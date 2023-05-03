	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<html>
	<head>
	<title>구매이력조회</title>
	
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
		  
		</style>
	
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	  	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<script type="text/javascript">
	
		function fncGetPurchaseList(currentPage){
			$("#currentPage").val(currentPage)
			$("form").attr("method" ,"POST").attr("action" , "/purchase/listPurchase").submit();
		}
		
		
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
			//환불요청 로직
			$('button').on("click" , function() {
				//admin에게 알람 가야함.
			});
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
	       <h3>구매 목록 조회</h3>
	   </div>
	   
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="center">주문 번호</th>
            <th align="center">상품명</th>
            <th align="center">배송현황</th>
            <th align="center">구매확정</th>
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
				  <td align="center">${ i }</td>
				  <td align="left">${purchase.tranNo}</td>
				  <td align="left">${purchase.purchaseProd.prodName}</td>
				  <td align="left">
				  		<c:set var="code" value="${purchase.tranCode}"/>
			         <c:choose>
			         	<c:when test="${code.trim() eq '1'}"> 구매완료 (배송 전)
			         	</c:when>
			         	<c:when test="${code.trim() eq '2'}"> 배송중
			         	</c:when>
			         	<c:when test="${code.trim() eq '3'}"> 배송완료
			         	</c:when>
			         	<c:otherwise>해당없음</c:otherwise>
			         </c:choose>   
				  </td>
				  <td align="left">
				  		<c:set var="b" value="${purchase.tranCode}"/>
							<c:if test="${b.trim() eq '3'}">
								구매가 확정 되었습니다.
							</c:if>
							<c:if test="${b.trim() eq '2'}">
								<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">상품 도착(구매확정)</a>
							</c:if>
							<c:if test="${b.trim() eq '1'}">
								<button type="button" id="refund" class="btn btn-danger">환불 요청(구매취소)</button>
							</c:if>
							
				  </td>
				</tr>
	         </c:forEach>
	        	 
			  </form>	  
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp">
		<jsp:param name="id" value="purchase" />
	</jsp:include>
	<!-- PageNavigation End... -->
	
</body>
</html>
