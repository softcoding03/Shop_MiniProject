<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
<div class="container text-center">
		 
		 <nav>
		  <!-- ũ������ :  pagination-lg pagination-sm-->
		  <ul class="pagination" >
		    
		    <!--  <<== ���� nav -->
		  	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		 		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<li>
			</c:if>
			
				<c:if test="${param.id == 'user'}">
			      <a href="javascript:fncGetUserList('${ resultPage.currentPage-1}')" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
		      	</c:if>
				<c:if test="${param.id == 'product'}">
				  <a href="javascript:fncGetProductList('${ resultPage.currentPage-1}')" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
				</c:if>
				<c:if test="${param.id == 'purchase'}">
				  <a href="javascript:fncGetPurchaseList('${ resultPage.currentPage-1}')" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
				</c:if>
				
		    </li>
		    
		    <!--  �߾�  -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
				<c:if test="${ resultPage.currentPage == i }">
					<!--  ���� page ����ų��� : active -->
				    <li class="active">
				    	<c:if test="${param.id == 'user'}">
				    		<a href="javascript:fncGetUserList('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				    	</c:if>
				    	<c:if test="${param.id == 'product'}">
				    		<a href="javascript:fncGetProductList('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				    	</c:if>
				    	<c:if test="${param.id == 'purchase'}">
				    		<a href="javascript:fncGetPurchaseList('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				    	</c:if>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.currentPage != i}">	
					<li>
						<c:if test="${param.id == 'user'}">
							<a href="javascript:fncGetUserList('${ i }');">${ i }</a>
						</c:if>
						<c:if test="${param.id == 'product'}">
							<a href="javascript:fncGetProductList('${ i }');">${ i }</a>
						</c:if>
						<c:if test="${param.id == 'purchase'}">
							<a href="javascript:fncGetPurchaseList('${ i }');">${ i }</a>
						</c:if>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  ���� nav==>> -->
		     <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		  		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li>
			</c:if>
		      
		      <c:if test="${param.id == 'user'}">
		      	<a href="javascript:fncGetUserList('${resultPage.endUnitPage+1}')" aria-label="Next">
		      </c:if>  
		      <c:if test="${param.id == 'product'}">
		        <a href="javascript:fncGetProductList('${resultPage.endUnitPage+1}')" aria-label="Next">
		      </c:if>
		      <c:if test="${param.id == 'purchase'}">
		        <a href="javascript:fncGetPurchaseList('${resultPage.endUnitPage+1}')" aria-label="Next">
		      </c:if>
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		
</div>
 


<div class="container">
		<nav>
		  <ul class="pager">
		    <li><a href="#">Previous</a></li>
		    <li><a href="#">Next</a></li>
		  </ul>
		</nav>
</div>


<div class="container">
		<nav>
		  <ul class="pager">
		    <li class="previous disabled"><a href="#"><span aria-hidden="true">&larr;</span> Older</a></li>
		    <!-- <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> Older</a></li>  -->
		    <li class="next"><a href="#">Newer <span aria-hidden="true">&rarr;</span></a></li>
		  </ul>
		</nav>
</div>