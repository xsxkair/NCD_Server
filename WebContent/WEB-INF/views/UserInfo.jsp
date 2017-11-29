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

        $(".modifyPassword").change(function(){
        	$("#oldPassword").val("");
            $("#newPassword").val("");
            if($(this).is(':checked'))
                $(".ModifyPasswordDiv").show();
            else
                $(".ModifyPasswordDiv").hide();
			
		});

        var createQrR = JSON.parse("${ncd_user.createqr}");
		var checkQrR = JSON.parse("${ncd_user.checkqr}");
		var adduser = JSON.parse("${ncd_user.adduser}");
		var deluser = JSON.parse("${ncd_user.deluser}");
		var edituser = JSON.parse("${ncd_user.edituser}");
		var upsoft = JSON.parse("${ncd_user.upsoft}");
		var downsoft = JSON.parse("${ncd_user.downsoft}");
            
		refreshData("${ncd_user.account}", "${ncd_user.name}", createQrR, checkQrR, adduser, deluser, edituser, upsoft, downsoft);
      })
      
	function refreshData(account, name, createQrR, checkQrR, adduser, deluser, edituser, upsoft, downsoft){
    	
        $("#account").val(account);
        $("#oldPassword").val("");
        $("#newPassword").val("");
        $("#name").val(name);
        $(".ModifyPasswordDiv").hide();
        $(".modifyPassword").prop("checked", false);

        $('#createqr').prop("checked", createQrR);
		$('#checkqr').prop("checked", checkQrR);
		$('#adduser').prop("checked", adduser);
		$('#deluser').prop("checked", deluser);
		$('#edituser').prop("checked", edituser);
		$('#upsoft').prop("checked", upsoft);
		$('#downsoft').prop("checked", downsoft);
	}

      function modifyAjax(){

  		var json = {
  				"account": $("#account").val(),
  				"name": $("#name").val(),
                "oldPassword": $("#oldPassword").val(),
  				"newPassword": $("#newPassword").val(),
  		    };

  		$.ajax(
  			{
  				url : "modifyUser",
  				type : "POST",
  				data : json,
  				success : function(data){
  					alert(data.status);
  					
  					if(data.status == "Success")
  					{
  						var createQrR = JSON.parse(data.user.createqr);
  				        var checkQrR = JSON.parse(data.user.checkqr);
  				      	var adduser = JSON.parse(data.user.adduser);
  						var deluser = JSON.parse(data.user.deluser);
  						var edituser = JSON.parse(data.user.edituser);
  						var upsoft = JSON.parse(data.user.upsoft);
  						var downsoft = JSON.parse(data.user.downsoft);
  				        
  				        refreshData(data.user.account, data.user.name, createQrR, checkQrR, adduser, deluser, edituser, upsoft, downsoft);
  					}
  				},
  				error : function(data){
  					alert("Fail");
  				}
  			}
  		);
  	}
</script>

</head>
<body>
	<%@include file="menu.jsp"%>

	<form class="saveForm" action="modifyUser" method="post">
	
		<div>
			<div class="formItem"><strong>账号：</strong></div>
			<div class="formInput">
				<input type="text" id="account" name="account" disabled="disabled">
				<input type="checkbox" class="modifyPassword" value="">
			</div>
		</div>
    	
    	<div class="ModifyPasswordDiv">
			<div class="formItem"><strong>旧密码：</strong></div>
			<div class="formInput">
				<input type="password" id="oldPassword" name="oldPassword">
			</div>
		</div>
		
		<div class="ModifyPasswordDiv">
			<div class="formItem"><strong>新密码：</strong></div>
			<div class="formInput">
				<input type="password" id="newPassword" name="newPassword">
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
				<input id="createqr" type="checkbox" name="createqr" disabled="disabled"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>审核二维码：</strong></div>
			<div class="formInput">
				<input id="checkqr" type="checkbox" name="checkqr" disabled="disabled"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>添加用户：</strong></div>
			<div class="formInput">
				<input id="adduser" type="checkbox" name="adduser" disabled="disabled"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>删除用户：</strong></div>
			<div class="formInput">
				<input id="deluser" type="checkbox" name="deluser"  disabled="disabled"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>编辑用户：</strong></div>
			<div class="formInput">
				<input id="edituser" type="checkbox" name="edituser" disabled="disabled"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>上传设备更新程序：</strong></div>
			<div class="formInput">
				<input id="upsoft" type="checkbox" name="upsoft" disabled="disabled"/>
			</div>
		</div>
		
		<div>
			<div class="formItem"><strong>下载设备更新程序：</strong></div>
			<div class="formInput">
				<input id="downsoft" type="checkbox" name="downsoft" disabled="disabled"/>
			</div>
		</div>

    <button type="button"  onClick="modifyAjax();">提交</button>
  </form>
</body>
</html>
