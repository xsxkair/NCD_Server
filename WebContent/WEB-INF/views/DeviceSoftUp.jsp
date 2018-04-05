<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传荧光分析仪报告管理软件</title>

<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/Soft.css">
<link rel="stylesheet" type="text/css" href="scripts/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="scripts/themes/icon.css">

<script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>

<script  type="text/javascript">

	$(function(){
		$.ajax({
			url : "QueryAllSoftName",
			type : "POST",
			success : function(data){
				var names = data.names;
				var langs = data.langs;
				var htmlText = "";
				
				$('#nameSelect').empty();
				$.each(names, function (index, obj) {
					htmlText = "<option value='" + obj + "'>" + obj + "</option>";
					$("#nameSelect").append(htmlText);
	            });
				
				$('#langSelect').empty();
				$.each(langs, function (index, obj) {
					htmlText = "<option value='" + obj + "'>" + obj + "</option>";
					$("#langSelect").append(htmlText);
	            });
				
				selectNameFun();
		    	selectLangFun();
			}
		});
	});
	

	$(function(){
		var msg = "${requestScope.status}";
		var upsoft = JSON.parse("${ncd_user.upsoft}");
		
		if(msg.length > 0)
			alert(msg);

    	if(upsoft)
    	{
    		$("#submitBn").removeAttr("disabled");
    		$("#submitBn").val("提交");
    	}
    	else
    	{
    		$("#submitBn").attr("disabled", "disabled");
    		$("#submitBn").val("无权限");
    	}
    	
	});
	
	function selectNameFun()
	{
		$('#nameInput').val($('#nameSelect').val());
	};
	
	function selectLangFun()
	{
		$('#langInput').val($('#langSelect').val());
	};
</script>
</head>
<body>
	
	<%@include file="menu.jsp"%>

	<form id="Form3" action="UploadSoftFile" method="post"  enctype="multipart/form-data">
		<div>
			<div class="formItem"><strong>文件：</strong></div>
			<div class="formInput">
				<input type="file" name="file">
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>设备类型(id)：</strong></div>
			<div class="formInput">
				<input type="text" name="name" id="nameInput" >
				<select id="nameSelect" onchange="selectNameFun();"></select>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>设备语言：</strong></div>
			<div class="formInput">
				<input type="text" name="lang" id="langInput">
				<select id="langSelect" onchange="selectLangFun();"></select>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>版本：</strong></div>
			<div class="formInput">
				<input type="text" name="version">
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>说明：</strong></div>
			<div class="formInput">
				<input type="text" name="dsc">
			</div>
		</div>
		
		<input type="submit" id="submitBn" value="提交"/>
	</form>

</body>
</html>