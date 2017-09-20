<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改个人信息</title>


<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/UserList.css">

<script  type="text/javascript">
    $(function(){
    	$("#userListUl").on('click','li',function(){
	       	QueryUserAjax($(this).attr('id'));
	    });
    	QueryAllUserAjax();
      })

	function QueryAllUserAjax(){
    	
    	$.ajax(
		{
			url : "queryAllUser",
			type : "POST",
			success : function(data)
			{
 				$("#userListUl").empty();
				$.each(data, function (index, obj) 
				{
					var trHTML = "<li id=\"";
					trHTML += obj.account;
					trHTML += "\">";
					trHTML += obj.name;
					trHTML += "</li>";
					$("#userListUl").append(trHTML);
				});
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
		    };
    	$.ajax(
		{
			url : "saveUser",
			type : "POST",
			data : json,
			success : function(data)
			{
				alert(data.status);
					
				if(data.status == "Success")
				{
					showUser(data.user);
				}
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
		var createQrR = users;
	    
	}
    
	function showUser(user)
	{
		var createQrR = JSON.parse(user.createqr);
	    var checkQrR = JSON.parse(user.checkqr);
	        
	    $("#account").val(user.account);
        $("#password").val(user.password);
        $("#name").val(user.name);
        
        if(createQrR)
            $('#createqr').prop("checked", true);
        else
            $('#createqr').prop('checked', false);

        if(checkQrR)
            $('#checkqr').prop("checked", true);
        else
            $('#checkqr').prop('checked', false);
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
					<input type="text" id="account" name="account" disabled="disabled">
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
					<input id="createqr" type="checkbox" name="createqr" />
				</div>
			</div>
			
			<div>
				<div class="formItem"><strong>审核二维码：</strong></div>
				<div class="formInput">
					<input id="checkqr" type="checkbox" name="checkqr" />
				</div>
			</div>
	
		    <button type="button"  onClick="SaveUserAjax($(account).val());">提交</button>
		    <button type="button"  onClick="DeleteUserAjax($(account).val());">删除</button>
		</div>
	</div>
</body>
</html>
