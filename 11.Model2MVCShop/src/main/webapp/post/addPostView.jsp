	<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<html lang="ko">
	<head>
	<title>게시물 등록</title>
		<meta charset="EUC-KR">
		
		<!-- 참조 : http://getbootstrap.com/css/   참조 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <!--  NAVER SmartEditor -->
   <script src="/smartEditor/js/service/HuskyEZCreator.js"></script>
	
	
	
	
		<style>
	       body > div.container{
	        	border: 3px solid #D6CDB7;
	            margin-top: 10px;
	        }
	        
	        body {
            padding-top : 50px;
       		 }
	    </style>
	
	<script type="text/javascript">
	
		editorLoding : function (title, contents){
						nhn.husky.EZCreator.createInIFrame({
							 oAppRef: oEditors,
							 elPlaceHolder: document.getElementById('contents'), // html editor가 들어갈 textarea id 입니다.
							 sSkinURI: "/smartEditor/SmartEditor2Skin.html",  // html editor가 skin url 입니다.
							 htParams : {
						          // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						          bUseToolbar : true,             
						          // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						          bUseVerticalResizer : true,     
						          // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						          bUseModeChanger : true,         
						          fOnBeforeUnload : function(){
						          }
					 }, 
				
					/**
					 * 수정 시 에디터에 데이터 저장
					 */
				fOnAppLoad: function () {
				    //수정모드를 구현할 때 사용할 부분입니다. 로딩이 끝난 후 값이 체워지게 하는 구현을 합니다.
				     oEditors.getById["contents"].exec("PASTE_HTML", [contents]); //로딩이 끝나면 contents를 txtContent에 넣습니다.
					 },
						 
					 fCreator: "createSEditor2",
				});
		}
		
	</script>
	

	</head>
	
<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
		<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center" style="background-color:#FDCEE2;">게시물 등록</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
	
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">게시물 제목</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="게시물 제목을 입력해주세요.">
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">게시물 내용</label>
		    <div class="col-sm-4">
		      <textarea class="form-control" name="contents" id="contents" style="width: 100%; height:500px;"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		  
		  
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" id="add" class="btn btn-primary" >등&nbsp;록</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
	
	
	
</body>
	</html>