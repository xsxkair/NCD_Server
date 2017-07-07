<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传荧光分析仪报告管理软件</title>
</head>
<body>
	
	结果:${requestScope.status}<br/><br/><br/><br/>
	
	上传客户端：<br/>
	

	<form name="Form1" action="UploadSoftFile" method="post"  enctype="multipart/form-data">
		文件<input type="file" name="file">
		<input type="text" name="name" style="hidden" value="Client">
		版本<input type="text" name="version">
		说明<input type="text" name="dsc">
		
		<input type="submit" value="upload"/>
	</form>
	
	<br/><br/>
	上传客户端补丁：<br/>
	

	<form name="Form2" action="UploadSoftFile" method="post"  enctype="multipart/form-data">
		文件<input type="file" name="file">
		<input type="text" name="name" style="hidden" value="CPath">
		版本<input type="text" name="version">
		说明<input type="text" name="dsc">
		
		<input type="submit" value="upload"/>
	</form>
	
	<br/><br/>
	通用设备程序上传：<br/>

	<form name="Form3" action="UploadSoftFile" method="post"  enctype="multipart/form-data">
		文件<input type="file" name="file">
		<input type="text" name="name" style="hidden" value="Device">
		版本<input type="text" name="version">
		说明<input type="text" name="dsc">
		
		<input type="submit" value="upload"/>
	</form>
	
	<br/><br/>
	指定设备程序上传：<br/>

	<form name="Form4" action="UploadSoftFile" method="post"  enctype="multipart/form-data">
		文件<input type="file" name="file">
		<input type="text" name="name">
		版本<input type="text" name="version">
		说明<input type="text" name="dsc">
		
		<input type="submit" value="upload"/>
	</form>
</body>
</html>