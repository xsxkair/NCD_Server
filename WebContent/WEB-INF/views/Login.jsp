<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<link rel="stylesheet" type="text/css" href="css/LoginPageCss.css">

<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>

<script>

	function loginFun(){
		var json = {
				"account": $("#account").val(),
				"password": $("#password").val(),
		    };
		
		$.ajax({
			url : "login",
			type : "POST",
			data : json,
			success : function(data){
				if(data == "Success")
					location.href = "HomePage";
				else
					alert(data);
			},
			error : function(data){
						
			}
		});
	}

</script>
</head>
<body>
	<div>
			<h1>Welcome</h1>
			
			<div >
				<input id="account" type="text"  placeholder="Username">
				<input id="password" type="password"  placeholder="Password">
				<button type="button" id="login-button" onclick="loginFun();">Login</button>
			</div>
	</div>
<!-- - <div class="htmleaf-container">
	<div class="wrapper">
		<div class="container">
			<h1>Welcome</h1>
			
			<div >
				${requestScope.status}<br/>
				<input id="account" type="text"  placeholder="Username">
				<input id="password" type="password"  placeholder="Password">
				<button type="button" id="login-button" onclick="loginFun();">Login</button>
			</div>
		</div>
		
		<ul class="bg-bubbles">
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
		</ul>
	</div>
</div>-->
</body>
</html>