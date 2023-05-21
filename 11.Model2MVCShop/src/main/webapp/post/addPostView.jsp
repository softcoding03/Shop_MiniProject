<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
   
   <!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
 
    <script type="text/javascript">
    $(document).ready(function() {
    		$('#summernote').summernote({
            placeholder: '내용을 작성해주세요.',
            tabsize: 2,
            height: 500
          });
    	});
    </script>
    
   
</head>
<body>
    
    
    	<form method="post" action="/post/addPost" method="POST">
    		<table border=1 width=80%>
    			<tr>
    				<td>제목</td>
    					<td><input type="text" name="postName" style="width:100%;"></td>
    			</tr>
    			<tr>
    				<td colspan="2">
    					<textarea id="summernote" name="postContents"></textarea>
    				</td>
    			</tr>
    		</table>
    	
    		<input type="submit" value="전송">
    	
    	
    	
		  
		</form>
    
</body>
</html>
