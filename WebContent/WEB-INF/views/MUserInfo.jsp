<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改个人信息</title>

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
	
	function M_Info(){

		var json = {
				"name": $("#name").val(),
		        "sex": $('input:radio[name="sex"]:checked').val(),
		        "age": $("#age").val(),
		        "phone": $("#phone").val(),
		        "job": $("#job").val(),
		        "dsc": $("#desc").val()
		    };

		$.ajax(
			{
				url : "MUserInfoHandler",
				type : "POST",
				data : json,
				success : function(data){
					if(data.status == "success")
						alert("修改成功");
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
		<p>姓名<input id="name" type="text"> </p>
 		<p>性别<input name="sex" id="sex" type="radio" value="男"/>男
		    <input name="sex" id="sex" type="radio" value="女"/>女
		</p>
		<p>年龄<input id="age" type="text"></p>
		<p>联系方式<input id="phone" type="text"></p>
		<p>职务<input id="job" type="text"></p>
		<p>备注<input id="desc" type="text"></p>
		
		<input name="Submit1" type="button" value="提交信息" onClick="M_Info();">
</body>
</html>