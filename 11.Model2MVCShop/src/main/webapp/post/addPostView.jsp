	<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<html lang="ko">
	<head>
	<title>�Խù� ���</title>
		<meta charset="EUC-KR">
		
		<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
							 elPlaceHolder: document.getElementById('contents'), // html editor�� �� textarea id �Դϴ�.
							 sSkinURI: "/smartEditor/SmartEditor2Skin.html",  // html editor�� skin url �Դϴ�.
							 htParams : {
						          // ���� ��� ���� (true:���/ false:������� ����)
						          bUseToolbar : true,             
						          // �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
						          bUseVerticalResizer : true,     
						          // ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
						          bUseModeChanger : true,         
						          fOnBeforeUnload : function(){
						          }
					 }, 
				
					/**
					 * ���� �� �����Ϳ� ������ ����
					 */
				fOnAppLoad: function () {
				    //������带 ������ �� ����� �κ��Դϴ�. �ε��� ���� �� ���� ü������ �ϴ� ������ �մϴ�.
				     oEditors.getById["contents"].exec("PASTE_HTML", [contents]); //�ε��� ������ contents�� txtContent�� �ֽ��ϴ�.
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
	
		<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center" style="background-color:#FDCEE2;">�Խù� ���</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
	
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�Խù� ����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="�Խù� ������ �Է����ּ���.">
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">�Խù� ����</label>
		    <div class="col-sm-4">
		      <textarea class="form-control" name="contents" id="contents" style="width: 100%; height:500px;"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		  
		  
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" id="add" class="btn btn-primary" >��&nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
	
	
	
</body>
	</html>