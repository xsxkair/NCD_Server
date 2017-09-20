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

        var qrdataIsEmpty = ${empty(user)};

        if(qrdataIsEmpty)
            $(".saveForm").hide();
        else {
            var createQrR = JSON.parse("${user.createqr}");
            var checkQrR = JSON.parse("${user.checkqr}");
            
            refreshData("${user.account}", "${user.name}", createQrR, checkQrR);
          }
      })
      
	function refreshData(account, name, createQrR, checkQrR){
    	
        $("#account").val(account);
        $("#oldPassword").val("");
        $("#newPassword").val("");
        $("#name").val(name);
        $(".ModifyPasswordDiv").hide();
        $(".modifyPassword").prop("checked", false);

        if(createQrR)
            $('#createqr').prop("checked", true);
        else
            $('#createqr').prop('checked', false);

        if(checkQrR)
            $('#checkqr').prop("checked", true);
        else
            $('#checkqr').prop('checked', false);
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
  				        
  				        refreshData(data.user.account, data.user.name, createQrR, checkQrR);
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

    <button type="button"  onClick="modifyAjax();">提交</button>
  </form>
</body>
</html>
