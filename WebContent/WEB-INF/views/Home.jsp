<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>武汉纽康度荧光分析仪报告管理中心</title>

<script type="text/javascript" src="scripts/jquery-3.1.0.min.js"></script>

<script  type="text/javascript">
	
	window.onload=function(){ 
		$.ajax(
			{
				url : "loginsession",
				type : "POST",
				data : {},
				success : function(data){
					if(data.status == "success")
						document.getElementById('manager').innerHTML = data.manager.name;
					else
						 window.location.href = "index.jsp";
				}
			}
		);
	}
</script>

</head>
<body>
	
	<a href="managerset" id="manager"></a>
	
</body>
</html>