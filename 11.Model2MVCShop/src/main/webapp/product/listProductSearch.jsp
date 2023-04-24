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
		  
		  img {
  			  max-height: 100px;  
  			  min-width: 100px; 
/*   			  object-fit: scale-down;  */
		  }
					  
		</style>
	
	
	
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	  	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<script type="text/javascript">
	
		
		
		
// 		무한 스크롤 start

		$(function() {
		    var page = 0; //현재 로드된 페이지
		    var size = 9; //한번에 로드할 데이터의 개수
		    var isLoading = false; //데이터 로딩중인지 여부 확인
		
		    function loadData() {
		    	//isLoading 변수를 사용하여, 데이터 로딩 중인 경우에는 추가 요청을 보내지 않습니다. 
		      if (isLoading) return;
		      isLoading = true;
		
		      $.ajax({
		        url: '/product/json/infinite',
		        type: 'POST',
		        //data: {
		        data: JSON.stringify({ //RestController로 보내려면 String 형태로 보내야한다. 
		          page: page,
		          size: size
		        }),
		        success: function(data) {
		          if (data.length > 0) {
		            var $container = $('#data-container');
		            for (var i = 0; i < data.length; i++) {
		              $container.append('<div>' + data[i].name + '</div>');
		            }
		            page++;
		            isLoading = false;
		          }
		        }
		      });
		      }
		  });
			
		    
	    //스크롤 이벤트 핸들러 등록
	    $(window).on('scroll', function() {
	      var $window = $(window);
	      var windowHeight = $window.height();
	      var scrollTop = $window.scrollTop();
	      var documentHeight = $(document).height();
	
	      if (windowHeight + scrollTop >= documentHeight) {
	        loadData();
	      }
	    });
		
		    

// 		무한 스크롤 end		
		
	
		function fncGetProductList(currentPage){
	// 		document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
	// 		document.detailForm.submit();
			$("form").attr("method" ,"POST").attr("action" , "/product/listProduct?menu=search").submit();
		}
		
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			$("button.btn.btn-default").on("click" , function() {
				fncGetProductList(1);
			});
			
			//'상세보기' 기능
			$(".btn-primary").on("click", function() {
// 				alert($(this).find("input").val().trim());
				self.location="/product/getProduct?prodNo="+$(this).find("input").val().trim();
			});
			
			$(".ct_list_pop td:nth-child(3)").css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)").css("background-color" , "whitesmoke");
			
			//오토컴플릿
			$("#searchKeyword").autocomplete({
			      source: function(request, response) {
			    	  
			    	  var searchCondition = $('option:selected').val();
			    	  var searchKeyword = $('#searchKeyword').val();

			    	  console.log($('option:selected').val());
			    	  console.log($('#searchKeyword').val());
			    	  
			    	  $.ajax({
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
		
		
	 <c:set var="i" value="0" />
	 
	<div class="row">
		 <c:forEach var="product" items="${list}">
		  	<c:set var="i" value="${i+1}" />
		    
			  <div class="col-sm-6 col-md-4">
			  
					    <div class="thumbnail">
					      <img src="/images/uploadFiles/${product.fileName}"/>
					      <div class="caption">
					        <h4 id="prodName">상품명 : ${product.prodName}</h4>
					        
					        <h4>가격 : ${product.price} 원</h4>
						        <p>
							       <button type="button" class="btn btn-primary">
							       		상세보기
							       		<input type="hidden" value="${product.prodNo}"/>
							       </button>
							       <button type="button" class="btn btn-default" role="button">장바구니에 추가</button>
						        </p>
					      </div>
					    </div>
					    
			  </div>
			 
		 </c:forEach>
	</div>	
	
	<!-- 무한스크롤 위한 div -->
	<div id="data-container"></div>	


    


</div>
		
		
		
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp">
		<jsp:param name="id" value="product" />
	</jsp:include>
	<!-- PageNavigation End... -->
	
</body>

	</html>
