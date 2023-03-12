	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<html>
	<head>
	<title>굿즈 검색</title>
	
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
	
	
		function fncGetProductList(currentPage){
	// 		document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
	// 		document.detailForm.submit();
			$("form").attr("method" ,"POST").attr("action" , "/product/listProduct?menu=search").submit();
		}
		
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetProductList(1);
			});
			
			$( "td:nth-child(6) > i" ).on("click" ,function() {
				//Debug..
						

				alert($(this).find("input").val().trim());
//					self.location ="/product/getProduct?prodNo="+$(this).find("input").val().trim();
				
				var prodNo = $(this).find("input").val().trim();
				$.ajax(
						{
							url:"/product/json/getProduct/"+prodNo ,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status) {
								
								console.log(JSONData.regDateString);
								console.log(JSONData);
								var displayValue = "<h6>" 
														+"상품명 : "+JSONData.prodName+"<br/>"
														+"상품이미지 : "+JSONData.fileName+"<br/>"
														+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
														+"제조일자 : "+JSONData.manuDate+"<br/>"
														+"가격 : "+JSONData.price+"<br/>"
														+"등록일자 : "+JSONData.regDateString+"<br/>"
														+"</h6>";
								$("h6").remove();
								$( "#"+prodNo+"" ).html(displayValue);
							}
						});
			});
			

			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
			
			
			
			$( "#searchKeyword" ).autocomplete({
			      source: function(request, response) {
			    	  
			    	  var searchCondition = $('option:selected').val();
			    	  var searchKeyword = $('#searchKeyword').val();

			    	  console.log($('option:selected').val());
			    	  console.log($('#searchKeyword').val());
			    	  
			    	  $.ajax(
							{
								url:"/product/json/getAll/"+searchCondition+"/"+searchKeyword ,
								method : "GET",
								dataType : "json",
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData, status) {
									console.log(JSONData);
									response(JSONData);				
								}
					   });
			    	}
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
	       <h3>굿즈 목록 조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				        <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				        <option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 end /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >굿즈명</th>
            <th align="left">가격</th>
            <th align="left">등록일</th>
            <th align="left">현재 상태</th>
            <th align="left">간략정보</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${i+1}" />
			<tr>
			  <td align="center">${ i }</td>
		<!--  상품정보 getProduct 들어가서 상품 판매중일대만 구매 버튼 활성화 만들기 -->
			  <td align="left"  title="Click : 상품정보 확인">${product.prodName}</td>
			  
			  <td align="left">${product.price}</td>
			  <td align="left">${product.regDate}</td>
			  <td align="left">
			  	 	<c:if test="${product.proTranCode == '0'}">
		               판매중
		            </c:if>
		            <c:if test="${product.proTranCode != '0'}">
						판매완료
					</c:if>
			  </td>
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodNo}">
			  		<input type="hidden" id="prodNo" value="${product.prodNo}"/>
				</i>	
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
		<jsp:param name="id" value="product" />
	</jsp:include>
	<!-- PageNavigation End... -->
	
</body>

	</html>
