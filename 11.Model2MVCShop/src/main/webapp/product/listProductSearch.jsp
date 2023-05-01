	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<html>
	<head>
	<title>���� �˻�</title>
	
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
		  
		  img {
  			  max-height: 100px;  
  			  min-width: 100px; 
/*   			  object-fit: scale-down;  */
		  }
		  
		  /*�ε� �ִϸ��̼� CSS */
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
	
		
		
		
// 		���� ��ũ�� start

		$(function() {
		    var page = 2; //���� �ε�� ������
		    var size = 9; //�ѹ��� �ε��� �������� ����
		    var isLoading = false; //������ �ε������� ���� Ȯ��
		    
		    var pagedata = {
		    	page: page,
			    size: size,
			    searchCondition : $('option').val(),
			    searchKeyword : $('#searchKeyword').val()
		    }
		    console.log("condition?"+pagedata.searchCondition);
		    console.log("keyword?"+pagedata.searchKeyword);
		    
		  
		   
			function loadData() {
		      //isLoading ������ ����Ͽ�, ������ �ε� ���� ��쿡�� �߰� ��û�� ������ �ʽ��ϴ�. 
		      if (isLoading) return;
		      isLoading = true;
		      console.log("ajax ����");  
		      console.log("pagedata.page?"+pagedata.page);
			      //��ũ�ѽ� ������Ʈ �� 9���� ��ü ��û�ϴ� ajax
			      $.ajax({
			        url: '/product/json/infinite',
			        method: 'POST',
			        contentType: "application/json; charset=euc-kr",
			        data: JSON.stringify(pagedata), //RestController�� �������� String ���·� �������Ѵ�. 
			        dataType: "json",
			        success: function(serverData, status) {
			        	
			        	console.log("����status��?"+status)
			        	console.log("���۹��� data��?"+serverData)
			        
				          if (serverData.length != 0) {
				        	  console.log("append �ǽ�")
				            var $container = $('#data-container');
				            for (var i = 0; i < serverData.length; i++) {
				              //append�� html
				            	$container.append(
				            		  '<div class="col-sm-6 col-md-4">'
				            		  +'<div class="thumbnail" style="width: 300px; height: 250px;">'
				            		  + '<img src="/images/uploadFiles/'+serverData[i].fileName+'"/>'
				            		  + '<div class="caption">'
				            		  + '<h4 id="prodName">��ǰ�� : '+serverData[i].prodName+'</h4>'
				            		  + '<h4>���� : '+serverData[i].price+'��</h4>'
				            		  + '<p>'
				            		  + '<button type="button" class="btn btn-primary">'
				            		  + '�󼼺���'
				            		  + '<input type="hidden" value="'+serverData[i].prodNo+'"/>'
				            		  + '</button>'
				            		  + '<button type="button" class="btn btn-default" role="button">��ٱ��Ͽ� �߰�</button>'
				            		  + '</p>'
				            		  + '</div>'
				            		  + '</div>'
				            		  + '</div>'
				                );
				            }
				            page++;
				            $('.loading-overlay').hide(); //������ �ҷ����°� �Ϸ�Ǹ� �ִϸ��̼� �����
				          }
			        	isLoading = false;
			        }
			      });
		      }	
		    
		 	// �ε� �ִϸ��̼� �߰�
		    $('body').append('<div class="loading-overlay"><div class="loader"></div></div>');
		 	// �ʱ� ���·� �ε� �ִϸ��̼� �����
		    $('.loading-overlay').hide();
		 	
		    
		    //��ũ�ѹ� ���� �� ���� �Լ�
		    $(window).scroll(function() {
		    	var windowHeight = $(window).height(); //������ �� ����
		    	var scrollTop = $(window).scrollTop(); // ���� ��ũ�ѹٰ� �ִ� ��ġ(0) ��ũ�� �Ҷ� ���� ����
		    	//var documentHeight = $(document).height(); //������ �� ����(���ο� ������ �ҷ����� �����)
		    	//��ũ���� ������ �� ��� windowHeight�� scrollTop�� ���� documentHeight�� ũ��� ���ų� �� ũ�� �ȴ�. �� �� �߰� �����͸� �ε��ϸ� ��.
		    	
			    console.log("scrollTop ����?"+scrollTop);
			    console.log("windowHeight ����?"+windowHeight);
			    //console.log("documentHeight ����?"+documentHeight);
		    	
			    
		    	//if (windowHeight + scrollTop >= documentHeight) { ���� �̰� ������ windowHeight�� documentHeight���� ������ ... 
			      if (scrollTop >= (windowHeight-1000) && page <= ${resultPage.endUnitPage}) {    //request�� page ���� ���� ������ pageunit ����ŭ�� ����ǰԲ�   
		    			console.log("������ ���� ! loadData()��û ����");
		    			$('.loading-overlay').show(); //�ε��ִϸ��̼� ǥ�� ����		
						
			      		pagedata.page = page; //page++ ���� �����ϴ� data�� page������ ����
			            console.log("pagedata.page ???" + pagedata.page);
			            loadData();
			    }
		    });
		});
		    
// 		���� ��ũ�� end		
		
	
		
		//'�󼼺���' ��� -> .btn-primary ��ҿ� ���� �̺�Ʈ �ڵ鷯�� ����ϴ� ���� �ƴϰ�  
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
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			$("button.btn.btn-default").on("click" , function() {
				fncGetProductList(1);
			});
			
			$(".ct_list_pop td:nth-child(3)").css("color" , "red");
			$("h7").css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)").css("background-color" , "whitesmoke");
			
			//�������ø�
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>���� ��� ��ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ� 
		    		<!--  , ���� ${resultPage.currentPage}  ������-->
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
				    	<c:if test="${user.userName == 'admin'}">
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				        </c:if>
				        <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
				        <option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� end /////////////////////////////////////-->
		
		
	 <c:set var="i" value="0" />
	 
		<div class="row" id="data-container"> <!-- ���ѽ�ũ�� ���� div�� id ���� -->
			 <c:forEach var="product" items="${list}">
			  	<c:set var="i" value="${i+1}" />
				  <div class="col-sm-6 col-md-4">
						    <div class="thumbnail" style="width: 300px; height: 250px;">
						      <img src="/images/uploadFiles/${product.fileName}"/>
						      <div class="caption">
						        <h4 id="prodName">��ǰ�� : ${product.prodName}</h4>
						        
						        <h4>���� : ${product.price} ��</h4>
							        <p>
								       <button type="button" class="btn btn-primary">
								       		�󼼺���
								       		<input type="hidden" value="${product.prodNo}"/>
								       </button>
								       <button type="button" class="btn btn-default" role="button">��ٱ��Ͽ� �߰�</button>
							        </p>
						      </div>                                 
						    </div>
				  </div>
			 </c:forEach>
		< /div>	
		
	<div class="modal"><!-- Place at bottom of page --></div>

</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<%-- -- PageNavigation Start... 
	<jsp:include page="../common/pageNavigator_new.jsp">
		<jsp:param name="id" value="product" />
	</jsp:include>
	-->--%>
	
</body>

	</html>
