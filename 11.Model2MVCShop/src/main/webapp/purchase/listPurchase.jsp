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
// 			document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
			//document.detailForm.submit();
			$("form").attr("method" ,"POST").attr("action" , "/purchase/listPurchase?").submit();
		}
		
// 		//구매이력보기를 Admin입장에서 봐야할 때 제작============= userId 에 회원정보보기  Event  처리(Click) =============	
// 		$(function() {
		
// 			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
// 			$( "td:nth-child(2)" ).on("click" , function() {
// 				 self.location ="/product/getProduct?prodNo="+$(this).find("input").val().trim();
// 			});
						
// 			//==> userId LINK Event End User 에게 보일수 있도록 
// 			$( "td:nth-child(2)" ).css("color" , "red");
			
// 		});	
		
		
		
		
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetPurchaseList(1);
			});
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
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
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    
		<!-- table 위쪽 검색 end /////////////////////////////////////-->
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">주문 번호</th>
            <th align="left">상품명</th>
            <th align="left">주문자 이름</th>
            <th align="left">전화 번호</th>
            <th align="left">배송현황</th>
            <th align="left">정보수정</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${i+1}"/>
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : 구매정보 확인">${purchase.tranNo}</td>
			  <td align="left">${purchase.purchaseProd.prodName}</td>
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>
			  <td align="left">
			  	 	<c:if test="${purchase.tranCode == '0'}">
		               판매중
		            </c:if>
		            <c:if test="${purchase.tranCode == '1'}">
		               구매완료(배송 전)  
		               <a href="/purchase/updateTranCodeByProd?prodNo=${purchase.purchaseProd.prodNo}&tranCode=2">
		                  배송하기
		               </a>
		            </c:if>
		            <c:if test="${product.tranCode == '2'}">
		               배송중
		            </c:if>
		            <c:if test="${product.tranCode == '3'}">
		               배송완료
		            </c:if>
			  </td>
			  <td align="left">
			  		<c:set var="b" value="${purchase.tranCode}" />
					<c:if test="${b=='2'}">
						<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">물건 도착</a>
					</c:if>
			  </td>
			</tr>
          </c:forEach>
        
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
