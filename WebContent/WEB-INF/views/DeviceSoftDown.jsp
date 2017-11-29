<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传荧光分析仪报告管理软件</title>

<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/Soft.css">

<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>

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
				
				$('#nameInput').val($('#nameSelect').val());
				$('#langInput').val($('#langSelect').val());
				queryDeviceSoftInfo();
			}
		});
	});

	$(function(){
		var downsoft = JSON.parse("${ncd_user.downsoft}");

    	if(downsoft)
    	{
    		$("#submitBn").removeAttr("disabled");
    		$("#submitBn").text("下载");
    	}
    	else
    	{
    		$("#submitBn").attr("disabled", "disabled");
    		$("#submitBn").text("无权限");
    	}
	});
	
	function queryDeviceSoftInfo(){
		var sname = $('#nameInput').val();
		var slang = $('#langInput').val();
		
		if(sname.length == 0 || slang.length == 0)
			return;
		
		var json = {
				"softName": sname,
				"lang": slang,
		};
		
		$.ajax({
			url : "QuerySoftInfo",
			type : "POST",
			data : json,
			success : function(data)
			{
				showSoftInfo(data);
			},
			error : function(data)
			{
				alert("Fail");
			}
		 });
	}
	
	function showSoftInfo(data){
		$("#version").text(data.version);
        $("#fsize").text(data.fsize);
        $("#MD5").text(data.md5);
        $("#dsc").text(data.dsc);
	}
	
	function downSoft(){
		var url = "DownloadSoftFile?softName=";
		url += $("#name").val();
		location.href = url;
	}
	
	function selectNameFun()
	{
		$('#nameInput').val($('#nameSelect').val());
		queryDeviceSoftInfo();
	};
	
	function selectLangFun()
	{
		$('#langInput').val($('#langSelect').val());
		queryDeviceSoftInfo();
	};
</script>
</head>
<body>
	
	<%@include file="menu.jsp"%>

	<form id="Form3">
	
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
				<strong id="version"></strong>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>文件大小：</strong></div>
			<div class="formInput">
				<strong id="fsize"></strong>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>md5：</strong></div>
			<div class="formInput">
				<strong id="MD5"></strong>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>说明：</strong></div>
			<div class="formInput">
				<strong id="dsc"></strong>
			</div>
		</div>

		<button type="button" id="submitBn" onClick="downSoft();">下载</button>
	</form>

</body>
</html>