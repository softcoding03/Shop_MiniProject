<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
   <script type="text/javascript" src="../smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
    <form>
        <!-- ����Ʈ �����Ͱ� ���Ե� div �±� -->
        <div id="sample_editor">
            <p>�����ۼ�</p>
        </div>
        <!-- �����Ϳ��� �ۼ��� ������ ������ textarea �±�-->
        <textarea name="ir1" id="ir1" rows="10" cols="100">�����Ϳ� �⺻���� ������ ��(���� ���)�� ���ٸ� �� value ���� �������� �����ø� �˴ϴ�.</textarea>
        <br>
        <button type="button" onclick="submitContents()">�ۼ� �Ϸ�</button>
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
