<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>

<script type="text/javascript" src="scripts/jquery-3.1.0.min.js"></script>

<script  type="text/javascript">
	
	window.onload=function(){ 
		$.ajax(
			{
				url : "loginsession",
				type : "POST",
				data : {},
				success : function(data){
					if(data.status == "error")
						window.location.href = "index.jsp";
				}
			}
		);
	}
	
	function MUserPass(){

		var json = {
				"newpass1": $("#newpass1").val(),
		        "newpass2": $("#newpass2").val(),
		        "oldpass": $("#oldpass").val()
		    };

		$.ajax(
			{
				url : "MUserPassHandler",
				type : "POST",
				data : json,
				success : function(data){
					if(data.status == "success"){
						alert("修改成功");
						window.location.href='Home';
					}
					else if(data.status == "passerror")
						alert("密码错误");
					else if(data.status == "fail")
						alert("新密码不一致");
					else if(data.status == "error")
						alert("修改失败");
					else 
						window.location.href='ReLogin';
				}
			}
		);
	}
	
</script>

</head>
<body>
		<p>新密码<input id="newpass1" type="text"> </p>
		<p>新密码<input id="newpass2" type="text"> </p>
		<p>旧密码<input id="oldpass" type="text"> </p>

		<input name="Submit1" type="button" value="提交信息" onClick="MUserPass();">
</body>
</html>