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
		  
		  /*로딩 애니메이션 CSS */
			.loading-overlay {
			  position: fixed;
			  top: 0;
			  left: 0;
			  width: 100%;
			  height: 100%;
			  background: rgba(255, 255, 255, 0.5);
			  z-index: 9999;
			}  
		  	.loader {
			  border: 16px solid #f3f3f3; 
			  border-top: 16px solid #3498db;
			  border-radius: 50%;
			  width: 80px;
			  height: 80px;
			  animation: spin 2s linear infinite;
			  position: absolute;
			  top: 50%;
			  left: 50%;
			  margin-top: -40px;
			  margin-left: -40px;
			}
			
			@keyframes spin {
			  0% { transform: rotate(0deg); }
			  100% { transform: rotate(360deg); }
			}
					  
		</style>
	
	
	
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	  	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<script type="text/javascript">
	
		
		
		
// 		무한 스크롤 start

		$(function() {
		    var page = 2; //현재 로드된 페이지
		    var size = 9; //한번에 로드할 데이터의 개수
		    var isLoading = false; //데이터 로딩중인지 여부 확인
		    
		    var pagedata = {
		    	page: page,
			    size: size,
			    searchCondition : $('option').val(),
			    searchKeyword : $('#searchKeyword').val()
		    }
		    console.log("condition?"+pagedata.searchCondition);
		    console.log("keyword?"+pagedata.searchKeyword);
		    
		  
		   
			function loadData() {
		      //isLoading 변수를 사용하여, 데이터 로딩 중인 경우에는 추가 요청을 보내지 않습니다. 
		      if (isLoading) return;
		      isLoading = true;
		      console.log("ajax 시작");  
		      console.log("pagedata.page?"+pagedata.page);
			      //스크롤시 업데이트 할 9개의 객체 요청하는 ajax
			      $.ajax({
			        url: '/product/json/infinite',
			        method: 'POST',
			        contentType: "application/json; charset=euc-kr",
			        data: JSON.stringify(pagedata), //RestController로 보내려면 String 형태로 보내야한다. 
			        dataType: "json",
			        success: function(serverData, status) {
			        	
			        	console.log("전송status는?"+status)
			        	console.log("전송받은 data는?"+serverData)
			        
				          if (serverData.length != 0) {
				        	  console.log("append 실시")
				            var $container = $('#data-container');
				            for (var i = 0; i < serverData.length; i++) {
				              //append할 html
				            	$container.append(
				            		  '<div class="col-sm-6 col-md-4">'
				            		  +'<div class="thumbnail" style="width: 300px; height: 250px;">'
				            		  + '<img src="/images/uploadFiles/'+serverData[i].fileName+'"/>'
				            		  + '<div class="caption">'
				            		  + '<h4 id="prodName">상품명 : '+serverData[i].prodName+'</h4>'
				            		  + '<h4>가격 : '+serverData[i].price+'원</h4>'
				            		  + '<p>'
				            		  + '<button type="button" class="btn btn-primary">'
				            		  + '상세보기'
				            		  + '<input type="hidden" value="'+serverData[i].prodNo+'"/>'
				            		  + '</button>'
				            		  + '<button type="button" class="btn btn-default" role="button">장바구니에 추가</button>'
				            		  + '</p>'
				            		  + '</div>'
				            		  + '</div>'
				            		  + '</div>'
				                );
				            }
				            page++;
				            $('.loading-overlay').hide(); //데이터 불러오는게 완료되면 애니메이션 숨기기
				          }
			        	isLoading = false;
			        }
			      });
		      }	
		    
		 	// 로딩 애니메이션 추가
		    $('body').append('<div class="loading-overlay"><div class="loader"></div></div>');
		 	// 초기 상태로 로딩 애니메이션 숨기기
		    $('.loading-overlay').hide();
		 	
		    
		    //스크롤바 동작 시 실행 함수
		    $(window).scroll(function() {
		    	var windowHeight = $(window).height(); //문서의 총 높이
		    	var scrollTop = $(window).scrollTop(); // 현재 스크롤바가 있는 위치(0) 스크롤 할때 값이 증가
		    	//var documentHeight = $(document).height(); //문서의 총 높이(새로운 데이터 불러오면 변경됨)
		    	//스크롤이 끝까지 된 경우 windowHeight와 scrollTop의 합은 documentHeight의 크기와 같거나 더 크게 된다. 이 때 추가 데이터를 로딩하면 됨.
		    	
			    console.log("scrollTop 값은?"+scrollTop);
			    console.log("windowHeight 값은?"+windowHeight);
			    //console.log("documentHeight 값은?"+documentHeight);
		    	
			    
		    	//if (windowHeight + scrollTop >= documentHeight) { 원래 이게 맞으나 windowHeight랑 documentHeight값이 동일한 ... 
			      if (scrollTop >= (windowHeight-1000) && page <= ${resultPage.endUnitPage}) {    //request가 page 값이 쿼리 수행후 pageunit 수만큼만 수행되게끔   
		    			console.log("마지막 도달 ! loadData()요청 시작");
		    			$('.loading-overlay').show(); //로딩애니메이션 표시 시작		
						
			      		pagedata.page = page; //page++ 값을 전송하는 data의 page값으로 지정
			            console.log("pagedata.page ???" + pagedata.page);
			            loadData();
			    }
		    });
		});
		    
// 		무한 스크롤 end		
		
	
		
		//'상세보기' 기능 -> .btn-primary 요소에 대한 이벤트 핸들러를 등록하는 것이 아니고  
		$(document).on("click", ".btn-primary", function() {
			self.location="/product/getProduct?prodNo="+$(this).find("input").val().trim();
		});
	
		function fncGetProductList(currentPage){
	 		//document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
	 		//document.detailForm.submit();
			$("form").attr("method" ,"POST").attr("action" , "/product/listProduct?menu=search").submit();
		}
		
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			$("button.btn.btn-default").on("click" , function() {
				fncGetProductList(1);
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
		    		전체  ${resultPage.totalCount } 건수 
		    		<!--  , 현재 ${resultPage.currentPage}  페이지-->
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
				    	<c:if test="${user.userName == 'admin'}">
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				        </c:if>
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
	 
		<div class="row" id="data-container"> <!-- 무한스크롤 위한 div에 id 지정 -->
			 <c:forEach var="product" items="${list}">
			  	<c:set var="i" value="${i+1}" />
				  <div class="col-sm-6 col-md-4">
						    <div class="thumbnail" style="width: 300px; height: 250px;">
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
		< /div>	
		
	<div class="modal"><!-- Place at bottom of page --></div>

</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<%-- -- PageNavigation Start... 
	<jsp:include page="../common/pageNavigator_new.jsp">
		<jsp:param name="id" value="product" />
	</jsp:include>
	-->--%>
	
</body>

	</html>
