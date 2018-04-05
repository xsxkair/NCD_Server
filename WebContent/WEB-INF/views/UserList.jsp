<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改个人信息</title>


<script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/UserList.css">

<script  type="text/javascript">
    $(function(){
    	$("#userListUl").on('click','li',function(){
	       	QueryUserAjax($(this).attr('id'));
	    });
    	QueryAllUserAjax();
    	
    	var delUser = JSON.parse("${ncd_user.deluser}");
    	var editUser = JSON.parse("${ncd_user.edituser}");

    	if(delUser)
    	{
    		$("#delBn").removeAttr("disabled");
    		$("#delBn").text("删除");
    	}
    	else
    	{
    		$("#delBn").attr("disabled", "disabled");
    		$("#delBn").text("无权限");
    	}
    	if(editUser)
    	{
    		$("#editBn").removeAttr("disabled");
    		$("#editBn").text("提交");
    	}
    	else
    	{
    		$("#editBn").attr("disabled", "disabled");
    		$("#editBn").text("无权限");
    	}
      })

	function QueryAllUserAjax(){
    	
    	$.ajax(
		{
			url : "queryAllUser",
			type : "POST",
			success : function(data)
			{
				showAllUser(data);
			},
			error : function(data)
			{
				alert("Fail");
  			}
  		});
	}
    
    function QueryUserAjax(account){
    	var json = {
				"account": account,
		    };
    	$.ajax(
		{
			url : "queryOneUser",
			type : "POST",
			data : json,
			success : function(data)
			{
				showUser(data);
			},
			error : function(data)
			{
				alert("Fail");
  			}
  		});
	}
    
    function SaveUserAjax(account){
    	var json = {
				"account": account,
				"name": $("#name").val(),
                "password": $("#listpassword").val(),
  				"createqr": $("#createqr").prop("checked"),
  				"checkqr": $("#checkqr").prop("checked"),
  				"adduser": $("#adduser").prop("checked"),
  				"deluser": $("#deluser").prop("checked"),
  				"edituser": $("#edituser").prop("checked"),
  				"upsoft": $("#upsoft").prop("checked"),
  				"downsoft": $("#downsoft").prop("checked"),
		    };
    	$.ajax(
		{
			url : "saveUser",
			type : "POST",
			data : json,
			success : function(data)
			{
				alert(data);
			},
			error : function(data)
			{
				alert("Fail");
  			}
  		});
	}
    function DeleteUserAjax(account){
    	var json = {
				"account": account,
		    };
    	$.ajax(
		{
			url : "deleteUser",
			type : "POST",
			data : json,
			success : function(data)
			{
				showAllUser(data.users);
			},
			error : function(data)
			{
				alert("Fail");
  			}
  		});
	}
    
    function showAllUser(users)
	{
		$("#userListUl").empty();
		$.each(users, function (index, obj) 
		{
			var trHTML = "<li id=\"";
			trHTML += obj.account;
			trHTML += "\">";
			trHTML += obj.name;
			trHTML += "</li>";
			$("#userListUl").append(trHTML);
		});
	}
    
	function showUser(user)
	{    
	    $("#listaccount").val(user.account);
        $("#listpassword").val(user.password);
        $("#name").val(user.name);
        
        $('#createqr').prop("checked", JSON.parse(user.createqr));
		$('#checkqr').prop("checked", JSON.parse(user.checkqr));
		$('#adduser').prop("checked", JSON.parse(user.adduser));
		$('#deluser').prop("checked", JSON.parse(user.deluser));
		$('#edituser').prop("checked", JSON.parse(user.edituser));
		$('#upsoft').prop("checked", JSON.parse(user.upsoft));
		$('#downsoft').prop("checked", JSON.parse(user.downsoft));
	}
</script>

</head>
<body>
	<%@include file="menu.jsp"%>
	
	<div class="UserListMainDiv">
		<div class="userListDiv">
			<h2>用户列表</h2>
			<ul id="userListUl"></ul>
		</div>
		<div  class="userInfoDiv">
			<div>
				<div class="formItem"><strong>账号：</strong></div>
				<div class="formInput">
					<input type="text" id="listaccount" name="account" disabled="disabled">
				</div>
			</div>
	    	
	    	<div>
				<div class="formItem"><strong>密码：</strong></div>
				<div class="formInput">
					<input type="password" id="listpassword" name="password">
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
					<input id="createqr" type="checkbox" name="createqr" />
				</div>
			</div>
			
			<div>
				<div class="formItem"><strong>审核二维码：</strong></div>
				<div class="formInput">
					<input id="checkqr" type="checkbox" name="checkqr" />
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
		
		<div>
			<div class="formItem"><strong>上传设备更新程序：</strong></div>
			<div class="formInput">
				<input id="upsoft" type="checkbox" name="upsoft" />
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>下载设备更新程序：</strong></div>
			<div class="formInput">
				<input id="downsoft" type="checkbox" name="downsoft" />
			</div>
		</div>
	
		    <button type="button" id="editBn" onClick="SaveUserAjax($('#listaccount').val());">提交</button>
		    <button type="button" id="delBn"  onClick="DeleteUserAjax($('#listaccount').val());">删除</button>
		</div>
	</div>
</body>
</html>
