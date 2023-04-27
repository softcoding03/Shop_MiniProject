<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
   <script type="text/javascript" src="../smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
    <form>
        <!-- 스마트 에디터가 삽입될 div 태그 -->
        <div id="sample_editor">
            <p>내용작성</p>
        </div>
        <!-- 에디터에서 작성한 내용을 전송할 textarea 태그-->
        <textarea name="ir1" id="ir1" rows="10" cols="100">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
        <br>
        <button type="button" onclick="submitContents()">작성 완료</button>
    </form>
    <script type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		 oAppRef: oEditors,
		 elPlaceHolder: "ir1",
		 sSkinURI: "../se2/SmartEditor2Skin.html",
		 fCreator: "createSEditor2"
		});
	</script>
</body>
</html>
