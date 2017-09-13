<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	//显示详情
	$(document).ready(function(){
		$("#form").submit();
	});
</script>
</head>

<body>
<form id="form" action="checkSession" method="post" style="display:none;">
	<button type="submit" id="login-button">Login</button>
</form>
</body>
</html>