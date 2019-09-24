<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Daum에디터 - 파일 첨부</title> 
<script src="/assets/daumeditor/js/popup.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="/assets/daumeditor/css/popup.css" type="text/css"  charset="utf-8"/>
<script type="text/javascript">
// <![CDATA[
	
	function done() {

		// 기본설정
		var objTarget = $('form[name=imageForm]');
		var strFile = objTarget.find('[name=file]').val();

		// 체크
		if(!strFile) {
			alert('파일을 선택하세요.');
			return;
		}

		// 데이터 전달
		objTarget.ajaxForm({
			beforeSubmit :	function() {
			},
			success		 :  function(data) {
				data =  $.parseJSON(data);
				if(data['__STATE__'] == "SUCCESS") {
				
					// 기본 설정
					var objData = data['__DATA__'];
					var filename = objData['filename'];
					var filesize = objData['filesize'];
					var attachurl = objData['attachurl'];
					var filemime = objData['filemime'];
					
					var _mockdata = {
						'attachurl': attachurl,
						'filemime': filemime,
						'filename': filename,
						'filesize': filesize
					};

					execAttach(_mockdata);
					
					closeWindow();

				} else {
					var strMsg = data['__MSG__'];
					if(!strMsg) { strMsg = data; }
					alert(strMsg);
				}
		   }
		}); 

		objTarget.submit();

	}

	function initUploader(){
	    var _opener = PopupUtil.getOpener();
	    if (!_opener) {
	        alert('잘못된 경로로 접근하셨습니다.');
	        return;
	    }
	    
	    var _attacher = getAttacher('file', _opener);
	    registerAction(_attacher);
	}
	
</script>
</head>
<body onload="initUploader();">
<div class="wrapper">
	<div class="header">
		<h1>파일 첨부</h1>
	</div>	
	<div class="body">
		<form name="imageForm" method="post" enctype="multipart/form-data" action="write.jsp">
			<input type="hidden" name="menuType" value="daumeditor">
			<input type="hidden" name="mode" value="json">
			<input type="hidden" name="act" value="fileUpload">
			<dl class="alert">
				<dt>파일 첨부 확인</dt>
				<dd><input type="file" name="file"></dd>
			</dl>
		</form>
	</div>
	<div class="footer">
		<p><a href="#" onclick="closeWindow();" title="닫기" class="close">닫기</a></p>
		<ul>
			<li class="submit"><a href="#" onclick="done();" title="등록" class="btnlink">등록</a> </li>
			<li class="cancel"><a href="#" onclick="closeWindow();" title="취소" class="btnlink">취소</a></li>
		</ul>
	</div>
</div>
</body>
</html>