<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
        
         img {
  			  max-height: 400px;  
  			  width: 400px; 
  			  object-fit: scale-down; 
		  }
		 
        
   	</style>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
     <script type="text/javascript">
     $(function() {
    	 $("#a").hover(function(){

    	        $(this).css("background-color", "yellow");

    	    }, function(){

    	        $(this).css("background-color", "pink");

    	  });
     });
	 </script>	
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  �Ʒ��� ������ http://getbootstrap.com/getting-started/  ���� -->	
   	<!--  <div class="container ">
      <!-- Main jumbotron for a primary marketing message or call to action -->
<!--
	<div class="jumbotron">
        <h1>Model2MVCShop </h1>
        <p>J2SE , DBMS ,JDBC , Servlet & JSP, Java Framework , HTML5 , UI Framework �н� �� Mini-Project ����</p>
     </div>
    </div>
-->

	<img src="/images/newjeans/newjeans-adornewgg.gif" width="400" height="140" class="img-responsive center-block">
	<div class="page-header" style="background-color:#FDD8F6;">
        <h1 align="center" style="background-color:#FDD8F6;">New Jeans</h3>
        <h2 align="center"> ���� �Ǹ����� ���� ���� ȯ���մϴ�.</h1>
        
    </div>
      <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
          <li data-target="#carousel-example-generic" data-slide-to="1"></li>
          <li data-target="#carousel-example-generic" data-slide-to="2"></li>
          <li data-target="#carousel-example-generic" data-slide-to="3"></li>
        </ol>
        
        <div class="carousel-inner" role="listbox">
          <div class="item active" display="center">
          	<a href = "/product/getProduct?prodNo=10243" id="a">
            	<img  src="/images/newjeans/book.jpg" alt="Third slide" class="img-responsive center-block">
            	<p>������ 1st OMG �̱� �ٹ� // ���� �󼼺��⸦ �Ϸ��� Ŭ�����ּ���.</p>
          	</a>
          </div>
          <div class="item">
          	<a href = "/product/getProduct?prodNo=10244">
            	<img src="/images/newjeans/keyring.jpg" alt="Second slide" class="img-responsive center-block">
          		<p>������ Ű�� // ���� �󼼺��⸦ �Ϸ��� Ŭ�����ּ���.</p>
          	</a>
          </div>
          <div class="item">
          	<a href = "/product/getProduct?prodNo=10241">
            	<img src="/images/newjeans/bag.jpg" alt="Third slide" class="img-responsive center-block">
          		<p>������ �ڵ��1 // ���� �󼼺��⸦ �Ϸ��� Ŭ�����ּ���.</p>
          	</a>
          </div>
          <div class="item">
          	<a href = "/product/getProduct?prodNo=10245">
            	<img src="/images/newjeans/bag2.jpg" alt="Third slide"  class="img-responsive center-block">
          		<p>������ �ڵ��2 // ���� �󼼺��⸦ �Ϸ��� Ŭ�����ּ���.</p>
          	</a>
          </div>
        </div>
        
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
      
      
      
	<!-- ���� : http://getbootstrap.com/css/   : container part..... -->
	<div class="container">
        <h3 style="border:1px solid blue;">������(NewJeans)...</h3>
        <h2 >���� ã�� �ǰ� ���� �Ծ ������ �ʴ� ��ó�� �ô��� �������� �ǰڴٴ� ���ο� New Genes�� �ǰڴٴ� ������ ��� �ִ�</h2>
  	 	
  	 </div>

</body>

</html>