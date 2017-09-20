<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改个人信息</title>


<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/UserInfo.css">

<script  type="text/javascript">
    $(function(){
    	var addUser = JSON.parse("${ncd_user.adduser}");
    	clearPage();
    	if(addUser)
    	{
    		$("#submitBn").removeAttr("disabled");
    		$("#submitBn").text("提交");
    	}
    	else
    	{
    		$("#submitBn").attr("disabled", "disabled");
    		$("#submitBn").text("无权限");
    	}
    	
      });
      
	function clearPage(){
    	
        $("#account").prop("value", "");
        $("#password").prop("value", "");
        $("#name").prop("value", "");
        $("#createqr").prop("checked", false);
        $("#checkqr").prop("checked", false);
        $("#adduser").prop("checked", false);
        $("#deluser").prop("checked", false);
        $("#edituser").prop("checked", false);
	};

      function addAjax(){
		var x = $("#account");
  		var json = {
  				"account": $("#account").val(),
  				"name": $("#name").val(),
                "password": $("#password").val(),
  				"createqr": $("#createqr").prop("checked"),
  				"checkqr": $("#checkqr").prop("checked"),
  				"adduser": $("#adduser").prop("checked"),
  				"deluser": $("#deluser").prop("checked"),
  				"edituser": $("#edituser").prop("checked"),
  		    };

  		$.ajax(
  			{
  				url : "saveUser",
  				type : "POST",
  				data : json,
  				success : function(data){
  					alert(data);
  					if(data == "Success")
  						clearPage();
  				},
  				error : function(data){
  					alert("Fail");
  				}
  			}
  		);
  	};
</script>

</head>
<body>
	<%@include file="menu.jsp"%>

	<form class="saveForm" action="modifyUser" method="post">
	
		<div>
			<div class="formItem"><strong>账号：</strong></div>
			<div class="formInput">
				<input type="text" id="account" name="account" >
			</div>
		</div>
    	
    	<div>
			<div class="formItem"><strong>密码：</strong></div>
			<div class="formInput">
				<input type="password" id="password" name="password">
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>姓名：</strong></div>
			<div class="formInput">
				<input type="text" id="name" name="name">
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>创建二维码：</strong></div>
			<div class="formInput">
				<input id="createqr" type="checkbox" name="createqr"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>审核二维码：</strong></div>
			<div class="formInput">
				<input id="checkqr" type="checkbox" name="checkqr"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>添加用户：</strong></div>
			<div class="formInput">
				<input id="adduser" type="checkbox" name="adduser"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>删除用户：</strong></div>
			<div class="formInput">
				<input id="deluser" type="checkbox" name="deluser" />
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>编辑用户：</strong></div>
			<div class="formInput">
				<input id="edituser" type="checkbox" name="edituser" />
			</div>
		</div>

    <button type="button" id="submitBn" onClick="addAjax();">提交</button>
  </form>
</body>
</html>
