<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
	
		
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>굿 즈 명</strong></div>
			<div class="col-xs-8 col-md-4">${post.postName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>굿즈 상세 정보</strong></div>
			<div class="col-xs-8 col-md-4">${post.postContents}</div>
		</div>

		
		
 	</div>
</body>
</html>