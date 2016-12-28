<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>

<script type="text/javascript" src="scripts/jquery-3.1.0.min.js"></script>

<script  type="text/javascript">
	
	function loginfunction(){

		var json = {
				"account": $("#account").val(),
		        "password": $("#password").val()
		    };

		$.ajax(
			{
				url : "login",
				type : "POST",
				data : json,
				success : function(data){
					if(data == "error")
						document.getElementById('msg').innerHTML = '登录失败';
					else
						 window.location.href = "Home";
				}
			}
		);
	}
</script>
</head>
<body>
	
	<div>
		<label id="msg"></label>
	</div>
	账号：<input type="text" id="account"/>
	账号：<input type="password" id="password"/>
	<button id="loginbn" onclick="loginfunction()">登录</button>
	
</body>
</html>