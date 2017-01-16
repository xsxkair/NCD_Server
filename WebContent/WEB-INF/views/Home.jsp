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
					if(data.status == "success"){
						//如果是超级管理员，则显示上传接口
						if(data.manager.type == 0){
							var ulelement = document.getElementById('UpYgfxySoft');
							ulelement.style.visibility='visible';
						}
						document.getElementById('userName').innerHTML = data.manager.name;
					}
					else
						window.location.href='ReLogin';
				}
			}
		);
	}

</script>

</head>
<body>
	
	欢迎您--<a href="ModifyUser" id="userName"></a> <a href="ModifyUserPassword" >修改密码</a><br/>
	
	菜单：<br/>
	<ul>
		<li><a href="UpClientSoft" id="UpYgfxySoft" style="visibility:hidden;">上传客户端软件</a></li>
		<li><a href="DownClientSoft" id="downYgfxySoft" >下载客户端软件</a></li>
	</ul>
	

</body>
</html>